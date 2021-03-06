<?php
if(posix_getuid()<>0){die("Cannot be used in web server mode\n\n");}
include_once(dirname(__FILE__).'/ressources/class.templates.inc');
include_once(dirname(__FILE__).'/ressources/class.ini.inc');
include_once(dirname(__FILE__).'/ressources/class.samba.inc');
include_once(dirname(__FILE__).'/ressources/class.autofs.inc');
include_once(dirname(__FILE__).'/ressources/class.mysql.inc');
include_once(dirname(__FILE__).'/ressources/class.backup.inc');
include_once(dirname(__FILE__).'/ressources/class.os.system.inc');
include_once(dirname(__FILE__).'/ressources/class.cyrus.inc');
include_once(dirname(__FILE__).'/ressources/class.user.inc');
include_once(dirname(__FILE__).'/framework/class.unix.inc');
include_once(dirname(__FILE__)."/framework/frame.class.inc");



$date=date('Y-m-d');
$GLOBALS["ADDLOG"]="/var/log/artica-postfix/backup-starter-$date.log";
@mkdir("/var/log/artica-postfix/sql-events-queue");


if(preg_match("#--verbose#",implode(" ",$argv))){$GLOBALS["DEBUG"]=true;$GLOBALS["VERBOSE"]=true;}
if(preg_match("#--reload#",implode(" ",$argv))){$GLOBALS["RELOAD"]=true;}
if(preg_match("#--only-test#",implode(" ",$argv))){$GLOBALS["ONLY_TESTS"]=true;}
if(preg_match("#--no-umount#",implode(" ",$argv))){$GLOBALS["NO_UMOUNT"]=true;}
if(preg_match("#--no-standard-backup#",implode(" ",$argv))){$GLOBALS["NO_STANDARD_BACKUP"]=true;}
if(preg_match("#--no-reload#",implode(" ",$argv))){$GLOBALS["NO_RELOAD"]=true;}
if(preg_match("#--mysql-db#",implode(" ",$argv))){backup_mysql_databases_list(0);die();}


$GLOBALS["USE_RSYNC"]=false;
$GLOBALS["INTRO_CMDLINES"]=@implode(" ",$argv);


if($argv[1]=="--restore-mbx"){
	restorembx($argv[2]);
	die();
}

if(preg_match("#--cron#",implode(" ",$argv))){
	buildcron();
	die();
}


if($argv[1]=="--usb"){
	mount_usb("usb://{$argv[2]}",0,true);
	die();
}

if($argv[1]=="--mount"){
	$id=$argv[2];
	while (list ($num, $cmd) = each ($argv) ){
		if(preg_match("#--dir=(.+)#",$cmd,$re)){$GLOBALS["DIRLIST"]="/".$re[1];continue;}
		if(preg_match("#--id=([0-9]+)#",$cmd,$re)){$id=$re[1];continue;}
		if(preg_match("#--list#",$cmd,$re)){$GLOBALS["dirlist"]=true;}			
		}
	
	$GLOBALS["ONNLY_MOUNT"]=true;
	writelogs(date('m-d H:i:s')." "."mounting $id",__FUNCTION__,__FILE__);
	$dir=backup($id);
	ParseMailboxDir($dir);
	if(!$GLOBALS["NO_UMOUNT"]){shell_exec("umount -l $dir");}
	die();
	}


$ID=$argv[1];
if($ID<1){
	writelogs(date('m-d H:i:s')." "."unable to get task ID \"{$GLOBALS["INTRO_CMDLINES"]}\" process die()",__FUNCTION__,__FILE__,__LINE__);
	die();
}





backup($ID);



function buildcron(){
	$unix=new unix();
	$path="/etc/cron.d";
	
	$sql="SELECT * FROM backup_schedules ORDER BY ID DESC";
	$q=new mysql();
	$results=$q->QUERY_SQL($sql,"artica_backup");
	if(!$q->ok){return null;}	
	
	$files=$unix->DirFiles("/etc/cron.d");
	while (list ($num, $filename) = each ($files) ){
		if(preg_match("#artica-backup-([0-9]+)$#",$filename)){
			echo "Starting......: Backup remove $filename\n";
			@unlink("$path/$filename");
		}
	}
	
	while($ligne=@mysql_fetch_array($results,MYSQL_ASSOC)){
		$schedule=$ligne["schedule"];
		echo "Starting......: Backup $schedule\n";
		$f[]="$schedule  ". LOCATE_PHP5_BIN()." ". __FILE__." {$ligne["ID"]} >/dev/null 2>&1";
		
	}
	
	@file_put_contents("/etc/artica-postfix/backup.tasks",@implode("\n",$f));
	if(!$GLOBALS["NO_RELOAD"]){
		system("/etc/init.d/artica-postfix restart daemon");
	}
	
}



