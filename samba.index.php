<?php
	include_once('ressources/class.templates.inc');
	include_once('ressources/class.ldap.inc');
	include_once('ressources/class.users.menus.inc');
	include_once('ressources/class.artica.inc');
	include_once('ressources/class.ini.inc');
	include_once('ressources/class.samba.inc');
	include_once('ressources/class.user.inc');
	include_once('ressources/class.kav4samba.inc');
	
	

	
	if(!CheckSambaRights()){die();}
	if( isset($_POST['upload']) ){main_kav4samba_LicenceUploaded();exit();}
	if(isset($_GET["FolderDelete"])){folder_delete();exit;}
	if(isset($_GET["mkdirp"])){mkdirp();exit;}
	if(isset($_GET["TreeRightInfos"])){TreeRightInfos();exit;}
	if(isset($_GET["userlists"])){echo folder_security_list_users();exit;}
	if(isset($_GET["AddUserToFolder"])){folder_security_adduser();exit;}
	if(isset($_GET["SaveUseridPrivileges"])){folder_security_save_priv();exit;}
	if(isset($_GET["main"])){main_switch();exit;}
	
	if(!CheckSambaUniqueRights()){die();}
	if(isset($_GET["script"])){popup_js();exit;}
	if(isset($_GET["popup"])){popup_page();exit;}
	if(isset($_GET["SaveGeneralSettings"])){SaveConf();exit;}
	if(isset($_GET["status"])){echo main_status();exit;}
	if(isset($_GET["GetTreeFolders"])){browser();exit;}
	if(isset($_GET["AddTreeFolders"])){AddShareFolder();exit;}
	if(isset($_GET["UserSecurityInfos"])){echo folder_UserSecurityInfos();exit;}
	if(isset($_GET["prop"])){folder_properties_switch();exit;}
	if(isset($_GET["SaveFolderProp"])){SaveFolderProp();exit;}
	if(isset($_GET["security"])){folder_security_users();exit;}
	if(isset($_GET["finduserandgroup"])){folder_security_users_find();exit;}
	if(isset($_GET["UseAVbasesSet"])){main_kav4samba_save();exit;}
	if(isset($_GET["kav_actions"])){main_kav4samba_save_actions();exit;}
	if(isset($_GET["vfs_object"])){save_folder_vfs();exit;}
	if(isset($_GET["upload"])){main_kav4samba_upload_licence();exit;}
	
	if(isset($_GET["neighborhood"])){neighborhood_index();exit;}
	if(isset($_GET["neighborhood-save"])){neighborhood_save();exit;}
	
	if(isset($_GET["DomainAdmin"])){DomainAdmin_index();exit;}
	if(isset($_GET["domain-admin-save"])){DomainAdmin_save();exit;}
	if(isset($_GET["syncronize"])){syncronize_js();exit;}
	if(isset($_GET["syncronize-confirm"])){syncronize_exec();exit;}
	
	if(isset($_GET["js-security-infos"])){folder_UserSecurityInfos_js();exit;}
	if(isset($_GET["js-securityf-infos"])){folder_security_js();exit;}

	if(isset($_GET["name-resolve-order-list"])){name_resolve_order();exit;}
	
	die("Wrong query");

	
function ChekGlobalRights(){
	$user=new usersMenus();
	if($user->AsArticaAdministrator){return true;}
	if($user->AsSambaAdministrator){return true;}
	if($user->AsOrgStorageAdministrator){return true;}
	return false;
}

function CheckSambaUniqueRights(){
	$user=new usersMenus();
	if($user->AsArticaAdministrator){return true;}
	if($user->AsSambaAdministrator){return true;}	
}
	
function syncronize_exec(){
	$sock=new sockets();
	$sock->getFrameWork("cmd.php?samba-synchronize=yes");
	$tpl=new templates();
	echo strip_tags(replace_accents($tpl->_ENGINE_parse_body("{success}\n{apply_upgrade_help}")));
}
	
function syncronize_js(){
	$page=CurrentPageName();
	$tpl=new templates();
	$text=$tpl->_ENGINE_parse_body("{samba_synchronize_explain}");
	$text=str_replace("\n","\\n",$text);
	
	$users=new usersMenus();
	if(!$users->AsSambaAdministrator){
		$error=$tpl->_ENGINE_parse_body("{ERROR_NO_PRIVS}");
		echo "alert('$error')";
		die();
	}	
	
	$html="
	//
	
var x_samba_sync_load= function (obj) {
	var results=obj.responseText;
	alert(results);
	}	
	
	
	function samba_sync_load(){
			if(confirm('$text')){
				var XHR = new XHRConnection();
				XHR.appendData('syncronize-confirm','yes');
				XHR.sendAndLoad('$page', 'GET',x_samba_sync_load);
				}
			}
	
	
	samba_sync_load();";
			
			echo $html;
	
}
	
function main_page(){
	

	
	$html=
	"
<script language=\"JavaScript\">       
var timerID  = null;
var timerID1  = null;
var tant=0;
var reste=0;

function demarre(){
   tant = tant+1;
   reste=10-tant;
	if (tant < 10 ) {                           
      timerID = setTimeout(\"demarre()\",5000);
      } else {
               tant = 0;
               //document.getElementById('wait').innerHTML='<img src=img/wait.gif>';
               ChargeLogs();
               demarre();                                //la boucle demarre !
   }
}


function ChargeLogs(){
	LoadAjax('services_status','$page?status=yes&hostname={$_GET["hostname"]}');
	if(document.getElementById('kaveventsShow')){
		LoadAjax('main_smb_config','$page?main=kav4samba&kavTab=events&hostname={$_GET["hostname"]}')
	}
	
	}
</script>	
	
	<table style='width:100%'>
	<tr>
	<td width=1% valign='top'><img src='img/bg_samba.png'>	<p class=caption>{about}</p></td>
	<td valign='top'><div id='services_status'>". main_status() . "</div></td>
	</tr>
	<tr>
		<td colspan=2 valign='top'><br>
			<div id='main_smb_config'></div>
		</td>
	</tr>
	</table>
	<script>demarre();LoadAjax('main_smb_config','$page?main=yes');</script>
	
	";
	
	$cfg["JS"][]='js/samba.js';
	$cfg["JS"][]="js/json.js";
	$tpl=new template_users('{APP_SAMBA}',$html,0,0,0,0,$cfg);
	echo $tpl->web_page;
	}

function popup_js(){
	$json=file_get_contents("js/json.js");
	$samba=file_get_contents("js/samba.js");
	$tpl=new templates();
	$windows_network_neighborhood=$tpl->_ENGINE_parse_body('{windows_network_neighborhood}');
	$domain_admin=$tpl->_ENGINE_parse_body("{domain_admin}");
	$ERR_NO_PASS_MATCH=$tpl->_ENGINE_parse_body("{ERR_NO_PASS_MATCH}");
	$page=CurrentPageName();
	$title=$tpl->_parse_body("{APP_SAMBA}");
	
	$start="load();";
	if(isset($_GET["behavior"])){$start="neighborhood();";}
	if(isset($_GET["behavior-admin"])){$start="DomainAdmin();";}
	

	
	$html="
 	
	$start
	
	function load(){
		YahooWin(850,'$page?popup=yes','$title');	
	}	
	
	function neighborhood(){
		YahooWin2(350,'$page?neighborhood=yes','$windows_network_neighborhood');
	}
	
	function x_Save_neighborhood_form(obj) {
		var tempvalue=obj.responseText;
		if(tempvalue.length>0){alert(tempvalue);}	
		neighborhood();
	}		
	
	function Save_neighborhood_form(field_id){
		var value=document.getElementById(field_id).value;
		document.getElementById('neighborhood_index').innerHTML='<center><img src=\"img/wait_verybig.gif\"></center>';
		var XHR = new XHRConnection();
		XHR.appendData('neighborhood-save',field_id);
		XHR.appendData('value',value);
		XHR.sendAndLoad('$page', 'GET',x_Save_neighborhood_form);				
	
	}
	
	function x_DomainAdminSave(obj) {
		var tempvalue=obj.responseText;
		if(tempvalue.length>0){alert(tempvalue);}	
		YahooWin2Hide();
	}			
	
	
	function DomainAdminSave(){
		var password1=document.getElementById('password1').value;
		var password2=document.getElementById('password2').value;
		
		if(password1!==password2){
			alert('$ERR_NO_PASS_MATCH');
			return false;
		}
		
		document.getElementById('DomainAdminSave').innerHTML='<center><img src=\"img/wait_verybig.gif\"></center>';
		var XHR = new XHRConnection();
		XHR.appendData('domain-admin-save',password1);
		XHR.sendAndLoad('$page', 'GET',x_DomainAdminSave);			
	
	}
	
	function DomainAdminSaveKey(e){
		if(checkEnter(e)){
				DomainAdminSave();
			}
	}
	
	function DomainAdmin(){
		YahooWin2(350,'$page?DomainAdmin=yes','$domain_admin');
	}
	
	$json
	$samba
	";
$user=new usersMenus();
$tpl=new templates();
if($user->AsSambaAdministrator==false){$html=$tpl->_ENGINE_parse_body("alert('{ERROR_NO_PRIVS}');");}		
	
	echo $html;
}

function popup_page(){echo main_tabs();}

function main_tabs(){

	$page=CurrentPageName();
	$array["yes"]='{main_settings}';
	$array["shared_folders"]='{shared_folders}';
	$array["conf"]='{config}';
	$array["acldisks"]="{acl_disks}";
	$array["events"]="{events}";
	$tpl=new templates();
	
	$users=new usersMenus();
	if($users->KAV4SAMBA_INSTALLED){
		$array["kav4samba"]='{APP_KAV4SAMBA}';	
	}
	
	
	
	while (list ($num, $ligne) = each ($array) ){
		if($num=="acldisks"){
			$html[]= $tpl->_ENGINE_parse_body("<li><a href=\"samba.shared.folders.list.php?acldisks=yes\"><span>$ligne</span></li>\n");
			continue;
		}
		
		if($num=="events"){
			$html[]= $tpl->_ENGINE_parse_body("<li><a href=\"samba.events.php\"><span>$ligne</span></li>\n");
			continue;
		}		
		
		$html[]= $tpl->_ENGINE_parse_body("<li><a href=\"$page?main=$num\"><span>$ligne</span></li>\n");
	}
	
	
	return "
	<div id=main_config_samba style='width:100%;height:650px;overflow:auto'>
		<ul>". implode("\n",$html)."</ul>
	</div>
		<script>
				$(document).ready(function(){
					$('#main_config_samba').tabs({
				    load: function(event, ui) {
				        $('a', ui.panel).click(function() {
				            $(ui.panel).load(this.href);
				            return false;
				        });
				    }
				});
			

			});
		</script>";		
	
	
}


function main_switch(){
	
	switch ($_GET["main"]) {
		case "yes":main_smb_config();exit;break;
		case "logs":main_logs();exit;break;
		case "shared_folders":shared_folders();exit;break;
		case "trusted_networks_list": echo main_trusted_networks_list();exit;break;
		case "conf":echo main_conf();exit;break;
		case "plugins";echo main_plugins();exit;
		case "kav4samba";echo main_kav4samba();exit;
		default:main_smb_config();
			break;
	}
	
	
}	

function main_status_smbd(){
if($_GET["hostname"]==null){$hostname=$users->hostname;$_GET["hostname"]=$hostname;}else{$hostname=$_GET["hostname"];}		
	$ini=new Bs_IniHandler();
	$sock=new sockets();
	$ini->loadString($sock->getFrameWork("cmd.php?samba-status=yes"));
	$status=DAEMON_STATUS_ROUND("SAMBA_SMBD",$ini);
	$tpl=new templates();
	return $tpl->_ENGINE_parse_body($status);	
	
}

function main_status_nmbd(){
if($_GET["hostname"]==null){$hostname=$users->hostname;$_GET["hostname"]=$hostname;}else{$hostname=$_GET["hostname"];}		
	$ini=new Bs_IniHandler();
	$sock=new sockets();
	$ini->loadString($sock->getFrameWork("cmd.php?samba-status=yes"));
	$status=DAEMON_STATUS_ROUND("SAMBA_NMBD",$ini);
	$tpl=new templates();
	return $tpl->_ENGINE_parse_body($status);	
	
}
function main_status_scannedonly(){
		
	$ini=new Bs_IniHandler();
	$sock=new sockets();
	$ini->loadString($sock->getFrameWork("cmd.php?samba-status=yes"));
	$status=DAEMON_STATUS_ROUND("SAMBA_SCANNEDONLY",$ini);
	$tpl=new templates();
	return $tpl->_ENGINE_parse_body($status);	
	
}

function main_status_active_directory(){
	$sock=new sockets();
	$EnableSambaActiveDirectory=$sock->GET_INFO("EnableSambaActiveDirectory");
	if($EnableSambaActiveDirectory==0){return null;}
	$config=unserialize(base64_decode($sock->GET_INFO("SambaAdInfos")));	
	$WORKGROUP=base64_encode($config["WORKGROUP"]);
	$ADSERVER=$config["ADSERVER"];
	$results=unserialize(base64_decode($sock->getFrameWork("cmd.php?wbinfo-domain=$WORKGROUP")));
	if(strtolower($results["Active Directory"])=='yes'){
		$img="42-green.png";
	}else{
		$img="42-red.png";
	}
	
	if(strlen($results["Alt_Name"])>14){$results["Alt_Name"]=texttooltip(substr($results["Alt_Name"],0,14)."...",$results["Alt_Name"],null,null,1,"font-size:10px");}
	if(strlen($results["SID"])>14){$results["SID"]=texttooltip(substr($results["SID"],0,14)."...",$results["SID"],null,null,1,"font-size:10px");}
	
$html="<table style='width:1OO%'>
<tr>
<td width=1% valign='top'>" . imgtootltip($img,'{make_samba_ad}',"Loadjs('samba.ad.php')")."</td>
<td>
	<table style='width:100%'>
		<tr>
		<td align='right' nowrap><strong>{activedirectory_server}:</td>
		<td><strong><span style='font-size:12px'>$ADSERVER</strong></td>
		</tr>
		<tr>
		<td align='right' nowrap><strong>{activedirectory_domain}:</td>
		<td><strong><span style='font-size:10px'>{$results["Alt_Name"]}</strong></td>
		</tr>		
		<tr>
		<td align='right' nowrap><strong>SID:</td>
		<td><strong><span style='font-size:10px'>{$results["SID"]}</strong></td>
		</tr>			
	</table>
	</td>
</table>";	
$tpl=new templates();
return RoundedLightGreen($tpl->_ENGINE_parse_body($html));
	
}


function main_status(){
	
	$ad=main_status_active_directory();
	if($ad<>null){$ad="<br>$ad";}
return "<div style='width:290px'>".main_status_smbd() . "<br>" . main_status_nmbd()."$ad<br>".main_status_scannedonly()."</div>";
	
}


function main_smb_config(){
	$style="style='padding:3px;border-bottom:1px dotted #CCCCCC'";
	$sock=new sockets();
	$tpl=new templates();
	$page=CurrentPageName();
	$SambaEnabled=$sock->GET_INFO("SambaEnabled");
	$EnableSambaActiveDirectory=$sock->GET_INFO("EnableSambaActiveDirectory");
	if($SambaEnabled==null){$SambaEnabled=1;}	
	$disable_samba=Paragraphe("server-disable-64.png",'{enable_disable_samba}','{enable_disable_samba_text}',
	"javascript:Loadjs('samba.disable.php');",'{enable_disable_samba_text}',260,null,1);	
	
	
	if($SambaEnabled==0){
				$html=main_tabs()."<br>
			<h5>{main_settings}</H5>
			<center style='margin:50px'>$disable_samba</center>";
			
			$tpl=new templates();
			echo $tpl->_ENGINE_parse_body($html);
			exit;
	}
	
	$users=new usersMenus();
	if($_GET["hostname"]==null){$hostname=$users->hostname;$_GET["hostname"]=$hostname;}else{$hostname=$_GET["hostname"];}
	$smb=new samba();
	$page=CurrentPageName();
	$ldap=new clladp();
	
	for($i=0;$i<11;$i++){
		$logh[$i]=$i;
	}
	
	$icon_samba_type=Paragraphe("64-server-ask.png",'{windows_network_neighborhood}','{windows_network_neighborhood_text}',
	"javascript:neighborhood();",'{windows_network_neighborhood}',260,null,1);
	
	$admin_domain=Paragraphe("members-priv-64.png",'{domain_admin}','{domain_admin_text}',
	"javascript:DomainAdmin();",'{domain_admin_text}',260,null,1);
	
	
	$acl_support=Paragraphe("acl-support-64.png",'{ACLS_SUPPORT}','{ACLS_SUPPORT_TEXT}',
	"javascript:Loadjs('samba.acls.settings.php');",'{ACLS_SUPPORT_TEXT}',260,null,1);
	
	
	
	
	$enable_Editposix=$tpl->_ENGINE_parse_body("{enable_Editposix}").':';
	$enable_Editposix=html_entity_decode($enable_Editposix);
	if(strlen($enable_Editposix)>37){
		$enable_Editposix=texttooltip(htmlentities(substr($enable_Editposix,0,35)).'...:',htmlentities($enable_Editposix));
	}
	
	$domain_master="
<tr>
	<td align='right' nowrap valign='top' class=legend>{local master}:</td>
	<td valign='top'>" . Field_checkbox('local master','yes',$smb->main_array["global"]["local master"])."</td>
	<td valign='top'>" . help_icon("{local master_text}")."</td>
</tr>		
<tr>	
	<td align='right' nowrap valign='top' class=legend>{domain logons}:</td>
	<td valign='top'>" . Field_checkbox('domain logons','yes',$smb->main_array["global"]["domain logons"])."</td>
	<td valign='top'>" . help_icon("{domain logons_text}")."</td>
</tr>
<tr>
	<td align='right' nowrap valign='top' class=legend>{domain master}:</td>
	<td valign='top' >" . Field_array_Hash(array("no"=>"{no}","yes"=>"{yes}",
	"auto"=>"{auto}"),"domain master",$smb->main_array["global"]["domain master"],null,null,0,'width:100px')."</td>
	<td valign='top'>" . help_icon("{domain master_text}")."</td>
</tr>";
	
	
	if($EnableSambaActiveDirectory==1){
		$workgroup_disabled=true;
		$domain_master="
<tr>
	<td align='right' nowrap valign='top' class=legend>{local master}:</td>
	<td valign='top' >--". Field_hidden("local master","{$smb->main_array["global"]["local master"]}")."</td>
	<td valign='top'>" . help_icon("{local master_text}")."</td>
</tr>		
<tr>	
	<td align='right' nowrap valign='top' class=legend>{domain logons}:</td>
	<td valign='top' >--". Field_hidden("domain logons","{$smb->main_array["global"]["domain logons"]}")."</td>
	<td valign='top'>" . help_icon("{domain logons_text}")."</td>
</tr>		
<tr>
	<td align='right' nowrap valign='top' class=legend>{domain master}:</td>
	<td valign='top' >--". Field_hidden("domain master","{$smb->main_array["global"]["domain master"]}")."</td>
	<td valign='top'>" . help_icon("{domain master_text}")."</td>
</tr>";
	}
	
	$log_level=Field_array_Hash($logh,'log level',$smb->main_array["global"]["log level"],null,null,0,'width:90px');
	
	$form1="
	<input type='hidden' name='SaveGeneralSettings' id='SaveGeneralSettings' value='yes'>
	
	<table style='width:99%'>
<tr>
	<td align='right' nowrap valign='top' class=legend class=legend>SID:</td>
	<td valign='top'><strong>".$ldap->LOCAL_SID()."</strong></td>
	<td valign='top'><div style='padding-right:3px;'>" . imgtootltip("icon_edit.gif","{CHANGE_SID_TEXT}","Loadjs('samba.sid.php')",'right')."</div></td>
	</tr>
<tr>
<tr><td colspan=3><hr></td></tr>	
	
<tr>
	<td align='right' nowrap valign='top' class=legend class=legend>{workgroup}:</td>
	<td valign='top'>" . Field_text("workgroup",$smb->main_array["global"]["workgroup"],'width:190px',null,null,null,false,null,$workgroup_disabled)."</td>
	<td valign='top'>" . help_icon("{workgroup_text}")."</td>
	</tr>
<tr>
	<td align='right' nowrap valign='top' class=legend>{netbiosname}:</td>
	<td valign='top'>" . Field_text("netbiosname",$smb->main_array["global"]["netbios name"],'width:190px')."</td>
	<td valign='top'>" . help_icon("{netbiosname_text}")."</td>
</tr>	
<tr>
	<td align='right' nowrap valign='top' class=legend>{server string}:</td>
	<td valign='top'>" . Field_text("server string",$smb->main_array["global"]["server string"],'width:190px')."</td>
	<td valign='top'>" . help_icon("{server string_text}")."</td>
</tr>	
	
	
<tr>	
	<td align='right' nowrap valign='top' class=legend>{disable netbios}:</td>
	<td valign='top'>" . Field_checkbox('disable netbios','yes',$smb->main_array["global"]["disable netbios"])."</td>
	<td valign='top'>" . help_icon("{disable netbios_text}")."</td>
</tr>
<tr>	
	<td align='right' nowrap valign='top' class=legend>$enable_Editposix</td>
	<td valign='top'>" . Field_checkbox('enable_Editposix','yes',$smb->SambaEnableEditPosixExtension)."</td>
	<td valign='top'>" . help_icon("{enable_Editposix_text}")."</td>
</tr>

<tr>	
	<td align='right' nowrap valign='top' class=legend>{log level}:</td>
	<td valign='top'>$log_level</td>
	<td valign='top'>" . help_icon("{log level_text}")."</td>
</tr>


	<tr>
	<td $style colspan=3 align='right' valign='top'>
	<hr>
	". button("{apply}","SaveSambaMainConfiguration()")
	."</td>
	</tr>
</table>
";
	
	

	
	$users=new usersMenus();
	if($users->WINBINDD_INSTALLED){$winbindd="status_ok.gif";}else{$winbindd="status_critical.gif";}

$form2="
	<table style='width:99%'>
	<tr><td colspan=3 ><H3>{title1}</H3></td></tr>
<tr>	
	<td align='right' nowrap valign='top' class=legend>{winbindd_installed}:</td>
	<td valign='top'><img src='img/$winbindd'></td>
	<td valign='top'>&nbsp;</td>
</tr>	