function backup($ID){
	$date_start=time();
	$GLOBALS["RESOURCE_MOUNTED"]=true;
	$sql="SELECT * FROM backup_schedules WHERE ID='$ID'";
	$mount_path="/opt/artica/mounts/backup/$ID";
	$q=new mysql();
	$unix=new unix();	
	$users=new usersMenus();
	$servername=$users->fqdn;
	$servername=str_replace('.(none)',"",$servername);
	$servername=str_replace(')',"",$servername);
	$servername=str_replace('(',"",$servername);
	
	
	
	
	$ligne=@mysql_fetch_array($q->QUERY_SQL($sql,"artica_backup"));
	
	if(!$q->ok){
		send_email_events("Backup Task $ID:: Mysql database error !","Aborting backup","backup");
		backup_events($ID,"initialization","ERROR, Mysql database error");
		return false;
	}
	
	if(!$GLOBALS["ONNLY_MOUNT"]){
		$pid=$ligne["pid"];	
		if($unix->process_exists($pid)){
			send_email_events("Backup Task $ID::  Already instance $pid running","Aborting backup","backup");
			backup_events($ID,"initialization","ERROR, Already instance $pid running");
			return false;
		}
	}
	
	$sql="UPDATE backup_schedules set pid='".getmypid()."' WHERE ID='$ID'";
	$q->QUERY_SQL($sql,"artica_backup");
		
	$ressources=unserialize(base64_decode($ligne["datasbackup"]));
	if(count($ressources)==0){
		backup_events($ID,"initialization","ERROR,No source specified");
		send_email_events("Backup Task $ID::  No source specified","Aborting backup","backup");
		return false;
	}
	
	if($ressources["OPTIONS"]["STOP_IMAP"]==1){$GLOBALS["NO_STOP_CYRUS"]=" --no-cyrus-stop";}
	
	$backup=new backup_protocols();
	$resource_type=$ligne["resource_type"];
	$pattern=$ligne["pattern"];
	$first_ressource=$backup->extractFirsRessource($ligne["pattern"]);
	$container=$ligne["container"];
	backup_events($ID,"initialization","resource: $resource_type -> $first_ressource");
	if($resource_type==null){
		backup_events($ID,"initialization","ERROR,No resource specified");
		send_email_events("Backup Task $ID:: No resource specified !","Aborting backup","backup");
		return false;
	}
	
	
	
	
	if($resource_type=="smb"){
		$mounted_path_sep="/";
		if(!mount_smb($pattern,$ID,true)){
			backup_events($ID,"initialization","ERROR,$first_ressource unable to mount");
			send_email_events("Backup Task $ID::  resource: $first_ressource unable to mount","Aborting backup","backup");
			
			return false;
		}
	}
	
	
	if($resource_type=="usb"){
		$mounted_path_sep="/";
		if(!mount_usb($pattern,$ID,true)){
			backup_events($ID,"initialization","ERROR,$first_ressource unable to mount");
			send_email_events("Backup Task $ID::  resource: $first_ressource unable to mount","Aborting backup","backup");
			return false;
		}
	}	
	
	if($resource_type=="rsync"){
		$mounted_path_sep=null;
		$mount_path=null;
		$GLOBALS["RESOURCE_MOUNTED"]=false;
		$GLOBALS["USE_RSYNC"]=true;
		$GLOBALS["NO_UMOUNT"]=true;
		
		if(!mount_rsync($pattern,$ID,true)){
			backup_events($ID,"initialization","ERROR,$first_ressource unable to connect");
			send_email_events("Backup Task $ID::  resource: $first_ressource unable to connect","Aborting backup","backup");
			return false;
		}else{
			backup_events($ID,"initialization","INFO,$first_ressource connect success");
		}
		
		
	}	
	
	
	
	if($GLOBALS["ONLY_TESTS"]){
		writelogs(date('m-d H:i:s')." "."[TASK $ID]:umount $first_ressource",__FUNCTION__,__FILE__,__LINE__);
		if($GLOBALS["RESOURCE_MOUNTED"]){exec("umount -l $mount_path");}
		return;
	}
	
	if($GLOBALS["ONNLY_MOUNT"]){return $mount_path;}
	
	
	if($container=="daily"){
		backup_events($ID,"initialization","INFO, Daily container");
		$mount_path_final=$mount_path.$mounted_path_sep."backup.".date('Y-m-d')."/$servername";
	}else{
		backup_events($ID,"initialization","INFO, Weekly container");
		$mount_path_final=$mount_path.$mounted_path_sep."backup.".date('Y-W')."/$servername";
	}
	
if($GLOBALS["DEBUG"]){
		$cmd_verb=" --verbose";
		writelogs(date('m-d H:i:s')." "."[TASK $ID]: Verbose mode detected",__FUNCTION__,__FILE__,__LINE__);
	}

if(!$GLOBALS["NO_STANDARD_BACKUP"]){
	$GLOBALS["MOUNTED_PATH_FINAL"]=$mount_path_final;
	
	while (list ($num, $WhatToBackup) = each ($ressources) ){
		if(is_array($WhatToBackup)){$WhatToBackup_ar=implode(",",$WhatToBackup);}
		backup_events($ID,"initialization","INFO, WhatToBackup ($WhatToBackup) $WhatToBackup_ar");
		if($WhatToBackup=="all"){
			backup_events($ID,"initialization","INFO, Backup starting Running macro all cyrus, mysql, LDAP, Artica...");
			send_email_events("Backup Task $ID:: Backup starting Running macro all ","Backup is running","backup");
			if($users->cyrus_imapd_installed){
				backup_events($ID,"initialization","INFO, cyrus-imapd mailboxes processing");
				backup_cyrus($ID);
			}
			backup_events($ID,"initialization","INFO, LDAP Database processing");
			backup_ldap($ID);
			backup_events($ID,"initialization","INFO, Mysql Database processing");
			backup_mysql($ID);
			backup_events($ID,"initialization","INFO, Artica settings processing");
			backup_artica($ID);
			backup_events($ID,"initialization","continue to next process");
			continue;				
		}
	}
}else{
	backup_events($ID,"initialization","INFO, Skipping standard macros");
	
}
	
	$sql="SELECT * FROM backup_folders WHERE taskid=$ID";
	$results=$q->QUERY_SQL($sql,"artica_backup");	
	if(!$q->ok){
		backup_events($ID,"personal","ERROR, mysql $q->mysql_error");
		return;
	}
	
	
	while($ligne=@mysql_fetch_array($results,MYSQL_ASSOC)){	
		if($ligne["recursive"]==1){$recursive=" --recursive";}else{$recursive=null;}
		$path=trim(base64_decode($ligne["path"]));
		if(!is_dir($path)){
			backup_events($ID,"personal","ERROR, [$path] no such file or directory");
			continue;
			
		}
		
		backup_events($ID,"personal","INFO, Backup starting for $path");
		send_email_events("Backup Task $ID:: Backup starting $path","Backup is running for path $path","backup");
		backup_mkdir($path);
		$results=backup_copy($path,$path,$ID);
		backup_events($ID,"personal","INFO, Backup finish for $path\n$results");
	}
	
	if(!$GLOBALS["NO_UMOUNT"]){
		backup_events($ID,"initialization","INFO, umount $mount_path");
		writelogs(date('m-d H:i:s')." "."[TASK $ID]:umount $mount_path",__FUNCTION__,__FILE__,__LINE__);
		exec("umount -l $mount_path");
	}
	
	$date_end=time();
	$calculate=distanceOfTimeInWords($date_start,$date_end);
	backup_events($ID,"TIME","INFO, Time: $calculate ($source_path)");	
	
	
	backup_events($ID,"initialization","INFO, Backup task terminated");
	send_email_events("Backup Task $ID:: Backup stopping","Backup is stopped","backup");
	
	
	
	shell_exec(LOCATE_PHP5_BIN2()." ".dirname(__FILE__)."/exec.cleanfiles.php");
}