$domain_master
	


	
<tr>
	<td align='right' nowrap valign='top' class=legend>{os level}:</td>
	<td valign='top'>" . Field_text("os level",$smb->main_array["global"]["os level"],'width:60px')."</td>
	<td valign='top'>" . help_icon("{os level_text}")."</td>
</tr>
<tr>
	<td align='right' nowrap valign='top' class=legend>{SambaDnsProxy}:</td>
	<td valign='top'>" . Field_checkbox('dns proxy','yes',$smb->main_array["global"]["dns proxy"])."</td>
	<td valign='top'>" . help_icon("{SambaDnsProxy_explain}")."</td>
</tr>		
<tr><td colspan=3>&nbsp;</td></tr>
<tr>
	<td nowrap valign='top' align='right'><h3>{name_resolve_order}:</H3>
	<td colspan=2 valign='top'><div id='name_resolve_order_id'></div></td>
</td>	
</tr>
		
	<tr>
	<td colspan=3 align='right' valign='top'>
	<hr>
	". button("{apply}","SaveSambaMainConfiguration()")
	."</td>
	</tr>

	</table>
	";


	
	
	$html="
	<h5>{main_settings}</H5>
	<div id='MainSambaConfigDiv'>
	<table style='width:100%'>
	<tr>
	<td valign='top'>$icon_samba_type$admin_domain$disable_samba$acl_support
	</td>
	<td valign='top' width=99%>
		$form1
		<br>
		$form2
		</td>
	</tr>
	</table>
	</div>
	<script>
	
	var x_SaveSambaMainConfiguration=function (obj) {
			tempvalue=obj.responseText;
			if(tempvalue.length>0){alert(tempvalue);}
			RefreshTab('main_config_samba');
	    }
	
	
		function SaveSambaMainConfiguration(){
		var XHR = new XHRConnection();
		XHR.appendData('SaveGeneralSettings','yes');
		XHR.appendData('workgroup',document.getElementById('workgroup').value);
		XHR.appendData('netbiosname',document.getElementById('netbiosname').value);
		XHR.appendData('server string',document.getElementById('server string').value);
		XHR.appendData('log level',document.getElementById('log level').value);
		XHR.appendData('domain master',document.getElementById('domain master').value);
		XHR.appendData('os level',document.getElementById('os level').value);
		if(document.getElementById('disable netbios').checked){
			XHR.appendData('disable netbios','yes');}else{
			XHR.appendData('disable netbios','no');}
			
		if(document.getElementById('disable netbios').checked){
			XHR.appendData('disable netbios','yes');}else{
			XHR.appendData('disable netbios','no');}

		if(document.getElementById('enable_Editposix').checked){
			XHR.appendData('enable_Editposix','yes');}else{
			XHR.appendData('enable_Editposix','no');}			
		
		if(document.getElementById('domain logons').checked){
			XHR.appendData('domain logons','yes');}else{
			XHR.appendData('domain logons','no');}	

		if(document.getElementById('local master').checked){
			XHR.appendData('local master','yes');}else{
			XHR.appendData('local master','no');}			
		document.getElementById('MainSambaConfigDiv').innerHTML='<center><img src=\"img/wait_verybig.gif\"></center>';			
		XHR.sendAndLoad('$page', 'GET',x_SaveSambaMainConfiguration);		

		
		}
		
		
		function name_resolve_order_refresh(){
			LoadAjax('name_resolve_order_id','$page?name-resolve-order-list=yes');
		}
		
		function NameResolveOrderSet(index,position){
			LoadAjax('name_resolve_order_id','$page?name-resolve-order-list=yes&index='+index+'&pos='+position);
		}
		
	
	name_resolve_order_refresh();";
	
	
	echo $tpl->_ENGINE_parse_body($html);
	
}

function SaveConf(){
	$samba=new samba();
	$sock=new sockets();
	if(isset($_GET["enable_Editposix"])){
		if($_GET["enable_Editposix"]=='yes'){$_GET["enable_Editposix"]=1;}
		$samba->SambaEnableEditPosixExtension=$_GET["enable_Editposix"];
		unset($_GET["enable_Editposix"]);
	}
	
	if(isset($_GET["netbiosname"])){
		$sock->SET_INFO("SambaNetBiosName",$_GET["netbiosname"]);
		unset($_GET["netbiosname"]);
	}
	
	
while (list ($num, $val) = each ($_GET) ){
	   $num=str_replace("domain_logons","domain logons",$num);
	   $num=str_replace("domain_master","domain master",$num);
	   $num=str_replace("local_master","local master",$num);
	   $num=str_replace("os_level","os level",$num);
	   $num=str_replace("log_ldevel","log level",$num);
	   $num=str_replace("log_level","log level",$num);
	   $num=str_replace("disable_netbios","disable netbios",$num);
	   $num=str_replace("server_string","server string",$num);
	   
	
	
	
		writelogs("$num = $val",__FUNCTION__,__FILE__);
		$samba->main_array["global"][$num]=$val;
		
	}	
$samba->SaveToLdap();
	
}

function name_resolve_order(){
	$tpl=new templates();
	$smb=new samba();
	$name_resolve=explode(" ",$smb->main_array["global"]["name resolve order"]);
	
	if(isset($_GET["index"])){
		$name_resolve_new=array_move_element_flat($name_resolve,$_GET["index"],$_GET["pos"]);
		$smb->main_array["global"]["name resolve order"]=implode(" ",$name_resolve_new);
		$smb->SaveToLdap();
		
		echo "<script>name_resolve_order_refresh();</script>";return;
	}
	
	
	$html="
	<hr>
	<table>";
	while (list ($num, $val) = each ($name_resolve) ){
		$html=$html."
			<tr ". CellRollOver().">
			<td width=1%><img src='img/fw_bold.gif'></td>
			<td><strong>{smb_{$val}}</strong></td>
			<td width=1%>". imgtootltip("arrow_up.gif","{up}","NameResolveOrderSet('$num','up')")."</td>
			<td width=1%>". imgtootltip("arrow_down.gif","{down}","NameResolveOrderSet('$num','down')")."</td>
			</tr>
			
			";
		
	}
	$html=$html."<table>";	
	echo $tpl->_ENGINE_parse_body($html);
}


function rewrite_headers(){
		$spam=new spamassassin();
	unset($_GET["rewrite_headers"]);
	
while (list ($num, $val) = each ($_GET) ){
		$spam->rewrite_headers[$num]=$val;
		}	
$spam->SaveToLdap();		

}

function add_headers(){
		$spam=new spamassassin();
	unset($_GET["add_headers"]);
	
while (list ($num, $val) = each ($_GET) ){
		$spam->add_headers[$num]=$val;
		}	
$spam->SaveToLdap();		
	
}




function main_plugins(){
$style="style='padding:3px;border-bottom:1px dotted #CCCCCC'";
	$users=new usersMenus();
	if($_GET["hostname"]==null){$hostname=$users->hostname;$_GET["hostname"]=$hostname;}else{$hostname=$_GET["hostname"];}
	$spam=new spamassassin();
	$users=new usersMenus();
	$page=CurrentPageName();
	
	
	if(!$users->razor_installed){
		$razor_but="<img src='img/status_disabled.gif'><input type='hidden' name='use_razor2' id='use_razor2' value='0'>";
	}else{
		$razor_but=Field_numeric_checkbox_img('use_razor2',$spam->main_array["use_razor2"],'{enable_disable}');
	}
	
	if(!$users->pyzor_installed){
		$pyzor_but="<img src='img/status_disabled.gif'><input type='hidden' name='use_pyzor' id='use_pyzor' value='0'>";
	}else{
		$pyzor_but=Field_numeric_checkbox_img('use_pyzor',$spam->main_array["use_pyzor"],'{enable_disable}');
	}	
	
	$html=main_tabs()."<br>
	<h5>{plugins}</H5>

	<form name='FFM_DANS5'>
	<input type='hidden' name='SaveGeneralSettings' value='yes'>
	" . RoundedLightGrey("
	<table style='width:100%'>
		<tr>
			<td width=1% valign='top'>$razor_but</td>
			<td><H5>Razor</H5><br><div class=caption>{razor_text}</div><td>
		</tr>
		<tr>
			<td width=1% valign='top'>$pyzor_but</td>
			<td><H5>Pyzor</H5><br><div class=caption>{pyzor_text}</div><td>
		<tr>
	<td $style colspan=2 align='right' valign='top'>
	
	<input type='button' value='{save}&nbsp;&raquo;' OnClick=\"javascript:ParseForm('FFM_DANS5','$page',true);\"></td>
	</tr>

	</table>") . "</FORM><br>";
	
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($html);
	
	
	
	
}





function GetNewForm(){
	
$pure=new milter_greylist();
$id=$_GET["class"];
$line=$pure->ParseAcl($pure->acl[$id]);
	
	
	switch ($_GET["ChangeFormType"]) {
		case "dnsrbl":
			if(!preg_match('#delay\s+([0-9]+)([a-z])#',$line[3],$re)){
				$re[1]=15;
				$re[2]="m";
			}
			$form=
			"<table style='width:100%'>
				<tr>
					<td strong width=1% nowrap align='right'>{dnsrbl_service}:</td>
					<td>" . Field_array_Hash($pure->dnsrbl_class,'dnsrbl_class',null) . "</td>
				</tr>
				<tr>
					<td strong width=1% nowrap align='right'>{delay}:</td>
					<td>" . Field_text("delay","{$re[1]}{$re[2]}",'width:100px') . "</td>
				</tr>				
			</table>";
			
			
			break;
	
		default:$form="<table style='width:100%'>
			<tr>
				<td align='right' width=1% nowrap>{pattern}:</td>
				<td><textarea name='pattern' rows=3 style='width:100%'>{$line[3]}</textarea>
			</tr>
		</table>";
			break;
	}
		
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($form);
}





function main_conf(){
$pure=new samba();
	$page=CurrentPageName();
	$g=$pure->global_conf;
	
	$tbl=explode("\n",$g);
	while (list ($num, $ligne) = each ($tbl) ){
		if(trim($ligne)==null){continue;}
		$ligne=str_replace("#","<br><br>#",$ligne);
		$ligne=str_replace("[","<br>[",$ligne);
		$c=$c."<div><code>$ligne</code></div>";
		
	}
	
	
	
	$html="<h5>{config}</H5>
	<div style='padding:5px;;width:100%;;background-color:#FFFFFF'>
	$c
	</div>";
		
$tpl=new templates();
	echo  $tpl->_ENGINE_parse_body($html);		
}

function shared_folders(){

$html="
	
<table style='width:100%'>
<tr>
	<td valign='top' width=99%><h5>{shared_folders}</H5></td>
	<td valign='top' style='border-left:1px solid #005447;padding:5px' nowrap>". button("{add_a_shared_folder}","Loadjs('SambaBrowse.php')"). "</td>
</tr>
</table>".shared_folders_list();
	
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($html);		
	
}


function shared_folders_list(){
	$tpl=new templates();
	$samba=new samba();
	$folders=$samba->main_folders;
	if(!is_array($folders)){return $tpl->_ENGINE_parse_body(button("{add_a_shared_folder}","Loadjs('SambaBrowse.php')"));}
	
	
	$html="
	<input type='hidden' id='del_folder_name' value='{del_folder_name}'>
	<table style='width:100%'>
	<tr>
	<th>&nbsp;</th>
	<th>{name}</th>
	<th>{path}</th>
	<th>&nbsp;</th>
	</tr>";
	
	
	while (list ($FOLDER, $ligne) = each ($folders) ){
		$properties=CellRollOver("FolderProp('$FOLDER')");
		$delete=imgtootltip('delete-32.png','{delete}',"FolderDelete('$FOLDER')");
		if($samba->main_array[$FOLDER]["path"]=="/home/netlogon"){
			$properties=null;
			$delete="&nbsp;";
		}
		
		if($samba->main_array[$FOLDER]["path"]=="/home/export/profile"){
			$properties=null;
			$delete="&nbsp;";
		}

		if($FOLDER=="homes"){
			$properties=null;
			$delete="&nbsp;";
		}	

		if($FOLDER=="printers"){
			$properties=null;
			$delete="&nbsp;";
		}	

		if($FOLDER=="print$"){
			$properties=null;
			$delete="&nbsp;";
		}	
		if($FOLDER=="netlogon"){
			$properties=null;
			$delete="&nbsp;";
		}

		if($FOLDER=="profiles.V2"){
			$properties=null;
			$delete="&nbsp;";
		}
		if($FOLDER=="profile"){
			$properties=null;
			$delete="&nbsp;";
		}				

		

		
	$icon="folder-granted-properties-48.png";	
	if($properties==null){$icon="folder-granted-properties-48-grey.png";}	
		
		
	$html=$html . "
	<tr $properties>
	<td width=1%><img src='img/$icon'></td>
	<td><strong style='font-size:13px'><code style='font-size:13px'>$FOLDER</a></code></td>
	<td><strong ><code style='font-size:13px'>{$samba->main_array[$FOLDER]["path"]}</a></code></td>
	<td width=1%>$delete</td>
	</tr>
	";
	}
	
	$html=$html ."</table>";
	
	$html="<div style='width:99%;'>$html</div>";
	
	
	return $tpl->_ENGINE_parse_body($html);
	
	
}

function browser(){
	$html="
	<input type='hidden' id='YahooSelectedFolders_ask' value='{YahooSelectedFolders_ask}'>
	<input type='hidden' id='YahooSelectedFolders_ask2' value='{YahooSelectedFolders_ask2}'>
	<table style='width:100%'>
	<tr>
	<td valign='top'>
	<div id='folderTree'>
	</div>
	</td>
	<td valign='top'><div id='TreeRightInfos'></div></td>
	</tr>
	</table>
	";
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($html);
	}

function main_logs(){
	$page=CurrentPageName();
	$tpl=new templates();
	$html=main_tabs() . "
	<H5>{events}</H5>
	<iframe src='miltergreylist.events.php' style='width:100%;height:500px;border:0px'></iframe>";
	echo $tpl->_ENGINE_parse_body($html);
	}
	
function AddShareFolder(){
	$folder=$_GET["AddTreeFolders"];
	$folder_name=$_GET["YahooSelectedFolders_ask2"];
	$samba=new samba();
	
	if(is_array($samba->main_array[$folder_name])){
		$d=date('YmdHis');
		$folder_name="{$folder_name}_$d";
	}
	
	$samba->main_array["$folder_name"]["path"]=$folder;
	$samba->main_array["$folder_name"]["create mask"]= "0660";
	$samba->main_array["$folder_name"]["directory mask"] = "0770";
	
	$samba->SaveToLdap();
	}
	
function SaveFolderProp(){
	$folder_name=$_GET["SaveFolderProp"];
	$samba=new samba();
	unset($_GET["SaveFolderProp"]);
	$_GET["comment"]=replace_accents($_GET["comment"]);
	$_GET["hide unreadable"]=$_GET["hide_unreadable"];
	$_GET["hide unwriteable files"]=$_GET["hide_unwriteable_files"];
	
	$_GET["inherit permissions"]=$_GET["inherit_permissions"];
	$_GET["acl check permissions"]=$_GET["acl_check_permissions"];
	$_GET["map acl inherit"]=$_GET["map_acl_inherit"];
	$_GET["acl group control"]=$_GET["acl_group_control"];
	$_GET["nt acl support"]=$_GET["nt_acl_support"];
	$_GET["inherit acls"]=$_GET["inherit_acls"];
	
	
	
	unset($_GET["inherit_permissions"]);
	unset($_GET["acl_check_permissions"]);
	unset($_GET["map_acl_inherit"]);
	unset($_GET["acl_group_control"]);
	unset($_GET["nt_acl_support"]);
 	unset($_GET["hide_unwriteable_files"]);
	unset($_GET["hide_unreadable"]);
	unset($_GET["inherit_acls"]);
	unset($_GET["hide_unwriteable_files"]);
	
while (list ($num, $val) = each ($_GET) ){
		$samba->main_array["$folder_name"][$num]=$val;
		}		
	$samba->SaveToLdap();
}


function save_folder_vfs(){
	$folder_name=$_GET["vfs_object"];
	
	$samba=new samba();
	
	unset($samba->main_array["$folder_name"]["vfs object"]);
	unset($samba->main_array["$folder_name"]["recycle:repository"]);
	unset($samba->main_array["$folder_name"]["recycle:keeptree"]);	
	unset($samba->main_array["$folder_name"]["recycle:versions"]);		
	unset($samba->main_array["$folder_name"]["recycle:touch"]);	
	unset($samba->main_array["$folder_name"]["recycle:exclude"]);		
	unset($samba->main_array["$folder_name"]["recycle:exclude_dir"]);		
	unset($samba->main_array["$folder_name"]["recycle:maxsize"]);	
	unset($samba->main_array["$folder_name"]["recycle:noversions"]);
	unset($samba->main_array["$folder_name"]["mysql_audit:host"]);	
	unset($samba->main_array["$folder_name"]["mysql_audit:user"]);
	unset($samba->main_array["$folder_name"]["mysql_audit:pass"]);
	unset($samba->main_array["$folder_name"]["mysql_audit:name"]);
	unset($samba->main_array["$folder_name"]["mysql_audit:port"]);
	
	if($_GET["recycle_vfs"]=="yes"){
		//.recycle/.recycle.%u 
		//$samba->main_array["$folder_name"]["recycle:repository"]="/home/recycle_bin/".md5($folder_name);
		$samba->main_array["$folder_name"]["recycle:repository"]=".RecycleBin$/%U";
		$samba->main_array["$folder_name"]["recycle:keeptree"]="yes";	
		$samba->main_array["$folder_name"]["recycle:versions"]="yes";
		$samba->main_array["$folder_name"]["recycle:touch"]="no";
		$samba->main_array["$folder_name"]["recycle:exclude"]="*.tmp|*.temp|*.obj|~\$*";	
		$samba->main_array["$folder_name"]["recycle:exclude_dir"]="/tmp|/temp|/cache";		
		$samba->main_array["$folder_name"]["recycle:maxsize"]="1073741824";
		$samba->main_array["$folder_name"]["recycle:noversions"]="*.mdb";
		$vfs[]="recycle:repository recycle:keeptree recycle:versions recycle:touch recycle:exclude recycle:exclude_dir recycle:maxsize recycle:noversions";
		}
		
		

    
	$users=new usersMenus();
		
	if($_GET["kav_vfs"]=="yes"){
		if($users->KAV4SAMBA_VFS<>null){
			$vfs[]=$users->KAV4SAMBA_VFS;
		}
	}
	
	if($_GET["mysql_vfs"]=="yes"){
	if($users->SAMBA_MYSQL_AUDIT){
		$vfs[]="mysql_audit";
		$samba->main_array["$folder_name"]["mysql_audit:host"]=$users->mysql_server;
    	$samba->main_array["$folder_name"]["mysql_audit:user"]=$users->mysql_admin;
    	$samba->main_array["$folder_name"]["mysql_audit:pass"]=$users->mysql_password;
    	$samba->main_array["$folder_name"]["mysql_audit:name"]="artica_events";
    	$samba->main_array["$folder_name"]["mysql_audit:port"]=$users->mysql_port;	
		}
	}
	
	if($_GET["scannedonly_vfs"]=="yes"){
		if($users->SCANNED_ONLY_INSTALLED){
			$vfs[]="scannedonly";
			$samba->main_array["$folder_name"]["scannedonly:socketname"]="/var/run/scannedonly.sock";
    		$samba->main_array["$folder_name"]["scannedonly: hide_nonscanned_files"]="False";
		}				
	}
	
	
	if(is_array($vfs)){
		$samba->main_array["$folder_name"]["vfs object"]=implode(" ",$vfs);
	}
	
$samba->SaveToLdap();
}

	
function folder_properties(){
	$folder=$_GET["prop"];
	$page=CurrentPageName();
	$smb=new samba();
	
	$path_encoded=base64_encode($smb->main_array[$folder]["path"]);
	
	if($smb->main_array["$folder"]["nt acl support"]==null){$smb->main_array["$folder"]["nt acl support"]=$smb->main_array["global"]["nt acl support"];}
	if($smb->main_array["$folder"]["acl group control"]==null){$smb->main_array["$folder"]["acl group control"]=$smb->main_array["global"]["acl group control"];}
	if($smb->main_array["$folder"]["map acl inherit"]==null){$smb->main_array["$folder"]["map acl inherit"]=$smb->main_array["global"]["map acl inherit"];}
	if($smb->main_array["$folder"]["acl check permissions"]==null){$smb->main_array["$folder"]["acl check permissions"]=$smb->main_array["global"]["acl check permissions"];}
	if($smb->main_array["$folder"]["inherit acls"]==null){$smb->main_array["$folder"]["inherit acls"]=$smb->main_array["global"]["inherit acls"];}		
	
	$h="
	<table style='width:100%'>
	<tr>
	<td valign='top'>
		". imgtootltip("folder-granted-remove-48.png","{delete_share}","FolderDelete('$folder')")."<hr>
		". imgtootltip('folder-acls-48.png','{acls_directory}',"Loadjs('samba.acls.php?path=$path_encoded')")."
	</td>
	<td valign='top' width=99%>
		<input type='hidden' name='SaveFolderProp' id='SaveFolderProp' value='$folder'><br>
		<div id='FodPropertiesFrom'>
		<table class=table_form>
		<tr>	
			<td $style align='right' nowrap valign='top' class=legend>{browseable}:</td>
			<td $style valign='top'>" . Field_checkbox('browsable','yes',strtolower($smb->main_array[$folder]["browsable"]))."</td>
			<td $style valign='top'>" . help_icon("{browseable_text}")."</td>
		</tr>
		
		<tr>	
			<td $style align='right' nowrap valign='top' class=legend>{writeable}:</td>
			<td $style valign='top'>" . Field_checkbox('writable','yes',strtolower($smb->main_array[$folder]["writable"]))."</td>
			<td $style valign='top'>" . help_icon("{writeable_text}")."</td>
		</tr>	
		<tr>	
			<td $style align='right' nowrap valign='top' class=legend>{public}:</td>
			<td $style valign='top'>" . Field_checkbox('public','yes',strtolower($smb->main_array[$folder]["public"]))."</td>
			<td $style valign='top'>" . help_icon("{public_text}")."</td>
		</tr>	
		<tr>	
			<td $style align='right' nowrap valign='top' class=legend>{hide_unreadable}:</td>
			<td $style valign='top'>" . Field_checkbox('hide_unreadable','yes',strtolower($smb->main_array[$folder]["hide unreadable"]))."</td>
			<td $style valign='top'>" . help_icon("{hide_unreadable_text}")."</td>
		</tr>
		<tr>	
			<td $style align='right' nowrap valign='top' class=legend>{hide_unwriteable_files}:</td>
			<td $style valign='top'>" . Field_checkbox('hide_unwriteable_files','yes',strtolower($smb->main_array[$folder]["hide unwriteable files"]))."</td>
			<td $style valign='top'>" . help_icon("{hide_unwriteable_files_text}")."</td>
		</tr>		
	<tr>			
		<td class=legend style='font-size:12px'>{nt_acl_support}</td>
		<td>". Field_checkbox("nt_acl_support","yes",$smb->main_array["$folder"]["nt acl support"])."</td>
		<td>".help_icon("{nt_acl_support_text}")."</td>
	</tr>
	<tr>
		<td class=legend style='font-size:12px'>{acl_group_control}</td>
		<td>". Field_checkbox("acl_group_control","yes",$smb->main_array["$folder"]["acl group control"])."</td>
		<td>".help_icon("{acl_group_control_text}")."</td>
	</tr>	
	<tr>
		<td class=legend style='font-size:12px'>{map_acl_inherit}</td>
		<td>". Field_checkbox("map_acl_inherit","yes",$smb->main_array["$folder"]["map acl inherit"])."</td>
		<td>".help_icon("{map_acl_inherit_text}")."</td>
	</tr>
	<tr>
		<td class=legend style='font-size:12px'>{acl_check_permissions}</td>
		<td>". Field_checkbox("acl_check_permissions","yes",$smb->main_array["$folder"]["acl check permissions"])."</td>
		<td>".help_icon("{acl_check_permissions_text}")."</td>
	</tr>
	<tr>
		<td class=legend style='font-size:12px'>{inherit_acls}</td>
		<td>". Field_checkbox("inherit_acls","yes",$smb->main_array["$folder"]["inherit acls"])."</td>
		<td>".help_icon("{inherit_acls_text}")."</td>
	</tr>	

	<tr>
		<td class=legend style='font-size:12px'>{inherit_permissions}</td>
		<td>". Field_checkbox("inherit_permissions","yes",$smb->main_array["$folder"]["inherit permissions"])."</td>
		<td>".help_icon("{inherit_permissions_text}")."</td>
	</tr>		
			<tr>
				<td $style colspan=3 align='right' valign='top'>
					<hr>". button("{apply}","SambaSaveFolderProperties()")."
					
				</td>
			</tr>
		</table>
		</div>

<br>
<table class=table_form>
<tr>
 	<td $style valign='top' class=legend'>{comment}:</td>
 	<td $style valign='top' class=legend'>" . Field_text('comment',$smb->main_array[$folder]["comment"])."</td>
</tr>
	<tr>
		<td $style colspan=3 align='right' valign='top'>
			<hr>". button("{apply}","SambaSaveFolderProperties()")."
		</td>
	</tr>
</table>	
</form>
	</td>
</tr>
</table>
<script>

var x_SambaSaveFolderPropertiesv2=function (obj) {
	tempvalue=obj.responseText;
	if(tempvalue.length>0){alert(tempvalue);}
	RefreshTab('main_config_folder_properties');
    }

function SambaSaveFolderProperties(){
	var XHR = new XHRConnection();
	mem_folder_name=document.getElementById('SaveFolderProp').value;
	XHR.appendData('SaveFolderProp','$folder');
	if(document.getElementById('browsable').checked){XHR.appendData('browsable','yes');}else{XHR.appendData('browsable','no');}
	if(document.getElementById('public').checked){XHR.appendData('public','yes');}else{XHR.appendData('public','no');}
	if(document.getElementById('writable').checked){XHR.appendData('writable','yes');}else{XHR.appendData('writable','no');}
	if(document.getElementById('hide_unreadable').checked){XHR.appendData('hide_unreadable','yes');}else{XHR.appendData('hide_unreadable','no');}
	if(document.getElementById('hide_unwriteable_files').checked){XHR.appendData('hide_unwriteable_files','yes');}else{XHR.appendData('hide_unwriteable_files','no');}
	if(document.getElementById('inherit_permissions').checked){XHR.appendData('inherit_permissions','yes');}else{XHR.appendData('inherit_permissions','no');}
	if(document.getElementById('acl_check_permissions').checked){XHR.appendData('acl_check_permissions','yes');}else{XHR.appendData('acl_check_permissions','no');}
	if(document.getElementById('map_acl_inherit').checked){XHR.appendData('map_acl_inherit','yes');}else{XHR.appendData('map_acl_inherit','no');}
	if(document.getElementById('acl_group_control').checked){XHR.appendData('acl_group_control','yes');}else{XHR.appendData('acl_group_control','no');}
	if(document.getElementById('nt_acl_support').checked){XHR.appendData('nt_acl_support','yes');}else{XHR.appendData('nt_acl_support','no');}
	if(document.getElementById('inherit_acls').checked){XHR.appendData('inherit_acls','yes');}else{XHR.appendData('inherit_acls','no');}
		
	
	
	
	XHR.appendData('comment',document.getElementById('comment').value);
	document.getElementById('FodPropertiesFrom').innerHTML='<center><img src=\"img/wait_verybig.gif\"></center>'; 
	XHR.sendAndLoad('$page', 'GET',x_SambaSaveFolderPropertiesv2);
	}
</script>
";
	
	
	$tpl=new templates();
	return  $tpl->_ENGINE_parse_body($h);
	
	
}
function folder_main(){
	$folder=$_GET["prop"];
	$smb=new samba();
	$style="style='border-bottom:1px dotted #CCCCCC'";
	
	$h="
	<H1>&laquo;$folder&raquo;&nbsp;{shared_properties}</h1>
	<div id='shareprop'>" .  folder_properties()."	
	</div>";
	
	
	$tpl=new templates();
	return  $tpl->_ENGINE_parse_body($h);
	
	
}