function mount_usb($pattern,$ID,$testwrite=true){
	$backup=new backup_protocols();
	$uuid=$backup->extractFirsRessource($pattern);
	$unix=new unix();
	$rsync=$unix->find_program("rsync");
	
	
	
	if($uuid==null){
		backup_events($ID,"initialization","ERROR, (usb) usb protocol error $pattern");
		writelogs(date('m-d H:i:s')." "."[TASK $ID]: usb protocol error $pattern",__FUNCTION__,__FILE__,__LINE__);
		return false;
	}
	
	$usb=new usb($uuid);
	writelogs(date('m-d H:i:s')." "."[TASK $ID]: $uuid $usb->path $usb->ID_FS_TYPE",__FUNCTION__,__FILE__,__LINE__);	
	
	if($usb->ID_FS_TYPE==null){
		backup_events($ID,"initialization","ERROR, (usb) usb type error $pattern");
		return false;
	}
	
	if($usb->path==null){
		backup_events($ID,"initialization","ERROR, (usb) usb dev error $pattern");
		return false;
	}	
	
	$mount=new mount($GLOBALS["ADDLOG"]);
	$mount_path="/opt/artica/mounts/backup/$ID";
	
	if(!$mount->ismounted($mount_path)){
		backup_events($ID,"initialization","ERROR, (usb) local mount point $mount_path not mounted");
		@mkdir($mount_path,null,true);
	}	
	
	if(!$mount->usb_mount($mount_path,$usb->ID_FS_TYPE,$usb->path)){
		backup_events($ID,"initialization","ERROR, (usb) unable to mount target point");
		return false;	
		
	}
	
	if(!$testwrite){return true;}
	
	$md5=md5(date('Y-m-d H:i:s'));
	@file_put_contents("$mount_path/$md5","#");
	if(is_file("$mount_path/$md5")){
		@unlink("$mount_path/$md5");
		if(is_file($rsync)){
			$GLOBALS["COMMANDLINECOPY"]="$rsync -ar {SRC_PATH} {NEXT} --stats";
		}else{
			$GLOBALS["COMMANDLINECOPY"]="/bin/cp -ru {SRC_PATH} {NEXT}";
		}
		
		$GLOBALS["COMMANDLINE_MOUNTED_PATH"]=$mount_path;		
		writelogs(date('m-d H:i:s')." "."[TASK $ID]: OK !",__FUNCTION__,__FILE__,__LINE__);
		if($GLOBALS["ONLY_TESTS"]){writelogs(date('m-d H:i:s')." "."<H2>{success}</H2>",__FUNCTION__,__FILE__,__LINE__);}
		return true;
	}else{
		backup_events($ID,"initialization","ERROR, (usb) $mount_path/$md5 permission denied");
		exec("umount -l $mount_path");
	}	
	
	
	
}