function folder_properties_switch(){
	
	switch ($_GET["propTab"]) {
		case "share":echo folder_properties();break;
		case "security": echo folder_security();break;
		case "conf": echo folder_conf();break;
		case "options": echo folder_modules();break;
		default:echo folder_properties_tab();break;
	}
}



function folder_conf(){
	$folder=$_GET["prop"];
	$smb=new samba();
	$ini=new Bs_IniHandler();
	$q[$folder]=$smb->main_array[$folder];
	$ini->_params=$q;
	
	$conf=$g=nl2br($ini->toString());
$html="
	<H6>{config}</H6>
	<div style='padding:5px;margin:5px;border:1px solid #CCCCCC;width:380px;background-color:white' id=''>	
	<code>$conf</code>
	
	</div>";
	
$tpl=new templates();
	return  $tpl->_ENGINE_parse_body($html);	
}

function folder_security(){
	$page=CurrentPageName();
	$folder=$_GET["prop"];

	$smb=new samba();
	
	$html="
	<H6>{users_and_groups}</H6>
	<input type='hidden' id='folder_security_users_ff' value='$folder'>
	<div style='padding:5px;margin:5px;border:1px solid #CCCCCC;width:380px;background-color:white' id='userlists'>
		" . folder_security_list_users()."
	
	
	
	</div>
	<table style='width:400px'>
	<tr>
	<td width=99%>&nbsp;</td>
	<td><input type='button' value='{add}&nbsp;&raquo;' OnClick=\"javascript:YahooWin5(400,'$page?security=$folder','{security} $folder');\"></td>
	<td>
	<input type='hidden' id='selectuserfirst' value='{selectuserfirst}'>
	<input type='hidden' value='' id='DeleteUserid'>
	<input type='button' value='{delete}&nbsp;&raquo;' OnClick=\"javascript:DeleteUserPrivilege();\"></td>
	</tr>
	</table>
	<br>
	<div style='padding:5px;margin:5px;border:1px solid #CCCCCC;width:380px;background-color:white' id='UserSecurityInfos'>
	
	</div>
	
	";
	$tpl=new templates();
	return  $tpl->_ENGINE_parse_body($html);
}



function folder_security_js(){
	$page=CurrentPageName();
	$html="
	
	
	var x_folder_Security_prop_save= function (obj) {
		var response=obj.responseText;
		if(response.length>0){alert(response);}
		document.getElementById('waitfolderpropf').innerHTML='';
	}		
	
	
	function folder_Security_prop_save(){
			var XHR = new XHRConnection();
			XHR.appendData('SaveFolderProp',document.getElementById('SaveFolderProp').value);
			
			if(document.getElementById('browsable').checked){
				XHR.appendData('browsable','yes');
			}else{
				XHR.appendData('browsable','no');
			}
			
			if(document.getElementById('writable').checked){
				XHR.appendData('writable','yes');}
			else{
				XHR.appendData('writable','no');
			}

			if(document.getElementById('public').checked){
				XHR.appendData('public','yes');
			}else{
				XHR.appendData('public','no');
			}			

			document.getElementById('waitfolderpropf').innerHTML='<img src=\"img/wait.gif\">';
			XHR.sendAndLoad('$page', 'GET',x_folder_Security_prop_save);	
		
		}
	
	
	
	folder_Security_prop_save();";
	echo $html;
}


function folder_UserSecurityInfos(){
	$folder=$_GET["prop"];
	$smb=new samba();
	$page=CurrentPageName();

	
	if($_GET["UserSecurityInfos"]==null){
	$html="
	
	<input type='hidden' name='SaveFolderProp' id='SaveFolderProp' value='$folder'>
	<table style='width:100%'>
		<tr style='background-color:#CCCCCC;font-weight:bolder;font-size:11px;text-align:center'>
			<th>&nbsp;</th>
			<th>{browseable}</th>
			<th>{writeable}</th>
			<th>{public}</th>
		</tr>";		
		$html=$html ."<tr>";
		$html=$html ."<td align='center'><div id='waitfolderpropf'></div></td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('browsable',$smb->main_array[$folder]["browsable"]) . "</td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('writable',$smb->main_array[$folder]["writable"]) . "</td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('public',$smb->main_array[$folder]["public"]) . "</td>";
		$html=$html ."</tr><tr>
		<td $style colspan=4 align='right' valign='top'>
			<input type='button' value='{apply}&nbsp;&raquo;' OnClick=\"javascript:Loadjs('$page?js-securityf-infos=yes');\"></td>
		</tr>";
		
		$tpl=new templates();
		return  $tpl->_ENGINE_parse_body($html);
		}
		
		
	else{
	$html="
	
	
	<input type='hidden' name='SaveFolderProp' id='SaveFolderProp' value='$folder'>
	<div style='font-size:14px;font-weight:bold;padding:4px'>{$_GET["UserSecurityInfos"]}:</div>
	<table style='width:100%'>
		<tr style='background-color:#CCCCCC;font-weight:bolder;font-size:11px;text-align:center'>
			<th align='center'>&nbsp;</th>
			<th align='center'>{valid}</th>
			<th align='center'>{write}</th>
			<th align='center'>{read}</th>
		</tr>";
	
		$hash=$smb->hash_privileges($folder);
		$html=$html ."<input type='hidden' id='SaveUseridPrivileges' name='SaveUseridPrivileges' value='{$_GET["UserSecurityInfos"]}'>";
		$html=$html ."<tr>";
		$html=$html ."<td align='center'><div id='waitfolderprop'></div></td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('valid users',$hash[$_GET["UserSecurityInfos"]]["valid users"]) . "</td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('write list',$hash[$_GET["UserSecurityInfos"]]["write list"]) . "</td>";
		$html=$html ."<td align='center'>" .Field_yesno_checkbox('read list',$hash[$_GET["UserSecurityInfos"]]["read list"]) . "</td>";
		$html=$html ."</tr><tr>
		<td $style colspan=4 align='right' valign='top'>
			<input type='button' value='{apply}&nbsp;&raquo;' OnClick=\"javascript:Loadjs('$page?js-security-infos=yes');\"></td>
		</tr>";
		
		$tpl=new templates();
		return  $tpl->_ENGINE_parse_body($html);
		}
	
}