function mount_smb($pattern,$ID,$testwrite=true){
	$backup=new backup_protocols();
	$unix=new unix();
	$rsync=$unix->find_program("rsync");
	$array=$backup->extract_smb_protocol($pattern);
	
	
	if(!is_array($array)){
		writelogs(date('m-d H:i:s')." "."[TASK $ID]: smb protocol error",__FUNCTION__,__FILE__,__LINE__);
		return false;
	}
	
	$mount_path="/opt/artica/mounts/backup/$ID";
	backup_events($ID,"initialization","INFO, local mount point $mount_path (mount_smb())");
	
	
	$mount=new mount($GLOBALS["ADDLOG"]);
	if(!$mount->ismounted($mount_path)){
		backup_events($ID,"initialization","INFO, local mount point $mount_path not mounted (mount_smb())");
		@mkdir($mount_path,null,true);
	}

	
	if(!$mount->smb_mount($mount_path,$array["SERVER"],$array["USER"],$array["PASSWORD"],$array["FOLDER"])){
		backup_events($ID,"initialization","ERROR, unable to mount target server (mount_smb())");
		return false;
	}
	
	if(!$testwrite){return true;}
	
	$md5=md5(date('Y-m-d H:i:s'));
	exec("/bin/touch $mount_path/$md5 2>&1",$results_touch);
	if(is_file("$mount_path/$md5")){
		@unlink("$mount_path/$md5");
		backup_events($ID,"initialization","INFO, writing test successfully passed OK !");
		if($GLOBALS["ONLY_TESTS"]){writelogs(date('m-d H:i:s')." "."<H2>{success}</H2>",__FUNCTION__,__FILE__,__LINE__);}
		
		if(is_file($rsync)){
			$GLOBALS["COMMANDLINECOPY"]="$rsync -ar --no-p --no-g --no-o {SRC_PATH} {NEXT} --stats -v";
		}else{
			$GLOBALS["COMMANDLINECOPY"]="/bin/cp -ru {SRC_PATH} {NEXT}";
		}
		
		$GLOBALS["COMMANDLINE_MOUNTED_PATH"]=$mount_path;		
		
		return true;
	}else{
		$logs_touch=implode("<br>",$results_touch);
		backup_events($ID,"initialization","ERROR, writing test failed");
		writelogs(date('m-d H:i:s')." "."[TASK $ID]: $logs_touch",__FUNCTION__,__FILE__,__LINE__);
		exec("umount -l $mount_path");
	}
}
function ParseMailboxDir($dir){
	$unix=new unix();
	$targetdir=$dir.$GLOBALS["DIRLIST"];
	@mkdir("/usr/share/artica-postfix/ressources/logs/cache");
	@chmod("/usr/share/artica-postfix/ressources/logs/cache",755);
	
	$cachefile="/usr/share/artica-postfix/ressources/logs/cache/".md5($GLOBALS["dirlist"].$targetdir)."list";
	if(is_file($cachefile)){
		if($unix->file_time_min($cachefile)<1441){
			echo @file_get_contents($cachefile);
			return;
		}
	}
	
	if($GLOBALS["dirlist"]){
		if($GLOBALS["USE_RSYNC"]){
			writelogs(date('m-d H:i:s')." "."Using rsync protocol $targetdir",__FUNCTION__,__FILE__,__LINE__);
			$ser=ParseMailboxDirRsync($targetdir);
			$ser=serialize($ser);
			//@file_put_contents($cachefile,$ser);
			echo $ser;
			return;			

		}
		writelogs(date('m-d H:i:s')." "."directory listing $targetdir",__FUNCTION__,__FILE__);
		exec("/usr/share/artica-postfix/bin/artica-install --dirlists $targetdir",$dirs);
		writelogs(count($dirs)." directories",__FUNCTION__,__FILE__);
		$ser=serialize($dirs);
		@file_put_contents($cachefile,$ser);
		echo $ser;
		return;
	}
	
	
	writelogs(date('m-d H:i:s')." "."parsing $targetdir",__FUNCTION__,__FILE__);
	if($GLOBALS["USE_RSYNC"]){
		writelogs(date('m-d H:i:s')." "."Using rsync protocol $dir",__FUNCTION__,__FILE__);
		$dirs=ParseMailboxDirRsync($targetdir);
		writelogs(count($dirs)." directories",__FUNCTION__,__FILE__);
		echo serialize($dirs);
		return;
	}
	
	
	$dirs=$unix->dirdir($targetdir);
	writelogs(count($dirs)." directories",__FUNCTION__,__FILE__);
	echo serialize($dirs);
	}
	
function restorembx($basedContent){
	$GLOBALS["ONNLY_MOUNT"]=true;
	$unix=new unix();
	$rsync=$unix->find_program("rsync");
	$chown=$unix->find_program("chown");
	$sudo=$unix->find_program("sudo");
	$reconstruct=$unix->LOCATE_CYRRECONSTRUCT();
	if(!is_file($rsync)){
		writelogs(date('m-d H:i:s')." "."Unable to stat rsync program",__FUNCTION__,__FILE__,__LINE__);
		return;
	}
	
	if(!is_file($reconstruct)){
		writelogs(date('m-d H:i:s')." "."Unable to stat reconstruct program",__FUNCTION__,__FILE__,__LINE__);
		return;
	}
		
	
	$array=unserialize(base64_decode($basedContent));
	$id=$array["taskid"];
	writelogs(date('m-d H:i:s')." "."mounting $id",__FUNCTION__,__FILE__);
	$mounted_dir=backup($id);	
	if($mounted_dir==null){
		writelogs(date('m-d H:i:s')." "."cannot mount task id $id",__FUNCTION__,__FILE__);
		return ;
		}
		
		
		
	$path=$array["path"];
	$uid=$array["uid"];
	
	if(preg_match("#INBOX\/(.+)#",$array["mailbox"],$re)){
		$mailbox=$re[1];
		$cyrus=new cyrus();
		$cyrus->CreateSubDir($uid,$mailbox);
	}else{
		$mailbox=$array["mailbox"];
	}
	$localimapdir=$unix->IMAPD_GET("partition-default");
	if(!is_dir($localimapdir)){writelogs(date('m-d H:i:s')." "."Unable to stat local partition-default",__FUNCTION__,__FILE__,__LINE__);return;}
	$userfs=str_replace(".","^",$uid);
	$firstletter=substr($userfs,0,1);
	$localuserfs="$localimapdir/$firstletter/user/$userfs";
	$localimapdir="$localimapdir/$firstletter/user/$userfs/";
	if(!is_dir($localimapdir)){writelogs(date('m-d H:i:s')." "."Unable to stat local \"$localimapdir\"",__FUNCTION__,__FILE__,__LINE__);return;}
	
	
	
	$remoteimapdir="$mounted_dir/$path/$mailbox";
	@mkdir($localimapdir,null,true);
	
	if(substr($remoteimapdir,strlen($remoteimapdir)-1,1)<>"/"){$remoteimapdir=$remoteimapdir."/";}
	
	
	 $cmd="$rsync -z --stats $remoteimapdir* $localimapdir 2>&1";
	if($GLOBALS["USE_RSYNC"]){
		$backup=new backup_protocols();
		writelogs(date('m-d H:i:s')." "."Using rsync protocol",__FUNCTION__,__FILE__,__LINE__);
		$array_config=$backup->extract_rsync_protocol($remoteimapdir);
		if(!is_array($array)){
			writelogs(date('m-d H:i:s')." "."[TASK $ID]: rsync protocol error",__FUNCTION__,__FILE__,__LINE__);
			return false;
		}	
		
		if($array_config["PASSWORD"]<>null){
			$tmpstr="/opt/artica/passwords/".md5($array_config["PASSWORD"]);
			@mkdir("/opt/artica/passwords",null,true);
			@file_put_contents($tmpstr,$array_config["PASSWORD"]);
			$pwd=" --password-file=$tmpstr";
		}
	
		if($array["USER"]<>null){
			$user="{$array["USER"]}@";
		}
		
		$cmd="$rsync$pwd --stats rsync://$user{$array_config["SERVER"]}/{$array_config["FOLDER"]}*  $localimapdir 2>&1";
		
		
		
	}
	writelogs(date('m-d H:i:s')." "."Restore from $remoteimapdir",__FUNCTION__,__FILE__,__LINE__);
	writelogs(date('m-d H:i:s')." "."Restore to $localimapdir",__FUNCTION__,__FILE__,__LINE__);
	writelogs(date('m-d H:i:s')." "."reconstruct path $reconstruct",__FUNCTION__,__FILE__,__LINE__);
	writelogs(date('m-d H:i:s')." "."$cmd",__FUNCTION__,__FILE__,__LINE__);
	exec($cmd,$rsynclogs);
	
	$i=0;
	while (list ($num, $line) = each ($rsynclogs)){
		if(preg_match("#Number of files transferred:\s+([0-9]+)#",$line,$re)){$GLOBALS["events"][]="Files restored: {$re[1]}";}
		if(preg_match("#Total transferred file size:\s+([0-9]+)#",$line,$re)){$bytes=$re[1];$re[1]=round(($re[1]/1024)/1000)."M";$GLOBALS["events"][]="{$re[1]} size restored ($bytes bytes)";}		
		if(preg_match("#Permission denied#",$line)){$i=$i+1;}
		
	}
	$GLOBALS["events"][]="$i file(s) on error";
	shell_exec("$chown -R cyrus:mail $localuserfs");
	shell_exec("/bin/chmod -R 755 $localuserfs");
	
	$cmd="$sudo -u cyrus $reconstruct -r -f user/$uid 2>&1";
	writelogs(date('m-d H:i:s')." "."$cmd",__FUNCTION__,__FILE__,__LINE__);
	exec($cmd,$rsynclogs);
	$GLOBALS["events"][]="Reconstruct information: ";
	while (list ($num, $line) = each ($rsynclogs)){
		$GLOBALS["events"][]="reconstructed path: $line";
	}	
	
	writelogs(date('m-d H:i:s')." "."restarting imap service",__FUNCTION__,__FILE__,__LINE__);
	system("/etc/init.d/artica-postfix restart imap");
	print_r($GLOBALS["events"]);
	
}