function folder_UserSecurityInfos_js(){
	$page=CurrentPageName();
	$html="
	
	
	var x_folder_UserSecurityInfos_save= function (obj) {
		var response=obj.responseText;
		if(response.length>0){alert(response);}
		document.getElementById('waitfolderprop').innerHTML='';
	}		
	
	
	function folder_UserSecurityInfos_save(){
			var XHR = new XHRConnection();
			
			XHR.appendData('SaveFolderProp',document.getElementById('SaveFolderProp').value);
			
			if(!document.getElementById('SaveUseridPrivileges')){alert('SaveUseridPrivileges!');}
			XHR.appendData('SaveUseridPrivileges',document.getElementById('SaveUseridPrivileges').value);
			
			if(document.getElementById('valid users').checked){
				XHR.appendData('valid users','yes');
			}else{
				XHR.appendData('valid users','no');
			}
			
			if(document.getElementById('write list').checked){
				XHR.appendData('write list','yes');}
			else{
				XHR.appendData('write list','no');
			}

			if(document.getElementById('read list').checked){
				XHR.appendData('read list','yes');
			}else{
				XHR.appendData('read list','no');
			}			
				
			document.getElementById('waitfolderprop').innerHTML='<img src=\"img/wait.gif\">';
			XHR.sendAndLoad('$page', 'GET',x_folder_UserSecurityInfos_save);	
		
		}
	
	
	
	folder_UserSecurityInfos_save();";
	echo $html;
}

//sudo mount -o remount,acl /tmp
// /sbin/tune2fs -o +acl /dev/mapper/LVM1-data
// setfacl -m g:Domain Users:r-- vehicule


function folder_properties_tab(){
	if(!isset($_GET["propTab"])){$_GET["propTab"]="share";};
	
	$page=CurrentPageName();
	$array["share"]='{share}';
	$array["security"]='{security}';
	$array["conf"]='{config}';
	$array["options"]='{options}';
	$tpl=new templates();
	
		while (list ($num, $ligne) = each ($array) ){
		$html[]= $tpl->_ENGINE_parse_body("<li><a href=\"$page?propTab=$num&prop={$_GET["prop"]}\"><span>$ligne</span></li>\n");
	}
	
	
	echo "
	<div id=main_config_folder_properties style='width:100%;height:500px;overflow:auto'>
		<ul>". implode("\n",$html)."</ul>
	</div>
		<script>
				$(document).ready(function(){
					$('#main_config_folder_properties').tabs({
				    load: function(event, ui) {
				        $('a', ui.panel).click(function() {
				            $(ui.panel).load(this.href);
				            return false;
				        });
				    }
				});
			
		
			});
		</script>";	
	
	
	
	
}

function folder_security_users(){
	
	$form1="
	<input type='hidden' id='folder_security_users_ff' value='{$_GET["security"]}'>
	<input type='hidden' id='IsNFS' value='{$_GET["nfs"]}'>
	<table style='width:100%'>
	<td>" . Field_text('query',null,'width:100%',null,null,null,null,"FindUserGroupClick(event);")."</td>
	<td align='right'><input type='button' OnClick=\"javascript:FindUserGroup();\" value='{search}&nbsp;&raquo;'></td>
	</table>";
	
	$form1="<div style='width:350px'>$form1</div><br>";
	
	$form2="<div style='padding:5px;border:1px solid #CCCCCC;width:340px;background-color:white;height:250px;overflow:auto' id='finduserandgroupsid'></div>";
	
	
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body("$form1$form2");
	}
	
	
function folder_modules(){
	$users=new usersMenus();
	$sock=new sockets();
	$EnableKav4Samba=$sock->GET_INFO('EnableKav4Samba');
	$EnableScannedOnly=$sock->GET_INFO('EnableScannedOnly');
	if($EnableKav4Samba==null){$EnableKav4Samba=1;}
	if($EnableScannedOnly==null){$EnableScannedOnly=1;}	
	
	$folder=$_GET["prop"];
	$smb=new samba();
	$kav=false;
	$page=CurrentPageName();
	
	if($users->KAV4SAMBA_INSTALLED){
		if($EnableKav4Samba==1){
			if($users->KAV4SAMBA_VFS<>null){
			$kav=true;
		}}
	}
	
	$vfs_modules=explode(" ",$smb->main_array[$folder]["vfs object"]);
	while (list ($num, $ligne) = each ($vfs_modules) ){
		if($ligne<>null){
			$vfs[$ligne]=true;
		}
		
	}
	
	if($vfs["recycle:repository"]){
		$recycle="yes";
		}else{
		$recycle="no";
		}
		
	if($vfs["scannedonly"]){
		$scannedonly="yes";
		}else{
		$scannedonly="no";
		}		
	
	
	if($kav){
		if($vfs[$users->KAV4SAMBA_VFS]){
			$kav_protected="yes";
		}
	}else{
		$kav_protected="no";
	}
	
if($users->SAMBA_MYSQL_AUDIT){
	if($vfs["mysql_audit"]){
		$mysql="yes";
		
	}else{
		$mysql="no";
	}
	
	$mysql_vfs="
	<tr>
		<td align='right' nowrap class=legend>{mysql_stats}:</td>
		<td align='left'>". Field_yesno_checkbox_img('mysql_vfs',$mysql)."</td>
	</tr>";	
}
	
	$kav_vfs="
	<tr>
		<td align='right' nowrap class=legend>{kantivirus_protect}:</td>
		<td align='left'>". Field_yesno_checkbox_img('kav_vfs',$kav_protected)."</td>
	</tr>
	";

	$scannedonly_vfs="
	<tr>
		<td align='right' nowrap class=legend>{clamav_protect}:</td>
		<td align='left'>". Field_yesno_checkbox_img('scannedonly_vfs',$scannedonly)."</td>
	</tr>
	";	
	
	$recycle_vfs="
	<tr>
		<td align='right' nowrap class=legend>{recycle}:</td>
		<td align='left'>". Field_yesno_checkbox_img('recycle_vfs',$recycle)."</td>
	</tr>
	";	
	

	

	
	if(!$kav){
	$kav_vfs="
	<tr>
		<td align='right' nowrap class=legend>{kantivirus_protect}:</td>
		<td align='left'><img src='img/status_ok-grey.gif'><input type='hidden' id='kav_vfs' name='kav_vfs' value='no'></td>
	</tr>";	
	}
	
	if(!$users->SCANNED_ONLY_INSTALLED){
		$EnableScannedOnly=0;
	$scannedonly_vfs="
	<tr>
		<td align='right' nowrap class=legend>{clamav_protect}:</td>
		<td align='left'><img src='img/status_ok-grey.gif'><input type='hidden' id='scannedonly_vfs' name='scannedonly_vfs' value='no'></td>
	</tr>";			
	}
	
	if($EnableScannedOnly==0){
	$scannedonly_vfs="
	<tr>
		<td align='right' nowrap class=legend>{clamav_protect}:</td>
		<td align='left'><img src='img/status_ok-grey.gif'><input type='hidden' id='scannedonly_vfs' name='scannedonly_vfs' value='no'></td>
	</tr>";			
	}
	
	$html="
	<FORM NAME='FFMVFS'>
	<br>
	<H5>{options}</H5>
	<input type='hidden' id='vfs_object' name='vfs_object' value='{$_GET["prop"]}'>
	<table class=table_form>
	$recycle_vfs
	$mysql_vfs
	$kav_vfs
	$scannedonly_vfs
	<tr>
	<td colspan=2 align='right'><hr>
		<input type='button' OnClick=\"javascript:SambaSaveVFSModules();\" value='{edit}&nbsp;&raquo;'>
	</td>
	</tr>
	</table>
	</FORM>
	";
	
	
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($html);
	
	
	
	
}


function folder_security_list_users(){
	$folder=$_GET["prop"];
	$smb=new samba();
	
	$users=$smb->main_array[$folder]["valid users"].",".$smb->main_array[$folder]["write list"].",".$smb->main_array[$folder]["read list"];
	
		$html="<table>
		<tr>
		<td width=1%><img src='img/wingroup.png'></td>
				<td width=99%
		onMouseOver=\"this.style.background='#CCCCCC';this.style.cursor='pointer'\" 
		OnMouseOut=\"this.style.background='transparent';this.style.cursor='default'\"
		OnClick=\"javascript:UserSecurityInfos('');\"
		<strong style='font-size:12px'>
			{users}</td>
		</tr>";
		
		
	$table=explode(",",$users);
	while (list ($num, $ligne) = each ($table) ){
		if($ligne<>null){
			$usr[$ligne]=$ligne;
		}
		
	}
	
	if(is_array($usr)){
		while (list ($num, $ligne) = each ($usr) ){
			
			if(substr($ligne,0,1)=='@'){
			$img="wingroup.png";
			$Displayname=substr($ligne,1,strlen($ligne));
		}else{
			$Displayname=$ligne;
			$img="winuser.png";
		}
			
			
			$html=$html .
			
			"<tr>
		<td width=1%><img src='img/$img'></td>
				<td width=99%
		onMouseOver=\"this.style.background='#CCCCCC';this.style.cursor='pointer'\" 
		OnMouseOut=\"this.style.background='transparent';this.style.cursor='default'\"
		OnClick=\"javascript:UserSecurityInfos('$ligne');\"
		<strong style='font-size:12px'>
			$Displayname</td>
		</tr>";
			
		}
		
	}
		
		$html=$html."</table>";
		$tpl=new templates();
		return  $tpl->_ENGINE_parse_body($html);	
	
}

function folder_security_adduser(){
	$samba=new samba();
	$list=explode(",",$samba->main_array[$_GET["prop"]]["write list"]);
	$list[]=$_GET["AddUserToFolder"];
	while (list ($num, $ligne) = each ($list) ){
		if($ligne<>null){$a[$ligne]=$ligne;}
	}
	
	
	$samba->main_array[$_GET["prop"]]["write list"]=implode(',',$a);
	$samba->SaveToLdap();
	
}