function mount_rsync($pattern,$ID,$testwrite=true){
	$backup=new backup_protocols();
	$unix=new unix();
	$rsync=$unix->find_program("rsync");
	
	if(!is_file($rsync)){
		backup_events($ID,"initialization","ERROR, unable to stat rsync ".__FUNCTION__);
		return false;
	}
	
	$array=$backup->extract_rsync_protocol($pattern);
	if(!is_array($array)){
		backup_events($ID,"initialization","ERROR, rsync protocol error ".__FUNCTION__);
		return false;
	}	
	
	backup_events($ID,"initialization","INFO, " .strlen($array["PASSWORD"])." length password ".__FUNCTION__);
	
	if($array["PASSWORD"]<>null){
		@mkdir("/root/.backup.pwd",600,true);
		$tmpstr="/root/.backup.pwd/$ID";
		@file_put_contents($tmpstr,$array["PASSWORD"]);
		if(!is_file($tmpstr)){
			backup_events($ID,"initialization","ERROR, $tmpstr no such file or directory ".__FUNCTION__);
			return false;
		}
		@chmod($tmpstr,600);
		@chown($tmpstr,"root:root");
		$pwd=" --password-file=$tmpstr";
	}
	
	if($array["USER"]<>null){
		$user="{$array["USER"]}@";
	}
	
	$pattern_list="$rsync --list-only$pwd rsync://$user{$array["SERVER"]}/{$array["FOLDER"]} --stats --dry-run 2>&1";
	
	if($GLOBALS["DEBUG"]){echo "mount_rsync():: Listing files or directories using \"$pattern_list\"\n";}
	
	exec($pattern_list,$results);
	
	
	while (list ($num, $line) = each ($results)){
		if(preg_match("#\@ERROR#",$line)){
		backup_events($ID,"initialization","ERROR, failed to connect rsync://$user{$array["SERVER"]}/{$array["FOLDER"]}".__FUNCTION__);
		if($GLOBALS["DEBUG"]){echo "mount_rsync()::  found  \"$line\"\n";}
		}
		
		if(preg_match("#Number of files#",$line)){
			$GLOBALS["COMMANDLINECOPY"]="$rsync -ar {SRC_PATH} rsync://$user{$array["SERVER"]}/{$array["FOLDER"]}/{NEXT} --stats $pwd";
			$GLOBALS["COMMANDLINE_MOUNTED_PATH"]=null;
			return true;
		
		}
	}

	backup_events($ID,"initialization","ERROR, No information has been returned... ".__FUNCTION__);
	system("/bin/rm -rf /tmp/artica-temp");
}

function ParseMailboxDirRsync($pattern){
	$backup=new backup_protocols();
	$unix=new unix();
	$rsync=$unix->find_program("rsync");

	$array=$backup->extract_rsync_protocol($pattern);
	if(!is_array($array)){
		writelogs(date('m-d H:i:s')." "."rsync protocol error",__FUNCTION__,__FILE__,__LINE__);
		return false;
	}	
	
	if($array["PASSWORD"]<>null){
		$tmpstr=$unix->FILE_TEMP();
		@file_put_contents($tmpstr,$array["PASSWORD"]);
		$pwd=" --password-file=$tmpstr";
	}
	
	if($array["USER"]<>null){
		$user="{$array["USER"]}@";
	}	
	
	$pattern_list="$rsync --list-only$pwd rsync://$user{$array["SERVER"]}/{$array["FOLDER"]}/ --stats --dry-run 2>&1";
	
	if($GLOBALS["DEBUG"]){echo "ParseMailboxDirRsync():: Listing files or directories using \"$pattern_list\"\n";}
	
	writelogs(date('m-d H:i:s')." "."$pattern_list",__FUNCTION__,__FILE__,__LINE__);
	exec($pattern_list,$results);
	@unlink($tmpstr);
	unset($array);
	
	while (list ($num, $line) = each ($results)){
		
		if(preg_match("#^d[rwx\-]+\s+[0-9]+\s+[0-9\/]+\s+[0-9\:]+\s+(.+)#",$line,$re)){
			writelogs($re[1],__FUNCTION__,__FILE__,__LINE__);
			if(trim($re[1])=='.'){continue;}
			$array[trim($re[1])]=trim($re[1]);
			continue;
		}
	}
	
	return $array;
	
}

function backup_ldap($ID){
	$unix=new unix();
	$slapcat=$unix->find_program("slapcat");
	if($slapcat==null){
		backup_events($ID,"ldap","ERROR, unable to stat slapcat");
		return false;
	}
	backup_events($ID,"ldap","INFO, exporting local database");
	shell_exec("$slapcat -l /tmp/ldap.ldif");
	
	backup_mkdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/ldap_backup");
	if(!backup_isdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/ldap_backup")){
		backup_events($ID,"ldap","ERROR, ldap_backup permission denied or no such file or directory");
		return false;
	}
	
	$info=backup_copy("/tmp/ldap.ldif","{$GLOBALS["MOUNTED_PATH_FINAL"]}/ldap_backup",$ID);
	$ldap=new clladp();
	@file_put_contents("/tmp/suffix",$ldap->suffix);
	$info=backup_copy("/tmp/ldap.ldif","{$GLOBALS["MOUNTED_PATH_FINAL"]}/ldap_backup",$ID); 
}


function backup_mysql($ID){
$sock=new sockets();	
$unix=new unix();
$date_start=time();
	$mysqlhotcopy=$unix->find_program("mysqlhotcopy");
	
	
	if($mysqlhotcopy==null){
		backup_events($ID,"mysql","ERROR, unable to stat mysqlhotcopy");
		return false;
	}
	
	$array=backup_mysql_databases_list($ID);
	if(!is_array($array)){
		backup_events($ID,"mysql","ERROR, unable to get databases list");
		return false;		
	}
	
	
	$q=new mysql();
	if($q->mysql_password<>null){$password=" --password=$q->mysql_password";}
	if($q->mysql_admin<>null){$user=" --user=$q->mysql_admin";}
	$temporarySourceDir=$sock->GET_INFO("ExecBackupTemporaryPath");
	if($temporarySourceDir==null){$temporarySourceDir="/home/mysqlhotcopy";}
	$temporarySourceDir="$temporarySourceDir/mysql";
	
	
	@mkdir($temporarySourceDir,0666,true);
	if(!is_dir($temporarySourceDir)){
		backup_events($ID,"mysql","ERROR, $temporarySourceDir permission denied or no such file or directory");
		return ;
	}
	
	backup_events($ID,"mysql","INFO, using $temporarySourceDir for temp backup");
	
	while (list ($num, $line) = each ($array)){
		if(trim($line)==null){continue;}
		backup_events($ID,"mysql","INFO, mysqlhotcopy ($line) -> $temporarySourceDir");
		unset($results);
		
		exec("$mysqlhotcopy --addtodest$user$password $line $temporarySourceDir 2>&1",$results);
		while (list ($num_line, $evenement) = each ($results)){
			if(preg_match("#No space left on device#",$evenement)){
				backup_events($ID,"mysql","ERROR, backup No space left on device ($temporarySourceDir)\n". implode("\n",$results));
				if(is_dir($temporarySourceDir)){shell_exec("/bin/rm -rf $temporarySourceDir/*");}
				return;
			}
		}
		backup_events($ID,"mysql","INFO, backup $line\n". implode("\n",$results));
		
		if(strtolower($line)=="zarafa"){
			backup_mysql_database_mysqldump($ID,"zarafa",$temporarySourceDir);
		}

	}	
	backup_events($ID,"mysql","INFO, Send mysql backup to the \n". implode("\n",$results));
	
	backup_mkdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/mysql");
	backup_copy("$temporarySourceDir/*","mysql",$ID);
	backup_events($ID,"mysql","INFO, backup remove content of $temporarySourceDir/*");
	if(is_dir($temporarySourceDir)){shell_exec("/bin/rm -rf $temporarySourceDir/*");}
	backup_events($ID,"mysql","INFO, backup END without known error");
	
	$date_end=time();
	$calculate=distanceOfTimeInWords($date_start,$date_end);
	backup_events($ID,"mysql","INFO, time: $calculate");
	
}

function backup_mysql_database_mysqldump($ID,$database,$temporarySourceDir){
	$date_start=time();
	$q=new mysql();
	if($q->mysql_password<>null){$password=" -p$q->mysql_password";}
	if($q->mysql_admin<>null){$user=" -u $q->mysql_admin";}
	
	
	
	$unix=new unix();
	$mysqldump=$unix->find_program("mysqldump");
	$bzip2=$unix->find_program("bzip2");
	if($mysqldump==null){
		backup_events($ID,"mysql","ERROR, Unable to find mysqldump");
		return;
	}
	
	$target_file="$temporarySourceDir/$database.tar.bz2";
	
	$cmd="$mysqldump$user$password --single-transaction --skip-add-locks --skip-lock-tables $database | $bzip2 > $target_file 2>&1";
	backup_events($ID,"mysql","INFO, Dumping $database mysql database");
	exec($cmd,$results);
	$date_end=time();
	
	$calculate=distanceOfTimeInWords($date_start,$date_end);
	
	backup_events($ID,"mysql","INFO, $database $calculate");
	
	while (list ($num_line, $evenement) = each ($results)){
			if(preg_match("#Error\s+([0-9]+)#",$evenement)){
				backup_events($ID,"mysql","ERROR, $evenement");
				return;
			}
		}	
	
	
	if(!is_file("$target_file")){
		backup_events($ID,"mysql","ERROR, Dumping $database mysql database failed, $target_file no such file or directory");
		return;
	}
		$size=$unix->file_size_human("$target_file");
		backup_events($ID,"mysql","INFO, END dumping $database mysql database ($size)");
	}

function backup_mysql_databases_list($ID){
	$users=new usersMenus();
	$mysqldir=$users->mysqld_datadir;
	if(!is_dir($mysqldir)){
		backup_events($ID,"mysql","ERROR, unable to stat directory ($mysqldir)");
		return;
	}
	$unix=new unix();
	$array=$unix->dirdir($mysqldir);
	while (list ($num, $line) = each ($array)){$results[]=$line;}
	return $results;
}

function backup_artica($ID){
	backup_mkdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/etc-artica-postfix");
	backup_copy("/etc/artica-postfix","etc-artica-postfix",$ID);
	backup_events($ID,"mysql","INFO, backup Artica done");
}


function backup_cyrus($ID){
	$date_start=time();
	$users=new usersMenus();
	if(!$users->cyrus_imapd_installed){
		backup_events($ID,"cyrus-imap","INFO, cyrus-impad NOT Installed");
		return true;
	}
	
	if($GLOBALS["COMMANDLINECOPY"]==null){
		backup_events($ID,"cyrus-imap","ERROR, COMMANDLINECOPY is null");
		return false;
	}
	
	$partition_default=$users->cyr_partition_default;
	$config_directory=$users->cyr_config_directory;

	backup_events($ID,"cyrus-imap","INFO, partition-default=$partition_default\nDirectory config=$config_directory");
	
	backup_mkdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/partitiondefault");
	backup_mkdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/configdirectory");
	
	if(!backup_isdir("{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/configdirectory")){
		backup_events($ID,"cyrus-imap","ERROR, $mounted_path/cyrus-imap/configdirectory permission denied or no such file or directory");
		return false;
	}

	$info=backup_copy($config_directory,"{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/configdirectory",$ID);
	backup_events($ID,"cyrus-imap","INFO,configdirectory\n$info");
	$info=backup_copy($partition_default,"{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/partitiondefault",$ID);
	backup_events($ID,"cyrus-imap","INFO,partitiondefault\n$info");
	$cmd="su - cyrus -c \"$users->ctl_mboxlist -d >/tmp/mailboxlist.txt\"";
	exec($cmd,$results);
	
	if(!is_file("/tmp/mailboxlist.txt")){
		backup_events($ID,"cyrus-imap","ERROR,unable to export mailbox list\n$cmd\n".implode("\n",$results));
	}
	$info=backup_copy("/tmp/mailboxlist.txt","{$GLOBALS["MOUNTED_PATH_FINAL"]}/cyrus-imap/mailboxlist.txt",$ID);
	backup_events($ID,"cyrus-imap","INFO, mailboxlist.txt\n$info");
	$date_end=time();
	$calculate=distanceOfTimeInWords($date_start,$date_end);
	backup_events($ID,"cyrus-imap","INFO, time: $calculate");
	
}