function folder_security_save_priv(){
/*	SaveFolderProp	180872
SaveUseridPrivileges	david.touzeau
read_list	no
valid_users	no
write_list	yes
*/

$samba=new samba();
writelogs("save privileges for {$_GET["SaveFolderProp"]}",__FUNCTION__,__FILE__);

$folder=$_GET["SaveFolderProp"];
$h=$samba->hash_privileges($folder);
$item=$_GET["SaveUseridPrivileges"];

if($_GET["read_list"]=="no"){unset($h[$item]["read list"]);}else{$h[$item]["read list"]='yes';}

if($_GET["valid_users"]=="no"){
	unset($h[$item]["valid users"]);}
	else{$h[$item]["valid users"]='yes';}
	
if($_GET["write_list"]=="no"){
	writelogs("$item= delete write list",__FUNCTION__,__FILE__);
	unset($h[$item]["write list"]);}
	else{$h[$item]["write list"]='yes';}

		if(is_array($h)){	
			while (list ($user, $array) = each ($h) ){
				if(trim($user)==null){continue;}
				while (list ($priv, $n) = each ($array) ){
						writelogs("$priv=$user",__FUNCTION__,__FILE__);
						$a[$priv][]=$user;
					}
				
			}
			
		}else{
			writelogs("no privileges array given",__FUNCTION__,__FILE__);
		}
if(is_array($a)){
while (list ($c, $d) = each ($a) ){
	$samba->main_array[$folder][$c]=implode(',',$d);
	}
}else{
	writelogs("no privileges given for folder \"$folder\", delete all list privileges",__FUNCTION__,__FILE__);
	unset($samba->main_array[$folder]["write list"]);
	unset($samba->main_array[$folder]["valid users"]);
	unset($samba->main_array[$folder]["read list"]);
}

$samba->SaveToLdap();

	
}


function folder_security_users_find(){
	$users=new user();
	$nfs=false;
	if($_GET["IsNFS"]=="yes"){$nfs=true;}
	if($nfs){
		if($_GET["query"]==null){$_GET["query"]='*';}
	}else{
		if($_GET["query"]=='*'){$_GET["query"]=null;}
	}
	
	$hash=$users->find_samba_items($_GET["query"]);
	if(!is_array($hash)){return null;}
	
	while (list ($num, $ligne) = each ($hash) ){
		if($num==null){continue;}
		$js="AddUserToFolder('$num')";
		if($nfs){$js="AddUserToFolderNFS('$num')";}
		
		if(substr($ligne,0,1)=='@'){
			$img="wingroup.png";
			$Displayname=substr($ligne,1,strlen($ligne));
		}else{
			$Displayname=$ligne;
			$img="winuser.png";
		}
		
		if(substr($num,strlen($num)-1,1)=='$'){
			$Displayname=str_replace('$','',$Displayname);
			$img="base.gif";
			
		}
		
		
	$html=$html."<table>
		<tr>
		<td width=1%><img src='img/$img'></td>
		<td 
		onMouseOver=\"this.style.background='#CCCCCC';this.style.cursor='pointer'\" 
		OnMouseOut=\"this.style.background='transparent';this.style.cursor='default'\"
		OnClick=\"javascript:$js;\"
		><strong style='font-size:11px' >$Displayname</td>
		</tr>
		</table>
	
	";
	}
	
	
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body("$html");
	
}

function TreeRightInfos(){
	$folder=$_GET["TreeRightInfos"];
	$f=basename($folder);
	
	
	$html="
	<input type='hidden' id='YahooBranch' value='$folder'>
	<input type='hidden' id='give_folder_name' value='{give_folder_name}'>
	<input type='hidden' id='del_folder_name' value='{del_folder_name}'>
	
	
	<div style='width:240px'>
	<H5>$f</h5>
	<table style='width:100%'>
	<tr>
	<td width=1%><a href=\"javascript:YahooTreeAddSubFolder();\"><img src='img/folder-add.gif'></a></b></td>
	<td><a href=\"javascript:YahooTreeAddSubFolder();\">{add_sub_folder}</a></td>
	</tr>
	<tr>
	<td width=1%><a href=\"javascript:YahooTreeDelSubFolder();\"><img src='img/folder-del.gif'></a></b></td>
	<td><a href=\"javascript:YahooTreeDelSubFolder();\">{del_sub_folder}</a></td>
	</tr>
	<tr>
	<td width=1%><img src='img/folder-select.gif'></a></b></td>
	<td>{tree_select_folder_text}</a></td>
	</tr>			
	</table>
	
	</div>
	
	";
	
$tpl=new templates();
	echo RoundedLightBlue($tpl->_ENGINE_parse_body("$html"));	
}

function mkdirp(){
	$sock=new sockets();
	$tpl=new templates();
	echo $tpl->javascript_parse_text(base64_decode($sock->getFrameWork("cmd.php?create-folder=". base64_encode($_GET["mkdirp"]))));
	
}
function folder_delete(){
	$samba=new samba();
	unset($samba->main_array[$_GET["FolderDelete"]]);
	$samba->SaveToLdap();
	}
	
function main_kav4samba_tabs(){	
	if(!isset($_GET["kavTab"])){$_GET["kavTab"]="general";};
	$page=CurrentPageName();
	$array["general"]='{main_settings}';
	$array["Objectsaction"]='{Objects_action}';
	$array["events"]='{kav_events}';
	$array["license"]='{license}';
	//$array["Notifysettings"]='{Notify_settings}';
	
	
	while (list ($num, $ligne) = each ($array) ){
		if($_GET["kavTab"]==$num){$class="id=tab_current";}else{$class=null;}
		$html=$html . "<li><a href=\"javascript:LoadAjax('main_smb_config','$page?main=kav4samba&kavTab=$num&hostname=$hostname')\" $class>$ligne</a></li>\n";
			
		}
	return "<br><div id=tablist>$html</div><br>";		
	
}

function main_kav4samba_AddAnewKey(){
	$tpl=new templates();
	$page=CurrentPageName();
	$html="<H4>{licence operations}</H4>
	<center><input type='button' Onclick=\"javascript:s_PopUp('$page?upload=yes','550','550');\" value='&laquo;&nbsp;{add new licence}&nbsp;&raquo;'></center>";
	
	$html=Paragraphe('add-key-64.png','{add_a_license}','{add_a_license_text}',"javascript:s_PopUp(\"$page?upload=yes\",\"550\",\"550\");") . "<br>
	" . Paragraphe('shopping-cart-64.png','{by_a_license}','{by_a_license_text}',"javascript:MyHref(\"http://www.kaspersky.com/business_globalstore\")");
	
	return $tpl->_ENGINE_parse_body($html,'milter.index.php');
	
	
}

function main_kav4samba_license(){
	$sock=new sockets();
	$tabs=main_tabs();
	$datas=$sock->getfile("kav4sambalicense");	
	$tbl=explode("\n",$datas);
	
	while (list ($num, $val) = each ($tbl) ){
		if(trim($val)==null){continue;}
		$lic=$lic."<div>$val</div>";
		
	}
	
	$howto=main_kav4samba_AddAnewKey();
	$html="$tabs
	<br><H5>{APP_KAV4SAMBA} {license}</H5>".main_kav4samba_tabs()."
	<table style='width:100%'>
	<tr>
		<td valign='top'>
		<center>
		<div style='width:70%;border:1px solid #CCCCCC;background-color:white;text-align:left;padding:5px'>$lic</div>
		</center>
		</td>
		<td valign='top'>$howto</td>
	</tr>
	</table>
	
	";
	
	$tpl=new templates();
echo $tpl->_ENGINE_parse_body($html);		
		
}

function main_kav4samba_upload_licence($error=null){
if(!isset($_SESSION["uid"])){echo "<H1>Session Out</H1>";exit;}
include_once("ressources/class.templates.inc");
include_once("ressources/class.ldap.inc");
$user=new usersMenus();
$page=CurrentPageName();
if($user->AsPostfixAdministrator==false){echo 
	$rpl=new template_users("{import users}","{not allowed}",0,1);
	echo $rpl->web_page;
	exit;}
	
$html="<p>&nbsp;</p>
<div id='content' style='width:400px'>
<h4>{add new licence}</h4>
<p>{kavsamba_licence_text}</p>
<div style='font-size:11px;width:100%;height:250px;overflow:auto'><code>$error</code></div>
<form method=\"post\" enctype=\"multipart/form-data\" action=\"$page\">
<p>
<input type=\"file\" name=\"fichier\" size=\"30\">
<input type='submit' name='upload' value='{upload file}&nbsp;&raquo;' style='width:90px'>
</p>
</form>

</div>
</fieldset>
";	
$tpl=new template_users('{add new licence}',$html,0,1);
echo $tpl->web_page;	
}

function main_kav4samba_LicenceUploaded(){
	$tmp_file = $_FILES['fichier']['tmp_name'];
	$content_dir=dirname(__FILE__)."/ressources/conf/upload";
	if(!is_dir($content_dir)){mkdir($content_dir);}
	if( !is_uploaded_file($tmp_file) ){main_kav4samba_upload_licence('{error_unable_to_upload_file}');exit();}
	
	 $type_file = $_FILES['fichier']['type'];
	  if( !strstr($type_file, 'key')){	main_kav4samba_upload_licence('{error_file_extension_not_match} :key');	exit();}
	 $name_file = $_FILES['fichier']['name'];

if(file_exists( $content_dir . "/" .$name_file)){@unlink( $content_dir . "/" .$name_file);}
 if( !move_uploaded_file($tmp_file, $content_dir . "/" .$name_file) ){main_kav4samba_upload_licence("{error_unable_to_move_file} : ". $content_dir . "/" .$name_file);exit();}
     
    $_GET["moved_file"]=$content_dir . "/" .$name_file;
    include_once("ressources/class.sockets.inc");
    $socket=new sockets();
 $res=$socket->getfile("kav4sambaPushLicense:$content_dir/$name_file");
 $tbl=explode("\n",$res);
 if(is_array($tbl)){
while (list ($num, $val) = each ($tbl) ){
		if(trim($val)==null){continue;}
		if(preg_match('#Error#',$val)){
			$ss="color:red;";
		}else{$ss="";}
		$nres=$nres."<div style='font-weight:bold;$ss'>$val</div>";
		
	} 
 }
main_kav4samba_upload_licence("<div style='background-color:EDEDED;border:1px solid #CCCCCC;padding:5px;'>$nres</div>");	
	
}


function main_kav4samba_events(){
	$sock=new sockets();
	$tabs=main_tabs();
	$datas=$sock->getfile("kav4sambaevents");
	$tbl=explode("\n",$datas);
		$tbl=array_reverse ($tbl, TRUE);		
		while (list ($num, $val) = each ($tbl) ){
			$html=$html . "<div style='color:white;margin-bottom:3px;'><code>$val</code></div>";
			
		}
		
		$html="$tabs
		<input type='hidden' id='kaveventsShow' value='yes'>
		<br><H5>{APP_KAV4SAMBA}</H5>
		".main_kav4samba_tabs()."<div style='width:100%;height:300px;overflow:auto'>".RoundedBlack($html)."</div>";
	$tpl=new templates();
echo $tpl->_ENGINE_parse_body($html);		
	
}

function main_kav4samba_Objects_action(){
	$tabs=main_tabs();
	$kav=new kav4samba();
	$arr=array("movePath /home/.infected"=>"{movePath}","remove"=>"{remove}",null=>"{no_action}");
	$page=CurrentPageName();
	$html="$tabs<br><H5>{APP_KAV4SAMBA}</H5>".main_kav4samba_tabs()."
	<FORM NAME=FFM1>
	<input type='hidden' name='kav_actions' id='kav_actions' value='yes'>
	<table class=table_form>
	<tr>
	<td align='right' nowrap class=legend>{OnInfected}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnInfected",$kav->main_array["samba.actions"]["OnInfected"])."</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{OnCured}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnCured",$kav->main_array["samba.actions"]["OnCured"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{OnSuspicion}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnSuspicion",$kav->main_array["samba.actions"]["OnSuspicion"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{OnWarning}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnWarning",$kav->main_array["samba.actions"]["OnWarning"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{OnProtected}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnProtected",$kav->main_array["samba.actions"]["OnProtected"])."</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{OnCorrupted}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnCorrupted",$kav->main_array["samba.actions"]["OnCorrupted"])."</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{OnError}:</td>
	<td align='left'>".Field_array_Hash($arr,"OnError",$kav->main_array["samba.actions"]["OnError"])."</td>
	</tr>				
	</tr>			
	<tr><td colspan=2 align='right'><input type='button' OnClick=\"javascript:ParseForm('FFM1','$page',true)\" value='{edit}&nbsp;&raquo;'><hr></td></tr>
	</table>
	</form>
	";
	
	$tpl=new templates();