function backup_isdir($path){
	$results[]="SRC: $path";
	if($GLOBALS["USE_RSYNC"]){
		$cmd=str_replace("{SRC_PATH}","--list-only",$GLOBALS["COMMANDLINECOPY"]);
		$cmd=str_replace("-ar"," ",$cmd);
		$cmd=str_replace("{NEXT}","$path",$cmd);
		exec($cmd,$results);
		while (list ($num, $line) = each ($results)){if(preg_match("#No such file or directory#",$line)){return false;}}
		return true;
	}
	
	return is_dir($path);
	
}

function backup_copy($source_path,$dest_path,$ID=null){
		$date_start=time();
		$cmd=str_replace("{SRC_PATH}",$source_path,$GLOBALS["COMMANDLINECOPY"]);
		$GLOBALS["MOUNTED_PATH_FINAL"]=trim($GLOBALS["MOUNTED_PATH_FINAL"]);
		writelogs(date('m-d H:i:s')." "."#########################################",__FUNCTION__,__FILE__,__LINE__);
		writelogs(date('m-d H:i:s')." "."Starting point {$GLOBALS["MOUNTED_PATH_FINAL"]}",__FUNCTION__,__FILE__,__LINE__);
		writelogs(date('m-d H:i:s')." "."command line=$cmd",__FUNCTION__,__FILE__,__LINE__);
		if($GLOBALS["MOUNTED_PATH_FINAL"]<>null){
			$dest_path=str_replace($GLOBALS["MOUNTED_PATH_FINAL"],"",$dest_path);
		}
		
		$final_path="{$GLOBALS["MOUNTED_PATH_FINAL"]}/$dest_path";
		$final_path=str_replace('//','/',$final_path);
		$cmd=str_replace("{NEXT}",$final_path,$cmd);
		writelogs(date('m-d H:i:s')." "."Copy directory $source_path to $final_path",__FUNCTION__,__FILE__,__LINE__);
		writelogs(date('m-d H:i:s')." "."$cmd",__FUNCTION__,__FILE__,__LINE__);
		exec($cmd. " 2>&1",$results);
		if(!check_rsync_error($results)){
		if($ID>0){backup_events($ID,"Copy","ERROR,$cmd");}}else{if($ID>0){backup_events($ID,"Copy","INFO,$cmd");}}
		
		
		$date_end=time();
		$calculate=distanceOfTimeInWords($date_start,$date_end);
		backup_events($ID,"Copy","INFO, time: $calculate ($source_path)");
		writelogs(date('m-d H:i:s')." "."#########################################",__FUNCTION__,__FILE__,__LINE__);
		
		
		return @implode("\n",$results);
		
}

function check_rsync_error($ID,$results){
		while (list ($num, $line) = each ($results)){
			writelogs(date('m-d H:i:s')." "."[TASK $task_id]: $line ",__FUNCTION__,__FILE__,__LINE__);
			if(preg_match("#rsync error#",$line)){
			 if(preg_match("#some files\/attrs were not transferred#")){continue;}
			 if(preg_match("#some files vanished before they could be transferred#")){continue;}
			 if($ID>0){backup_events($ID,"Copy","ERROR,$line\n$cmd");return false;}
			}
		}
	return true;	
	}


function backup_mkdir($path){
	
	if($GLOBALS["USE_RSYNC"]){
		writelogs(date('m-d H:i:s')." "."create directory /tmp/artica-temp/$path",__FUNCTION__,__FILE__,__LINE__);
		@mkdir("/tmp/artica-temp/$path",600,true);
		chdir("/tmp/artica-temp");
		@file_put_contents("/tmp/artica-temp/$path/.default","#");
		$cmd=str_replace("{SRC_PATH}","/tmp/artica-temp/*",$GLOBALS["COMMANDLINECOPY"]);
		$cmd=str_replace("{NEXT}","",$cmd);
		writelogs($cmd,__FUNCTION__,__FILE__,__LINE__);
		system($cmd);
		shell_exec("/bin/rm -rf /tmp/artica-temp/*");
		chdir("/root");
		return;
	}
	
	@mkdir("$path",0600,true);
	if(!is_dir("$path")){
		writelogs("Unable to create directory $path no such file or directory",__FUNCTION__,__FILE__,__LINE__);
	}
}


function backup_events($task_id,$source_type,$text){
	$text=addslashes($text);
	$date=date('Y-m-d H:i:s');
	writelogs(date('m-d H:i:s')." "."[TASK $task_id]: $text",__FUNCTION__,__FILE__,__LINE__);
	$sql="INSERT INTO `backup_events`(task_id,zdate,backup_source,event) VALUES('$task_id','$date','$source_type','$text');";
	$md5=md5($sql);
	if(!$GLOBALS["ONLY_TESTS"]){
		@file_put_contents("/var/log/artica-postfix/sql-events-queue/$md5.sql",$sql);
	}
}




?>