echo $tpl->_ENGINE_parse_body($html);
	
	}
	
function main_kav4samba(){
	
	if($_GET["kavTab"]=="Objectsaction"){
		main_kav4samba_Objects_action();
		exit;
	}
	
	if($_GET["kavTab"]=="events"){
		main_kav4samba_events();
		exit;
	}

	if($_GET["kavTab"]=="license"){
		main_kav4samba_license();
		exit;
	}	
	
	$tabs=main_tabs();
	$kav=new kav4samba();
	$UseAVbasesSet=Field_array_Hash(array("standard"=>"standard","extended"=>"extended"),"UseAVbasesSet",$kav->main_array["scanner.options"]["UseAVbasesSet"]);
	$page=CurrentPageName();
	$html="$tabs<br><H5>{APP_KAV4SAMBA}</H5>".main_kav4samba_tabs()."
	<p class=caption>{kav4samba_about}</p>
	
	<FORM NAME=FFM1>
	<table class=table_form>
	<tr><td colspan=2><strong style='font-size:13px;font-weight:bold'>{how_to_scan}<hr></td></tr>
	<tr>
	<td align='right' nowrap class=legend>{UseAVbasesSet}:</td>
	<td align='left'>$UseAVbasesSet</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{MaxLoadAvg}:</td>
	<td align='left'>" .Field_text('MaxLoadAvg',$kav->main_array["scanner.options"]["MaxLoadAvg"],'width:50px')."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{Ichecker}:</td>
	<td align='left'>" .Field_yesno_checkbox('Ichecker',$kav->main_array["scanner.options"]["Ichecker"])."</td>
	</tr>		
	<tr>
	<td align='right' nowrap class=legend>{LocalFS}:</td>
	<td align='left'>" .Field_yesno_checkbox('LocalFS',$kav->main_array["scanner.options"]["LocalFS"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{Recursion}:</td>
	<td align='left'>" .Field_yesno_checkbox('Recursion',$kav->main_array["scanner.options"]["Recursion"])."</td>
	</tr>		
	<tr>
	<td align='right' nowrap class=legend>{Cure}:</td>
	<td align='left'>" .Field_yesno_checkbox('Cure',$kav->main_array["scanner.options"]["Cure"])."</td>
	</tr>		
	<tr>
	<tr><td colspan=2><strong style='font-size:13px;font-weight:bold'>{wich_to_scan}<hr></td></tr>
	<td align='right' nowrap class=legend>{Packed}:</td>
	<td align='left'>" .Field_yesno_checkbox('Packed',$kav->main_array["scanner.options"]["Packed"])."</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{Archives}:</td>
	<td align='left'>" .Field_yesno_checkbox('Archives',$kav->main_array["scanner.options"]["Archives"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{SelfExtArchives}:</td>
	<td align='left'>" .Field_yesno_checkbox('SelfExtArchives',$kav->main_array["scanner.options"]["SelfExtArchives"])."</td>
	</tr>	
	<tr>
	<td align='right' nowrap class=legend>{MailPlain}:</td>
	<td align='left'>" .Field_yesno_checkbox('MailPlain',$kav->main_array["scanner.options"]["MailPlain"])."</td>
	</tr>
	<tr>
	<td align='right' nowrap class=legend>{MailBases}:</td>
	<td align='left'>" .Field_yesno_checkbox('MailBases',$kav->main_array["scanner.options"]["MailBases"])."</td>
	</tr>			

	<tr><td colspan=2 align='right'><input type='button' OnClick=\"javascript:ParseForm('FFM1','$page',true)\" value='{edit}&nbsp;&raquo;'><hr></td></tr>
	
	
	
	</table>
	</form>";
	
$tpl=new templates();
echo $tpl->_ENGINE_parse_body($html);
	
}

function main_kav4samba_save(){
	$kav=new kav4samba();
	
	while (list ($num, $ligne) = each ($_GET) ){
		$kav->main_array["scanner.options"][$num]=$ligne;
		
		
	}
	$kav->SaveToLdap();
	
}

function main_kav4samba_save_actions(){
$kav=new kav4samba();
	
	while (list ($num, $ligne) = each ($_GET) ){
		$kav->main_array["samba.actions"][$num]=$ligne;
		
		
	}
	$kav->SaveToLdap();	
	
}

function neighborhood_save(){
	$field=$_GET["neighborhood-save"];
	$value=$_GET["value"];
	
	$samba=new samba();
	switch ($field) {
		case "HasSingleMode":
			$samba->main_array["global"]["domain logons"]="no";
			$samba->main_array["global"]["preferred master"]="no";
			$samba->main_array["global"]["domain master"]="no";
			$samba->main_array["global"]["local master"]="no";
			$samba->main_array["global"]["os level"]=20;
			$samba->SaveToLdap();
			break; 
			
		case "hasLocalMaster":
			$samba->main_array["global"]["domain logons"]="no";
			$samba->main_array["global"]["preferred master"]="yes";
			$samba->main_array["global"]["domain master"]="no";
			$samba->main_array["global"]["local master"]="yes";
			$samba->main_array["global"]["os level"]=33;
			$samba->SaveToLdap();
			break; 			
		
		case "HasPDC":
			$samba->main_array["global"]["domain logons"]="yes";
			$samba->main_array["global"]["preferred master"]="yes";
			$samba->main_array["global"]["domain master"]="yes";
			$samba->main_array["global"]["local master"]="yes";
			$samba->main_array["global"]["os level"]=40;
			$samba->SaveToLdap();	
			break; 
			
		default:
			$samba->main_array["global"]["domain logons"]="no";
			$samba->main_array["global"]["preferred master"]="no";
			$samba->main_array["global"]["domain master"]="no";
			$samba->main_array["global"]["local master"]="no";
			$samba->main_array["global"]["os level"]=20;
			$samba->SaveToLdap();			
			break;
	}
	
}

function DomainAdmin_Save(){
	
	$password=$_GET["domain-admin-save"];
	
	$samba=new samba();
	$samba->EditAdministrator('administrator',$password);
	$sock=new sockets();
	$sock->SET_INFO("DomainAdministratorEdited",1);
	
}


function DomainAdmin_index(){
	
	$samba=new samba();
	$password=$samba->GetAdminPassword("administrator");
	
	$html="<h1>{domain_admin}</h1>
	<p class=caption>{domain_admin_text}</p>
	
	<strong style='font-size:14px'>&laquo;{$samba->main_array["global"]["workgroup"]}\administrator&raquo; {password}</strong>
	<div id='DomainAdminSave'>
	<table style='width:100%' class=table_form>
	<tr>
		<td class=legend>{password}:</td>
		<td>" . Field_password('password1',$password,null,null,null,null,false,"DomainAdminSaveKey(event)")."</td>
	</tr>
	<tr>
		<td class=legend>{confirm}:</td>
		<td>" . Field_password('password2',$password,null,null,null,null,false,"DomainAdminSaveKey(event)")."</td>
	</tr>	
	<tr>
	<td colspan=2 align='right'>
	<hr>
	". button("{edit}","DomainAdminSave()")."
	
	</tr>
	</table>
	</div>
	
	";
		
	$tpl=new templates();
	echo $tpl->_ENGINE_parse_body($html);
	
}

	
function neighborhood_index(){
	$tpl=new templates();
	
	$samba=new samba();
	
	$sock=new sockets();
	$EnableSambaActiveDirectory=$sock->GET_INFO("EnableSambaActiveDirectory");
	
	if($EnableSambaActiveDirectory==1){
		$html="
		<center style='margin:10px;font-size:14px'>{this_server_is_an_ad_member}</center>
		";
		echo $tpl->_ENGINE_parse_body($html);
		exit;
	}
	
	
	if(strtolower($samba->main_array["global"]["domain logons"])=="yes"){
		if(strtolower($samba->main_array["global"]["preferred master"]=="yes")){
			if(strtolower($samba->main_array["global"]["domain master"]=="yes")){
					if(strtolower($samba->main_array["global"]["local master"]=="yes")){				
						$hasApdc=1;
						$hasLocalMaster=0;
						$HasSingleMode=0;
			}}}}
	
	if(strtolower($samba->main_array["global"]["domain logons"])=="no"){
		if(strtolower($samba->main_array["global"]["preferred master"]=="no")){
			if(strtolower($samba->main_array["global"]["domain master"]=="no")){
				if(strtolower($samba->main_array["global"]["local master"]=="no")){
				$hasApdc=0;
				$hasLocalMaster=0;
				$HasSingleMode=1;
			}}
		}
	}

	if(strtolower($samba->main_array["global"]["domain logons"])=="no"){
		if(strtolower($samba->main_array["global"]["preferred master"]=="yes")){
			if(strtolower($samba->main_array["global"]["domain master"]=="no")){
				if(strtolower($samba->main_array["global"]["local master"]=="yes")){
				$hasApdc=0;
				$hasLocalMaster=1;
				$HasSingleMode=0;
			}}
		}
	}	
	
	
$pdc=Paragraphe_switch_img("{PDC}","{PDC_TEXT}","HasPDC",$hasApdc);	
$standalone=Paragraphe_switch_img("{SINGLE_MODE}","{SINGLE_MODE_TEXT}","HasSingleMode",$HasSingleMode);
$localmaster=Paragraphe_switch_img("{LOCAL_MASTER}","{LOCAL_MASTER_TEXT}","hasLocalMaster",$hasLocalMaster);
	
//os level=32
	
	
	$html="
	<h1>{windows_network_neighborhood}</h1>
	<p class=caption>{windows_network_neighborhood_text}</p>
	<div id='neighborhood_index'>
	<table style='width:100%'>
	<tr>
		<td valing='top'>$pdc</td>
		<td valign='top'><input type='button' OnClick=\"javascript:Save_neighborhood_form('HasPDC');\" value='{apply}&nbsp;&raquo;'></td>
	</tr>
	<tr><td colspan=2><hr></td></tr>
	<tr>
		
		<td valing='top'>$standalone</td>
		<td valign='top'><input type='button' OnClick=\"javascript:Save_neighborhood_form('HasSingleMode');\" value='{apply}&nbsp;&raquo;'></td>
		<tr><td colspan=2><hr></td></tr>
	</tr>
	<tr>
		
		<td valing='top'>$localmaster</td>
		<td valign='top'><input type='button' OnClick=\"javascript:Save_neighborhood_form('hasLocalMaster');\" value='{apply}&nbsp;&raquo;'></td>
		<tr><td colspan=2><hr></td></tr>
	</tr>	
	</table>
	</div>
	";
	
	echo $tpl->_ENGINE_parse_body($html);
	
	
	
	
}


//http://www.linuxplusvalue.be/mylpv.php?id=214
?>


