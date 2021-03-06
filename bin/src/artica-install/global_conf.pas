unit global_conf;
{$MODE DELPHI}
//{$mode objfpc}{$H+}
{$LONGSTRINGS ON}

interface

uses
//depreciated oldlinux -> linux
Classes, SysUtils,Process,strutils,IniFiles,RegExpr in 'RegExpr.pas',unix,logs,dateutils,uHashList,Geoip,BaseUnix,md5,dhcp_server,openvpn,cups,pdns, obm2,
samba,smartd,xapian,opengoo,dstat,sugarcrm,rsync,tcpip,policyd_weight,apache_artica, autofs,nfsserver,framework,ocsi,assp,gluster,zabbix,hamachi,vmwaretools,phpldapadmin,monit,zarafa_server,squidguard,wifi, emailrelay,mldonkey,backuppc,kav4fs,ocsagent,
mailarchiver in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mailarchiver.pas',
kavmilter    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/kavmilter.pas',
kas3         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/kas3.pas',
kav4proxy    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/kav4proxy.pas',
zsystem      in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/zsystem.pas',
obm          in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/obm.pas',
mysql_daemon in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mysql_daemon.pas',
fdm          in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/fdm.pas',
syslogng     in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/syslogng.pas',
rdiffbackup  in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/rdiffbackup.pas',
artica_cron  in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/artica_cron.pas',
miltergreylist in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/miltergreylist.pas',
dnsmasq      in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/dnsmasq.pas',
bind9        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/bind9.pas',
cyrus        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/cyrus.pas',
clamav       in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/clamav.pas',
spamass      in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/spamass.pas',
pureftpd     in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/pureftpd.pas',openldap,
roundcube    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/roundcube.pas',
ntpd         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/ntpd.pas',
spfmilter    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/spfmilter.pas',
mimedefang   in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mimedefang.pas',
squid        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/squid.pas',
stunnel4     in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/stunnel4.pas',
dkimfilter   in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/dkimfilter.pas',
postfix_class    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/postfix_class.pas',
lighttpd         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/lighttpd.pas',
xfce             in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/xfce.pas',
dansguardian     in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/dansguardian.pas',
kav4samba        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/kav4samba.pas',
awstats          in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/awstats.pas',
bogom            in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/bogom.pas',
saslauthd        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/saslauthd.pas',
collectd         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/collectd.pas',
//mailgraph_class  in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-mailgraph/mailgraph_class.pas',
mailgraph_daemon in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mailgraph_daemon.pas',
fetchmail        in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/fetchmail.pas',
mailspy_milter   in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mailspy_milter.pas',
amavisd_milter   in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/amavisd_milter.pas',
imapsync         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/imapsync.pas',
kretranslator    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/kretranslator.pas',
isoqlog          in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/isoqlog.pas',
dotclear         in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/dotclear.pas',
jcheckmail       in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/jcheckmail.pas',
mailmanctl       in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/mailmanctl.pas';


type
  TStringDynArray = array of string;

  type

  { MyConf }

  MyConf=class


private
       GLOBAL_INI:TIniFile;
       LOGS                :tlogs;
       notdebug2           :boolean;
       download_silent     :boolean;
       CCYRUS:Tcyrus;
       clamav:Tclamav;
       spamass:Tspamass;
       Cpureftpd:Tpureftpd;
       ldap:topenldap;
       roundcube:Troundcube;
       ntpd:tNTPD;
       spfm:tspf;
       samba:tsamba;
       mimedef:tmimedefang;
       squid:Tsquid;
       stunnel:tstunnel;
       dkim: tdkim;
       postfix:tpostfix;
       mailgraph:tMailgraphClass;
       miltergreylist:tmilter_greylist;
       lighttpd:Tlighttpd;
       global_backup_usb_path:string;
       dansguardian:Tdansguardian;
       kav4samba:Tkav4Samba;
       awstats:Tawstats;
       kav4proxy:Tkav4proxy;
       bind9:Tbind9;
       obm:Tobm;
       zmysql:Tmysql_daemon;
       fdm:tfdm;
       artica_cron:tcron;
       mailarchive:tmailarchive;
       dnsmasq:tdnsmasq;
       collectd:tcollectd;
       fetchmail:tfetchmail;
       mailman:tmailman;
       tcpip:ttcpip;
       apache_artica:tapache_artica;
       procedure  killfile(path:string);

       function   GetIPAddressOfInterface( if_name:ansistring):ansistring;
       procedure  ShowScreen(line:string);
       function   POSTFIX_EXTRAINFOS_PATH(filename:string):string;
       procedure  SYSTEM_NETWORKS_SET_NIC_DEBIAN(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
       function   FileSize_ko(path:string):longint;
       procedure  GETTY_CHANGE_INITTAB();
       procedure SYSTEM_VERIFY_ISO();

       function  SCAN_DISK_PARTITIONS_SIZE_PHP(dev:string):string;
       function  usb_devinfo_query(dev:string;key:string):string;


public
      SYS:Tsystem;
      debug:boolean;
      echo_local:boolean;
      ArrayList:TStringList;
       function  USB_DEV_INFO(dev:string;key:string):string;
      FUNCTION ADD_PROCESS_QUEUE(command:string):string;
      FUNCTION GLOBAL_STATUS():string;
      function CGI_ALL_APPLIS_INSTALLED():string;
      function INYADIN_VERSION():string;
      PROCEDURE BuildDeb(targetfile:string;targetversion:string);
      procedure WRITE_STATUS();

      procedure THREAD_COMMAND_SET(zcommands:string);
      function CheckInterface( if_name:string):boolean;
      function GetIPInterface( if_name:string):string;

      function  ReadFileIntoString(path:string):string;
      procedure set_INFOS(key:string;val:string);
      function  get_INFOS(key:string):string;
      procedure set_LDAP(key:string;val:string);
      function  get_LDAP(key:string):string;
      procedure ExecProcess(commandline:string);
      procedure MonShell(cmd:string;sh:boolean);
      function  MD5FromString(value:string):string;


      function  PERL_VERSION():string;
      function  PERL_BIN_PATH():string;
      function  PERL_INCFolders():TstringList;
      procedure PERL_PATCHING_HEADER(path:string);

      //ARTICA_MAKE
      function ARTICA_MAKE_STATUS():string;

      //GDM
      function     GDM_STATUS():string;
      function     GDM_VERSION():string;

      //NMAP
      function     NMAP_VERSION():string;
      function     WINEXE_VERSION():string;

      //GNUPLOT
      function     GNUPLOT_VERSION():string;
      function     DSTAT_VERSION():string;

      //LDAP

      function     LDAP_GET_DAEMON_USERNAME():string;
      function     LDAP_GET_BIN_PATH:string;
      PROCEDURE    LDAP_DB_CONFIG();
      function     LDAP_INITD():string;
      function     LDAP_SLAPADD_BIN_PATH():string;


      //PRELOAD
      FUNCTION       PRELOAD_VERSION():string;
      FUNCTION       PRELOAD_PID():string;
      FUNCTION       PRELOAD_STATUS():string;

      //CYRUS
      procedure      CYRUS_SET_V2(val:string);
      function       CYRUS_GET_V2():string;
      FUNCTION       CYRUS_IMAP_GET_VALUE(key:string):string;


      //MHONARC
      function       MHONARC_VERSION():string;

      //CONSOLE-KIT
      function       CONSOLEKIT_STATUS():string;

      //SYSLOGGER
      procedure      SYSLOGER_STOP();
      function       SYSLOGER_STATUS():string;
      function       SYSLOGER_PID():string;
      procedure      SYSLOGER_START();

      //USB
      function       SCAN_USB():string;
      function       usb_devinfo_path(path:string):string;
      function       usb_mount_point(path:string):string;
      function       usb_size(pathFrom:string;pathTo:string):string;
      function       UsbExists(uuid:string):boolean;
      function       usbMountPoint(target_uuid:string):string;
      procedure      BACKUP_USB();
      function       SCAN_DISK_PHP(norecheck:boolean=false):string;
      function       SCAN_DISK_PARTITIONS_PHP(dev:string):string;

      function       LMB_LUNDIMATIN_VERSION():string;
      function       PHPMYADMIN_VERSION():string;
      function       DRUPAL_VERSION():string;
      //CLAMAV

      function       CLAMD_GETINFO(Key:String):string;
      procedure      CLAMD_SETINFO(Key:String;value:string);
      function       CLAMD_CONF_PATH():string;
      function       CLAMDSCAN_BIN_PATH():string;



      //backup
      FUNCTION       TEMP_DATE():string;
      FUNCTION       BACKUP_MYSQL():string;
      FUNCTION       BACKUP_ARTICA_STATUS():string;
      procedure      CLEAN_QUARANTINES();


      //iptables
      function       IPTABLES_PATH():string;
      function       IPTABLES_VERSION():string;
      function       IPTABLES_STATUS():string;
      function       IPTABLES_LIST_NICS():string;
      FUNCTION       IPTABLES_CURRENT_RULES():string;
      FUNCTION       IPTABLES_EVENTS():string;


      //pure-ftpd
      procedure      PURE_FTPD_PREPARE_LDAP_CONFIG();
      procedure      PURE_FTPD_DELCONFIG(key:string);
      procedure      PURE_FTPD_SETCONFIG(key:string;value:string);

      //SHARED FOLDERS
      function       SHARED_CONF_GET_CLIENTS(SharedSource:string):TStringList;


      //OBM
      procedure      OBM_SYNCHRO();

      //ATMAIL
      function       ATMAIL_VERSION():string;


      function  RRDTOOL_SecondsBetween(longdate:string):string;
      function  RRDTOOL_VERSION():string;
      function  RRDTOOL_TIMESTAMP(longdate:string):string;
      function  RRDTOOL_LOAD_AVERAGE():string;
      function  RRDTOOL_BIN_PATH():string;
      PROCEDURE RRDTOOL_FIX();

      function RRDTOOL_STAT_LOAD_AVERAGE_DATABASE_PATH():string;
      function RRDTOOL_STAT_LOAD_CPU_DATABASE_PATH():string;
      function RRDTOOL_STAT_LOAD_MEMORY_DATABASE_PATH():string;
      function RRDTOOL_STAT_POSTFIX_MAILS_SENT_DATABASE_PATH():string;

      procedure RDDTOOL_POSTFIX_MAILS_SENT_STATISTICS();
      procedure RDDTOOL_POSTFIX_MAILS_CREATE_DATABASE();

      procedure RDDTOOL_LOAD_AVERAGE_GENERATE();
      procedure RDDTOOL_LOAD_CPU_GENERATE();
      procedure RDDTOOL_LOAD_MEMORY_GENERATE();
      function  RRDTOOL_GRAPH_HEIGHT():string;
      function  RRDTOOL_GRAPH_WIDTH():string;
      procedure RDDTOOL_POSTFIX_MAILS_SENT_GENERATE();

      function       GETLIVE_VERSION():string;

      function       INADYN_PERFORM(IniData:String;UpdatePeriod:integer):string;
      function       INADYN_PID():string;
      procedure      INADYN_PERFORM_STOP();

      function       XINETD_BIN():string;
      function       XINETD_PID():string;
      procedure      HOTWAYD_START();
      function       HOTWAYD_VERSION():string;


      function RENATTACH_VERSION():string;
      function  CRON_CREATE_SCHEDULE(ProgrammedTime:string;Croncommand:string;name:string):boolean;
      function  CRON_PID():string;
      function  CROND_INIT_PATH():string;

      function PHP5_LIB_MODULES_PATH():string;

      function CERTIFICATE_PASS(path:string):string;
      function CERTIFICATE_PATH(path:string):string;
      function CERTIFICATE_CA_FILENAME(path:string):string;
      function CERTIFICATE_KEY_FILENAME(path:string):string;
      function CERTIFICATE_CERT_FILENAME(path:string):string;

      function PROCMAIL_VERSION():string;
      function PROCMAIL_INSTALLED():boolean;
      function PROCMAIL_LOGS_PATH():string;
      function PROCMAIL_USER():string;
      function PROCMAIL_QUARANTINE_PATH():string;

      function PROCMAIL_QUARANTINE_USER_FILE_NUMBER(username:string):string;
      function PROCMAIL_READ_QUARANTINE(fromFileNumber:integer;tofilenumber:integer;username:string):TstringList;
      function PROCMAIL_READ_QUARANTINE_FILE(file_to_read:string):string;





      function  LIB_GSL_VERSION():string;

      //OPENSSL
      function  OPENSSL_TOOL_PATH():string;
      function  OPENSSL_VERSION():string;
      procedure OPENSSL_CERTIFCATE_CONFIG();

      function ROUNDCUBE_VERSION():string;
      function ROUNDCUBE_DEFAULT_CONFIG():string;
      function ROUNDCUBE_MYSQL_CONFIG():string;


      function GetAllApplisInstalled():string;


      //POSTFIX
      function  POSTFIX_HEADERS_CHECKS():string;
      procedure POSTFIX_CHECK_POSTMAP();
      function  POSFTIX_DELETE_FILE_FROM_CACHE(MessageID:string):boolean;
      procedure POSTFIX_REPLICATE_MAIN_CF(mainfile:string);
      function  POSTFIX_LAST_ERRORS():string;
      procedure POSTFIX_CONFIGURE_MAIN_CF();


      //SImpleCalendar
      function SIMPLE_CALENDAR_VERSION():string;


      // CYRUS
      function SASLPASSWD_PATH():string;





      procedure APACHE_ARTICA_START();
      procedure APACHE_ARTICA_STOP();
      function  APACHE_ARTICA_ENABLED():string;
      function QUEUEGRAPH_TEMP_PATH():string;


      function  AVESERVER_GET_VALUE(KEY:string;VALUE:string):string;
      function  AVESERVER_GET_PID():string;
      function  AVESERVER_GET_LICENCE():string;
      function  AVESERVER_PATTERN_DATE():string;
      function  AVESERVER_GET_KEEPUP2DATE_LOGS_PATH():string;
      function  AVESERVER_SET_VALUE(KEY:string;VALUE:string;DATA:string):string;
      function  AVESERVER_GET_DAEMON_PORT():string;
      function  AVESERVER_GET_TEMPLATE_DATAS(family:string;ztype:string):string;
      procedure AVESERVER_REPLICATE_TEMPLATES();
      procedure AVESERVER_REPLICATE_kav4mailservers(mainfile:string);
      function  AVESERVER_GET_LOGS_PATH():string;





      function  Cyrus_get_servername:string;
      function  Cyrus_get_admins:string;
      function  Cyrus_get_unixhierarchysep:string;
      function  Cyrus_get_virtdomain:string;
      function  Cyrus_get_adminpassword:string;
      function  Cyrus_get_admin_name():string;
      procedure Cyrus_set_admin_name(val:string);
      procedure Cyrus_set_adminpassword(val:string);
      function  Cyrus_get_value(value:string):string;
      function  CYRUS_DELIVER_BIN_PATH():string;
      function  CYRUS_IMAPD_CONF_GET_INFOS(value:string):string;


      function  SYSTEM_GMT_SECONDS():string;

      //TCP/IP
      function  InterfacesList(): String;
      procedure ARTICA_HAS_GAYTEWAY();
      function  SYSTEM_GET_ALL_LOCAL_IP():string;
      function  SYSTEM_GET_LOCAL_IP(ifname:string):string;
      function  SYSTEM_GET_LOCAL_MASK(ifname:string):string;
      function  SYSTEM_GET_LOCAL_MAC(ifname:string):string;
      function  SYSTEM_GET_LOCAL_BROADCAST(ifname:string):string;
      function  SYSTEM_GET_LOCAL_DNS():string;
      function  SYSTEM_GET_LOCAL_GATEWAY(ifname:string):string;
      procedure SYSTEM_NETWORKS_SET_NIC(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
      procedure SYSTEM_NETWORKS_SET_NIC_REDHAT(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
      function  IsIfaceDown(ifname:string): boolean;
      function  SYSTEM_NETWORK_INFO_NIC_DEBIAN(nicname:string):string;
      function  SYSTEM_NETWORK_INFO_NIC_REDHAT(nicname:string):string;
      function  SYSTEM_NETWORK_INFO_NIC(nicname:string):string;
      procedure SYSTEM_NETWORKS_SET_HOSTNAME(name:string);
      procedure SYSTEM_NETWORKS_SET_HOSTNAME_IN_HOSTS(name:string);



      function  SYSTEM_DAEMONS_STATUS():string;
      function  SYSTEM_DAEMONS_STOP_START(APPS:string;mode:string;return_string:boolean):string;
      procedure SYSTEM_CHDIR(path:string);
      function  IsWireless(ifname:string): boolean;

      //start the service
      function  SYSTEM_START_ARTICA_DAEMON():boolean;
      procedure LDAP_VERIFY_PASSWORD();
      procedure START_ALL_DAEMONS();
      procedure START_MYSQL();
      procedure ARTICA_STOP();

      function  SYSTEM_PROCESS_EXISTS(processname:string):boolean;
      function  SYSTEM_KERNEL_VERSION():string;
      function  SYSTEM_LIBC_VERSION():string;
      function  SYSTEM_LD_SO_CONF_ADD(path:string):string;
      function  SYSTEM_CRON_TASKS():TstringList;
      function  SYSTEM_USER_LIST():string;
      function  SYSTEM_CRON_REPLIC_CONFIGS():string;
      function  SYSTEM_ADD_NAMESERVER(nameserver:string):boolean;
      function  SYSTEM_NETWORK_INITD():string;
      function  SYSTEM_NETWORK_LIST_NICS():TStringList;

      function  SYSTEM_NETWORK_IFCONFIG():string;
      function  SYSTEM_NETWORK_IFCONFIG_ETH(ETH:string):string;
      function  SYSTEM_NETWORK_RECONFIGURE():string;
      function  SYSTEM_PROCESS_PS():string;
      function  SYSTEM_PROCESS_INFO(PID:string):string;
      function  SYSTEM_ALL_IPS():string;
      function  SYSTEM_PROCESS_EXIST(pid:string):boolean;
      function  SYSTEM_PROCESS_MEMORY(PID:string):integer;
      function  SYSTEM_MAKE_PATH():string;
      function  SYSTEM_GCC_PATH():string;
      function  SYSTEM_ENV_PATHS():string;
      procedure SYSTEM_ENV_PATH_SET(path:string);
      function  SYSTEM_VERIFY_CRON_TASKS():string;
      function  SYSTEM_GET_SYS_DATE():string;
      function  SYSTEM_GET_HARD_DATE():string;
      function  SYSTEM_FQDN():string;
      function  SYSTEM_IS_HOSTNAME_VALID():boolean;
      function  SYSTEM_MARK_DEB_CDROM():string;
      procedure SYSTEM_SET_HOSTENAME(hostname:string);
      function  SYSTEM_IP_OVERINTERNET():string;
      function  SYSTEM_GET_HTTP_PROXY:string;
      function  SYSTEM_GET_FOLDERSIZE(folderpath:string):string;
      function  SYSTEM_FILE_BETWEEN_NOW(filepath:string):LongInt;
      function  SYSTEM_FILE_DAYS_BETWEEN_NOW(filepath:string):LongInt;
      function  SYSTEM_FILE_TIME(filepath:string):string;
      function  SYSTEM_FILE_MIN_BETWEEN_NOW(filepath:string):LongInt;
      function  SYSTEM_FILE_SECONDS_BETWEEN_NOW(filepath:string):LongInt;
      function  SYSTEM_PROCESS_LIST_PID(processname:string):string;
      function  SYSTEM_GET_PLATEFORM():string;
      function  SYSTEM_ISIP_LOCAL(ipToTest:string):boolean;
      function  SYSTEM_LOCAL_SID():string;
      FUNCTION  SYSTEM_GET_SYSLOG_PATH():string;
      function  SYSTEM_PROCESS_MEMORY_FATHER(PID:string):integer;
      function  SYSTEM_PROCESS_MEMORY_SINGLE(PID:string):integer;
      function  SYSTEM_PROCESS_STATUS(PID:string):string;
      procedure PATCHING_PERL_TO_ARTICA(TargetPath:string);
      function  PathIsDirectory(path:string):boolean;
      procedure SYSTEM_CHANGE_MOTD();
      procedure LISTDIRS_RECURSIVE(path:string);

      function  ExecPipe(commandline:string):string;
      function  WGET_DOWNLOAD_FILE(uri:string;file_path:string):boolean;
      function  MD5FromFile(path:string):string;
      function  CURL_HTTPS_ENABLED():boolean;

      //BOA
      function         BOA_SET_CONFIG():boolean;
      procedure        BOA_FIX_ETC_HOSTS();
      function         BOA_DAEMON_GET_PID():string;
      procedure        BOA_TESTS_INIT_D();
      procedure        BOA_STOP();
      procedure        BOA_START();
      function         BOA_BIN_PATH():string;
       function        BOA_DAEMON_STATUS():string;

      //CROSSROADS
      function         CROSSROADS_VERSION():string;
      FUNCTION         CROSSROADS_MASTERNAME():string;
      procedure        CROSSROADS_SEND_REQUESTS_TO_SERVER(uri:string);
      FUNCTION         CROSSROADS_POOLING_TIME():integer;

      function GEOIP_VERSION():string;
      function hpinlinux_VERSION():string;

      function  SASLAUTHD_PATH_GET():string;
      function  SASLAUTHD_VALUE_GET(key:string):string;
      function  SASLAUTHD_TEST_INITD():boolean;



      function  postfix_get_virtual_mailboxes_maps():string;

      //YOREL
      procedure YOREL_VERIFY_START();
      procedure YOREL_CHECK_PEL_LIB();
      function  YOREL_RECONFIGURE(database_path:string):string;

      //LMB
      function LMB_VERSION():string;
      function GROUPOFFICE_VERSION():string;

      function get_POSTFIX_HASH_FOLDER():string;
      function get_INSTALL_PATH():string;
      function get_DISTRI():string;
      function get_UPDATE_TOOLS():string;

      procedure set_FileStripDiezes(filepath:string);
      function set_POSTFIX_HASH_FOLDER(val:string):string;

      procedure set_INSTALL_PATH(val:string);
      function set_DISTRI(val:string):string;
      procedure set_UPDATE_TOOLS(val:string);

      procedure set_LINUX_DISTRI(val:string);


      function get_LINUX_DISTRI():string;
      function get_LINUX_MAILLOG_PATH():string;
      function get_LINUX_INET_INTERFACES():string;
      function get_LINUX_DOMAIN_NAME():string;
      function get_SELINUX_ENABLED():boolean;
      procedure set_SELINUX_DISABLED();

      function LINUX_GET_HOSTNAME:string;
      function LINUX_DISTRIBUTION():string;
      function LINUX_CONFIG_INFOS():string;
      function LINUX_APPLICATION_INFOS(inikey:string):string;
      function LINUX_INSTALL_INFOS(inikey:string):string;
      function LINUX_CONFIG_PATH():string;
      function LINUX_REPOSITORIES_INFOS(inikey:string):string;
      function LINUX_LDAP_INFOS(inikey:string):string;



      procedure MYSQL_INIT_ERROR();
      function  MYSQL_ACTION_TESTS_ADMIN():boolean;
      function  MYSQL_ACTION_CREATE_ADMIN(username:string;password:string):boolean;
      function  MYSQL_ACTION_IMPORT_DATABASE(filenname:string;database:string):boolean;
      function  MYSQL_ACTION_COUNT_TABLES(database_name:string):integer;
      function  MYSQL_ACTION_QUERY_DATABASE(database:string;sql:string):boolean;
      function  MYSQL_ENABLED:boolean;
      function  MYSQL_VERSION:string;
      function  MYSQL_BIN_PATH:string;
      function  MYSQL_INIT_PATH:string;
      function  MYSQL_MYCNF_PATH:string;
      function  MYSQL_PID_PATH():string;
      function  MYSQL_STATUS():string;
      function  MYSQL_EXEC_BIN_PATH():string;
      function  MYSQL_SERVER_PARAMETERS_CF(key:string):string;
      function  MYSQL_READ_CF(key:string;mycfpath:string):string;
      function  MYSQL_ACTION_IMPORT_FILE(filenname:string;database:string;mycf_path:string):boolean;
      function  MYSQL_DATABASE_CHECK_LIST(BasePath:string):TstringList;
      procedure MYSQL_RECONFIGURE_DB();
      function  MYSQL_PARSE_TABLE_NAME_INFILE(path:string):string;
      function  MYSQL_ARTICA_START_CMDLINE():string;
      function  MYSQL_DETERMINE_DATABASE_IN_FILEQUERY(path:string):string;
      function  mysqldump_path():string;


      procedure MYSQL_CHANGE_ROOT_PASSWORD();
      procedure MYSQL_UPGRADE();

      function set_ARTICA_PHP_PATH(val:string):string;
      procedure set_ARTICA_DAEMON_LOG_MaxSizeLimit(val:integer);
      function get_ARTICA_LISTEN_IP():string;
      function get_ARTICA_LOCAL_PORT():integer;
      procedure SET_ARTICA_LOCAL_SECOND_PORT(val:integer);
      function get_ARTICA_LOCAL_SECOND_PORT():integer;
      function ARTICA_MYSQL_INFOS(val:string):string;
      procedure ARTICA_MYSQL_SET_INFOS(val:string;value:string);


       //Mailgraph operations



      function   get_MAILGRAPH_RRD():string;
      function   get_MAILGRAPH_RRD_VIRUS():string;
      function   MAILGRAPGH_PID_PATH():string;
      function   MAILGRAPH_RDD_PATH():string;
      procedure  MAILGRAPGH_FIX_PERL();







      //files operations
      function ln(frompath:string;topath:string):boolean;

      function  get_ARTICA_PHP_PATH():string;
      function  get_ARTICA_DAEMON_LOG_MaxSizeLimit():integer;



      function  ARTICA_DAEMON_GET_PID():string;

      function  ARTICA_FILTER_GET_ALL_PIDS():string;
      function  ARTICA_SEND_SUBQUEUE_NUMBER(QueueNumber:string):integer;
      function  ARTICA_SEND_MAX_SUBQUEUE_NUMBER:integer;
      function  ARTICA_FILTER_CHECK_PERMISSIONS():string;
      function  ARTICA_SEND_QUEUE_NUMBER():integer;

      function  ARTICA_FILTER_QUEUEPATH():string;

      function  ARTICA_SQL_QUEUE_NUMBER():integer;
      function  ARTICA_VERSION():string;
      function  ARTICA_PATCH_VERSION():string;

      function EMAILRELAY_VERSION():string;
      procedure WATCHDOG_PURGE_BIGHTML();


      function  get_kaspersky_mailserver_smtpscanner_logs_path():string;
      function  ExecStream(commandline:string;ShowOut:boolean):TMemoryStream;
      function  GetMonthNumber(MonthName:string):integer;

      procedure StripDiezes(filepath:string);
      function  PHP5_INI_PATH:string;
      function  PHP5_INI_SET_EXTENSION(librari:string):string;
      function  PHP5_IS_MODULE_EXISTS(modulename:string):boolean;


      function COMMANDLINE_PARAMETERS(FoundWhatPattern:string):boolean;
      function COMMANDLINE_EXTRACT_PARAMETERS(pattern:string):string;
      procedure DeleteFile(Path:string);
      procedure StatFile(path:string);
      function  FileSymbolicExists(path:string):boolean;
      function  StatFileSymbolic(Path:string):string;
      procedure deb_files_extists_between(patha:string;pathb:string);
      function  HtmlToText(error_text:string):string;
      procedure ParseMyqlQueue();
      function  TEMP_SEC():string;
      procedure PERL_CREATE_DEFAULT_SCRIPTS();
      function  STATUS_PATTERN_DATABASES():string;
      procedure INSTANT_SEARCH();


      function Explode(const Separator, S: string; Limit: Integer = 0):TStringDynArray;
      procedure splitexample(s:string;sep:string);
      constructor Create();
      destructor Free;

END;

implementation

constructor MyConf.Create();
begin
       SYS:=Tsystem.Create;
       LOGS:=tlogs.Create;
       CCYRUS:=TCYRUS.Create(SYS);
       roundcube:=Troundcube.Create(SYS);
       clamav:=Tclamav.Create();
       spamass:=Tspamass.Create(SYS);
       Cpureftpd:=Tpureftpd.Create();
       SYSTEM_CHDIR(get_ARTICA_PHP_PATH());
       ldap:=Topenldap.Create;
       ntpd:=TNTPD.Create;
       ArrayList:=TStringList.Create;
       download_silent:=false;
       spfm:=tspf.Create;
       samba:=Tsamba.Create;
       mimedef:=Tmimedefang.Create(SYS);
       squid:=Tsquid.Create;
       stunnel:=Tstunnel.Create(SYS);
       dkim:=Tdkim.Create(SYS);
       postfix:=Tpostfix.Create(SYS);
       mailgraph:=tMailgraphClass.Create(SYS);
       miltergreylist:=tmilter_greylist.Create(SYS);
       lighttpd:=Tlighttpd.Create(SYS);
       dansguardian:=Tdansguardian.Create(SYS);
       fetchmail:=tfetchmail.Create(SYS);


       kav4samba:=Tkav4samba.Create;
       awstats:=Tawstats.Create(SYS);
       kav4proxy:=Tkav4proxy.Create(SYS);
       bind9:=Tbind9.Create(SYS);
       obm:=Tobm.Create(SYS);
       zmysql:=tmysql_daemon.Create(SYS);
       fdm:=tfdm.Create(SYS);

       if Not DirectoryExists('/opt/artica/logs') then begin
          forceDirectories('/opt/artica/logs');
          fpsystem('/bin/chmod 755 /opt/artica/logs');
       end;
end;

destructor MyConf.Free;
begin
  //LOGS.Free;
  CCYRUS.Free;
  SYS.Free;
  try
      fetchmail.Free;
  except
  exit;
  end;

end;
//##############################################################################
function myconf.SYSTEM_MARK_DEB_CDROM():string;
 var

    A:Boolean;
    l:TstringList;
    i:integer;
    RegExpr:TRegExpr;

begin
    A:=false;

    if not FileExists('/etc/apt/sources.list') then exit;

    l:=TstringList.Create;
    l.LoadFromFile('/etc/apt/sources.list');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='^deb cdrom';


    for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           l.Strings[i]:='#' + l.Strings[i];
           A:=True;
        end;

    end;

    if A then l.SaveToFile('/etc/apt/sources.list');
    l.free;
    RegExpr.Free;

    result:='';
end;
//##############################################################################
function myconf.HtmlToText(error_text:string):string;

         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;
begin
     error_text:=AnsiReplaceText(error_text,CRLF,'');
     error_text:=AnsiReplaceText(error_text,CR,'');
     error_text:=AnsiReplaceText(error_text,LF,'');
     error_text:=AnsiReplaceText(error_text,'  ',' ');
     error_text:=AnsiReplaceText(error_text,'&quot;','"');
     error_text:=AnsiReplaceText(error_text,'<br>',', ');
     error_text:=AnsiReplaceText(error_text,'<p>','');
     error_text:=AnsiReplaceText(error_text,'<tt>','');
     error_text:=AnsiReplaceText(error_text,'</tt>','');
     result:=error_text;
end;
//##############################################################################
function myconf.SIMPLE_CALENDAR_VERSION():string;
var
   i:integer;
    l:TStringList;
    RegExpr:TRegExpr;
begin

if not FileExists('/usr/share/sgs/bin/core/index.php') then exit;
l:=TstringList.Create;
l.LoadFromFile('/usr/share/sgs/bin/core/index.php');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='Simple Groupware\s+([0-9\.]+)\s+';
for i:=0 to l.Count-1 do begin
    if RegExpr.exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;
end;

l.free;
RegExpr.free;

end;
//##############################################################################



procedure myconf.SYSTEM_SET_HOSTENAME(hostname:string);
 var
    F:boolean;
    l:TStringList;
    RegExpr:TRegExpr;
    i:integer;
begin

    fpsystem('/bin/echo "'+ hostname + '"  >/etc/hostname');
    fpsystem('/bin/echo "'+ hostname + '"  >/proc/sys/kernel/hostname');

    if FileExists(bind9.bin_path()) then exit;

    l:=TStringList.Create;
    F:=false;
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='127\.0\.1\.1';;
    l.LoadFromFile('/etc/hosts');
     RegExpr.Expression:='127\.0\.1\.1';;
    for i:=0 to l.Count-1 do begin

      if RegExpr.Exec(l.Strings[i]) then begin
         l.Strings[i]:='127.0.1.1' + chr(9) + hostname;
         F:=true;
      end;
    end;

  if not F then begin
  RegExpr.Expression:='127\.0\.0\.1';;
    for i:=0 to l.Count-1 do begin

      if RegExpr.Exec(l.Strings[i]) then begin
         l.Strings[i]:='127.0.0.1' + chr(9) + hostname;
      end;
    end;

end;
l.SaveToFile('/etc/hosts');

end;
//##############################################################################

function myconf.SYSTEM_FQDN():string;
var
 ypdomainname:string;
 domainname:string;
  RegExpr:TRegExpr;
begin

    fpsystem(SYS.LOCATE_GENERIC_BIN('hostname')+' -s >/opt/artica/logs/hostname.txt');
    result:=ReadFileIntoString('/opt/artica/logs/hostname.txt');
    result:=trim(result);
    ypdomainname:=SYS.LOCATE_GENERIC_BIN('ypdomainname');
    if FIleExists(ypdomainname) then begin
         fpsystem(ypdomainname +' >/tmp/domain.name.txt 2>&1');
    end else begin
         fpsystem(SYS.LOCATE_GENERIC_BIN('sysctl')+' -n kernel.domainname >/tmp/domain.name.txt 2>&1');
    end;
    domainname:=trim(ReadFileIntoString('/tmp/domain.name.txt'));
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='name not set';
    if RegExpr.Exec(domainname) then domainname:='';
    RegExpr.Expression:='name not set';
    if RegExpr.Exec(domainname) then domainname:='';


    RegExpr.free;

    if length(domainname)>0 then result:=result+'.'+domainname;

end;


//##############################################################################
function myconf.SHARED_CONF_GET_CLIENTS(SharedSource:string):TStringList;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   res:TstringList;
begin
  res:=TStringList.Create;
  result:=res;
  l:=TStringList.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(.+?)\s+(\/.+?)\s+none\s+.+?bind\s+';
  if FileExists('/etc/mtab') then begin
      l.LoadFromFile('/etc/mtab');
      for i:=0 to l.Count-1 do begin
          if RegExpr.Exec(l.Strings[i]) then begin
              if RegExpr.Match[1]=SharedSource then res.Add(RegExpr.Match[2]);
          end;
      end;
  end;
  result:=res;

end;

//##############################################################################
procedure  myconf.PURE_FTPD_SETCONFIG(key:string;value:string);
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   Found:boolean;
begin
  if not FileExists('/opt/artica/etc/pure-ftpd.conf') then exit;
  Found:=false;
  l:=TstringList.Create;
  l.LoadFromFile('/opt/artica/etc/pure-ftpd.conf');
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^' + key + '\s+';
  for i:=0 to l.Count -1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          l.Strings[i]:=key + chr(9) + value;
          Found:=true;
          break;
      end;

  end;

  if Found=false then begin
  l.Add(key + chr(9) + value);
  l.SaveToFile('/opt/artica/etc/pure-ftpd.conf');
  end;
  l.Free;
  RegExpr.Free;

end;
procedure  myconf.PURE_FTPD_DELCONFIG(key:string);
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
begin
  if not FileExists('/opt/artica/etc/pure-ftpd.conf') then exit;
  l:=TstringList.Create;
  l.LoadFromFile('/opt/artica/etc/pure-ftpd.conf');
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^' + key + '\s+';
  for i:=0 to l.Count -1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          l.Delete(i);
          break;
      end;

  end;

  l.Free;
  RegExpr.Free;

end;



//##############################################################################
procedure myconf.ARTICA_HAS_GAYTEWAY();
var
   EnableArticaAsGateway:integer;
begin
    EnableArticaAsGateway:=0;
    if not TryStrToInt(SYS.GET_INFO('EnableArticaAsGateway'),EnableArticaAsGateway) then EnableArticaAsGateway:=0;
    if EnableArticaAsGateway=0 then begin
       if SYS.ip_forward_enabled() then begin
          logs.Syslogs('Starting......:  Disable Artica Gayteway mode');
          fpsystem('sysctl -w net.ipv4.ip_forward=0');
       end;

    end;

    if EnableArticaAsGateway=1 then begin
        if not SYS.ip_forward_enabled() then begin
         logs.Syslogs('Starting......:  Enable Artica Gayteway mode');
         fpsystem('sysctl -w net.ipv4.ip_forward=1');
       end;
    end;
end;
//##############################################################################
function myconf.SCAN_USB():string;
var
   l,s:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;

   fpath:string;
   fline:string;
   UUID:string;
   fLABEL:string;
   fTYPE:string;
   SEC_TYPE:string;
   DEV:string;
   mountp:string;
begin
   tmpfile:=logs.FILE_TEMP();
   fpsystem(SYS.LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmpfile);
   logs.DeleteFile(tmpfile);
   if FileExists('/etc/artica-postfix/devinfo') then logs.DeleteFile('/etc/artica-postfix/devinfo');
   RegExpr:=TRegExpr.Create;
   s:=Tstringlist.Create;
   s.Add('$_GLOBAL["usb_list"]=array(');
   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       DEV:='';

       if RegExpr.Exec(l.Strings[i]) then begin
           logs.Debuglogs(RegExpr.Expression + ' Match ' + l.Strings[i]);
           fpath:=RegExpr.Match[1];
           fpath:=AnsiReplaceText(fpath,'/dev/.static/dev','/dev');
           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then UUID:=RegExpr.Match[1];
           RegExpr.Expression:='LABEL="(.+?)"';
           if RegExpr.Exec(fline) then fLABEL:=RegExpr.Match[1];


           RegExpr.Expression:='TYPE="(.+?)"';
           if RegExpr.Exec(fline) then fTYPE:=RegExpr.Match[1];
           if fTYPE='swap' then continue;


           RegExpr.Expression:='SEC_TYPE="(.+?)"';
           if RegExpr.Exec(fline) then SEC_TYPE:=RegExpr.Match[1];
           mountp:=usb_mount_point(fpath);
           RegExpr.Expression:='\/([a-zA-Z0-9]+)$';
           if RegExpr.Exec(fpath) then DEV:=RegExpr.Match[1];

           s.Add(chr(9)+chr(9)+'"'+UUID+'"=>array(');
           s.Add(chr(9)+chr(9)+chr(9)+'"PATH"=>"'+fpath+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"UUID"=>"'+ UUID+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"LABEL"=>"'+fLABEL+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"TYPE"=>"'+fTYPE+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"SEC_TYPE"=>"'+SEC_TYPE+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"model"=>"'+usb_devinfo_path(fpath)+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"mounted"=>"'+mountp+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"DEV"=>"'+DEV+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"ID_MODEL"=>"'+USB_DEV_INFO(DEV,'ID_MODEL')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"ID_VENDOR"=>"'+USB_DEV_INFO(DEV,'ID_VENDOR')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"ID_FS_LABEL"=>"'+USB_DEV_INFO(DEV,'ID_FS_LABEL')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"DEVTYPE"=>"'+USB_DEV_INFO(DEV,'DEVTYPE')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"ID_FS_TYPE"=>"'+USB_DEV_INFO(DEV,'ID_FS_TYPE')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"ID_FS_LABEL_SAFE"=>"'+USB_DEV_INFO(DEV,'ID_FS_LABEL_SAFE')+'",');
           s.add(chr(9)+chr(9)+chr(9)+'"SIZE"=>"'+usb_size(fpath,mountp)+'"),');


       end;


   end;
   logs.DeleteFile('/etc/artica-postfix/fdisk.info');
   s.Add(chr(9)+chr(9)+');');
   result:=s.Text;
   s.free;
   l.free;
   RegExpr.free;



end;
//##############################################################################
function myconf.SCAN_DISK_PHP(norecheck:boolean):string;
   var
   l,s:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   DiskDev:string;
   SIZE:string;
   ID_BUS:string;
   proc_partition:boolean;

begin

    proc_partition:=false;
    if not FileExists('/etc/artica-postfix/fdisk.info') then begin
       if FileExists('/proc/partitions') then begin
          proc_partition:=true;
          fpsystem('/sbin/fdisk -l > /etc/artica-postfix/fdisk.info 2>&1');
       end else begin

          fpsystem('/bin/df -h > /etc/artica-postfix/fdisk.info 2>&1');
       end;

    end;


     if not FileExists('/etc/artica-postfix/fdisk.info') then begin
        logs.Syslogs('SCAN_DISK_PHP():: Fatal Error while stat /etc/artica-postfix/fdisk.info');

     end;

     s:=TstringList.Create;
      s.Add('$_GLOBAL["disks_list"]=array(');


     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;

     l.LoadFromFile('/etc/artica-postfix/fdisk.info');
     for i:=0 to l.Count-1 do begin
         RegExpr.Expression:='cannot open.+?partitions';
         if RegExpr.Exec(l.Strings[i]) then begin
            if not norecheck then begin
               logs.DeleteFile('/etc/artica-postfix/fdisk.info');
               SCAN_DISK_PHP(true);
            end;
         end;

        RegExpr.Expression:='(.+?)\s+([0-9\.A-Z]+)\s+([0-9\.A-Z]+)\s+([0-9\.A-Z]+)\s+([0-9\.\%]+)\s+';
        if proc_partition then RegExpr.Expression:='^[A-Za-z]+\s+(.+?):\s+([0-9\.]+)\s+([A-Za-z]+)';
         if RegExpr.Exec(l.Strings[i]) then begin
                  DiskDev:=RegExpr.Match[1];
                  if DiskDev='none' then continue;
                  logs.Debuglogs('SCAN_DISK_PHP:: Found "'+DiskDev+'"');
                  ID_BUS:=usb_devinfo_query(DiskDev,'SUBSYSTEMS');
                  if length(ID_BUS)=0 then  ID_BUS:=USB_DEV_INFO(DiskDev,'ID_BUS');
                  if ID_BUS='usb' then continue;
                  if proc_partition then SIZE:=RegExpr.Match[2]+' '+RegExpr.Match[3] else SIZE:=RegExpr.Match[2];
                  s.Add(chr(9)+chr(9)+'"'+DiskDev+'"=>array(');
                  s.Add(chr(9)+chr(9)+chr(9)+'"SIZE"=>"'+SIZE+'",');
                  s.add(chr(9)+chr(9)+chr(9)+'"ID_FS_LABEL"=>"'+sys.usbLabel(DiskDev)+'",');
                  s.add(chr(9)+chr(9)+chr(9)+'"ID_MODEL_1"=>"'+usb_devinfo_query(DiskDev,'ATTRS{model}')+'",');
                  s.add(chr(9)+chr(9)+chr(9)+'"ID_MODEL_2"=>"'+USB_DEV_INFO(DiskDev,'ID_MODEL')+'",');
                  s.add(chr(9)+chr(9)+chr(9)+'"ID_VENDOR"=>"'+USB_DEV_INFO(DiskDev,'ID_VENDOR')+'",');
                  s.add(chr(9)+chr(9)+chr(9)+'"ID_BUS"=>"'+ID_BUS+'",');
                  s.Add(chr(9)+chr(9)+chr(9)+'"MOUNTED"=>"'+SYS.usb_mount_point(DiskDev)+'",');
                  s.Add(chr(9)+chr(9)+chr(9)+'"PARTITIONS"=>'+SCAN_DISK_PARTITIONS_PHP(DiskDev));
                  s.Add(chr(9)+chr(9)+chr(9)+'),');
         end;



     end;

     s.Add(chr(9)+');');
     result:=s.Text;
     s.free;
     l.free;
     RegExpr.free;




end;
//##############################################################################
function myconf.SCAN_DISK_PARTITIONS_PHP(dev:string):string;
var
   l,s:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   DiskDev:string;
   mddev_path:string;
   D:boolean;
   cmd:string;
   part_type:string;
   mountp:string;
begin
    D:=false;
    DiskDev:='';
    d:=SYS.COMMANDLINE_PARAMETERS('--verbose');
    mddev_path:='/etc/artica-postfix/fdisk.'+logs.MD5FromString(dev)+'.info';
    logs.DeleteFile(mddev_path);

    if not FileExists(mddev_path) then begin
       cmd:='/sbin/fdisk -l ' + dev + ' >'+ mddev_path+ ' 2>&1';
       if D then writeln(cmd);
       fpsystem(cmd);
    end;


if not FileExists(mddev_path) then begin
        logs.Syslogs('SCAN_DISK_PARTITIONS_PHP():: Fatal Error while stat '+mddev_path);
        exit('array()');
     end;

     l:=TstringList.Create;
     s:=TstringList.Create;
     s.Add('array(');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^([a-z0-9\/\-]+)([\s|*]+)[0-9\+]+\s+[0-9\+]+\s+[0-9\+]+\s+([0-9a-z\+]+)\s+[a-zA-z0-9]+';
     l.LoadFromFile(mddev_path);
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            mountp:=usb_mount_point(RegExpr.Match[1]);
            part_type:=RegExpr.Match[3];
            s.Add(chr(9)+chr(9)+chr(9)+chr(9)+'"'+RegExpr.Match[1]+'"=>array(');
            s.Add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"TYPE"=>"'+part_type +'",');
            s.Add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"MOUNTED"=>"'+mountp+'",');
            s.add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"ID_FS_LABEL"=>"'+sys.usbLabel(RegExpr.Match[1])+'",');
            s.add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"ID_FS_TYPE"=>"'+USB_DEV_INFO(DiskDev,'ID_FS_TYPE')+'",');
            s.add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"free_size"=>"'+usb_size(RegExpr.Match[1],mountp)+'",');
            if part_type<>'5' then s.Add(chr(9)+chr(9)+chr(9)+chr(9)+chr(9)+'"SIZE"=>"'+SCAN_DISK_PARTITIONS_SIZE_PHP(RegExpr.Match[1]) +'"');
            s.Add(chr(9)+chr(9)+chr(9)+chr(9)+'),');
         end;
     end;



     s.add(chr(9)+chr(9)+chr(9)+')');
     result:=s.Text;


end;
//##############################################################################
function myconf.SCAN_DISK_PARTITIONS_SIZE_PHP(dev:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   mddev_path:string;
   D:boolean;
   cmd:string;

begin

    D:=false;
    d:=SYS.COMMANDLINE_PARAMETERS('--verbose');



    mddev_path:='/etc/artica-postfix/fdisk.partition.'+logs.MD5FromString(dev)+'.info';
    logs.DeleteFile(mddev_path);

    if not FileExists(mddev_path) then begin
       cmd:='/sbin/fdisk -l ' + dev + ' >'+ mddev_path+ ' 2>&1';
       if D then writeln(cmd);
       fpsystem(cmd);
    end;


    if not FileExists(mddev_path) then begin
        logs.Syslogs('SCAN_DISK_PARTITIONS_SIZE_PHP():: Fatal Error while stat '+mddev_path);
        exit('0 Go');
     end;
     result:='0 Go';
     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^[a-zA-z]+\s+'+dev+':\s+([0-9\.]+)\s+([A-Za-z]+),';
     l.LoadFromFile(mddev_path);
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
             result:=RegExpr.Match[1]+' ' + RegExpr.Match[2];
             break;
         end;
     end;

l.free;
RegExpr.free;


end;
//##############################################################################

function myconf.USB_DEV_INFO(dev:string;key:string):string;
var
   l:TstringList;
   RegExpr:TRegExpr;
   f:boolean;
   i:integer;
   cmd:string;
   newdev:string;
   D:boolean;
begin
D:=false;
D:=COMMANDLINE_PARAMETERS('--verbose');
if FileExists('/usr/bin/udevinfo') then cmd:='/usr/bin/udevinfo -e';
if FileExists('/sbin/udevadm') then cmd:='/sbin/udevadm info -e';


RegExpr:=TRegExpr.Create;
RegExpr.Expression:='\/([a-zA-Z0-9\-\_]+)$';
RegExpr.Exec(dev);
newdev:=RegExpr.Match[1];

if D then writeln('cmd=',cmd);
if D then writeln('newdev=',newdev);

if length(newdev)=0 then begin
   if D then writeln('unable to find new dev in '+dev+' Match ' + key);
   newdev:=dev;
end;

if length(newdev)=0 then begin
   if D then writeln('unable to find new dev in '+dev+' Match ' + key);
   exit;
end;

//update-pciids && update-usbids

    if not FileExists('/etc/artica-postfix/devinfo') then fpsystem(cmd+' >/etc/artica-postfix/devinfo 2>&1');
    if not FileExists('/etc/artica-postfix/devinfo') then exit;

    f:=false;
    l:=TstringList.Create;
    l.LoadFromFile('/etc/artica-postfix/devinfo');

    if D then writeln('l.count=',l.Count);
    if l.Count<2 then begin
          fpsystem(cmd+' >/etc/artica-postfix/devinfo 2>&1');
          l.LoadFromFile('/etc/artica-postfix/devinfo');
    end;


    f:=false;
    for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^P:\s+.+?'+newdev+'$';
          if RegExpr.Exec(l.Strings[i]) then begin
          if d then writeln('FOUND '+l.Strings[i] + ' for '+RegExpr.Expression);
          f:=true;
          continue;
       end;


       if f then begin
          RegExpr.Expression:='E:\s+'+key+'=(.+)';
          if RegExpr.Exec(l.Strings[i]) then begin
            // if D then writeln('E=' +l.Strings[i]);
             result:=RegExpr.Match[1];
             break;
          end;


           RegExpr.Expression:='^P:\s+';
           //if D then writeln('P=' +l.Strings[i]);
           if RegExpr.Exec(l.Strings[i]) then break;
       end;


    end;

  RegExpr.free;
  l.free;
end;
//##############################################################################



procedure myconf.BACKUP_USB();
var
   remote_uuid:string;
   mountpoint:string;
   dev_point,target_point:string;
   D:boolean;
   perform:boolean;
begin
  D:=COMMANDLINE_PARAMETERS('--verbose');
  perform:=false;
  remote_uuid:=get_INFOS('ArticaUsbBackupKeyID');
  if D then logs.Debuglogs('BACKUP_USB():: target UUID='+remote_uuid);
  if length(remote_uuid)=0 then exit;


  if not UsbExists(remote_uuid) then begin
     if D then logs.Debuglogs('BACKUP_USB():: target UsbExists=FALSE');
     exit;
  end;
  mountpoint:=usbMountPoint(remote_uuid);
  if D then logs.Debuglogs('BACKUP_USB():: target UsbExists=TRUE dev='+mountpoint);

  if COMMANDLINE_PARAMETERS('--force') then logs.DeleteFile('/etc/artica-postfix/' + remote_uuid);

  if not FileExists('/etc/artica-postfix/' + remote_uuid) then begin
     perform:=true;
  end else begin

    if SYS.FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/' + remote_uuid)>120 then perform:=True;
  end;

  if not perform then begin
      if D then logs.Debuglogs('BACKUP_USB():: no time to perform this operation...');
      exit;
  end;

  logs.DeleteFile('/etc/artica-postfix/' + remote_uuid);
  logs.OutputCmd('/bin/touch /etc/artica-postfix/' + remote_uuid);

  if length(mountpoint)=0 then begin
     logs.Debuglogs('BACKUP_USB()::  bad mount point returned ' + mountpoint );
     exit;
  end;
  dev_point:=mountpoint;
  target_point:=usb_mount_point(dev_point);


  if length(target_point)=0 then begin
      logs.Debuglogs('BACKUP_USB():: mount '+dev_point );
      logs.OutputCmd(get_ARTICA_PHP_PATH()+'/bin/hmount -v ' + dev_point);
      target_point:=usb_mount_point(dev_point);
       if length(target_point)=0 then begin
         logs.Debuglogs('BACKUP_USB()::  unable to mount point '+dev_point );
         exit;
       end;

  end;
  if D then logs.Debuglogs('BACKUP_USB():: mounted on='+target_point);
  global_backup_usb_path:=target_point;
  BACKUP_MYSQL();





end;


//##############################################################################
function myconf.usbMountPoint(target_uuid:string):string;
begin
exit(SYS.usbMountPoint(target_uuid));
end;
//##############################################################################
function myconf.UsbExists(uuid:string):boolean;
begin
exit(SYS.DISK_USB_EXISTS(uuid));
end;
//##############################################################################
function myconf.usb_devinfo_query(dev:string;key:string):string;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   cmd:string;
   D:boolean;

begin
d:=false;
d:=SYS.COMMANDLINE_PARAMETERS('--verbose');
tmpfile:=logs.FILE_TEMP();
key:=AnsiReplaceText(key,'{','\{');
key:=AnsiReplaceText(key,'}','\}');
if FileExists('/usr/bin/udevinfo') then begin
   cmd:='/usr/bin/udevinfo -a -p `/usr/bin/udevinfo -q path -n ' + dev+ '`';
end else begin
  if FileExists('/sbin/udevadm') then cmd:='/sbin/udevadm info --query=all --path=`/sbin/udevadm info --query=path --name='+dev+'`';
end;

  if length(cmd)=0 then begin
     logs.Syslogs('usb_devinfo_path():: fatal error, unable to stat /usr/bin/udevinfo or /sbin/udevadm');
     exit;
  end;

  cmd:=cmd+' >'+tmpfile + ' 2>&1';
  if d then writeln('usb_devinfo_query():: '+cmd);
  fpsystem(cmd);
  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=key+'.+?"(.+?)"';
  if d then writeln('usb_devinfo_query():: pattern:', RegExpr.Expression,' in ',l.Count,' lines');
  for i:=0 to l.Count-1 do begin
      if d then writeln('usb_devinfo_query():: -> ',l.Strings[i]);
       if RegExpr.Exec(l.Strings[i]) then begin
          if d then writeln('usb_devinfo_query():: found ',l.Strings[i]);
          if  RegExpr.Match[1]='block' then continue;
          result:=RegExpr.Match[1];
          break;
       end;
  end;


  l.free;
  RegExpr.free;

end;
//##############################################################################

function myconf.usb_devinfo_path(path:string):string;
var
tmpfile:string;
l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   model:string;
   vendor:string;
   product:string;
   manufacturer:string;
   idVendor:string;
   idProduct:string;
   speed:string;
   cmd:string;

begin
  tmpfile:=logs.FILE_TEMP();

  path:=AnsireplaceText(path,'dev//dev','/dev');
  if FileExists('/usr/bin/udevinfo') then cmd:='/usr/bin/udevinfo -a -p `/usr/bin/udevinfo -q path -n ' + path+ '`';
  if FileExists('/sbin/udevadm') then cmd:='/sbin/udevadm info --query=all --path=`/sbin/udevadm info --query=path --name='+path+'`';

  if length(cmd)=0 then begin
     logs.Syslogs('usb_devinfo_path():: fatal error, unable to stat /usr/bin/udevinfo or /sbin/udevadm');
     exit;
  end;

  fpsystem(cmd+' >'+tmpfile + ' 2>&1');
  if not FileExists(tmpfile) then exit;
  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  idProduct:='';
  idVendor:='';
  manufacturer:='';
  product:='';
  speed:='';
  for i:=0 to l.Count-1 do begin
     RegExpr.Expression:='ATTRS\{model\}=="(.*?)"';
     if RegExpr.Exec(l.Strings[i]) then model:=RegExpr.Match[1];
     RegExpr.Expression:='ATTRS\{vendor\}=="(.*?)"';
     if RegExpr.Exec(l.Strings[i]) then vendor:=RegExpr.Match[1];

     if length(product)=0 then begin
        RegExpr.Expression:='ATTRS\{product\}=="(.*?)"';
        if RegExpr.Exec(l.Strings[i]) then product:=RegExpr.Match[1];
     end;

     if length(manufacturer)=0 then begin
        RegExpr.Expression:='ATTRS\{manufacturer\}=="(.*?)"';
        if RegExpr.Exec(l.Strings[i]) then manufacturer:=RegExpr.Match[1];
     end;

 if length(idVendor)=0 then begin
        RegExpr.Expression:='ATTRS\{idVendor\}=="([0-9]+)"';
        if RegExpr.Exec(l.Strings[i]) then idVendor:=RegExpr.Match[1];
     end;

 if length(idProduct)=0 then begin
        RegExpr.Expression:='ATTRS\{idProduct\}=="([0-9]+)"';
        if RegExpr.Exec(l.Strings[i]) then idProduct:=RegExpr.Match[1];
     end;


 if length(speed)=0 then begin
        RegExpr.Expression:='ATTRS\{speed\}=="([0-9]+)"';
        if RegExpr.Exec(l.Strings[i]) then speed:=RegExpr.Match[1];
     end;


     if (length(vendor)>0) and (length(model)>0) and (length(product)>0)  and (length(manufacturer)>0) and (length(speed)>0) then break;
  end;

  result:=trim(vendor)+';'+trim(model)+';'+trim(product)+';'+trim(manufacturer)+';' + idVendor+':'+idProduct+';'+speed+'Mbps;'+cmd;
  RegExpr.free;
  l.free;


end;
//##############################################################################

function myconf.usb_mount_point(path:string):string;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
begin
D:=false;
D:=COMMANDLINE_PARAMETERS('--debug');
if D then logs.Debuglogs('usb_mount_point()::"'+path+'"');
tmpfile:=logs.FILE_TEMP();
  fpsystem('/bin/mount -l >'+tmpfile + ' 2>&1');
  if not FileExists(tmpfile) then begin
     if D then logs.Debuglogs('usb_mount_point():: tmpfile "'+tmpfile+'" IS NULL');
     exit;
  end;

  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=path+'\s+on\s+(.+?)\s+type';
  for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        if D then logs.Debuglogs('usb_mount_point():: Found "'+l.Strings[i]+'" IS NULL');
        result:=trim(RegExpr.Match[1]);
        break;
     end;
  end;

  RegExpr.free;
  l.free;

end;
//##############################################################################
function myconf.usb_size(pathFrom:string;pathTo:string):string;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
begin
if length(pathTo)=0 then exit;
tmpfile:=logs.FILE_TEMP();
fpsystem('/bin/df -h >'+tmpfile + ' 2>&1');
if not FileExists(tmpfile) then exit;
  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=pathFrom+'\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+'+pathTo;
for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        result:=trim(RegExpr.Match[1]+';'+RegExpr.Match[2]+';'+RegExpr.Match[3]+';'+RegExpr.Match[4]);
        break;
     end;
  end;

  RegExpr.free;
  l.free;
end;
//##############################################################################

procedure myconf.PURE_FTPD_PREPARE_LDAP_CONFIG();
var
   artica_admin            :string;
   artica_password         :string;
   artica_suffix           :string;
   ldap_server             :string;
   ldap_server_port        :string;
   l                       :TstringList;

begin

    artica_admin:=get_LDAP('admin');
    artica_password:=get_LDAP('password');
    artica_suffix:=get_LDAP('suffix');
    ldap_server:=Get_LDAP('server');
    ldap_server_port:=Get_LDAP('port');


    if length(ldap_server)=0 then ldap_server:='127.0.0.1';
    if length(ldap_server_port)=0 then ldap_server_port:='389';
    l:=TstringList.Create;


    if not SYS.IsUserExists('ftpuser') then begin
        writeln('Starting......: pure-ftpd create user ftpuser on system');
        SYS.AddUserToGroup('ftpuser','ftpuser','','');
    end;

L.Add('LDAPServer ' + ldap_server);
L.Add('LDAPPort   ' + ldap_server_port);
L.Add('LDAPBaseDN ' + artica_suffix);
L.Add('LDAPBindDN cn=' + artica_admin + ',' + artica_suffix);
L.Add('LDAPBindPW ' + artica_password);
L.Add('LDAPFilter (&(objectClass=userAccount)(uid=\L)(FTPStatus=TRUE))');
L.Add('# LDAPHomeDir homeDirectory');
L.Add('LDAPVersion 3');
L.SaveToFile('/opt/artica/etc/pure-ftpd.ldap.conf');
l.free;

forceDirectories('/opt/artica/var/pureftpd');
PURE_FTPD_SETCONFIG('PIDFile','/var/run/pure-ftpd.pid');
PURE_FTPD_SETCONFIG('AltLog','w3c:/opt/artica/logs/pureftpd.log');
PURE_FTPD_SETCONFIG('CreateHomeDir','yes');
//PURE_FTPD_SETCONFIG('#LDAPConfigFile','/opt/artica/etc/pure-ftpd.ldap.conf');
PURE_FTPD_DELCONFIG('LDAPConfigFile');
PURE_FTPD_SETCONFIG('PureDB','/opt/artica/var/pureftpd/pureftpd.pdb');
end;
//##############################################################################
procedure myConf.CROSSROADS_SEND_REQUESTS_TO_SERVER();
var
   cross      :TiniFile;
   master_ip  :string;
   slave_ip   :string;
   cmdline    :string;
   PHP_PATH   :string;
   FileDate   :integer;
   syslogPath :string;
begin
 FileDate:=0;
 if not FileExists('/etc/artica-postfix/crossroads.indentities.conf') then exit;
 cross:=TiniFile.Create('/etc/artica-postfix/crossroads.indentities.conf');
 master_ip:=cross.ReadString('INFOS','mastr_ip','');
 slave_ip:=cross.ReadString('INFOS','slave_ip','');
if ParamStr(1)<>'-cross-rq'then begin
 if FileExists('/opt/artica/logs/crossroads.syslog.log') then begin
    FileDate:=SYSTEM_FILE_SECONDS_BETWEEN_NOW('/opt/artica/logs/crossroads.syslog.log');
    if FileDate>0 then begin
       logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER::FileDate="' + IntToStr(FileDate) + '"');
       if FileDate<CROSSROADS_POOLING_TIME() then exit;
    end;
 end;
end;

 logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER:: IP=' +master_ip + ' local ip=' + slave_ip + ' FileDate=' + intToStr(FileDate));
 uri:='https://'+master_ip +':9000/listener.balance.php?Check='+slave_ip;
 PHP_PATH:=get_ARTICA_PHP_PATH();
 syslogPath:=SYSTEM_GET_SYSLOG_PATH();

 logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER:: Export logs');


 if not FileExists(syslogPath) then begin
    logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER:: Warning !! Unable to stat "' + syslogPath + '" syslog path');
    exit;
 end;

 logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER:: EXEC: /usr/bin/tail -n 100 ' + syslogPath + '>/opt/artica/logs/crossroads.syslog.log');
 fpsystem('/usr/bin/tail -n 100 ' + syslogPath + '>/opt/artica/logs/crossroads.syslog.log');

 cmdline:='/opt/artica/bin/curl -k -A artica --connect-timeout 5  ';
 cmdline:=cmdline + ' -F "postfixevents=@' + PHP_PATH + '/ressources/logs/postfix-all-events.log"';
 cmdline:=cmdline + ' -F "crossroads.syslog.log=@/opt/artica/logs/crossroads.syslog.log"';
 cmdline:=cmdline + ' -F "global_status=@'+ PHP_PATH + '/ressources/logs/global-status.ini"';
 cmdline:=cmdline + ' ' + uri;

 logs.logs('CROSSROADS_SEND_REQUESTS_TO_SERVER:: ' + cmdline);
 fpsystem(cmdline + ' >/opt/artica/logs/curl.logs 2>&1');

 if ParamStr(1)='-cross-rq' then writeln(ReadFileIntoString('/opt/artica/logs/curl.logs'));

 logs.logs(ReadFileIntoString('/opt/artica/logs/curl.logs'));


end;


//##############################################################################
function myconf.SYSTEM_IS_HOSTNAME_VALID() :boolean;
var
   hostname:string;
   exp:TStringDynArray;
   D:Boolean;
begin
    result:=false;
    hostname:=SYSTEM_FQDN();
     D:=COMMANDLINE_PARAMETERS('debug');
    exp:=Explode('.',hostname);

     if D then writeln(hostname + '=',length(exp));


    if length(exp)<2 then begin
       if D then writeln(intTostr(length(exp)) + '<2');
       result:=false;
       exit;
    end;
    result:=true;

end;
//##############################################################################
function myconf.SYSTEM_GCC_PATH():string;
 begin
     if FileExists('/usr/bin/gcc') then exit('/usr/bin/gcc');
 end;
//##############################################################################
function myconf.SYSTEM_MAKE_PATH():string;
 begin
     if FileExists('/usr/bin/make') then exit('/usr/bin/make');
 end;
//##############################################################################
function  myconf.SYSTEM_GET_HTTP_PROXY:string;
var
   l:TStringList;
   i:integer;
   RegExpr:TRegExpr;

 begin
  if not FileExists('/etc/environment') then begin
     l:=TStringList.Create;
     l.Add('LANG="en_US.UTF-8"');
     l.SaveToFile('/etc/environment');
     exit;
  end;


  l:=TStringList.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(http_proxy|HTTP_PROXY)=(.+)';

  l.LoadFromFile('/etc/environment');
  for i:=0 to l.Count -1 do begin
      if RegExpr.Exec(l.Strings[i]) then result:=RegExpr.Match[2];

  end;
 l.FRee;
 RegExpr.free;

end;
//##############################################################################
function myconf.WGET_DOWNLOAD_FILE(uri:string;file_path:string):boolean;
begin
result:=SYS.WGET_DOWNLOAD_FILE(uri,file_path);
end;
//##############################################################################



FUNCTION myconf.SYSTEM_ENV_PATHS():string;
var
   Path:string;
   res:string;

 begin
     if FileExists('/usr/bin/printenv') then Path:='/usr/bin/printenv';
     if length(Path)=0 then exit;
     res:=ExecPipe(Path + ' PATH');
     result:=res;
end;
//##############################################################################
procedure Myconf.SYSTEM_ENV_PATH_SET(path:string);
var
 Table:TStringDynArray;
 datas:string;
 i:integer;
 newpath:string;
 D:Boolean;
begin
     D:=COMMANDLINE_PARAMETERS('debug');
     datas:=SYSTEM_ENV_PATHS();
     if length(datas)>1 then begin
        Table:=Explode(':',SYSTEM_ENV_PATHS());
        For i:=0 to Length(Table)-1 do begin
                 if D then writeln('SYSTEM_ENV_PATH_SET -> ' + path + ' already exists in env');
                 LOGS.logs('SYSTEM_ENV_PATH_SET -> ' + path + ' already exists in env');
                if Table[i]=path then exit;
        end;
     end;

    LOGS.logs('SYSTEM_ENV_PATH_SET -> ' + path);
    newpath:=SYSTEM_ENV_PATHS() + ':' + path;
    fpsystem('/usr/bin/env PATH=' + newpath + ' >/opt/artica/logs/env.tmp');

end;
//##############################################################################


function myconf.SYSTEM_VERIFY_CRON_TASKS();
var
   l:Tstringlist;
   logs:Tlogs;
begin
  l:=TStringList.Create;
  logs:=Tlogs.Create;
  forceDirectories('/etc/cron.d');

  if Not FileExists('/etc/cron.d/artica-cron-quarantine') then begin
      logs.Debuglogs('Create quarantine maintenance task in background;...');
      l.Add('#{artica-cron-quarantine_text}');
      l.Add('0 3 * * *  root ' +get_ARTICA_PHP_PATH() +'/bin/artica-quarantine -maintenance >/dev/null');
      l.SaveToFile('/etc/cron.d/artica-cron-quarantine');
  end;

l.Free;

if not FileExists('/etc/cron.d/artica_yorel') then YOREL_RECONFIGURE('');
logs.Debuglogs('SYSTEM_VERIFY_CRON_TASKS() end...');
result:='';

end;
//##############################################################################


function myconf.COMMANDLINE_PARAMETERS(FoundWhatPattern:string):boolean;
var
   i:integer;
   s:string;
   RegExpr:TRegExpr;

begin
 result:=false;
 s:='';
 if ParamCount>1 then begin
     for i:=2 to ParamCount do begin
        s:=s  + ' ' +ParamStr(i);
     end;
 end;
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:=FoundWhatPattern;
   if RegExpr.Exec(s) then begin
      RegExpr.Free;
      result:=True;
   end;


end;
//##############################################################################
function myconf.COMMANDLINE_EXTRACT_PARAMETERS(pattern:string):string;
var
   i:integer;
   s:string;
   RegExpr:TRegExpr;

begin
s:='';
 result:='';
 if ParamCount>0 then begin
     for i:=1 to ParamCount do begin
        s:=s  + ' ' +ParamStr(i);
     end;
 end;

         RegExpr:=TRegExpr.Create;
         RegExpr.Expression:=pattern;
         RegExpr.Exec(s);
         Result:=RegExpr.Match[1];
         RegExpr.Free;
end;
//##############################################################################
function myconf.CONSOLEKIT_STATUS():string;
var
   pidpath:string;
begin
   pidpath:=logs.FILE_TEMP();
   fpsystem(SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.status.php --console-kit >'+pidpath +' 2>&1');
   result:=logs.ReadFromFile(pidpath);
   logs.DeleteFile(pidpath);
end;
//#########################################################################################
function MyConf.get_SELINUX_ENABLED():boolean;
var filedatas:string;
RegExpr:TRegExpr;
begin
result:=false;
if not FileExists('/etc/selinux/config') then exit(False);
 filedatas:=ReadFileIntoString('/etc/selinux/config');
  RegExpr:=TRegExpr.create;
  RegExpr.Expression:='SELINUX=(enforcing|permissive|disabled)';
  if RegExpr.Exec(filedatas) then begin
         if RegExpr.Match[1]='permissive' then result:=True;
         if RegExpr.Match[1]='enforcing' then result:=True;
         if RegExpr.Match[1]='disabled' then result:=false;
       end
       else begin
          result:=False;
  end;
 end;
//##############################################################################
procedure MyConf.set_SELINUX_DISABLED();
var list:TstringList;
begin

if fileExists('/etc/rc.d/boot.apparmor') then begin
      ShowScreen('set_SELINUX_DISABLED:: Disable AppArmor...');
      fpsystem('/etc/init.d/boot.apparmor stop');
      fpsystem('/sbin/chkconfig -d boot.apparmor');
end;

if fileExists('/sbin/SuSEfirewall2') then begin
   ShowScreen('set_SELINUX_DISABLED:: Disable SuSEfirewall2...');
   fpsystem('/sbin/SuSEfirewall2 off');
end;
if FileExists('/etc/selinux/config') then begin
   killfile('/etc/selinux/config');
   list:=TstringList.Create;
   list.Add('SELINUX=disabled');
   list.SaveToFile('/etc/selinux/config');
   list.Free;
end;
end;
//#############################################################################
function MyConf.ARTICA_MYSQL_INFOS(val:string):string;
var ini:TIniFile;
begin
if not FileExists('/etc/artica-postfix/artica-mysql.conf') then exit();
ini:=TIniFile.Create('/etc/artica-postfix/artica-mysql.conf');
result:=ini.ReadString('MYSQL',val,'');
ini.Free;
end;
//#############################################################################
function MyConf.MYSQL_INIT_PATH:string;
begin
result:=zmysql.INIT_PATH();
end;
//#############################################################################
function MyConf.MYSQL_MYCNF_PATH:string;
begin
result:=zmysql.CNF_PATH();
end;
//#############################################################################
function Myconf.MYSQL_SERVER_PARAMETERS_CF(key:string):string;
var ini:TiniFile;
begin
  result:='';
  if not FileExists(MYSQL_MYCNF_PATH()) then exit();
  ini:=TIniFile.Create(MYSQL_MYCNF_PATH());
  result:=ini.ReadString('mysqld',key,'');

  if length(result)=0 then result:=ini.ReadString('mysqld_safe',key,'');

  ini.free;
end;
//#############################################################################
function Myconf.MYSQL_READ_CF(key:string;mycfpath:string):string;
var ini:TiniFile;
begin
  result:='';
  if not FileExists(mycfpath) then exit();
  ini:=TIniFile.Create(mycfpath);
  result:=ini.ReadString('mysqld',key,'');
  ini.free;
end;
//#############################################################################
function MyConf.MYSQL_BIN_PATH:string;
begin
  if FileExists('/usr/bin/mysql') then exit('/usr/bin/mysql');
  if FileExists('/opt/artica/bin/mysql') then exit('/opt/artica/bin/mysql');
end;
//#############################################################################
function MyConf.MYSQL_VERSION:string;
var mysql_bin,returned:string;
    RegExpr:TRegExpr;
begin
   mysql_bin:=MYSQL_BIN_PATH();
   if not FileExists(mysql_bin) then exit;
   returned:=ExecPipe(mysql_bin + ' -V');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='([0-9]+\.[0-9]+\.[0-9]+)';
   if RegExpr.Exec(returned) then result:=RegExpr.Match[1];
   RegExpr.Free;

end;
//#############################################################################
function myconf.CLAMDSCAN_BIN_PATH():string;
begin
if FileExists('/usr/bin/clamdscan') then exit('/usr/bin/clamdscan');
if FileExists('/opt/artica/bin/clamdscan') then exit('/opt/artica/bin/clamdscan');
end;
//#############################################################################

function MyConf.SYSTEM_ADD_NAMESERVER(nameserver:string):boolean;
var
   FileDatas:Tstringlist;
   RegExpr:TRegExpr;
   FileToEdit:string;
   i:integer;
begin
   FileToEdit:='/etc/resolv.conf';
   if not FileExists(FileToEdit) then  begin
      showscreen('SYSTEM_ADD_NAMESERVER:: unable to stat ' + FileToEdit);
      exit(false);
   end;

   FileDatas:=TStringList.Create;
   FileDatas.LoadFromFile(FileToEdit);
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^nameserver\s+' +nameserver;
   for i:=0 to FileDatas.Count -1 do begin
       if RegExpr.Exec(FileDatas.Strings[i]) then begin
          RegExpr.free;
          FileDatas.free;
          exit(true);
       end;
   end;

   FileDatas.Insert(0,'nameserver ' + nameserver);
   FileDatas.SaveToFile(FileToEdit);
   RegExpr.free;
   FileDatas.free;
   exit(true);
end;


function MyConf.SYSTEM_LD_SO_CONF_ADD(path:string):string;
var
 FileDatas:TStringList;
 i:integer;
begin
     FileDatas:=TStringList.Create;
    FileDatas.LoadFromFile('/etc/ld.so.conf');
    for i:=0 to FileDatas.Count -1 do begin
      if trim(FileDatas.Strings[i])=path then begin
         ShowScreen('SYSTEM_LD_SO_CONF_ADD:: "' + path + '" already added to /etc/ld.so.conf');
         FileDatas.Free;
         exit;
      end;
    end;

     FileDatas.Add(path);
     FileDatas.SaveToFile('/etc/ld.so.conf');
     FileDatas.Free;
     ShowScreen('SYSTEM_LD_SO_CONF_ADD:: -> ldconfig ... Please wait...');
     fpsystem('ldconfig');
     result:='';




end;

//#############################################################################
procedure MyConf.ARTICA_MYSQL_SET_INFOS(val:string;value:string);
begin
SYS.set_MYSQL(val,value);
end;
//#############################################################################
function MyConf.MYSQL_ENABLED():boolean;
var s:string;
begin
   result:=true;
   s:=ARTICA_MYSQL_INFOS('use_mysql');
   s:=LowerCase(s);
   if s='yes' then result:=true;
   if s='no' then result:=false;
end;
//#############################################################################
function MyConf.ARTICA_VERSION():string;
var
   l:string;
begin
   l:=get_ARTICA_PHP_PATH() + '/VERSION';
   if not FileExists(l) then exit('0.00');
   result:=trim(logs.ReadFromFile(l));
end;
//#############################################################################
function MyConf.ARTICA_PATCH_VERSION():string;
var
   l:string;
   F:TstringList;

begin
   l:=get_ARTICA_PHP_PATH() + '/PATCH';
   if not FileExists(l) then exit('');
   F:=TstringList.Create;
   F.LoadFromFile(l);
   result:=' PATCH '+trim(F.Text);
   F.Free;
end;
//#############################################################################
function MyConf.MYSQL_ACTION_TESTS_ADMIN():boolean;
    var root,password,commandline,cmd_result:string;
begin
  root:=SYS.MYSQL_INFOS('database_admin');
  password:=SYS.MYSQL_INFOS('database_password');
  if not fileExists('/usr/bin/mysql') then exit(false);
  if length(password)>0 then password:=' -p'+password;
  commandline:=MYSQL_EXEC_BIN_PATH() + ' -e ''select User,Password from user'' -u '+ root +password+' mysql';
  cmd_result:=ExecPipe(commandline);
  if length(cmd_result)>0 then exit(true) else exit(false);
end;
//#############################################################################
function MyConf.MYSQL_ACTION_COUNT_TABLES(database_name:string):integer;
    var root,commandline,password:string;
    list:TStringList;
    i:integer;
    XDebug:boolean;
    RegExpr:TRegExpr;
    count:integer;
begin
  count:=0;
  root:=SYS.MYSQL_INFOS('database_admin');
  password:=SYS.MYSQL_INFOS('database_password');
  XDebug:=COMMANDLINE_PARAMETERS('debug');
  if length(password)>0 then password:=' -p'+password;
  if not fileExists('/usr/bin/mysql') then exit(0);
  commandline:=MYSQL_EXEC_BIN_PATH() + ' -N -s -X -e ''show tables'' -u '+ root +password + ' ' + database_name;
  if XDebug then ShowScreen('MYSQL_ACTION_COUNT_TABLES::'+commandline);
  list:=TStringList.Create;
  list.LoadFromStream(ExecStream(commandline,false));
  if list.Count<2 then begin
    list.free;
    exit(0);
  end;

RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='<field name="Tables_in_' +database_name + '">(.+)<\/field>';
  //ShowScreen('MYSQL_ACTION_COUNT_TABLES::'+RegExpr.Expression);
  for i:=0 to list.count-1 do begin
      if RegExpr.Exec(list.Strings[i]) then inc(count);

  end;

list.free;
RegExpr.free;
exit(count);

end;
//#############################################################################
function MyConf.MYSQL_ACTION_IMPORT_DATABASE(filenname:string;database:string):boolean;
    var
    Logs:Tlogs;
begin
  result:=true;
  logs:=Tlogs.Create;
  logs.EXECUTE_SQL_FILE(filenname,database);
end;
//#############################################################################

procedure myconf.MYSQL_RECONFIGURE_DB();
var
   list:Tstringlist;
   path,tablename,database:string;
   i:integer;
   logs:Tlogs;
   RegExpr:TRegExpr;
   datadir:string;
   DatabaseName:string;
   DB:string;
begin
 Path:=ExtractFilePath(ParamStr(0)) + 'install/mysqldb';
 logs:=Tlogs.Create;
 if not DirectoryExists(Path) then begin
    logs.Debuglogs('MYSQL_RECONFIGURE_DB:: unable to stat ' + path);
    exit;
 end;
 logs.Debuglogs('MYSQL_RECONFIGURE_DB:: start');

 list:=TStringList.Create;
 list.AddStrings(sys.RecusiveListFiles(path));
 RegExpr:=TRegExpr.Create;
 datadir:=MYSQL_SERVER_PARAMETERS_CF('datadir');

 logs.Debuglogs('MYSQL_RECONFIGURE_DB::datadir='+datadir );
 logs.Debuglogs('MYSQL_RECONFIGURE_DB::Conntection ->' );

if not logs.Connect() then exit;
 logs.Debuglogs('MYSQL_RECONFIGURE_DB:: ' + IntTostr(list.Count) + ' files in '+Path);
 RegExpr.Expression:='db\.(.+)\.[0-9]+\.db';
 for i:=0 to list.Count-1 do begin
     if RegExpr.Exec(list.Strings[i]) then begin
         DatabaseName:=RegExpr.Match[1];
         tablename:=MYSQL_PARSE_TABLE_NAME_INFILE(list.Strings[i]);



         if not DirectoryExists(datadir + '/' + DatabaseName)then begin
                  DB:='CREATE DATABASE ' + DatabaseName;
                  logs.QUERY_SQL( pChar(DB),'');
         end;
         if length(tablename)>0 then begin
            if not FileExists(datadir+'/' + RegExpr.Match[1] + '/'+ tablename + '.frm') then begin
            logs.Debuglogs('');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::------------------------------------------------------------------------------');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::TableName.........: ' + tablename);
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::Base Path.........: ' + datadir + '/' + RegExpr.Match[1]);
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::Table Path........: ' + datadir+'/' + RegExpr.Match[1] + '/'+ tablename + '.frm');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::datadir...........: "'+datadir+'"');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::my.cnf............: "'+MYSQL_MYCNF_PATH()+'"');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::Filename..........: "'+list.Strings[i]+'"');
            logs.Debuglogs('MYSQL_RECONFIGURE_DB:: Parsing file ' + list.Strings[i] + ' table ' + tablename + ' in DB ' + RegExpr.Match[1]);
            logs.Debuglogs('MYSQL_RECONFIGURE_DB::' + datadir + '/' + RegExpr.Match[1] + '/'+ tablename + '.frm doesn''t exists');
            MYSQL_ACTION_IMPORT_FILE(list.Strings[i],RegExpr.Match[1],MYSQL_MYCNF_PATH());
            end;
         end else begin
              MYSQL_ACTION_IMPORT_FILE(list.Strings[i],RegExpr.Match[1],MYSQL_MYCNF_PATH());
         end;
     end;


 end;

 RegExpr.Expression:='ins\.(.+?)\.(.+?)\.db';
 for i:=0 to list.Count-1 do begin
    if RegExpr.Exec(list.Strings[i]) then begin
         tablename:=RegExpr.Match[2];
         database:=RegExpr.Match[1];
         path:=datadir+'s/' + database + '/'+ tablename + '.MYD';
         if FileExists(path) then begin
         logs.Debuglogs('MYSQL_RECONFIGURE_DB:: instert values in' + tablename + ' table in '+database + ' ('+path +')');
            if logs.GetFileBytes(path)<150 then begin

                MYSQL_ACTION_IMPORT_FILE(list.Strings[i],database,MYSQL_MYCNF_PATH());
            end;
         end else begin
             logs.Debuglogs('MYSQL_RECONFIGURE_DB:: unable to stat ' +path);
         end;
    end;
 end;

logs.Disconnect();

end;
//#############################################################################
function myconf.MYSQL_DETERMINE_DATABASE_IN_FILEQUERY(path:string):string;
var
   list:Tstringlist;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
begin


     D:=COMMANDLINE_PARAMETERS('debug');

     if not FileExists(path) then begin
        if D then writeln('MYSQL_DETERMINE_DATABASE_IN_FILEQUERY:: unable to stat ' + path);
        exit;
     end;



     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='INSERT INTO\s+(.+?)\.';
     list:=Tstringlist.Create;
     list.LoadFromFile(path);
     for i:=0 to list.Count-1 do begin
          list.Strings[i]:=AnsiReplaceStr(list.Strings[i],'`','');
          if D then writeln('MYSQL_DETERMINE_DATABASE_IN_FILEQUERY: parse :',list.Strings[i]);
          if RegExpr.Exec(list.Strings[i]) then begin
            result:=RegExpr.Match[1];
            if D then writeln('MYSQL_DETERMINE_DATABASE_IN_FILEQUERY: Found :',result);
            break;
          end;
     end;
RegExpr.Free;
list.Free;

end;
//#############################################################################
function myconf.MYSQL_PARSE_TABLE_NAME_INFILE(path:string):string;
var
   list:Tstringlist;
   i:integer;
   RegExpr:TRegExpr;
begin
 list:=TStringList.Create;
 list.LoadFromFile(path);
 RegExpr:=TRegExpr.Create;
 RegExpr.Expression:='CREATE TABLE\s+(.+)[s\(]+';
for i:=0 to list.Count-1 do begin
     if RegExpr.Exec(list.Strings[i]) then begin
        result:=trim(RegExpr.Match[1]);
        break;
     end;
 end;
 if length(result)>0 then begin
       result:=AnsiReplaceStr(result,'`','');
       RegExpr.Expression:='(.+?)\.(.+)';
       if RegExpr.Exec(result) then begin
          result:=trim(RegExpr.Match[2]);
       end;

 end;

 RegExpr.Expression:='IF NOT EXISTS\s+(.+)';
 if RegExpr.Exec(result) then begin
          result:=trim(RegExpr.Match[1]);
 end;


 RegExpr.Expression:='table (.+?) like';
  if RegExpr.Exec(result) then begin
          result:=trim(RegExpr.Match[1]);
 end;
 RegExpr.Expression:='(.+?) like';
  if RegExpr.Exec(result) then begin
          result:=trim(RegExpr.Match[1]);
 end;
 RegExpr.Expression:='(.+?)\s+\(';
  if RegExpr.Exec(result) then begin
          result:=trim(RegExpr.Match[1]);
 end;

 list.Free;
 RegExpr.Free;

end;
//#############################################################################

function MyConf.MYSQL_ACTION_IMPORT_FILE(filenname:string;database:string;mycf_path:string):boolean;
    var
    Logs:Tlogs;
begin
  result:=false;
  logs:=Tlogs.Create;


  if not logs.Connect() then exit;

  if not FileExists(mycf_path) then begin
     logs.Debuglogs('MYSQL_ACTION_IMPORT_FILE:: unable to stat ' + mycf_path);
     exit;
  end;

  if Get_INFOS('BadMysqlPassword')='1' then begin
     logs.logs('MYSQL_ACTION_IMPORT_FILE:: Please set correct username and password for mysql root...');
     logs.Debuglogs('MYSQL_ACTION_IMPORT_FILE:: Please set correct username and password for mysql root...');
     exit;
  end;

  if not FileExists(filenname) then begin
     logs.Debuglogs('MYSQL_ACTION_IMPORT_DATABASE:: Unable to stat ' +filenname);
     exit;
  end;
try
   if not logs.IF_DATABASE_EXISTS('amavis') then begin
      logs.QUERY_SQL(PChar('CREATE DATABASE amavis;'),'');
   end;
except
   logs.Debuglogs('MYSQL_ACTION_IMPORT_DATABASE:: FATAL exception on function MyConf.MYSQL_ACTION_IMPORT_FILE(1)');
   exit;
end;

try
   if not logs.IF_DATABASE_EXISTS('artica_events') then begin
      logs.QUERY_SQL(PChar('CREATE DATABASE artica_events;'),'');
   end;
except
   logs.Debuglogs('MYSQL_ACTION_IMPORT_DATABASE:: FATAL exception on function MyConf.MYSQL_ACTION_IMPORT_FILE(2)');
   exit;
end;

try
   logs.QUERY_SQL(PChar(ReadFileIntoString(filenname)),database);
except
 logs.Debuglogs('MYSQL_ACTION_IMPORT_DATABASE:: FATAL exception on function MyConf.MYSQL_ACTION_IMPORT_FILE(3)');
   exit;
end;
try
   logs.Disconnect();
except
  logs.Debuglogs('MYSQL_ACTION_IMPORT_DATABASE:: FATAL exception on function MyConf.MYSQL_ACTION_IMPORT_FILE() invoke -> logs.Disconnect()');
  exit;
end;


end;
//#############################################################################
function MyConf.MYSQL_ACTION_QUERY_DATABASE(database:string;sql:string):boolean;
    var
       root,commandline,password,port,socket,mysqlbin:string;
       Logs:Tlogs;

begin
  root    :=SYS.MYSQL_INFOS('database_admin');
  password:=SYS.MYSQL_INFOS('database_password');
  port    :=MYSQL_SERVER_PARAMETERS_CF('port');
  socket  :=MYSQL_SERVER_PARAMETERS_CF('socket');
  Logs    :=Tlogs.Create;
  mysqlbin:=MYSQL_EXEC_BIN_PATH();


  if length(password)>0 then password:=' -p'+password;
  if not fileExists(mysqlbin) then begin
     ShowScreen('MYSQL_ACTION_QUERY:: Unable to locate mysql binary ' + '"' + mysqlbin + '"');
     exit(false);
  end;
  commandline:=mysqlbin + ' --port=' + port + ' --socket=' +socket+ ' --database=' + database + ' --skip-column-names --silent --xml --execute=''' + sql + ''' --user='+ root +password;
  commandline:=commandline + ' >/dev/null 2>&1';

  Logs.Debuglogs('MYSQL_ACTION_QUERY::'+commandline);
  fpsystem(commandline);
end;
//#############################################################################

function Myconf.MYSQL_EXEC_BIN_PATH():string;
begin
   if FileExists('/opt/artica/mysql/bin/mysql') then exit('/opt/artica/mysql/bin/mysql');
   if FileExists('/opt/artica/bin/mysql') then exit('/opt/artica/bin/mysql');
   if FileExists('/usr/bin/mysql') then exit('/usr/bin/mysql');
end;
//#############################################################################
function MyConf.MYSQL_ACTION_CREATE_ADMIN(username:string;password:string):boolean;
    var root,commandline,pass:string;
    list:TStringList;
    i:integer;
    XDebug:boolean;
    RegExpr:TRegExpr;
    found:boolean;
begin
  if length(password)=0 then begin
     writeln('please, set a password...');
     exit(false);
  end;
  pass:=password;
  found:=false;
  if ParamStr(2)='setadmin' then XDebug:=true;
  root:=SYS.MYSQL_INFOS('database_admin');
  password:=SYS.MYSQL_INFOS('database_password');
   if not fileExists('/usr/bin/mysql') then begin
     ShowScreen('MYSQL_ACTION_IMPORT_DATABASE:: Unable to locate mysql binary (usually in  /usr/bin/mysql)');
     exit(false);
  end;
  if length(password)>0 then password:=' -p'+password;
  commandline:=MYSQL_EXEC_BIN_PATH() + ' -N -s -X -e ''select User from user'' -u '+ root +password+' mysql';
  if XDebug then ShowScreen(commandline);
  list:=TStringList.Create;
  list.LoadFromStream(ExecStream(commandline,false));
  if list.Count<2 then begin
    list.free;
    exit(false);
  end;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='<field name="User">(.+)<\/field>';
  for i:=0 to list.count-1 do begin
      if RegExpr.Exec(list.Strings[i]) then begin
          if RegExpr.Match[1]=username then found:=True;
      end;
  end;
  if found=true then begin
     ShowScreen('MYSQL_ACTION_CREATE_ADMIN:: updating ' + username + ' password');
     commandline:=MYSQL_EXEC_BIN_PATH() + ' -N -s -X -e ''UPDATE user SET Password=PASSWORD("' + pass + '") WHERE User="'+username+'"; FLUSH PRIVILEGES;'' -u '+ root +password+' mysql';
     if XDebug then ShowScreen('MYSQL_ACTION_CREATE_ADMIN::' + commandline);
     fpsystem(commandline);
  end else begin

  commandline:=MYSQL_EXEC_BIN_PATH() + ' -N -s -X -e ''INSERT INTO user';
  commandline:=commandline + ' (Host,User,Password,Select_priv,Insert_priv,Update_priv,Delete_priv,Create_priv,Drop_priv,Reload_priv,Shutdown_priv,Process_priv,File_priv,Grant_priv,References_priv,Index_priv,';
  commandline:=commandline + ' Alter_priv,Show_db_priv,Super_priv,Create_tmp_table_priv,Lock_tables_priv,Execute_priv,Repl_slave_priv,Repl_client_priv,Create_view_priv,Show_view_priv,Create_routine_priv,'; //11
  commandline:=commandline + ' Alter_routine_priv,Create_user_priv)';
  commandline:=commandline + ' VALUES("localhost","'+ username +'",PASSWORD("'+ pass+'"),';
  commandline:=commandline + '"Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y",';
  commandline:=commandline + '"Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y","Y");FLUSH PRIVILEGES;'' -u '+ root +password+' mysql';
  if XDebug then ShowScreen('MYSQL_ACTION_CREATE_ADMIN::' + commandline);
  fpsystem(commandline);
  end;

  list.free;

end;
//#############################################################################

procedure MyConf.set_LINUX_DISTRI(val:string);
var
   SYSadmin:Tsystem;
begin
SYSadmin:=Tsystem.create;
SYSadmin.set_INFO('LinuxDistributionName',val);
end;
//#############################################################################
function MyConf.OPENSSL_TOOL_PATH():string;
var
   SYSadmin:Tsystem;
begin
SYSadmin:=Tsystem.create;
result:=SYSadmin.LOCATE_OPENSSL_TOOL_PATH();
end;

//#############################################################################
function MyConf.CERTIFICATE_PASS(path:string):string;
var ini:TIniFile;
begin
ini:=TIniFile.Create(path);
result:=ini.ReadString('req','input_password','secret');
ini.Free;
end;
//#############################################################################
function MyConf.CERTIFICATE_PATH(path:string):string;
var ini:TIniFile;
begin
ini:=TIniFile.Create(path);
result:=ini.ReadString('default_db','dir','/etc/postfix/certificates');
ini.Free;
end;
//#############################################################################
function MyConf.CERTIFICATE_CA_FILENAME(path:string):string;
var ini:TIniFile;
begin
ini:=TIniFile.Create(path);
result:=ini.ReadString('postfix','smtpd_tls_CAfile','cacert.pem');
ini.Free;
end;
//#############################################################################
function MyConf.CERTIFICATE_KEY_FILENAME(path:string):string;
var ini:TIniFile;
begin
ini:=TIniFile.Create(path);
result:=ini.ReadString('postfix','smtpd_tls_key_file','smtpd.key');
ini.Free;
end;
//#############################################################################
function MyConf.CERTIFICATE_CERT_FILENAME(path:string):string;
var ini:TIniFile;
begin
ini:=TIniFile.Create(path);
result:=ini.ReadString('postfix','smtpd_tls_cert_file','smtpd.crt');
ini.Free;
end;
//#############################################################################
function MyConf.PROCMAIL_QUARANTINE_PATH():string;
var ini:TIniFile;
begin
if not fileExists('/etc/artica-postfix/artica-procmail.conf') then begin
   result:='/var/quarantines/procmail';
   exit;
end;
ini:=TIniFile.Create('/etc/artica-postfix/artica-procmail.conf');
result:=ini.ReadString('path','quarantine_path','/var/quarantines/procmail');
ini.Free;
end;

//#############################################################################
procedure MyConf.set_INFOS(key:string;val:string);
var F:TEXT;
begin
ForceDirectories('/etc/artica-postfix/artica-postfix/settings');
  AssignFile(F,'/etc/artica-postfix/artica-postfix/settings/'+key);
  Rewrite(F);
  Writeln (F,val);
  CloseFile(F);
end;
//#############################################################################
procedure MyConf.set_LDAP(key:string;val:string);
begin
ldap.set_LDAP(key,val);
end;
//#############################################################################
function MyConf.get_LDAP(key:string):string;
begin
result:=ldap.get_LDAP(key);
end;
//#############################################################################
function MyConf.ARTICA_FILTER_QUEUEPATH():string;
var ini:TIniFile;
begin
 ini:=TIniFile.Create('/etc/artica-postfix/artica-filter.conf');
 result:=ini.ReadString('INFOS','QueuePath','');
 if length(trim(result))=0 then result:='/var/spool/artica-filter';
end;
//##############################################################################


function MyConf.get_INFOS(key:string):string;
begin
result:=SYS.GET_INFO(key);
end;
//#############################################################################
function MyConf.RRDTOOL_STAT_LOAD_AVERAGE_DATABASE_PATH():string;
var value,phppath,path:string;
begin
value:=SYS.GET_INFO('StatLoadPath');
if length(value)=0 then  begin
   if debug then writeln('STAT_LOAD_PATH is not set in ini path');
   phppath:=get_ARTICA_PHP_PATH();
   path:=phppath+'/ressources/rrd/process.rdd';
   if debug then writeln('set STAT_LOAD_PATH to '+path);
   value:=path;
   SYS.set_INFO('StatLoadPath',path);
   if debug then writeln('done..'+path);
end;
result:=value;
end;
//#############################################################################
function MyConf.ARTICA_SEND_MAX_SUBQUEUE_NUMBER:integer;
var
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-filter.conf');
result:=ini.ReadInteger('INFOS','MAX_QUEUE_NUMBER',5);
ini.free;
end;
//#############################################################################


//#############################################################################
function MyConf.ARTICA_SEND_SUBQUEUE_NUMBER(QueueNumber:string):integer;
var
   QueuePath:string;
   NumbersIntoQueue:integer;
   D:boolean;
begin
  result:=0;
  NumbersIntoQueue:=0;
  D:=COMMANDLINE_PARAMETERS('debug');
  QueuePath:=ARTICA_FILTER_QUEUEPATH() + '/queue';
  if D then writeln('ARTICA_SEND_SUBQUEUE_NUMBER: QueuePath=' + QueuePath);
     if DirectoryExists(QueuePath + '/' +QueueNumber) then begin
        SYS.DirFiles(QueuePath + '/' + QueueNumber,'*.queue');
        NumbersIntoQueue:=SYS.DirListFiles.Count;
     end;
  if D then writeln('ARTICA_SEND_SUBQUEUE_NUMBER: Number=' + IntToStr(NumbersIntoQueue) + ' Objects');
  //logs.logs('ARTICA_SEND_SUBQUEUE_NUMBER:: NumbersIntoQueue:=' + IntToStr(NumbersIntoQueue));

  exit(NumbersIntoQueue);
end;
//#############################################################################
function MyConf.ARTICA_SEND_QUEUE_NUMBER():integer;
var
   QueuePath:string;

begin
  result:=0;

     QueuePath:=ARTICA_FILTER_QUEUEPATH();
     if DirectoryExists(QueuePath) then SYS.DirFiles(QueuePath , '*.eml');
     exit(SYS.DirListFiles.Count);

end;
//#############################################################################
function MyConf.ARTICA_SQL_QUEUE_NUMBER():integer;
var
   QueuePath:string;

begin
  QueuePath:=ARTICA_FILTER_QUEUEPATH();

  SYS.DirFiles(QueuePath,'*.sql');
  result:=SYS.DirListFiles.Count;

  exit;
end;
//#############################################################################
function MyConf.SYSTEM_PROCESS_EXIST(pid:string):boolean;
var
RegExpr:TRegExpr;
begin

  result:=false;
  pid:=trim(pid);
  if pid='0' then exit(false);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^([0-9]+)';
  if not RegExpr.Exec(pid) then exit;
  pid:=RegExpr.Match[1];
  if not fileExists('/proc/' + pid + '/exe') then begin
     exit(false)
  end else begin
      exit(true);
  end;
end;
//#############################################################################
function MyConf.PHP5_IS_MODULE_EXISTS(modulename:string):boolean;
var
   RegExpr:TRegExpr;
   Files:TStringList;
   i    :integer;
   D    :boolean;
begin
     result:=false;
     D:=COMMANDLINE_PARAMETERS('debug');
     if Not FileExists('/opt/artica/bin/php') then begin
        if D then writeln('Unable to stat /opt/artica/bin/php');
        exit;
     end;
     fpsystem('/opt/artica/bin/php -m >/opt/artica/logs/php5.modules.txt 2>&1');
     Files:=TStringList.Create;
     Files.LoadFromFile('/opt/artica/logs/php5.modules.txt');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^' + modulename;
     For i:=0 to Files.Count-1 do begin

         if RegExpr.Exec(Files.Strings[i]) then begin
            result:=true;
            break;
         end else begin
            if D then writeln(Files.Strings[i] + ' -> Not Match ' + RegExpr.Expression);
         end;
     end;

RegExpr.Free;
Files.Free;

end;
//#############################################################################
function MyConf.CGI_ALL_APPLIS_INSTALLED():string;
var
   AVE_VER,KASVER,SQUID_VER,DANS_VER,PUREFTP,AMAVISDVERSION,ASVer,tmpver:string;
   CROSSROADSVERSION:string;
   rdiffbackup:trdiffbackup;
   xxfce:txfce;
   kavmilter:Tkavmilter;
   kas3:tKas3;
   bogom:tbogom;
   mailspy:tmailspy;
   amavis:tamavis;
   imapsync:timapsync;
   retranslator:tkretranslator;
   isoqlog:tisoqlog;
   dotclear:tdotclear;
   jcheckmail:tjcheckmail;
   obm:tobm;
   dhcp3:tdhcp3;
   cups:tcups;
   obm2:tobm2;
   zsmartd:tsmartd;
   xapian:txapian;
   opengoo:topengoo;
   stunnel:tstunnel;
   sugarcrm:tsugarcrm;
   rsync:Trsync;
   policyd_weight:tpolicyd_weight;
   ocsi:tocsi;
   ocsagent:tocsagent;
   mgreylist:tmilter_greylist;
   assp:tassp;
   pdns:tpdns;
   gluster:tgluster;
   debug:boolean;
   zabbix:tzabbix;
   hamachi:thamachi;
   vmwaretools:tvmtools;
   zphpldapadmin:tphpldapadmin;
   zarafa_server:tzarafa_server;
   zsquidguard:tsquidguard;
   mldonkey:tmldonkey;
   backuppc:tbackuppc;
   kav4fs:tkav4fs;
begin

   debug:=false;
   debug:=SYS.COMMANDLINE_PARAMETERS('--debug');
   if debug then writeln('Starting instanciate libraries');
    kavmilter:=Tkavmilter.Create(SYS);
    AVE_VER:=kavmilter.VERSION();
    kavmilter.free;
    AMAVISDVERSION:='';

    DANS_VER:=dansguardian.DANSGUARDIAN_VERSION();

    kas3:=tkas3.Create(SYS);
    KASVER:=kas3.VERSION();
    kas3.Free;

    SQUID_VER:=squid.SQUID_VERSION();
    PUREFTP:=Cpureftpd.PURE_FTPD_VERSION();
    CROSSROADSVERSION:=CROSSROADS_VERSION();
    ASVer:=spamass.SPAMASSASSIN_VERSION();
    ArrayList.Clear;
    result:='';
    rdiffbackup:=trdiffbackup.Create;
    xxfce:=txfce.Create;



    ArrayList.Add('<SECURITY_MODULES>');
    ArrayList.Add('[APP_AVESERVER] "' + AVE_VER + '"');
    ArrayList.Add('[APP_KAS3] "' + KASVER + '"');


    //milter-greylist
    mgreylist:=tmilter_greylist.Create(SYS);
    try
       ArrayList.Add('[APP_MILTERGREYLIST] "'+mgreylist.VERSION()+'"');
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after mgreylist.VERSION()');
    end;
    mgreylist.free;

     pdns:=tpdns.Create(SYS);
    try
       ArrayList.Add('[APP_PDNS] "'+pdns.VERSION()+'"');
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after pdns.VERSION()');
    end;
    pdns.free;

    try
       zphpldapadmin:=Tphpldapadmin.Create(SYS);
       ArrayList.Add('[APP_PHPLDAPADMIN] "'+zphpldapadmin.VERSION()+'"');
       zphpldapadmin.free;
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after zphpldapadmin.VERSION()');
    end;



     //phpmyadmin
    ArrayList.Add('[APP_PHPMYADMIN] "' + PHPMYADMIN_VERSION() + '"');
    ArrayList.Add('[APP_DRUPAL] "' + DRUPAL_VERSION() + '"');

    ArrayList.Add('[APP_CLAMAV_MILTER] "' + clamav.CLAMAV_VERSION() + '"');
    ArrayList.Add('[APP_CLAMAV] "' + clamav.CLAMAV_VERSION() + '"');

    //kavmilter
    ArrayList.Add('[APP_KAVMILTER] "' + AVE_VER + '"');
    ArrayList.Add('[APP_NMAP] "' + NMAP_VERSION() + '"');


    bogom:=tbogom.Create(SYS);
    ArrayList.Add('[APP_BOGOM] "' + bogom.VERSION() + '"');
    ArrayList.Add('[APP_BOGOFILTER] "' + bogom.BOGOFILTER_VERSION() + '"');
    bogom.free;


    kav4fs:=Tkav4fs.Create(SYS);
    ArrayList.Add('[APP_KAV4FS] "' + kav4fs.VERSION() + '"');
    kav4fs.free;

    //stunnel;
    stunnel:=Tstunnel.Create(SYS);
    ArrayList.Add('[APP_STUNNEL] "' + stunnel.VERSION() + '"');
    stunnel.free;

    //mldonkey
    mldonkey:=tmldonkey.Create(SYS);
    ArrayList.Add('[APP_MLDONKEY] "' + mldonkey.VERSION() + '"');
    mldonkey.free;

    //backuppc
    backuppc:=tbackuppc.Create(SYS);
    ArrayList.Add('[APP_BACKUPPC] "' + backuppc.VERSION() + '"');
    backuppc.free;

    //rsync
    rsync:=Trsync.Create(SYS);
    ArrayList.Add('[APP_RSYNC] "' + rsync.VERSION() + '"');
    rsync.free;

    //ocsi
    ocsi:=tocsi.CReate(SYS);
    try
     ArrayList.Add('[APP_OCSI] "' + ocsi.VERSION() + '"');
     ocsi.free;
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after ocsi.VERSION()');
    end;


    //ocsagent
    ocsagent:=tocsagent.CReate(SYS);
    try
     ArrayList.Add('[APP_OCSI_LINUX_CLIENT] "' + ocsagent.VERSION() + '"');
     ocsagent.free;
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after ocsagent.VERSION()');
    end;


    //gluster
    if debug then writeln('GLUSTER START');
    gluster:=tgluster.Create(SYS);
    try
    if debug then writeln('-> gluster.VERSION()');
     tmpver:=gluster.VERSION();
     if debug then writeln('-> gluster.VERSION() -> ',tmpver);
     ArrayList.Add('[APP_GLUSTER] "' + tmpver+ '"');
     gluster.free;
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after gluster.VERSION()');
    end;

    if debug then writeln('GLUSTER END');


    jcheckmail:=tjcheckmail.CReate(SYS);
    ArrayList.Add('[APP_JCHECKMAIL] "' + jcheckmail.VERSION() + '"');
    jcheckmail.Free;


    amavis:=tamavis.Create(SYS);
    ArrayList.Add('[APP_AMAVISD_NEW] "' + amavis.AMAVISD_VERSION() + '"');
    ArrayList.Add('[APP_AMAVISD_MILTER] "' + amavis.MILTER_VERSION() + '"');
    ArrayList.Add('[APP_ALTERMIME] "' + amavis.altermime_version() + '"');
    amavis.Free;

    if length(SQUID_VER)>0  then ArrayList.Add('[APP_KAV4PROXY] "' + kav4proxy.VERSION() + '"');
    if length(DANS_VER)>0  then ArrayList.Add('[APP_DANSGUARDIAN] "' + DANS_VER + '"');
    if FIleExists(dansguardian.C_ICAP_BIN_PATH()) then ArrayList.Add('[APP_C_ICAP] "060708"');
    if length(AMAVISDVERSION)>0  then ArrayList.Add('[APP_AMAVIS] "' + AMAVISDVERSION + '"');
    if length(ASVer)>0  then ArrayList.Add('[APP_SPAMASSASSIN] "' + ASVer + '"');
    ArrayList.Add('[APP_KAV4SAMBA] "' + kav4samba.VERSION()+ '"');

    cups:=tcups.Create;
    ArrayList.Add('[APP_CUPS_DRV] "' + cups.DRIVER_VERSION()+ '"');


    retranslator:=tkretranslator.Create(SYS);
    ArrayList.Add('[APP_KRETRANSLATOR] "' + retranslator.VERSION() + '"');


    //squidguard
    zsquidguard:=tsquidguard.CReate(SYS);
    try
     ArrayList.Add('[APP_SQUIDGUARD] "' + zsquidguard.VERSION() + '"');
     zsquidguard.free;
    except
          logs.Syslogs('FATAL ERROR on CGI_ALL_APPLIS_INSTALLED after zsquidguard.VERSION()');
    end;

    hamachi:=thamachi.Create(SYS);
    ArrayList.Add('[APP_HAMACHI] "' + hamachi.VERSION() + '"');
    hamachi.free;






    ArrayList.Add('</SECURITY_MODULES>');

    ArrayList.Add('<CORE_MODULES>');
    ArrayList.Add('[APP_GDM] "' + GDM_VERSION() + '"');
    ArrayList.Add('[APP_XFCE] "' + xxfce.XFCE_VERSION() + '"');
    ArrayList.Add('[APP_INETD] "' + SYS.INETD_VERSION() + '"');
    ArrayList.Add('[APP_SIMPLE_GROUPEWARE] "' + SIMPLE_CALENDAR_VERSION() + '"');
    ArrayList.Add('[APP_ATOPENMAIL] "' + ATMAIL_VERSION() + '"');

    xapian:=Txapian.Create(SYS);
    ArrayList.Add('[APP_XAPIAN] "' + xapian.VERSION() + '"');
    ArrayList.Add('[APP_XAPIAN_OMEGA] "' + xapian.OMINDEX_VERSION() + '"');
    ArrayList.Add('[APP_XAPIAN_PHP] "' + xapian.PHP_VERSION() + '"');
    ArrayList.Add('[APP_XPDF] "' + xapian.APP_XPDF_VERSION() + '"');
    ArrayList.Add('[APP_UNRTF] "' + xapian.APP_UNRTF_VERSION() + '"');
    ArrayList.Add('[APP_UNZIP] "' + xapian.APP_UNZIP_VERSION() + '"');
    ArrayList.Add('[APP_CATDOC] "' + xapian.APP_CATDOC_VERSION() + '"');
    ArrayList.Add('[APP_ANTIWORD] "' + xapian.APP_ANTIWORD_VERSION() + '"');
    xapian.free;

    try
       zabbix:=tzabbix.Create(SYS);
       ArrayList.Add('[APP_ZABBIX_SERVER] "' + zabbix.SERVER_VERSION() + '"');
       ArrayList.Add('[APP_ZABBIX_AGENT] "' + zabbix.AGENT_VERSION() + '"');
       zabbix.free;
    except
       logs.Syslogs('FATAL ERROR on APP_ZABBIX_SERVER after zabbix.VERSION()');
    end;

    try
    zarafa_server:=tzarafa_server.Create(SYS);
    ArrayList.Add('[APP_ZARAFA] "' + zarafa_server.VERSION() + '"');
    except
       logs.Syslogs('FATAL ERROR on APP_ZARAFA after zarafa_server.VERSION()');
    end;
    dotclear:=tdotclear.CReate(SYS);
    ArrayList.Add('[APP_DOTCLEAR] "' + dotclear.VERSION() + '"');

    dhcp3:=tdhcp3.Create(SYS);
    ArrayList.Add('[APP_DHCP] "' + dhcp3.VERSION() + '"');
    dhcp3.Free;

    obm:=tobm.Create(SYS);
    ArrayList.Add('[APP_OBM] "' + obm.VERSION() + '"');

    obm2:=Tobm2.Create(SYS);
    ArrayList.Add('[APP_OBM2] "' + obm2.VERSION() + '"');
    obm.free;
    obm2.free;

    opengoo:=topengoo.Create(SYS);
    sugarcrm:=tsugarcrm.Create(SYS);
    ArrayList.Add('[APP_OPENGOO] "' + opengoo.OPENGOO_VERSION() + '"');
    ArrayList.Add('[APP_JOOMLA] "' + opengoo.JOOMLA_VERSION() + '"');
    ArrayList.Add('[APP_EACCELERATOR] "' + opengoo.EACCELERATOR_VERSION() + '"');
    ArrayList.Add('[APP_SUGARCRM] "' + sugarcrm.VERSION('/usr/local/share/artica/sugarcrm_src') + '"');



    opengoo.FRee;


    mailspy:=tmailspy.Create(SYS);
    ArrayList.Add('[APP_MAILSPY] "' + mailspy.VERSION() + '"');
    mailspy.Free;

    assp:=tassp.Create(SYS);
    ArrayList.Add('[APP_ASSP] "' + assp.VERSION() + '"');
    assp.Free;


    policyd_weight:=tpolicyd_weight.Create(SYS);
    ArrayList.Add('[APP_POLICYD_WEIGHT] "' + policyd_weight.VERSION() + '"');
    policyd_weight.free;


    ArrayList.Add('[APP_POSTFIX] "' + postfix.POSTFIX_VERSION() + '"');
    ArrayList.Add('[APP_GNARWL] "' + postfix.gnarwl_VERSION() + '"');
    ArrayList.Add('[APP_MSMTP] "' + postfix.MSMTP_VERSION() + '"');
    ArrayList.Add('[APP_PFLOGSUMM] "' + postfix.PFLOGSUMM_VERSION() + '"');
    ArrayList.Add('[APP_SARG] "' + squid.SARG_VERSION() + '"');
    ArrayList.Add('[APP_GNUPLOT] "' + GNUPLOT_VERSION() + '"');
    ArrayList.Add('[APP_DSTAT] "' + DSTAT_VERSION() + '"');





    if length(SQUID_VER)>0 then ArrayList.Add('[APP_SQUID] "'+ SQUID_VER + '"');
    if length(PUREFTP)>0 then ArrayList.Add('[APP_PUREFTPD] "'+ PUREFTP + '"');
    if length(CROSSROADS_VERSION)>0 then ArrayList.Add('[APP_CROSSROADS] "'+ CROSSROADSVERSION + '"');


    ArrayList.Add('[APP_LDAP] "' + ldap.LDAP_VERSION() + '"');
    ArrayList.Add('[APP_RENATTACH] "' + RENATTACH_VERSION() + '"');
    ArrayList.Add('[APP_GEOIP] "' + GEOIP_VERSION() + '"');


    dnsmasq:=Tdnsmasq.Create(SYS);
    ArrayList.Add('[APP_DNSMASQ] "' + dnsmasq.DNSMASQ_VERSION() + '"');
    dnsmasq.free;
    ArrayList.Add('[APP_INADYN] "' + INYADIN_VERSION() + '"');
    ArrayList.Add('[APP_SAMBA] "' +    samba.SAMBA_VERSION()+ '"');
    ArrayList.Add('[APP_SMBMOUNT] "' +    sys.SMBMOUNT_VERSION()+ '"');
    ArrayList.Add('[APP_DAR] "' +    rdiffbackup.Dar_version()+ '"');
    ArrayList.Add('[APP_PRELOAD] "' +    PRELOAD_VERSION()+ '"');
    try
       ArrayList.Add('[APP_WINEXE] "' +    WINEXE_VERSION()+ '"');
    except
    writeln('ERROR:: CGI_ALL_APPLIS_INSTALLED WINEXE_VERSION()');
    end;




    cups:=Tcups.Create;
    ArrayList.Add('[APP_CUPS] "' +    cups.VERSION()+ '"');
    ArrayList.Add('[APP_CUPS_BROTHER] "' +    cups.BROTHER_DRIVER_VERSION()+ '"');
    ArrayList.Add('[APP_HPINLINUX] "' +    hpinlinux_VERSION()+ '"');

    ArrayList.Add('</CORE_MODULES>');

    ArrayList.Add('<STAT_MODULES>');
    ArrayList.Add('[APP_RRDTOOL] "' + RRDTOOL_VERSION() + '"');
    ArrayList.Add('[APP_AWSTATS] "' + awstats.AWSTATS_VERSION() + '"');
    ArrayList.Add('[APP_MAILGRAPH] "' + mailgraph.MAILGRAPH_VERSION() + '"');
    ArrayList.Add('[APP_EMAILRELAY] "' + EMAILRELAY_VERSION() + '"');
    vmwaretools:=tvmtools.Create(SYS);
    ArrayList.Add('[APP_VMTOOLS] "' + vmwaretools.VERSION() + '"');
    zsmartd:=Tsmartd.Create(SYS);
    ArrayList.Add('[APP_SMARTMONTOOLS] "' + zsmartd.VERSION() + '"');
    zsmartd.free;


    imapsync:=timapsync.Create(SYS);
    ArrayList.Add('[APP_IMAPSYNC] "' + imapsync.VERSION() + '"');
    ArrayList.Add('[APP_MAILSYNC] "' + imapsync.MAILSYNC_VERSION() + '"');
    imapsync.Free;


    collectd:=tcollectd.Create(SYS);
    ArrayList.Add('[APP_COLLECTD] "' + collectd.VERSION() + '"');
    collectd.Free;

    isoqlog:=tisoqlog.CReate(SYS);
     ArrayList.Add('[APP_ISOQLOG] "' + isoqlog.VERSION() + '"');
    ArrayList.Add('</STAT_MODULES>');

    ArrayList.Add('<MAIL_MODULES>');
    ArrayList.Add('[APP_CYRUS] "' +    CCYRUS.CYRUS_VERSION()+ '"');
    ArrayList.Add('[APP_CYRUS_IMAP] "' +    CCYRUS.CYRUS_VERSION()+ '"');
    ArrayList.Add('[APP_FETCHMAIL] "' +fetchmail.FETCHMAIL_VERSION() + '"');
    ArrayList.Add('[APP_FDM] "' +fdm.VERSION() + '"');

    ArrayList.Add('[APP_GETLIVE] "' +  GETLIVE_VERSION() + '"');
    ArrayList.Add('[APP_HOTWAYD] "' +  HOTWAYD_VERSION() + '"');
    ArrayList.Add('[APP_PROCMAIL] "' + PROCMAIL_VERSION() + '"');
    ArrayList.Add('[APP_ROUNDCUBE] "' +roundcube.VERSION() + '"');
    ArrayList.Add('[APP_ROUNDCUBE3] "' +roundcube.VERSION() + '"');
    if fileExists('/usr/sbin/scannedonlyd_clamav') then ArrayList.Add('[APP_SCANNED_ONLY] "not applicable"');

                                  
    //pommo
    lighttpd:=tlighttpd.Create(SYS);
     ArrayList.Add('[APP_POMMO] "' +lighttpd.POMMO_VERSION() + '"');
     ArrayList.Add('[APP_LMB] "' +LMB_VERSION() + '"');
     ArrayList.Add('[APP_GROUPOFFICE] "' +GROUPOFFICE_VERSION() + '"');




    //mailman
    mailman:=tmailman.Create(SYS);
    ArrayList.Add('[APP_MAILMAN] "' +  mailman.VERSION() + '"');
    mailman.free;
    ArrayList.Add('</MAIL_MODULES>');

    ArrayList.Add('<SAMBA_MODULES>');
    ArrayList.Add('</SAMBA_MODULES>');

    ArrayList.Add('<LIB_MODULES>');
    ArrayList.Add('[APP_LIBGSL] "' + LIB_GSL_VERSION() + '"');
    ArrayList.Add('[APP_OPENSSL] "' + OPENSSL_VERSION() + '"');
    ArrayList.Add('[APP_PERL] "' + PERL_VERSION() + '"');
    ArrayList.Add('[APP_MYSQL] "' + MYSQL_VERSION() + '"');


    ArrayList.Add('</LIB_MODULES>');

    xxfce.free;

 end;
//#############################################################################
function MyConf.RENATTACH_VERSION():string;
var
   RegExpr            :TRegExpr;
   f                  :TstringList;
   i                  :integer;
   tmp                :string;
   binpath            :string;
begin


   result:=SYS.GET_CACHE_VERSION('APP_RENATTACH');
   if length(result)>2 then exit;

   tmp:=LOGS.FILE_TEMP();
   binpath:=SYS.LOCATE_GENERIC_BIN('renattach');

     if not FileExists(binpath) then begin
        logs.Debuglogs('myconf.RENATTACH_VERSION():: not installed');
        exit;
     end;

   fpsystem(binpath+' -V >'+tmp+' 2>&1');
   if not FileExists(tmp) then exit;
   f:=TstringList.Create;
   f.LoadFromFile(tmp);
   LOGS.DeleteFile(tmp);
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='renattach\s+([0-9\.]+)';
   for i:=0 to f.Count-1 do begin
       if  RegExpr.Exec(f.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
   end;

RegExpr.free;
f.free;
SYS.SET_CACHE_VERSION('APP_RENATTACH',result);

end;
 //#############################################################################
function MyConf.MHONARC_VERSION():string;
var
   RegExpr            :TRegExpr;
   f                  :TstringList;
   i                  :integer;
   tmp                :string;
   binpath            :string;
begin

   result:=SYS.GET_CACHE_VERSION('APP_MONARC');
   if length(result)>2 then exit;
   tmp:=LOGS.FILE_TEMP();
   binpath:=SYS.LOCATE_GENERIC_BIN('mhonarc');

     if not FileExists(binpath) then begin
        logs.Debuglogs('myconf.MHONARC_VERSION():: not installed');
        exit;
     end;

   fpsystem(binpath+' -v >'+tmp+' 2>&1');
   if not FileExists(tmp) then exit;
   f:=TstringList.Create;
   f.LoadFromFile(tmp);
   LOGS.DeleteFile(tmp);
   RegExpr:=tRegExpr.Create;
   RegExpr.Expression:='MHonArc\s+v([0-9\.]+)';
   for i:=0 to f.Count-1 do begin
       if  RegExpr.Exec(f.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
   end;

RegExpr.free;
f.free;
SYS.SET_CACHE_VERSION('APP_MONARC',result);
end;
//#############################################################################
function MyConf.EMAILRELAY_VERSION():string;
var
   RegExpr            :TRegExpr;
   f                  :TstringList;
   i                  :integer;
   tmp                :string;
   binpath            :string;

begin

   result:=SYS.GET_CACHE_VERSION('APP_EMAILRELAY');
   if length(result)>2 then exit;
   tmp:=LOGS.FILE_TEMP();
   binpath:=SYS.LOCATE_GENERIC_BIN('emailrelay');

     if not FileExists(binpath) then begin
        logs.Debuglogs('myconf.EMAILRELAY_VERSION():: not installed');
        exit;
     end;

   fpsystem(binpath+' -V >'+tmp+' 2>&1');
   if not FileExists(tmp) then exit;
   f:=TstringList.Create;
   f.LoadFromFile(tmp);
   LOGS.DeleteFile(tmp);
   RegExpr:=tRegExpr.Create;
   RegExpr.Expression:='E-MailRelay V([0-9\.]+)';
   for i:=0 to f.Count-1 do begin
       if  RegExpr.Exec(f.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
   end;
SYS.SET_CACHE_VERSION('APP_EMAILRELAY',result);
RegExpr.free;
f.free;
end;
//#############################################################################


function MyConf.GETLIVE_VERSION():string;
var
   RegExpr            :TRegExpr;
   tempstr            :string;
   f                  :TstringList;
   i                  :integer;
begin
   result:='';
   tempstr:=get_ARTICA_PHP_PATH() + '/bin/GetLive.pl';
   if not FileExists(tempstr) then exit;
   f:=TstringList.Create;
   f.LoadFromFile(tempstr);
   RegExpr:=tRegExpr.Create;
   RegExpr.Expression:='my \$Revision\s+=.+?([0-9\.]+)';
   For i:=0 to f.Count -1 do begin
       if RegExpr.Exec(f.Strings[i]) then begin
           result:=RegExpr.Match[1];
           break;
       end;

   end;
 // my $Revision

   f.free;
   RegExpr.Free;

end;
 //#############################################################################
function MyConf.GEOIP_VERSION():string;
var
   RegExpr:TRegExpr;
   database_path,tempstr:string;
   GeoIP:TGeoIP;
begin
 database_path:='/usr/local/share/GeoIP';
   ForceDirectories(database_path);
   RegExpr:=TRegExpr.Create;
   if FileExists(database_path + '/GeoIP.dat') then begin
      GeoIP := TGeoIP.Create(database_path + '/GeoIP.dat');
      tempstr:=GeoIP.GetDatabaseInfo;
      RegExpr.expression:='\s+([0-9]+)\s+';
      try
         if RegExpr.Exec(tempstr) then result:=RegExpr.Match[1];
      finally
      GeoIP.Free;
      RegExpr.free;
      end;
   end;

end;
//#############################################################################
function MyConf.GetAllApplisInstalled():string;
begin
 result:='';
 CGI_ALL_APPLIS_INSTALLED();
 writeln(ArrayList.Text);
 end;
//#############################################################################
function MyConf.ROUNDCUBE_VERSION():string;
var
   filepath:string;
   RegExpr:TRegExpr;
   List:TstringList;
   i:integer;
   D:boolean;
begin
     result:='';
     D:=COMMANDLINE_PARAMETERS('debug');

     if not DirectoryExists('/usr/share/roundcubemail') then begin
        if D then showScreen('ROUNDCUBE_VERSION:: /usr/share/roundcube doesn''t exists...');
        exit();
     end else begin
         if D then showScreen('ROUNDCUBE_VERSION:: /usr/share/roundcube is detected as a directory');
     end;


      filepath:='/usr/share/roundcubemail/index.php';


     if not fileExists(filepath) then begin
        if D then showScreen('ROUNDCUBE_VERSION:: unable to locate ' + filepath);
        exit('');
     end;


     List:=TstringList.Create;
     List.LoadFromFile(filepath);
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='define\(''RCMAIL_VERSION[\s,'']+([0-9\-\.a-z]+)';
     for i:=0 to List.Count-1 do begin
          if RegExpr.Exec(list.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
          end;

     end;

          list.Free;
          RegExpr.free;
end;
//#############################################################################
function MyConf.PHP5_INI_PATH():string;
begin
if fileExists('/etc/php5/apache2/php.ini') then exit('/etc/php5/apache2/php.ini');
if fileExists('/etc/php.ini') then exit('/etc/php.ini');
end;
//#############################################################################
function MyConf.PHP5_INI_SET_EXTENSION(librari:string):string;
var
   php_path:string;
   RegExpr:TRegExpr;
   D:Boolean;
   F:TstringList;
   I:integer;
begin
   result:='';
   D:=COMMANDLINE_PARAMETERS('debug');
   php_path:=PHP5_INI_PATH();
   if not FileExists(php_path) then begin
       if D then writeln('Unable to stat ' + php_path);
       exit;
   end;
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='^extension=' + librari;
    F:=TstringList.Create;
    F.LoadFromFile(php_path);
    for i:=0 to F.Count -1 do begin
       if RegExpr.Exec(f.Strings[i]) then begin
          if D then writeln('Already updated.. : ' + php_path);
           f.Free;
           RegExpr.Free;
           exit;
       end;
    end;
   f.Add('extension=' + librari);
   f.SaveToFile(php_path);
   f.free;
   RegExpr.free;

end;
//#############################################################################

function MyConf.INADYN_PERFORM(IniData:String;UpdatePeriod:integer):string;
var
   Ini      :TiniFile;
   l        :TStringList;
   aliasList:TStringDynArray;
   list     :string;
   cmd      :string;
   proxy    :string;
   i        :integer;
   D:boolean;
begin
    result:='';
    D:=COMMANDLINE_PARAMETERS('debug');
    if length(IniData)=0 then exit;
    l:=TStringList.Create;
    l.Add(IniData);
    l.SaveToFile('/opt/artica/logs/inadyn.rule.cf');
    ini:=TiniFile.Create('/opt/artica/logs/inadyn.rule.cf');
    cmd:='';
    cmd:=cmd + 'inadyn --username ' +  ini.ReadString('inadyn','username','');
    cmd:=cmd + ' --password ' +  ini.ReadString('inadyn','password','');
    cmd:=cmd + ' --dyndns_system ' +  ini.ReadString('inadyn','dyndns_system','');
    list:=ini.ReadString('inadyn','alias','');
    if length(list)>0 then begin
       aliasList:=Explode(',',list);
       for i:=0 to length(aliasList)-1 do begin
              cmd:=cmd + ' --alias ' + aliasList[i];
       end;
    end;
    UpdatePeriod:=UpdatePeriod*60;
    if ini.ReadString('PROXY','enabled','')='yes' then begin
       proxy:= ' --proxy_server ' + ini.ReadString('PROXY','servername','') + ':' + ini.ReadString('PROXY','serverport','');
    end;



    if ExtractFileName(ParamStr(0))<>'process1' then begin
       logs.Debuglogs('Starting......: inadyn daemon...' + ini.ReadString('inadyn','dyndns_system','') + ' ' + ini.ReadString('inadyn','username',''));
    end;

    if D then writeln(get_ARTICA_PHP_PATH() + '/bin/' + cmd + ' --log_file /opt/artica/logs/inadyn.log --update_period_sec ' + IntToStr(UpdatePeriod) + proxy + ' --background');
    fpsystem(get_ARTICA_PHP_PATH() + '/bin/' + cmd + ' --log_file /opt/artica/logs/inadyn.log --update_period_sec ' + IntToStr(UpdatePeriod) + proxy + ' --background');

end;
//#############################################################################
procedure MyConf.INADYN_PERFORM_STOP();
var
pids      :string;
begin
    pids:=trim(INADYN_PID());
    if length(pids)>0 then begin
         writeln('Stopping inadyn..........: ' + pids + ' PID');
         fpsystem('/bin/kill ' + pids);
    end;

end;



//#############################################################################





function MyConf.PROCMAIL_INSTALLED():boolean;
var
    procmail_bin:string;
    mem:TStringList;
     RegExpr:TRegExpr;
     i:integer;
     xzedebug:boolean;
begin

     if not FileExists(postfix.POSFTIX_MASTER_CF_PATH()) then begin
        exit;
     end;

     xzedebug:=false;
     if ParamStr(2)='status' then xzedebug:=true;

     if xzedebug then writeln('Version............:',PROCMAIL_VERSION());

     procmail_bin:=LINUX_APPLICATION_INFOS('procmail_bin');
     if length(procmail_bin)=0 then procmail_bin:='/usr/bin/procmail';
     if not FileExists(procmail_bin) then begin
        if xzedebug then writeln('Path...............:','unable to locate');
        exit(false);
      end;

     if xzedebug then writeln('Path...............:',procmail_bin);
     if xzedebug then writeln('logs Path..........:',PROCMAIL_LOGS_PATH());
     if xzedebug then writeln('user...............:',PROCMAIL_USER());
     if xzedebug then writeln('quarantine path....: ',PROCMAIL_QUARANTINE_PATH());

     if xzedebug then writeln('cyrdeliver path....: ',CYRUS_DELIVER_BIN_PATH());

     mem:=TStringList.Create;
     mem.LoadFromFile(postfix.POSFTIX_MASTER_CF_PATH());
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='procmail\s+unix.*pipe';
     for i:=0 to mem.Count-1 do begin
         if RegExpr.Exec(mem.Strings[i]) then begin
             mem.Free;
             RegExpr.free;
             if xzedebug then writeln('master.cf..........:','yes');
             exit(true);
         end;
     end;
     exit(false);

end;

 //#############################################################################
function MyConf.PROCMAIL_READ_QUARANTINE(fromFileNumber:integer;tofilenumber:integer;username:string):TstringList;
Var Info  : TSearchRec;
    Count : Longint;
    path  :string;
    Line:TstringList;
    return_line:string;

Begin
  Count:=0;
  Line:=TstringList.Create;
  if tofilenumber=0 then tofilenumber:=100;
if length(username)=0 then  exit(line);
     if length(username)>0  then path:=PROCMAIL_QUARANTINE_PATH() + '/' + username + '/new';

  If FindFirst (path+'/*',faAnyFile and faDirectory,Info)=0 then
    begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
              Inc(Count);
              if Count>=fromFileNumber then begin
                 return_line:='<file>'+Info.name+'</file>' +  PROCMAIL_READ_QUARANTINE_FILE(path + '/' + info.name);
                 Line.Add(return_line);
                 if ParamStr(1)='-quarantine' then writeln(return_line);
              end;
              if count>=tofilenumber then break;
              //Writeln (Info.Name:40,Info.Size:15);
         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  exit(line);
end;
//#############################################################################
function MyConf.PROCMAIL_READ_QUARANTINE_FILE(file_to_read:string):string;
var

    mem:TStringList;
    from,subj,tim:string;
     RegExpr,RegExpr2,RegExpr3:TRegExpr;
     i:integer;
begin
    mem:=TStringList.Create;
    mem.LoadFromFile(file_to_read);
    RegExpr:=TRegExpr.Create;
    RegExpr2:=TRegExpr.Create;
    RegExpr3:=TRegExpr.Create;
    RegExpr.Expression:='^From:\s+(.+)';
    RegExpr2.expression:='Subject:\s+(.+)';
    RegExpr3.expression:='Date:\s+(.+)';
    for i:=0 to mem.Count -1 do begin
        if RegExpr.Exec(mem.Strings[i]) then from:=RegExpr.Match[1];
        if RegExpr2.Exec(mem.Strings[i]) then subj:=RegExpr2.Match[1];
        if RegExpr3.Exec(mem.Strings[i]) then tim:=RegExpr3.Match[1];
        if length(from)+length(subj)+length(tim)>length(from)+length(subj) then break;

    end;

    RegExpr.free;
    RegExpr2.free;
    mem.free;
    result:='<from>' + from + '</from><time>' + tim + '</time><subject>' + subj + '</subject>';

end;





//#############################################################################
function MyConf.PROCMAIL_QUARANTINE_USER_FILE_NUMBER(username:string):string;
var
   count:integer;
   path:string;
begin

     if length(username)=0 then  exit('0');
     if length(username)>0  then path:=PROCMAIL_QUARANTINE_PATH() + '/' + username + '/new';
     count:=sys.DirectoryCountFiles(path);

     exit(intTostr(count));

end;
//#############################################################################
function MyConf.PROCMAIL_LOGS_PATH():string;
var
    mem:TStringList;
    RegExpr:TRegExpr;
    i:integer;
begin

     if not fileExists('/etc/procmailrc') then exit;
     mem:=TStringList.Create;
      mem.LoadFromFile('/etc/procmailrc');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='LOGFILE=("|\s|)([a-z\.\/]+)';

     for i:=0 to mem.Count-1 do begin

         if RegExpr.Exec(mem.Strings[i]) then begin
            result:=regExpr.Match[2];
            break;
         end;

     end;

     regExpr.Free;
     mem.Free;
end;
//#############################################################################
function MyConf.PROCMAIL_USER():string;
var
    mem:TStringList;
     RegExpr:TRegExpr;
     i:integer;

begin
   if not FileExists(postfix.POSFTIX_MASTER_CF_PATH()) then exit;
   mem:=TStringList.Create;
   mem.LoadFromFile(postfix.POSFTIX_MASTER_CF_PATH());
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='flags=([A-Za-z]+)\s+user=([a-zA-Z]+)\s+argv=.+procmail.+';
   for i:=0 to mem.Count-1 do begin
       if RegExpr.Exec(mem.Strings[i]) then begin
          result:=RegExpr.Match[2];
          break;
       end;

     end;
     mem.Free;
     RegExpr.Free;

end;
//#############################################################################
function Myconf.PROCMAIL_VERSION():string;
var
    procmail_bin:string;
    mem:TStringList;
    commandline:string;
     RegExpr:TRegExpr;
     i:integer;
     D:boolean;
begin
 D:=COMMANDLINE_PARAMETERS('debug');
   if D then ShowScreen('PROCMAIL_VERSION:: is there procmail here ???');
    D:=COMMANDLINE_PARAMETERS('debug');
     procmail_bin:=LINUX_APPLICATION_INFOS('procmail_bin');
     if length(procmail_bin)=0 then procmail_bin:='/usr/bin/procmail';
     if not FileExists(procmail_bin) then exit;


     mem:=TStringList.Create;
     commandline:='/bin/cat -v ' +procmail_bin ;

     mem.LoadFromStream(ExecStream(commandline,false));
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='v([0-9\.]+)\s+[0-9]{1,4}';

     for i:=0 to mem.Count-1 do begin
       if RegExpr.Exec(mem.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;

     end;
     mem.Free;
     RegExpr.Free;
end;
//#############################################################################

function myconf.RRDTOOL_BIN_PATH():string;
begin

  result:=SYS.RRDTOOL_BIN_PATH();
end;
//#############################################################################
function Myconf.RRDTOOL_VERSION():string;
var
    path:string;
    RegExpr:TRegExpr;
    FileData:TStringList;
    D:boolean;
begin
     D:=COMMANDLINE_PARAMETERS('debug');
     path:=RRDTOOL_BIN_PATH();
     if not FileExists(path) then begin
        if D then ShowScreen('RRDTOOL_VERSION:: Unable to stat ' + path);
        exit;
     end;
     FileData:=TStringList.Create;
     FileData.LoadFromStream(ExecStream(path,false));
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='([0-9\.]+)';
     if RegExpr.Exec(FileData.Strings[0]) then result:=RegExpr.Match[1];
      RegExpr.Free;
      FileData.Free;
end;
//#############################################################################
function Myconf.SYSTEM_GMT_SECONDS():string;
var value:string;
begin

value:=SYS.GET_INFO('GMT_TIME');
if length(value)=0 then begin
   value:=trim(ExecPipe('/bin/date +%:::z'));
   SYS.set_INFO('GMT_TIME',value);
end;
result:=value;

end;
//#############################################################################
function Myconf.SYSTEM_GET_SYS_DATE():string;
var
   value:string;
begin
   value:=trim(ExecPipe('/bin/date +"%Y-%m-%d;%H:%M:%S"'));
   result:=value;
end;
//#############################################################################
function Myconf.SYSTEM_GET_HARD_DATE():string;
var
   value:string;
begin
   value:=trim(ExecPipe('/sbin/hwclock --show'));
   result:=value;
end;
//#############################################################################


//#############################################################################
function Myconf.RRDTOOL_TIMESTAMP(longdate:string):string;
Begin
result:=RRDTOOL_SecondsBetween(longdate);
End ;
//#############################################################################

function Myconf.RRDTOOL_SecondsBetween(longdate:string):string;
var ANow,AThen : TDateTime;
 gmt,commut:string;
 RegExpr:TRegExpr;
 second,seconds:integer;
 parsed:boolean;

begin
     gmt:=SYSTEM_GMT_SECONDS();
     parsed:=False;
     //([0-9]+)[\/\-]([0-9]+)[\/\-]([0-9]+) ([0-9]+)\:([0-9]+)\:([0-9]+)
     if notdebug2=false then if debug then writeln('gmt:',gmt);
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='(\+|\-)([0-9]+)';
     RegExpr.Exec(gmt);
     second:=StrToInt(RegExpr.Match[2]);
     seconds:=(second*60)*60;
     if notdebug2=false then begin
        if debug then writeln('GMT seconds:',seconds);
        if debug then writeln('GMT (+-) :('+ RegExpr.Match[1]+ ')');
        if debug then writeln('LONG DATE:('+ longdate+ ')');
     end;
     commut:=RegExpr.Match[1];

    if length(longdate)=0 then ANow:=now;



    if length(longdate)>0 then begin
        RegExpr.Expression:='([0-9]+)[\/\-]([0-9]+)[\/\-]([0-9]+)\s+([0-9]+)\:([0-9]+)\:([0-9]+)';
        if RegExpr.exec(longdate) then begin
           if notdebug2=false then if debug then writeln('parse (1): Year (' + RegExpr.Match[1] + ') month(' + RegExpr.Match[2] + ') day(' + RegExpr.Match[3] + ') time: ' +RegExpr.Match[4] + '-' + RegExpr.Match[5] + '-' + RegExpr.Match[6]);
           ANow:=EncodeDateTime(StrToInt(RegExpr.Match[1]), StrToInt(RegExpr.Match[2]), StrToInt(RegExpr.Match[3]), StrToInt(RegExpr.Match[4]), StrToInt(RegExpr.Match[5]), StrToInt(RegExpr.Match[6]), 0);
           parsed:=true;
        end;

        if parsed=false then begin
           RegExpr.Expression:='([0-9]+)[\/\-]([0-9]+)[\/\-]([0-9]+)';
               if RegExpr.exec(longdate) then begin
                  if notdebug2=false then if debug then writeln('parse (2): ' + RegExpr.Match[1] + '-' + RegExpr.Match[2] + '-' + RegExpr.Match[3]);
                  ANow:=EncodeDateTime(StrToInt(RegExpr.Match[1]), StrToInt(RegExpr.Match[2]), StrToInt(RegExpr.Match[3]), 0, 0, 0, 0);
                  parsed:=true;
               end;
       end;
        if parsed=false then begin
           writeln('ERROR : unable to determine date : ' + longdate + ' must be yyyy/mm/dd hh:ii:ss');
           exit;
        end;
      end;


      AThen:=EncodeDateTime(1970, 1, 1, 0, 0, 0, 0);
      if commut='-' then begin
         if notdebug2=false then if debug then writeln('(-)' + DateTostr(Anow) + ' <> ' + DateTostr(AThen) );
         result:=IntTostr(SecondsBetween(ANow,AThen)+seconds);
      end;

      if commut='+' then begin
         if notdebug2=false then if debug then writeln('(+)' + DateTostr(Anow) + ' <> s' + DateTostr(AThen) );
         result:=IntTostr(SecondsBetween(ANow,AThen)-seconds);
      end;
      if notdebug2=false then if debug then writeln('result:',result);

end;
//#############################################################################

function myconf.ARTICA_FILTER_GET_ALL_PIDS():string;
var
   ps:TStringList;
   articafilter_path,commandline:string;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
begin
   result:='';
   ps:=TStringList.CReate;
   D:=COMMANDLINE_PARAMETERS('debug');
articafilter_path:=get_ARTICA_PHP_PATH() + '/bin/artica-filter';
commandline:='/bin/ps -aux';
if D then writeln('ARTICA_FILTER_GET_ALL_PIDS::' +commandline);
   ps.LoadFromStream(ExecStream(commandline,false));
   if ps.Count>0 then begin
       RegExpr:=TRegExpr.Create;
       RegExpr.Expression:='([a-z0-9A-Z]+)\s+([0-9]+).+?'+articafilter_path;
       for i:=0 to ps.count-1 do begin
             //if D then writeln('ARTICA_FILTER_GET_ALL_PIDS::' +ps.Strings[i]);
             if RegExpr.Exec(ps.Strings[i]) then result:=result + RegExpr.Match[2] + ' ';

       end;
       RegExpr.FRee;
   end;
    ps.Free;
end;
//#############################################################################

function Myconf.RRDTOOL_LOAD_AVERAGE():string;
 var filedatas:string;
  RegExpr:TRegExpr;
 Begin
      RegExpr:=TRegExpr.Create;

      RegExpr.Expression:='([0-9]+)\.([0-9]+)\s+([0-9]+)\.([0-9]+)\s+([0-9]+)\.([0-9]+)';
      filedatas:=ReadFileIntoString('/proc/loadavg');
      if RegExpr.Exec(filedatas) then begin
         if debug then writeln('RRDTOOL_LOAD_AVERAGE:',RegExpr.Match[1]+RegExpr.Match[2]+';' +RegExpr.Match[3]+RegExpr.Match[4] + ';' +RegExpr.Match[5]+RegExpr.Match[6]);
          result:=RegExpr.Match[1]+RegExpr.Match[2]+';' +RegExpr.Match[3]+RegExpr.Match[4] + ';' +RegExpr.Match[5]+RegExpr.Match[6];

      end;
      RegExpr.Free;


end;



//#############################################################################
procedure MyConf.YOREL_VERIFY_START();
var
   l:Tstringlist;
   i:integer;
   Rebuild:boolean;
   artica_path:string;
   logs:Tlogs;
begin
Rebuild:=False;
l:=TStringList.Create;
logs:=tlogs.Create;
ForceDirectories('/opt/artica/var/rrd/yorel');
l.Add('/opt/artica/var/rrd/yorel/cpu_system.rrd');
l.Add('/opt/artica/var/rrd/yorel/proc_other.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_idle.rrd');
l.Add('/opt/artica/var/rrd/yorel/io_sda_r.rrd');
l.Add('/opt/artica/var/rrd/yorel/loadavg_5.rrd');
l.Add('/opt/artica/var/rrd/yorel/hdd_pgsql.rrd');
l.Add('/opt/artica/var/rrd/yorel/hdd_www.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_user.rrd');
l.Add('/opt/artica/var/rrd/yorel/proc_httpd.rrd');
l.Add('/opt/artica/var/rrd/yorel/proc_system.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_hirq.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_iowait.rrd');
l.Add('/opt/artica/var/rrd/yorel/mem_user.rrd');
l.Add('/opt/artica/var/rrd/yorel/swap_free.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_sirq.rrd');
l.Add('/opt/artica/var/rrd/yorel/cpu_nice.rrd');
l.Add('/opt/artica/var/rrd/yorel/proc_pgsql.rrd');
l.Add('/opt/artica/var/rrd/yorel/hdd_other.rrd');
l.Add('/opt/artica/var/rrd/yorel/eth0_in.rrd');
l.Add('/opt/artica/var/rrd/yorel/proc_total.rrd');
l.Add('/opt/artica/var/rrd/yorel/mem_cached.rrd');
l.Add('/opt/artica/var/rrd/yorel/mem_buffers.rrd');
l.Add('/opt/artica/var/rrd/yorel/eth0_out.rrd');
l.Add('/opt/artica/var/rrd/yorel/hdd_total.rrd');
l.Add('/opt/artica/var/rrd/yorel/swap_used.rrd');
l.Add('/opt/artica/var/rrd/yorel/loadavg_1.rrd');
l.Add('/opt/artica/var/rrd/yorel/loadavg_15.rrd');
l.Add('/opt/artica/var/rrd/yorel/hdd_wwwlogs.rrd');
l.Add('/opt/artica/var/rrd/yorel/mem_free.rrd');
l.Add('/opt/artica/var/rrd/yorel/httpreq.rrd');
l.Add('/opt/artica/var/rrd/yorel/io_sda_w.rrd');
l.Add('/etc/cron.d/artica_yorel');

For i:=0 to l.Count-1 do begin
      if Not FileExists(l.Strings[i]) then begin
         logs.Debuglogs('YOREL_VERIFY_START():: Unable to stat '+l.Strings[i]);
         Rebuild:=True;
         end;
end;
YOREL_CHECK_PEL_LIB();
artica_path:=get_ARTICA_PHP_PATH() + '/bin/install/rrd';
  if Rebuild then begin
       logs.DebugLogs('Starting......: yorel, building configuration...');
       YOREL_RECONFIGURE('');
       fpsystem(artica_path + '/yorel-create >/dev/null 2>&1');
       logs.Debuglogs(artica_path + '/yorel-create >/dev/null 2>&1');
       fpsystem(artica_path + '/yorel-upd >/dev/null 2>&1');
       logs.Debuglogs(artica_path + '/yorel-upd >/dev/null 2>&1');
   end;
if FileExists('/usr/bin/pango-querymodules') then fpsystem('pango-querymodules >/etc/pango/pango.modules');
logs.Debuglogs('YOREL_VERIFY_START():: End...');

end;

//#############################################################################
procedure Myconf.YOREL_CHECK_PEL_LIB();
var
   perl_paths:TstringList;
   i:integer;
   linux_net_dev:boolean;
begin
linux_net_dev:=false;
perl_paths:=TstringList.Create;
perl_paths.AddStrings(PERL_INCFolders());

 for i:=0 to perl_paths.Count-1 do begin
     if FileExists(perl_paths.Strings[i]+'/Linux/net/dev.pm') then begin
         logs.DebugLogs('yorel,dev.pm is '+perl_paths.Strings[i]+'/Linux/net/dev.pm');
         linux_net_dev:=true;
         break;
     end;
 end;

 if not linux_net_dev then begin
     logs.DebugLogs('Starting......: yorel, unable to stat .*/Linux/net/dev.pm try to install it');
     fpsystem(paramstr(0) +' linux-net-dev');
 end;




end;
//#############################################################################



function Myconf.YOREL_RECONFIGURE(database_path:string):string;
var      artica_path,create_path,upd_path,image_path,du_path,cron_command,andalemono_path:string;
         list:TStringList;
         RegExpr:TRegExpr;
         i:integer;
         logs:Tlogs;
begin
   logs:=Tlogs.Create;
   result:='';
   if not FileExists(RRDTOOL_BIN_PATH()) then begin
         logs.Debuglogs('YOREL_RECONFIGURE:: WARNING !!! unable to locate rrdtool : usually in /usr/bin/rrdtool, found "'+RRDTOOL_BIN_PATH()+'" process cannot continue...');
         exit;
   end;



 artica_path:=get_ARTICA_PHP_PATH() + '/bin/install/rrd';
 image_path:='/opt/artica/share/www/system/rrd';
 forcedirectories(image_path);
 andalemono_path:=artica_path;
 create_path:=artica_path + '/yorel-create';
 upd_path:=artica_path+'/yorel-upd';
 du_path:='/usr/bin/du';

 logs.Debuglogs('YOREL_RECONFIGURE:: artica_path='+artica_path);
 logs.Debuglogs('YOREL_RECONFIGURE:: du_path='+du_path);



 if length(database_path)=0 then database_path:='/opt/artica/var/rrd/yorel';

 forcedirectories(database_path);

 if not DirectoryExists(artica_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Unable to stat ' + artica_path);
      exit;
 end;
  if not DirectoryExists(database_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Create ' + database_path);
      ForceDirectories(database_path);
 end;

  if not FileExists(andalemono_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Unable to stat ' + andalemono_path);
      exit;
 end;

  if not FileExists(create_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Unable to stat ' + create_path);
      exit;
 end;

   if not FileExists(du_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Unable to stat ' + du_path);
      exit;
 end;

   if not FileExists(upd_path) then begin
      logs.Debuglogs('YOREL_RECONFIGURE::Unable to stat ' + upd_path);
      exit;
 end;


   list:=TStringList.create;
   RegExpr:=TRegExpr.Create;

   logs.Debuglogs('YOREL_RECONFIGURE:: Scanning ='+create_path);
   if not FileExists(create_path) then begin
       logs.Debuglogs('YOREL_RECONFIGURE:: Unable to stat '+create_path);
       exit;
   end;

   list.LoadFromFile(create_path);
   try
   for i:=0 to  list.Count-1 do begin

      RegExpr.Expression:='my \$path[\s= ]+';
      if RegExpr.Exec(list.Strings[i]) then begin
         list.Strings[i]:='my $path=''' +  database_path + ''';';
         logs.Debuglogs('Starting......: yorel installation Change path in "' + database_path + '" in [my $path] ' +ExtractFileName(create_path));
      end;

      RegExpr.Expression:='RRDp::start';
      if RegExpr.Exec(list.Strings[i]) then begin
          logs.DebugLogs('Starting......: yorel installation Change path in "' + RRDTOOL_BIN_PATH() + '" in line ' + intToStr(i) + ' [RRDp::start] ' +ExtractFileName(create_path));
           list.Strings[i]:=' RRDp::start "' + RRDTOOL_BIN_PATH() + '";';
      end;
   end;
   except
    logs.DebugLogs('Starting......: yorel  fatal error while scanning ' + create_path);
    exit;
   end;

   logs.DebugLogs('Starting......: yorel installation saving ' + create_path);
   list.SaveToFile(create_path);



   RegExpr.Expression:='^my \$rdir';
    list.LoadFromFile(upd_path);
       for i:=0 to  list.Count-1 do begin
      if RegExpr.Exec(list.Strings[i]) then begin
         logs.DebugLogs('Starting......: yorel installation Change path "' + database_path + '" in ' +ExtractFileName(upd_path) );
         list.Strings[i]:='my $rdir=''' +  database_path + ''';';
         logs.DebugLogs('Starting......: yorel installation saving ' + upd_path);
         list.SaveToFile(upd_path);
         break;
      end;
   end;





    list.LoadFromFile(upd_path);
       for i:=0 to  list.Count-1 do begin
           RegExpr.Expression:='^my \$gdir';

           if RegExpr.Exec(list.Strings[i]) then begin
              logs.DebugLogs('Starting......: yorel installation Change path in "' + image_path + '" in line ' + intToStr(i) + ' [$gdir] ' +ExtractFileName(create_path));
              list.Strings[i]:='my $gdir=''' +  image_path + ''';';
           end;

           RegExpr.Expression:='RRDp::start';
           if RegExpr.Exec(list.Strings[i]) then begin
              logs.DebugLogs('Starting......: yorel installation Change path in "' + RRDTOOL_BIN_PATH() + '" in line ' + intToStr(i) + ' [RRDp::start] ' +ExtractFileName(upd_path));
              list.Strings[i]:=' RRDp::start "' + RRDTOOL_BIN_PATH() + '";';
           end;

   end;
     logs.DebugLogs('Starting......: yorel installation saving ' + upd_path);
     list.SaveToFile(upd_path);
     RegExpr.Free;
     list.free;


   if sys.DirectoryCountFiles(database_path)=0 then begin
       logs.DebugLogs('Starting......: yorel installation Create rrd databases in "' + database_path + '"');
       logs.DebugLogs('Starting......: yorel execute "'+create_path+'"');
       fpsystem(create_path);

   end;
  if sys.DirectoryCountFiles(database_path)=0 then begin
       logs.DebugLogs('YOREL_RECONFIGURE::Error, there was a problem while creating rrd databases in "' + database_path + '"');
       exit;
  end;
  logs.DebugLogs('Starting......: yorel installation Creating the cron script in order automically generate statistics');
  list:=TstringList.Create;
  list.Add('#!/bin/bash');
  list.Add('');
  list.Add('# HDD usage is collected with the following command,');
  list.Add('#  which can only be run as root');
  list.Add('/bin/chmod 644 '+database_path);
  list.Add(upd_path);
  list.SaveToFile(artica_path + '/yorel_cron');
  fpsystem('/bin/chmod 777 ' + artica_path + '/yorel_cron');
  list.free;

  cron_command:='1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59 * * * *' + chr(9) + 'root' + chr(9) + artica_path + '/yorel_cron >/dev/null 2>&1';
if DirectoryExists('/etc/cron.d') then begin
     list:=TstringList.Create;
     list.Add(cron_command);
     list.SaveToFile('/etc/cron.d/artica_yorel');
     list.Free;
end;


  logs.DebugLogs('Starting......: yorel installation Done...');

end;

//#############################################################################
procedure myconf.PERL_PATCHING_HEADER(path:string);
var
   l:TstringList;
   logs:Tlogs;
begin
   if not FileExists(path) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(path);
   logs:=Tlogs.Create;
   if length(l.Text)>0 then begin
      if pos('!',l.Strings[0])>0 then begin
      logs.Debuglogs('PERL_PATCHING_HEADER: -> ' + l.Strings[0]);
      l.Strings[0]:='#!' + PERL_BIN_PATH();
      l.SaveToFile(path);
      end;
   end;
   l.free;
end;
//#############################################################################

function Myconf.QUEUEGRAPH_TEMP_PATH():string;
var debugC:boolean;
list:TStringList;
cgi_path:string;
  RegExpr:TRegExpr;
  i:integer;
begin
debugC:=false;
if ParamStr(1)='-queuegraph' then debugC:=true;
cgi_path:=get_ARTICA_PHP_PATH() + '/bin/queuegraph/queuegraph1.cgi';

if not FileExists(cgi_path) then begin
   if debugC then ShowScreen('QUEUEGRAPH_TEMP_PATH::unable to locate ' + cgi_path);
   exit;
end;
list:=TStringList.Create;
list.LoadFromFile(cgi_path);
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='my \$tmp_dir[=''"\s+]+([a-zA-Z\/_\-0-9]+)';
  for i:=0 to list.Count-1 do begin
        if RegExpr.Exec(list.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
        end;

  end;
  if debugC then ShowScreen('QUEUEGRAPH_TEMP_PATH:: Path="' + result + '"');
  list.free;
  RegExpr.free;
end;
//#############################################################################
procedure Myconf.RDDTOOL_POSTFIX_MAILS_CREATE_DATABASE();
var
   database_path,date,command:string;
   sday:integer;
begin
     database_path:=RRDTOOL_STAT_POSTFIX_MAILS_SENT_DATABASE_PATH();
     if debug then writeln('RDDTOOL_POSTFIX_MAILS_CREATE_DATABASE');
     if debug then writeln('Testing database "' + database_path + '"');

     if not fileexists(database_path) then begin
        sday:=DayOf(now);
        sday:=sday-2;
        date:=IntTostr(YearOf(now)) + '-' +IntToStr(MonthOf(now)) + '-' + intTostr(sday) + ' 00:00:00';
                if debug then writeln('Creating database..start yesterday ' + date);
        date:=RRDTOOL_SecondsBetween(date);
        command:=RRDTOOL_BIN_PATH() + '  create ' + database_path + ' --start ' + date + ' DS:mails:ABSOLUTE:60:0:U RRA:AVERAGE:0.5:1:60';
        if debug then writeln(command);
        fpsystem(command);

        if debug then writeln('Creating database..done..');
     end;
end;


//#############################################################################
procedure Myconf.RDDTOOL_POSTFIX_MAILS_SENT_STATISTICS();
  var filedatas:TstringList;
  var maillog_path,rdd_sent_path,formated_date,new_formated_date,mem_formated_date:string;
  RegExpr:TRegExpr;
  i:integer;
  month,year,countlines:integer;

begin
     mem_formated_date:='';
     maillog_path:=get_LINUX_MAILLOG_PATH();
     if length(maillog_path)=0  then begin
           logs.logs('RDDTOOL_POSTFIX_MAILS_SENT_STATISTICS:: unable to stat maillog...aborting');
           if debug then writeln('unable to locate maillog path');
           exit;
     end;
     notdebug2:=true;
     if debug then writeln('reading ' +  maillog_path);
     rdd_sent_path:=RRDTOOL_STAT_POSTFIX_MAILS_SENT_DATABASE_PATH();
     countlines:=1;
     year:=YearOf(now);
     RegExpr:=TRegExpr.Create;
     filedatas:=TstringList.Create;
     filedatas.LoadFromFile(maillog_path);
     if debug then writeln('starting parsing lines number ',filedatas.Count);
     RegExpr.Expression:='([a-zA-Z]+)\s+([0-9]+)\s+([0-9\:]+).+postfix/(smtp|lmtp).+to=<(.+)>,\s+relay=(.+),.+status=sent.+';


     for i:=0 to filedatas.Count -1 do begin
         if RegExpr.Exec(filedatas.Strings[i]) then begin
               month:=GetMonthNumber(RegExpr.Match[1]);
               if debug then writeln(filedatas.Strings[i]);
                formated_date:=intTostr(year) + '-' + intTostr(month) + '-' + RegExpr.Match[2] + ' ' + RegExpr.Match[3];
                new_formated_date:=RRDTOOL_SecondsBetween(formated_date);
                if debug then writeln( new_formated_date + '/' +  mem_formated_date);
                if mem_formated_date=new_formated_date then begin
                    countlines:=countlines+1;
                    if debug then writeln( formated_date +  ' increment 1 ('+IntToStr(countlines)+')');
                end else begin
                    if debug then writeln( formated_date +' ' + new_formated_date + ' ' + RegExpr.Match[5] +  '('+IntToStr(countlines)+')->ADD');
                    fpsystem(RRDTOOL_BIN_PATH() + '  update ' + rdd_sent_path + ' ' + new_formated_date+ ':' + IntToStr(countlines));
                    mem_formated_date:=new_formated_date;
                    countlines:=1;
                end;

         end;

     end;
     RegExpr.Free;
     filedatas.Free;



end;
//#############################################################################

procedure Myconf.RDDTOOL_POSTFIX_MAILS_SENT_GENERATE();
var
   commandline:string;
   database_path:string;
   php_path,gif_path,gwidth,gheight:string;
begin
  php_path:=get_ARTICA_PHP_PATH();
  gwidth:=RRDTOOL_GRAPH_WIDTH();
  gheight:=RRDTOOL_GRAPH_HEIGHT();
  database_path:=RRDTOOL_STAT_POSTFIX_MAILS_SENT_DATABASE_PATH();

  gif_path:=php_path + '/img/LOAD_MAIL-SENT-1.gif';
commandline:=RRDTOOL_BIN_PATH() + '  graph ' + gif_path + ' -t "Mails sent pear day" -v "Mails number" -w '+gwidth+' -h '+gheight+' --start -1day ';
commandline:=commandline + 'DEF:mem_ram_libre='+database_path+':mem_ram_libre:AVERAGE  ';
///usr/bin/rrdtool graph /home/touzeau/developpement/artica-postfix/img/LOAD_MAIL-SENT-1.gif -t "Mails sent pear day" -v "Mails number" -w 550 -h 550 --start -1day DEF:mails=/home/touzeau/developpement/artica-postfix/ressources/rrd/postfix-mails-sent.rdd:mails:AVERAGE LINE1:mails\#FFFF00:"Emails number"
           if debug then writeln(commandline);

fpsystem(commandline + ' >/opt/artica/logs/rrd.generate.dustbin');
  if FileExists(gif_path) then fpsystem('/bin/chmod 755 ' + gif_path);

end;

//###########################################################################



//#############################################################################
function Myconf.GetMonthNumber(MonthName:string):integer;
begin
 if MonthName='Jan' then exit(1);
 if MonthName='Feb' then exit(2);
 if MonthName='Mar' then exit(3);
 if MonthName='Apr' then exit(4);
 if MonthName='May' then exit(5);
 if MonthName='Jun' then exit(6);
 if MonthName='Jul' then exit(7);
 if MonthName='Aug' then exit(8);
 if MonthName='Sep' then exit(9);
 if MonthName='Oct' then exit(10);
 if MonthName='Nov'  then exit(11);
 if MonthName='Dec'  then exit(12);
 if MonthName='jan' then exit(1);
 if MonthName='feb' then exit(2);
 if MonthName='mar' then exit(3);
 if MonthName='apr' then exit(4);
 if MonthName='may' then exit(5);
 if MonthName='jun' then exit(6);
 if MonthName='jul' then exit(7);
 if MonthName='aug' then exit(8);
 if MonthName='sep' then exit(9);
 if MonthName='oct' then exit(10);
 if MonthName='nov'  then exit(11);
 if MonthName='dec'  then exit(12);
end;
//#############################################################################


procedure Myconf.RDDTOOL_LOAD_MEMORY_GENERATE();
var
   commandline:string;
   database_path:string;
   php_path,gif_path,gwidth,gheight:string;
begin
  php_path:=get_ARTICA_PHP_PATH();
  gwidth:=RRDTOOL_GRAPH_WIDTH();
  gheight:=RRDTOOL_GRAPH_HEIGHT();
  database_path:=RRDTOOL_STAT_LOAD_MEMORY_DATABASE_PATH();

  gif_path:=php_path + '/img/LOAD_MEMORY-1.gif';
commandline:=RRDTOOL_BIN_PATH() + '  graph ' + gif_path + ' -t "SYSTEM memory pear day" -v "memory bytes" -w '+gwidth+' -h '+gheight+' --start -1day ';
commandline:=commandline + 'DEF:mem_ram_libre='+database_path+':mem_ram_libre:AVERAGE  ';
commandline:=commandline + 'DEF:mem_ram_util='+database_path+':mem_ram_util:AVERAGE  ';
commandline:=commandline + 'DEF:mem_virtu_libre='+database_path+':mem_virtu_libre:AVERAGE  ';
commandline:=commandline + 'DEF:mem_virtu_util='+database_path+':mem_virtu_util:AVERAGE ';
commandline:=commandline + 'CDEF:mem_virtu_libre_tt=mem_virtu_util,mem_virtu_libre,+,1024,* ';
commandline:=commandline + 'CDEF:mem_virtu_util_tt=mem_virtu_util,1024,* ';
commandline:=commandline + 'CDEF:mem_ram_tt=mem_ram_util,mem_ram_libre,+,1024,* ';
commandline:=commandline + 'CDEF:mem_ram_util_tt=mem_ram_util,1024,* ';
commandline:=commandline + 'LINE3:mem_ram_util_tt\#FFFF00:"RAM used" ';
commandline:=commandline + 'LINE2:mem_virtu_util_tt\#FF0000:"Virtual RAM used\n" ';
commandline:=commandline + 'GPRINT:mem_ram_tt:LAST:"RAM  Free %.2lf %s |" ';
commandline:=commandline + 'GPRINT:mem_ram_util_tt:MAX:"RAM  MAX used %.2lf %s |" ';
commandline:=commandline + 'GPRINT:mem_ram_util_tt:AVERAGE:"RAM average util %.2lf %s |" ';
commandline:=commandline + 'GPRINT:mem_ram_util_tt:LAST:"RAM  CUR util %.2lf %s\n" ';
commandline:=commandline + 'GPRINT:mem_virtu_libre_tt:LAST:"Swap Free %.2lf %s |" ';
commandline:=commandline + 'GPRINT:mem_virtu_util_tt:MAX:"Swap MAX used %.2lf %s |" ';
commandline:=commandline + 'GPRINT:mem_virtu_util_tt:AVERAGE:"Swap AVERAGE used %.2lf %s |" \';
commandline:=commandline + 'GPRINT:mem_virtu_util_tt:LAST:"Swap Current used %.2lf %s"';
           if debug then writeln(commandline);

fpsystem(commandline + ' >/opt/artica/logs/rrd.generate.dustbin');
  if FileExists(gif_path) then fpsystem('/bin/chmod 755 ' + gif_path);

end;

//#############################################################################




//#############################################################################
procedure Myconf.RDDTOOL_LOAD_AVERAGE_GENERATE();
var
   commandline:string;
   database_path:string;
   php_path,gif_path,gwidth,gheight:string;
begin
  php_path:=get_ARTICA_PHP_PATH();
  gwidth:=RRDTOOL_GRAPH_WIDTH();
  gheight:=RRDTOOL_GRAPH_HEIGHT();
  database_path:=RRDTOOL_STAT_LOAD_AVERAGE_DATABASE_PATH();

  gif_path:=php_path + '/img/LOAD_AVERAGE-1.gif';
  commandline:=RRDTOOL_BIN_PATH() + '  graph ' + gif_path + ' -t "SYSTEM LOAD pear day" -v "Charge x 100" -w '+gwidth+' -h '+gheight+' --start -1day ';
  commandline:=commandline + 'DEF:charge_1min=' + database_path + ':charge_1min:AVERAGE ';
  commandline:=commandline + 'DEF:charge_5min=' + database_path + ':charge_5min:AVERAGE ';
  commandline:=commandline + 'DEF:charge_15min=' + database_path + ':charge_15min:AVERAGE ';
  commandline:=commandline + 'LINE2:charge_1min\#FF0000:"Load 1 minute" ';
  commandline:=commandline + 'LINE2:charge_5min\#00FF00:"load 5 minute" ';
  commandline:=commandline + 'LINE2:charge_15min\#0000FF:"load 15 minute \n" ';
  commandline:=commandline + 'GPRINT:charge_1min:MAX:"System load  1 minute  \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_1min:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_1min:LAST:"CUR %.2lf %s \n" ';
  commandline:=commandline + 'GPRINT:charge_5min:MAX:"System load  5 minutes \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_5min:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_5min:LAST:"CUR %.2lf %s \n" ';
  commandline:=commandline + 'GPRINT:charge_15min:MAX:"System Load 15 minutes \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_15min:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:charge_15min:LAST:"CUR %.2lf %s \n"';
  fpsystem(commandline + ' >/opt/artica/logs/rrd.generate.dustbin');
  if FileExists(gif_path) then fpsystem('/bin/chmod 755 ' + gif_path);

end;

//#############################################################################
procedure Myconf.RDDTOOL_LOAD_CPU_GENERATE();
var
   commandline:string;
   database_path:string;
   php_path,gif_path,gwidth,gheight:string;
begin
  php_path:=get_ARTICA_PHP_PATH();
  gwidth:=RRDTOOL_GRAPH_WIDTH();
  gheight:=RRDTOOL_GRAPH_HEIGHT();
  database_path:=RRDTOOL_STAT_LOAD_CPU_DATABASE_PATH();
  gif_path:=php_path + '/img/LOAD_CPU-1.gif';

commandline:=RRDTOOL_BIN_PATH() + ' graph ' + gif_path + ' -t "CPU on day" -v "Util CPU 1/100 Seconds" -w '+gwidth+' -h '+gheight+' --start -1day ';
  commandline:=commandline + 'DEF:utilisateur='+ database_path+':utilisateur:AVERAGE ';
  commandline:=commandline + 'DEF:nice='+ database_path+':nice:AVERAGE ';
  commandline:=commandline + 'DEF:systeme='+ database_path+':systeme:AVERAGE ';
  commandline:=commandline + 'CDEF:vtotale=utilisateur,systeme,+ ';
  commandline:=commandline + 'CDEF:vutilisateur=vtotale,1,GT,0,utilisateur,IF ';
  commandline:=commandline + 'CDEF:vnice=vtotale,1,GT,0,nice,IF ';
  commandline:=commandline + 'CDEF:vsysteme=vtotale,1,GT,0,systeme,IF ';
  commandline:=commandline + 'CDEF:vtotalectrl=vtotale,1,GT,0,vtotale,IF ';
  commandline:=commandline + 'LINE2:vutilisateur\#FF0000:"User" ';
  commandline:=commandline + 'LINE2:vnice\#0000FF:"Nice" ';
  commandline:=commandline + 'LINE2:vsysteme\#00FF00:"system" ';
  commandline:=commandline + 'LINE2:vtotalectrl\#FFFF00:"sum \n" ';
  commandline:=commandline + 'GPRINT:vutilisateur:MAX:"CPU user \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vutilisateur:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vutilisateur:LAST:"CUR %.2lf %s \n" ';
  commandline:=commandline + 'GPRINT:vnice:MAX:"CPU nice  \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vnice:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vnice:LAST:"CUR %.2lf %s \n" ';
  commandline:=commandline + 'GPRINT:vsysteme:MAX:"CPU  system   \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vsysteme:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vsysteme:LAST:"CUR %.2lf %s \n" ';
  commandline:=commandline + 'GPRINT:vtotalectrl:MAX:"Total  CPU    \: MAX %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vtotalectrl:AVERAGE:"AVERAGE %.2lf %s |" ';
  commandline:=commandline + 'GPRINT:vtotalectrl:LAST:"CUR %.2lf %s \n"';

  if debug then writeln(commandline);
  fpsystem(commandline + ' >/opt/artica/logs/rrd.generate.dustbin');

  if FileExists(gif_path) then fpsystem('/bin/chmod 755 ' + gif_path);
end;
//#############################################################################
function Myconf.RRDTOOL_GRAPH_WIDTH():string;
var value:string;
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-postfix-rdd.conf');
value:=ini.ReadString('ARTICA','RRDTOOL_GRAPH_WIDTH','');
if length(value)=0 then  begin
   if debug then writeln('RRDTOOL_GRAPH_WIDTH is not set in ini');
   if debug then writeln('set RRDTOOL_GRAPH_WIDTH to 450');
   value:='550';
   ini.WriteString('ARTICA','RRDTOOL_GRAPH_WIDTH','450');
end;
result:=value;
ini.Free;
end;
//#############################################################################
function Myconf.RRDTOOL_GRAPH_HEIGHT():string;
var value:string;
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-postfix-rdd.conf');
value:=ini.ReadString('ARTICA','RRDTOOL_GRAPH_HEIGHT','');
if length(value)=0 then  begin
   if debug then writeln('RRDTOOL_GRAPH_WIDTH is not set in ini');
   if debug then writeln('set RRDTOOL_GRAPH_HEIGHT to 170');
   value:='550';
   ini.WriteString('ARTICA','RRDTOOL_GRAPH_HEIGHT','170');
end;
result:=value;
ini.Free;
end;
//#############################################################################
function MyConf.RRDTOOL_STAT_LOAD_CPU_DATABASE_PATH():string;
var value,phppath,path:string;
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-postfix-rdd.conf');
value:=ini.ReadString('ARTICA','STAT_CPU_PATH','');
if length(value)=0 then  begin
   if debug then writeln('STAT_LOAD_PATH is not set in ini path');
   phppath:=get_ARTICA_PHP_PATH();
   path:=phppath+'/ressources/rrd/cpu.rdd';
   if debug then writeln('set STAT_CPU_PATH to '+path);
   value:=path;
   ini.WriteString('ARTICA','STAT_CPU_PATH',path);
   if debug then writeln('done..'+path);
end;
result:=value;
ini.Free;
end;
//#############################################################################
function MyConf.RRDTOOL_STAT_LOAD_MEMORY_DATABASE_PATH():string;
var value,phppath,path:string;
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-postfix-rdd.conf');
value:=ini.ReadString('ARTICA','STAT_MEM_PATH','');
if length(value)=0 then  begin
   if debug then writeln('STAT_LOAD_PATH is not set in ini path');
   phppath:=get_ARTICA_PHP_PATH();
   path:=phppath+'/ressources/rrd/mem.rdd';
   if debug then writeln('set STAT_MEM_PATH to '+path);
   value:=path;
   ini.WriteString('ARTICA','STAT_MEM_PATH',path);
   if debug then writeln('done..'+path);
end;
result:=value;
ini.Free;
end;
//#############################################################################
function MyConf.RRDTOOL_STAT_POSTFIX_MAILS_SENT_DATABASE_PATH():string;
var value,phppath,path:string;
ini:TIniFile;
begin
ini:=TIniFile.Create('/etc/artica-postfix/artica-postfix-rdd.conf');
value:=ini.ReadString('ARTICA','STAT_MAIL_SENT_PATH','');
if length(value)=0 then  begin
   if debug then writeln('STAT_MAIL_PATH is not set in ini path');
   phppath:=get_ARTICA_PHP_PATH();
   path:=phppath+'/ressources/rrd/postfix-mails-sent.rdd';
   if debug then writeln('set STAT_MAIL_SENT_PATH to '+path);
   value:=path;
   ini.WriteString('ARTICA','STAT_MAIL_SENT_PATH',path);
   if debug then writeln('done..'+path);
end;
result:=value;
ini.Free;
end;
//#############################################################################
function myconf.LDAP_GET_BIN_PATH:string;
begin
   if FileExists('/usr/sbin/slapd') then exit('/usr/sbin/slapd');
   if FileExists('/opt/artica/bin/slapd') then exit('/opt/artica/bin/slapd');
end;
//#############################################################################

function Myconf.CYRUS_DELIVER_BIN_PATH():string;
var path:string;
begin
    path:=LINUX_APPLICATION_INFOS('cyrus_deliver_bin');
    if length(path)>0 then exit(path);
    if FileExists('/opt/artica/cyrus/bin/deliver') then exit('/opt/artica/cyrus/bin/deliver');
end;
//#############################################################################
function MyConf.POSFTIX_DELETE_FILE_FROM_CACHE(MessageID:string):boolean;
var FileSource,FileDatas:TStringList;
    php_path,commandline:string;
    RegExpr:TRegExpr;
    D:boolean;
    i:integer;
begin
   D:=COMMANDLINE_PARAMETERS('debug');
  FileSource:=TStringList.Create;
  php_path:=get_ARTICA_PHP_PATH() +'/ressources/databases/*.cache';
  commandline:='/bin/grep -l ' + MessageID + ' ' + php_path;
  if D then ShowScreen('POSFTIX_DELETE_FILE_FROM_CACHE:: EXEC -> ' + commandLine);
  //grep -l 8680973402E /home/touzeau/developpement/artica-postfix/ressources/databases/*.cache
  fpsystem(commandline + ' >/opt/artica/logs/artica_tmp');
  FileSource.LoadFromFile('/opt/artica/logs/artica_tmp');

  if FileSource.Count>0 then begin
     if D then ShowScreen('POSFTIX_DELETE_FILE_FROM_CACHE:: Found file : ' +FileSource.Strings[0]);
  end else begin
           if D then ShowScreen('POSFTIX_DELETE_FILE_FROM_CACHE:: no Found file : ');
            FileSource.Free;
            exit(false);
  end;
  FileDatas:=TStringList.Create;
  FileDatas.LoadFromFile(trim(FileSource.Strings[0]));
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=MessageID;
  for i:=0 to FileDatas.Count-1 do begin
       if RegExpr.Exec(FileDatas.Strings[i]) then begin
             if D then ShowScreen('POSFTIX_DELETE_FILE_FROM_CACHE:: Pattern found line : ' + IntToStr(i));
            FileDatas.Delete(i);

       end;
       if i>=FileDatas.Count-1 then break;
  end;
  FileDatas.SaveToFile(trim(FileSource.Strings[0]));
  RegExpr.free;
  FileDatas.free;
  FileSource.Free;
  exit(true);
end;
//#############################################################################
function myconf.INYADIN_VERSION():string;
var
   RegExpr        :TRegExpr;
   tmpstring      :string;
begin
   tmpstring:=ExecPipe(get_ARTICA_PHP_PATH()+ '/bin/inadyn --version');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='([0-9\.]+)';
   if RegExpr.Exec(tmpstring) then result:=RegExpr.Match[1];
   RegExpr.free;

end;
//#############################################################################
function MyConf.get_LINUX_DISTRI():string;
var value:string;
begin
GLOBAL_INI:=TIniFile.Create('/etc/artica-postfix/artica-postfix.conf');
value:=GLOBAL_INI.ReadString('LINUX','distribution-name','');
result:=value;
GLOBAL_INI.Free;
end;
//#############################################################################
function MyConf.AVESERVER_GET_VALUE(KEY:string;VALUE:string):string;
begin
  if not FileExists('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf') then exit;
  GLOBAL_INI:=TIniFile.Create('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf');
  result:=GLOBAL_INI.ReadString(KEY,VALUE,'');
  GLOBAL_INI.Free;
end;

//#############################################################################
function MyConf.AVESERVER_SET_VALUE(KEY:string;VALUE:string;DATA:string):string;
begin
result:='';
  if not FileExists('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf') then exit;
  GLOBAL_INI:=TIniFile.Create('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf');
  GLOBAL_INI.WriteString(KEY,VALUE,DATA);
  GLOBAL_INI.Free;
end;
//#############################################################################
function MyConf.CROND_INIT_PATH():string;
begin
   if FileExists('/etc/init.d/crond') then exit('/etc/init.d/crond');
   if FileExists('/etc/init.d/cron') then exit('/etc/init.d/cron');
end;

function MyConf.AVESERVER_GET_TEMPLATE_DATAS(family:string;ztype:string):string;
var
   key_name:string;
   file_name:string;
   template:string;
   subject:string;
begin
  if not FileExists('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf') then exit;

  key_name:='smtpscan.notify.' + ztype + '.' + family;
  GLOBAL_INI:=TIniFile.Create('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf');
  file_name:=GLOBAL_INI.ReadString(key_name,'Template','');
  subject:=GLOBAL_INI.ReadString(key_name,'Subject','');

  if not FileExists(file_name) then exit;


  template:=ReadFileIntoString(file_name);



  result:='<subject>' + subject + '</subject><template>' + template + '</template>';


end;
 //#############################################################################

procedure MyConf.AVESERVER_REPLICATE_TEMPLATES();
var phpath,ressources_path:string;
Files:string;
i:integer;
D:boolean;
RegExpr:TRegExpr;
DirFile:string;
key:string;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  phpath:=get_ARTICA_PHP_PATH();

  ressources_path:=phpath + '/ressources/conf';
  SYS.DirFiles(ressources_path,'notify_*');
  if SYS.DirListFiles.Count=0 then begin
     exit;
  end;

  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='notify_([a-z]+)_([a-z]+)';
  For i:=0 to SYS.DirListFiles.Count -1 do begin
     if RegExpr.Exec(SYS.DirListFiles.Strings[i]) then begin;
        key:='smtpscan.notify.' + RegExpr.Match[2] + '.' +  RegExpr.Match[1];
        DirFile:=AVESERVER_GET_VALUE(key,'Template');
        Files:=ressources_path + '/' + SYS.DirListFiles.Strings[i];
        if length(DirFile)>0 then begin
           if D then ShowScreen('AVESERVER_REPLICATE_TEMPLATES:: replicate ' + Files + ' to "'+ DirFile + '"');
           fpsystem('/bin/mv ' + Files + ' ' + DirFile);
        end;
     end;

  end;
 RegExpr.Free;



end;
 //#############################################################################


function MyConf.AVESERVER_GET_KEEPUP2DATE_LOGS_PATH():string;
begin
  result:=AVESERVER_GET_VALUE('updater.report','ReportFileName');
end;
 //#############################################################################
function MyConf.AVESERVER_GET_LOGS_PATH():string;
begin
  result:=AVESERVER_GET_VALUE('aveserver.report','ReportFileName');
end;
 //#############################################################################


function MyConf.AVESERVER_GET_DAEMON_PORT():string;
var
   master_cf:Tstringlist;
   RegExpr:TRegExpr;
   i:integer;
   master_line:string;
begin
    master_cf:=TStringList.create;
    master_cf.LoadFromFile(postfix.POSFTIX_MASTER_CF_PATH());
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='user=kluser\s+argv=\/opt\/kav\/.+';
    for i:=0 to master_cf.Count-1 do begin
        if RegExpr.Exec(master_cf.Strings[i]) then begin
                   master_line:=master_cf.Strings[i-1];
        end;
    end;

    RegExpr.Expression:='^.+:([0-9]+)\s+inet';
    if RegExpr.Exec(master_line) then result:=RegExpr.Match[1];
    RegExpr.Free;
    master_cf.free;


end;
 //#############################################################################

function MyConf.AVESERVER_GET_PID():string;
var pidpath:string;
begin
  pidpath:=AVESERVER_GET_VALUE('path','AVSpidPATH');
  if length(pidpath)=0 then exit;
  result:=trim(ReadFileIntoString(pidpath));
end;
//#############################################################################
function MyConf.AVESERVER_GET_LICENCE():string;
var licensemanager:string;
begin
    if not FileExists('/etc/init.d/aveserver') then exit;
    licensemanager:='/opt/kav/5.5/kav4mailservers/bin/licensemanager';
    if not FileExists(licensemanager) then exit;
    result:=ExecPipe(licensemanager + ' -s');
end;
//##############################################################################
function MyConf.get_kaspersky_mailserver_smtpscanner_logs_path():string;
begin
GLOBAL_INI:=TIniFile.Create('/etc/kav/5.5/kav4mailservers/kav4mailservers.conf');
result:=GLOBAL_INI.ReadString('smtpscan.report','ReportFileName','/var/log/kav/5.5/kav4mailservers/smtpscanner.log');
GLOBAL_INI.Free;
end;
//#############################################################################
procedure MyConf.set_INSTALL_PATH(val:string);
begin
SYS.set_INFO('ArticaInstallPath',val);
end;
function MyConf.get_INSTALL_PATH():string;
begin
result:=SYS.GET_INFO('ArticaInstallPath');
end;


function MyConf.set_DISTRI(val:string):string;
begin
result:='';
SYS.set_INFO('LinuxDistri',val);
end;
function MyConf.get_DISTRI():string;
begin
result:=SYS.GET_INFO('LinuxDistri');
end;
function MyConf.get_UPDATE_TOOLS():string;
begin
result:=SYS.GET_INFO('LinuxUpdateTools');
end;
//##################################################################################
procedure MyConf.set_UPDATE_TOOLS(val:string);
begin
SYS.SET_INFO('LinuxUpdateTools',val);
end;
//##################################################################################
function MyConf.get_ARTICA_PHP_PATH():string;
var path:string;
begin
  if FileExists('/home/dtouzeau/developpement/artica-postfix/bin/artica-install') then exit('/home/dtouzeau/developpement/artica-postfix');
  if not DirectoryExists('/usr/share/artica-postfix') then begin
  path:=ParamStr(0);
  path:=ExtractFilePath(path);
  path:=AnsiReplaceText(path,'/bin/','');
  exit(path);
  end else begin
  exit('/usr/share/artica-postfix');
  end;

end;
//##################################################################################
function MyConf.set_ARTICA_PHP_PATH(val:string):string;
begin
result:='';
if length(val)=0 then exit;
SYS.SET_INFO('ArticaPhpPath',val);
end;
//##################################################################################
function MyConf.get_ARTICA_LOCAL_PORT():integer;
begin
result:=0;
if not TryStrToInt(SYS.GET_INFO('ArticaBoaPort'),result) then result:=47979;
end;
function MyConf.get_ARTICA_LOCAL_SECOND_PORT():integer;
begin
result:=0;
if not TryStrToInt(SYS.GET_INFO('ArticaBoaSecondPort'),result) then result:=0;
end;
procedure MyConf.SET_ARTICA_LOCAL_SECOND_PORT(val:integer);
begin
SYS.set_INFO('ArticaBoaSecondPort',IntToStr(val));
end;
function MyConf.get_ARTICA_LISTEN_IP():string;
begin
 result:=SYS.GET_INFO('ArticaListenIP');
 if length(result)=0 then result:='127.0.0.1';
end;
//##################################################################################
function MyConf.POSTFIX_EXTRAINFOS_PATH(filename:string):string;
begin
if not FileExists('/etc/artica-postfix/postfix-extra.conf') then exit;
GLOBAL_INI:=TIniFile.Create('/etc/artica-postfix/postfix-extra.conf');
result:=GLOBAL_INI.ReadString('POSTFIX',filename,'');
GLOBAL_INI.Free;
end;
//##################################################################################
function MyConf.get_ARTICA_DAEMON_LOG_MaxSizeLimit():integer;
begin
result:=0;
if not TryStrToInt(SYS.GET_INFO('MaxLogDaemonsSize'),result) then result:=1000;
end;
//##################################################################################
procedure MyConf.set_ARTICA_DAEMON_LOG_MaxSizeLimit(val:integer);
begin
SYS.set_INFO('MaxLogDaemonsSize',IntToStr(val));
end;
//##################################################################################
function MyConf.get_POSTFIX_HASH_FOLDER():string;
begin
result:=SYS.GET_INFO('PostFixHashFolder');
if length(result)=0 then result:='/etc/postfix/hash_files';
end;
//##################################################################################
function MyConf.set_POSTFIX_HASH_FOLDER(val:string):string;
begin
result:='';
SYS.set_INFO('PostFixHashFolder',val);
end;
//##############################################################################
procedure MyConf.CYRUS_SET_V2(val:string);
begin
SYS.SET_INFO('CyrusSetV2',val);
end;
//##############################################################################
function MyConf.CYRUS_GET_V2():string;
begin
result:=SYS.GET_INFO('CyrusSetV2');
end;


function myconf.LDAP_GET_DAEMON_USERNAME():string;
   var get_ldap_user,get_ldap_user_regex:string;
   RegExpr:TRegExpr;
   FileDatas:TStringList;
   i:integer;
begin
       get_ldap_user_regex:=LINUX_LDAP_INFOS('get_ldap_user_regex');
       get_ldap_user:=LINUX_LDAP_INFOS('get_ldap_user');

       if length(get_ldap_user)=0 then begin
           writeln('LDAP_GET_USERNAME::unable to give infos from get_ldap_user key in infos.conf');
           exit;
       end;

       if length(get_ldap_user_regex)=0 then begin
           writeln('LDAP_GET_USERNAME::unable to give infos from get_ldap_user_regex key in infos.conf');
           exit;
       end;

       if not FileExists(get_ldap_user) then begin
          writeln('LDAP_GET_USERNAME::There is a problem to stat ',get_ldap_user);
          exit;
       end;
      FileDatas:=TStringList.Create;
      RegExpr:=TRegExpr.Create;
      RegExpr.Expression:=get_ldap_user_regex;
      FileDatas.LoadFromFile(get_ldap_user);
      for i:=0 to FileDatas.Count-1 do begin
          if RegExpr.Exec(FileDatas.Strings[i]) then begin
             result:=RegExpr.Match[1];
             RegExpr.Free;
             FileDatas.free;
             exit;
          end;

      end;
end;



function myconf.LDAP_INITD():string;
begin
    if FileExists('/etc/init.d/slapd') then exit('/etc/init.d/slapd');
    if FileExists('/etc/init.d/ldap') then exit('/etc/init.d/ldap');

end;
//##############################################################################
function myconf.CROSSROADS_VERSION():string;
var
   RegExpr:TRegExpr;
   FileS:TstringList;
begin
    if not FileExists('/opt/artica/bin/crossroads') then exit;
    fpsystem('/opt/artica/bin/crossroads -V >/opt/artica/logs/crossroads.version.tmp');
    if not FileExists('/opt/artica/logs/crossroads.version.tmp') then exit;

    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='([0-9\.]+)';
    FileS:=TstringList.Create;
    FileS.LoadFromFile('/opt/artica/logs/crossroads.version.tmp');
    if RegExpr.Exec(FileS.Text) then result:=RegExpr.Match[1];
    RegExpr.Free;
    FileS.free;
end;
//##############################################################################
function myconf.IPTABLES_PATH():string;
begin
  if FileExists('/sbin/iptables') then exit('/sbin/iptables');
  if FileExists('/usr/sbin/iptables') then exit('/usr/sbin/iptables');
  if FileExists('/usr/local/sbin/iptables') then exit('/usr/local/sbin/iptables');
  if FileExists('/usr/local/bin/iptables') then exit('/usr/local/bin/iptables');
  if FileExists('/bin/iptables') then exit('/bin/iptables');
  exit(get_INFOS('iptables_path'));
end;
//##############################################################################
function myconf.IPTABLES_VERSION():string;
var
   RegExpr:TRegExpr;
   FileS:TstringList;
   i:integer;
begin
     if not FileExists(IPTABLES_PATH()) then exit;
     fpsystem(IPTABLES_PATH() + ' --version >/opt/artica/tmp/iptables.ver');
     if not FileExists('/opt/artica/tmp/ipatbles.ver') then exit;
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='v([0-9\.]+)';
     FileS:=TstringList.Create;
     try
     Files.LoadFromFile('/opt/artica/logs/ipatbles.ver');
     DeleteFile('/opt/artica/tmp/iptables.ver');
     For i:=0 to files.Count-1 do begin
         if RegExpr.Exec(FileS.Strings[i]) then begin
            result:=RegExpr.Match[1];
            RegExpr.free;
            files.free;
            exit;
         end;
     end;
     finally
     Files.Free;
     end;

end;
//##############################################################################
function MyConf.MYSQL_ARTICA_START_CMDLINE():string;
var
   cmd       :string;
   Port      :string;
   pidfile   :string;
   bindaddr  :string;
   datadir   :string;
begin


if not FileExists(SYS.LOCATE_mysqld_bin()) then begin
   logs.Debuglogs('MYSQL_ARTICA_START_CMDLINE:: MYSQL is not installed...');
   exit;
end;

  port    :=SYS.MYSQL_INFOS('port');
  bindaddr:=MYSQL_SERVER_PARAMETERS_CF('bind-address');
  pidfile :=MYSQL_SERVER_PARAMETERS_CF('pid-file');
  datadir :=MYSQL_SERVER_PARAMETERS_CF('datadir');


cmd:=SYS.LOCATE_mysqld_bin()+' --defaults-file=/opt/artica/mysql/etc/my.cnf --basedir=/opt/artica/mysql ';
cmd:=cmd + ' --datadir=' + datadir;
cmd:=cmd + ' --user=artica';
cmd:=cmd + ' --log-error=/opt/artica/logs/artica-sql/mysql.err';
cmd:=cmd + ' --pid-file=' +pidfile;
cmd:=cmd + ' --port=' + port + ' --bind-address=' + bindaddr + ' &';
result:=cmd;

end;
//##############################################################################
procedure MyConf.MYSQL_INIT_ERROR();
var
   RegExpr:TRegExpr;
   l:TstringList;
   i:integer;
begin
   if not FileExists('/opt/artica/logs/mysql.init') then exit;

   l:=TstringList.Create;
   l.LoadFromFile('/opt/artica/logs/mysql.init');
   RegExpr:=tRegExpr.Create;

   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='Too many connections';
       if RegExpr.Exec(l.Strings[i]) then begin
            set_INFOS('MysqlTooManyConnections','1');
            break;
       end;
   end;

  RegExpr.free;
  l.free;


end;




function myConf.OPENSSL_VERSION():string;
var
   openssl_path,str:string;
   RegExpr:TRegExpr;
   D:Boolean;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  openssl_path:=OPENSSL_TOOL_PATH();
  if FileExists(openssl_path) then exit('0.0');
  if D then writeln('OPENSSL_VERSION() -> '+ openssl_path);
  str:=trim(ExecPipe(openssl_path + ' version 2>&1'));
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='.+?([0-9\.]+)';
  if RegExpr.Exec(str) then result:=RegExpr.Match[1];
  RegExpr.Free;
  exit;


end;
//##############################################################################
function MyConf.LIB_GSL_VERSION():string;
begin
   IF NOT FILEeXISTS('/usr/local/bin/gsl-config') THEN EXIT('0.0');
   result:=trim(ExecPipe('/usr/local/bin/gsl-config --version 2>&1'));
end;
//##############################################################################
function Myconf.CURL_HTTPS_ENABLED():boolean;
var
   FileS:TstringList;
   i:integer;
begin
result:=false;
    if not FileExists('/opt/artica/bin/curl-config') then exit;
    forceDirectories('/opt/artica/logs');
    fpsystem('/opt/artica/bin/curl-config --protocols >/opt/artica/logs/curl-config.tmp');
    if not FileExists('/opt/artica/logs/curl-config.tmp') then exit;
    FileS:=TStringList.Create;
    FileS.LoadFromFile('/opt/artica/logs/curl-config.tmp');
    For i:=0 to FileS.Count-1 do begin
        if LowerCase(trim(FileS.Strings[i]))=LowerCase('HTTPS') then begin
            result:=true;
            break;
        end;
    end;

    FileS.FRee;

end;
//##############################################################################

function MyConf.SYSTEM_GET_PLATEFORM():string;
var
   line:string;
   RegExpr:TRegExpr;
begin
   fpsystem('/bin/uname -a >/opt/artica/logs/uname.tmp');
   line:=ReadFileIntoString('/opt/artica/logs/uname.tmp');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='\s+i([0-9]+)\s+GNU';
   if RegExpr.Exec(line) then result:=RegExpr.Match[1];
end;
//##############################################################################
PROCEDURE myconf.LDAP_DB_CONFIG();
var
 filedatas:        TstringList;
 logs:Tlogs;
begin
logs:=Tlogs.Create;
LOGS.logs('LDAP_DB_CONFIG:: START');
if DirectoryExists('/opt/artica/var/openldap-data') then begin
      if not FileExists('/opt/artica/var/openldap-data/DB_CONFIG') then begin
         filedatas:=TstringList.Create;
         logs.DebugLogs('Starting......: OpenLDAP creating /opt/artica/var/openldap-data/DB_CONFIG');
         filedatas.Add('set_cachesize 0 2097152 0');
         filedatas.Add('set_lg_regionmax 262144');
         filedatas.Add('set_lg_bsize 2097152');
         filedatas.SaveToFile('/opt/artica/var/openldap-data/DB_CONFIG');

      end;
   end;

if DirectoryExists('/usr/local/var/openldap-data') then begin
      if not FileExists('/usr/local/var/openldap-data/DB_CONFIG') then begin
         filedatas:=TstringList.Create;
         logs.DebugLogs('Starting......: OpenLDAP creating /usr/local/var/openldap-data/DB_CONFIG');
         filedatas.SaveToFile('/usr/local/var/openldap-data/DB_CONFIG');

      end;
   end;

   if DirectoryExists('/var/lib/ldap') then begin
      if not FileExists('/var/lib/ldap/DB_CONFIG') then begin
         filedatas:=TstringList.Create;
         logs.DebugLogs('Starting......: OpenLDAP creating /var/lib/ldap/DB_CONFIG');
         filedatas.SaveToFile('/var/lib/ldap/DB_CONFIG');

      end;
   end;
   LOGS.logs('LDAP_DB_CONFIG:: Finish');
end;
//##############################################################################
FUNCTION myconf.CROSSROADS_MASTERNAME():string;
var
   cross_ini:TIniFile;
begin
  if not FileExists('/etc/artica-postfix/crossroads.indentities.conf') then exit;
  cross_ini:=TIniFile.Create('/etc/artica-postfix/crossroads.indentities.conf');
  result:=cross_ini.ReadString('INFOS','master_name','');
  cross_ini.Free;
end;
//##############################################################################
FUNCTION myconf.CROSSROADS_POOLING_TIME():integer;
var
   cross_ini:TIniFile;
begin
  if not FileExists('/etc/artica-postfix/crossroads.indentities.conf') then exit(300);
  cross_ini:=TIniFile.Create('/etc/artica-postfix/crossroads.indentities.conf');
  result:=cross_ini.ReadInteger('INFOS','pol_time',300);
  cross_ini.Free;
end;
//##############################################################################
procedure myconf.SYSTEM_CHDIR(path:string);
begin
 ChDir (path);
 if IOresult<>0 then logs.Syslogs('Cannot change to directory : ' + path);
end;
//##############################################################################
function MyConf.SASLAUTHD_PATH_GET():string;
begin

    if FileExists('/etc/default/saslauthd') then result:='/etc/default/saslauthd';
    if FileExists('/etc/sysconfig/saslauthd') then  result:='/etc/sysconfig/saslauthd';
    if Debug then ShowScreen('SASLAUTHD_PATH_GET -> "' + result + '"');
end;
//##############################################################################
function MyConf.SASLAUTHD_VALUE_GET(key:string):string;
var Msaslauthd_path,mdatas:string;
   RegExpr:TRegExpr;
begin
Msaslauthd_path:=SASLAUTHD_PATH_GET();
    if length(Msaslauthd_path)=0 then begin
        if Debug then writeln('SASLAUTHD_VALUE_GET -> NULL!!!');
        exit;
    end;

     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:=key + '=[\s"]+([a-z\/]+)(?)';
     if Debug then writeln('SASLAUTHD_VALUE_GET -> Read ' + Msaslauthd_path);
     mdatas:=ReadFileIntoString(Msaslauthd_path);

     if RegExpr.Exec(mdatas) then begin
        result:=RegExpr.Match[1];
        if Debug then writeln('SASLAUTHD_VALUE_GET -> regex ' + result);
     end;
     RegExpr.Free;
end;
//##############################################################################
function myconf.SASLAUTHD_TEST_INITD():boolean;
var List:TStringList;
   RegExpr:TRegExpr;
   i:integer;
begin
   ShowScreen('SASLAUTHD_TEST_INITD:: Prevent false mechanism in init.d for saslauthd');
   if not fileExists('/etc/init.d/saslauthd') then begin
      showScreen('SASLAUTHD_TEST_INITD:: Error stat etc/init.d/saslauthd');
   end;
     List:=TStringList.Create;
     List.LoadFromFile('/etc/init.d/saslauthd');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='SASLAUTHD_AUTHMECH=([a-z]+)';
     for i:=0 to List.Count-1 do begin
          if RegExpr.Exec(list.Strings[i]) then begin
             showScreen('SASLAUTHD_TEST_INITD:: Read: "' + RegExpr.Match[1]+'"');
             if  RegExpr.Match[1]<>'ldap' then begin
                  showScreen('SASLAUTHD_TEST_INITD:: change to "ldap" mode');
                  list.Strings[i]:='SASLAUTHD_AUTHMECH=ldap';
                  list.SaveToFile('/etc/init.d/saslauthd');
                  showScreen('SASLAUTHD_TEST_INITD:: done..');
                  fpsystem('/etc/init.d/saslauthd restart');
                  list.Free;
                  RegExpr.free;
                  exit(true);
             end;
          end;

     end;
 showScreen('SASLAUTHD_TEST_INITD:: nothing to change...');
 list.Free;
 RegExpr.free;
 exit(true);
end;
//##############################################################################
function MyConf.BOA_SET_CONFIG();
var
   List:TstringList;
   LocalPort:integer;
   BoaLOGS:Tlogs;
   openldap:Topenldap;
   newal:string;
begin
result:=true;
LocalPort:=get_ARTICA_LOCAL_PORT();
BoaLOGS:=Tlogs.Create;
forcedirectories('/opt/artica/share/www');
forcedirectories('/opt/artica/share/www/squid/rrd');
forcedirectories('/opt/artica/share/www/squid/sarg');
List:=TstringList.Create;
BoaLOGS.logs('Writing httpd.conf for artica-postfix listener on ' + IntToStr(LocalPort) + ' port');
logs.DebugLogs('Starting......: Boa will listen on '+ IntToStr(LocalPort) + ' port');
if FileExists('/var/log/artica-postfix/boa_error.log') then logs.DeleteFile('/var/log/artica-postfix/boa_error.log');
if FileExists('/var/log/artica-postfix/boa_access_log') then logs.DeleteFile('/var/log/artica-postfix/boa_access_log');
if FileExists('/var/log/artica-postfix/boa_cgi_log') then logs.DeleteFile('/var/log/artica-postfix/boa_cgi_log');

List.Add('Port ' + IntToStr(LocalPort));
List.Add('Listen 127.0.0.1');
List.Add('User root');
List.Add('Group root');
List.Add('PidFile /etc/artica-postfix/boa.pid');
List.Add('ErrorLog /var/log/artica-postfix/boa_error.log');
List.Add('AccessLog /var/log/artica-postfix/boa_access_log');
List.Add('CGILog /var/log/artica-postfix/boa_cgi_log');
List.Add('DocumentRoot /opt/artica/share/www');
List.Add('DirectoryIndex index.html');
List.Add('#DirectoryMaker /usr/lib/boa/boa_indexer');
List.Add('KeepAliveMax 1000');
List.Add('KeepAliveTimeout 5');
List.Add('#MimeTypes /etc/mime.types');
List.Add('DefaultType text/plain');
List.Add('CGIPath /bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:/sbin:/bin:/usr/X11R6/bin');
List.Add('AddType application/x-executable cgi');
List.Add('ScriptAlias /cgi/ ' + get_ARTICA_PHP_PATH() + '/bin/');
List.Add('Alias /queue ' + ARTICA_FILTER_QUEUEPATH());
List.Add('Alias /images ' + get_ARTICA_PHP_PATH() + '/img/');
List.Add('Alias /css ' + get_ARTICA_PHP_PATH() + '/css/');
List.add('Alias /sarg /opt/artica/share/www/sarg/');
openldap:=Topenldap.Create;
newal:=logs.MD5FromString(openldap.ldap_settings.password+openldap.ldap_settings.suffix);
List.add('Alias /'+newal+' /');


list.SaveToFile('/etc/artica-postfix/httpd.conf');
list.Free;
BoaLOGS.free;
end;
//##############################################################################
function myconf.LDAP_SLAPADD_BIN_PATH():string;
begin
if FileExists('/usr/sbin/slapadd') then exit('/usr/sbin/slapadd');
if FileExists('/opt/artica/sbin/slapadd') then exit('/opt/artica/sbin/slapadd');
end;
//##############################################################################


procedure MyConf.LDAP_VERIFY_PASSWORD();
var artica_admin,artica_password,artica_suffix:string;
    change:boolean;
    tfile:Tstringlist;
    i:integer;
    logs:Tlogs;
    sasl:tsaslauthd;
begin
    change:=false;
    logs:=Tlogs.Create;

    artica_admin:=get_LDAP('admin');
    artica_password:=get_LDAP('password');
    artica_suffix:=get_LDAP('suffix');

    logs.DebugLogs('Starting......: LDAP ' + artica_admin + ':' + artica_password + '//' + artica_suffix);




    tfile:=TStringList.Create;
    tfile.Add('dn: '+artica_suffix);
    tfile.Add('objectClass: top');
    tfile.Add('objectClass: organization');
    tfile.Add('objectClass: dcObject');
    tfile.Add('o: my-domain');
    tfile.Add('dc: my-domain');
    tfile.SaveToFile('/opt/artica/logs/_init.ldif');
    tfile.Free;


    fpsystem(LDAP_SLAPADD_BIN_PATH() + '  -l /opt/artica/logs/_init.ldif >/opt/artica/logs/_init.ldif.resp 2>&1');

    if FileExists('/opt/artica/awstats/wwwroot/cgi-bin/awstats.pl') then begin
        forceDirectories('/opt/artica/etc/awstats');
        if not FileExists('/opt/artica/etc/awstats/awstats.mail.conf') then begin
            logs.DebugLogs('Starting......: reconfigure awstats');
            fpsystem(Paramstr(0) + ' -awstats-reconfigure');
            fpsystem(Paramstr(0) + ' -awstats generate');
        end;
    end;

    tfile:=TStringList.Create;
    if FileExists('/opt/artica/logs/_init.ldif.resp') then begin
       tfile.LoadFromFile('/opt/artica/logs/_init.ldif.resp');
       for i:=0 to tfile.Count-1 do begin
             if pos('DB_KEYEXIST',tfile.Strings[i])=0 then begin
                logs.DebugLogs('Starting......: LDAP '+ tfile.Strings[i]);
             end;
       end;
    end;
     logs.DebugLogs('Starting......: LDAP tests suffix ' + artica_suffix + ' ok');

     if fileexists('/usr/bin/newaliases') then begin
        fpsystem('/usr/bin/newaliases >/dev/null 2>&1');
        logs.DebugLogs('Starting......: newaliases OK');
     end;


     if FileExists('/opt/artica/cyrus/bin/reconstruct') then begin
        fpsystem('/opt/artica/cyrus/bin/reconstruct >/dev/null 2>&1');
        logs.DebugLogs('Starting......: reconstruct cyrus database ok');
     end;



     if FileExists('/opt/artica/db/lib/libdb-4.6.so') then begin
        if Not FileExists('/usr/local/lib/libdb-4.6.so') then begin
           fpsystem('/bin/ln -s /opt/artica/db/lib/libdb-4.6.so /usr/local/lib/libdb-4.6.so');
           logs.DebugLogs('Starting......: Linking /opt/artica/db/lib/libdb-4.6.so -> /usr/local/lib/libdb-4.6.so');
        end;
     end;

     if FileExists('/opt/artica/db/lib/libdb-4.6.so') then begin
        if Not FileExists('/lib/libdb-4.6.so') then begin
           fpsystem('/bin/ln -s /opt/artica/db/lib/libdb-4.6.so /lib/libdb-4.6.so');
           logs.DebugLogs('Starting......: Linking /opt/artica/db/lib/libdb-4.6.so -> /lib/libdb-4.6.so');
        end;

     end;

     if FileExists('/opt/artica/lib/libiconv.so.2.4.0') then begin
        if Not FileExists('/lib/libiconv.so.2') then begin
           fpsystem('/bin/ln -s --force /opt/artica/lib/libiconv.so.2.4.0 /lib/libiconv.so.2');
           logs.DebugLogs('Starting......: Linking /opt/artica/lib/libiconv.so.2.4.0 -> /lib/libiconv.so.2');
        end;

     end;
      PURE_FTPD_PREPARE_LDAP_CONFIG();


    if change=true then begin
       sasl:=tsaslauthd.Create(SYS);
       logs.DebugLogs('Starting......: ldap password as changed fix settings...');
       logs.DebugLogs('Starting......: Restart postfix, cyrus, saslauthd');
       POSTFIX_CONFIGURE_MAIN_CF();
       CCYRUS.WRITE_IMAPD_CONF();
       CCYRUS.SASLAUTHD_CONFIGURE();

       postfix.POSTFIX_STOP();
       CCYRUS.CYRUS_DAEMON_STOP();
       sasl.STOP();

       postfix.POSTFIX_STOP();
       postfix.POSTFIX_START();
       CCYRUS.CYRUS_DAEMON_START();
       sasl.START();
       sasl.Free;
    end;


end;
//##############################################################################
procedure MyConf.WATCHDOG_PURGE_BIGHTML();
var
   queue_path:string;
   Dirs      :TstringList;
   FileList  :TstringList;
   D         :boolean;
   i         :integer;
   mIni      :TiniFile;
   dayMax    :Integer;
begin

   D:=COMMANDLINE_PARAMETERS('debug');
   queue_path:=ARTICA_FILTER_QUEUEPATH() + '/bightml';

   Dirs:=TstringList.Create;
   Dirs.AddStrings(SYS.DirDirRecursive(queue_path));
   if D then writeln('WATCHDOG_PURGE_BIGHTML: ' + IntToStr(Dirs.Count) + ' folders');
   if Dirs.Count=0 then exit;
   FileList:=TStringlist.Create;
   for i:=0 to Dirs.Count-1 do begin
         if D then writeln('WATCHDOG_PURGE_BIGHTML: find conf files in ' + Dirs.Strings[i]+ ' dir');
         FileList.AddStrings(SYS.SearchFilesInPath(Dirs.Strings[i],'*.conf'));

   end;
   if D then writeln('WATCHDOG_PURGE_BIGHTML: ' + IntToStr(FileList.Count) + ' files');
   if FileList.Count=0 then exit;

    for i:=0 to FileList.Count-1 do begin
         if D then writeln('WATCHDOG_PURGE_BIGHTML: ' + FileList.Strings[i]);
         mIni:=TiniFile.Create(FileList.Strings[i]);

         dayMax:=mIni.ReadInteger('GENERAL','maxday',2);
         if SYSTEM_FILE_DAYS_BETWEEN_NOW(FileList.Strings[i])>dayMax then begin
            logs.logs('WATCHDOG_PURGE_BIGHTML:: Delete ' + ExtractFilePath(FileList.Strings[i]));
            fpsystem('/bin/rm -rf ' + ExtractFilePath(FileList.Strings[i]));
         end;

    end;
end;
//##############################################################################
function MyConf.SYSTEM_START_ARTICA_DAEMON():boolean;
var
   Rootpath:string;
   knel:integer;
   kernel_version:string;
   l:TstringList;
   xfce:Txfce;
   pidof_path:string;
   emailrelay:Temailrelay;
begin
     forcedirectories('/etc/artica-postfix');
     logs:=Tlogs.Create;


     if not FileExists('/etc/artica-postfix/first.boot') then begin
         l:=TstringList.Create;
         l.Add('xxx');
         l.SaveToFile('/etc/artica-postfix/first.boot');
         l.free;
         fpsystem(paramStr(0) + ' --init-from-repos');
         halt(0);
     end;


     kernel_version:=trim(SYSTEM_KERNEL_VERSION());
     kernel_version:=Copy(kernel_version,0,3);
     result:=true;
     knel:=StrToInt(AnsiReplaceStr(kernel_version,'.',''));
     if knel<26 then begin
        writeln('Your kernel version '+ kernel_version + ' is not supported');
        writeln('You need to upgrade your system to the newest version (>=2.6)');
        writeln('aborting...');
        halt(0);
     end;

     writeln('Starting......: Artica version '+trim(SYS.ARTICA_VERSION()));
     writeln('Starting......: Kernel version ' + kernel_version);
     writeln('Starting......: Distribution "' + LINUX_DISTRIBUTION() + '" i' + SYSTEM_GET_PLATEFORM());


    if not FileExists('/bin/pidof') then begin
       pidof_path:=SYS.LOCATE_GENERIC_BIN('pidof');
       if FileExists(pidof_path) then logs.OutputCmd('/bin/ln -s '+pidof_path+' /bin/pidof');
    end;

    if not FileExists('/etc/artica-postfix/settings/Daemons/SystemV5CacheEnabled') then SYS.set_INFO('SystemV5CacheEnabled','0');

    SYSTEM_VERIFY_ISO();


    if FileExists('/etc/init.d/keymap.sh') then begin
       writeln('Starting......: run /etc/init.d/keymap.sh');
       fpsystem('/etc/init.d/keymap.sh start');
    end else begin
       writeln('Starting......: unable to stat /etc/init.d/keymap.sh');
    end;


     if FileExists('/opt/artica/license.expired.conf') then DeleteFile('/opt/artica/license.expired.conf');




    if SYS.PROCESS_EXIST(SYS.PIDOF('artica-backup')) then begin
          logs.Syslogs('A backup process is currently in execution, stop process');
          fpsystem(get_ARTICA_PHP_PATH()+'/bin/process1');
    end;

    if SYS.PROCESS_EXIST(SYS.PIDOF('artica-update')) then begin
          logs.Syslogs('An update process is currently in execution, stop process');
          fpsystem(get_ARTICA_PHP_PATH()+'/bin/process1');
    end;


     ldap.LDAP_START();
     Rootpath:=get_ARTICA_PHP_PATH();

     ForceDirectories('/usr/share/artica-postfix/ressources/profiles');
     ForceDirectories('/var/log/artica-postfix/RTM');
     logs.OutputCmd('/bin/chmod 777 /usr/share/artica-postfix/ressources/profiles');
     logs.OutputCmd('/bin/chmod 777 /tmp');

     artica_cron:=tcron.Create(SYS);
     artica_cron.START();
     artica_cron.free;


     SYSLOGER_START();
     START_MYSQL();
     APACHE_ARTICA_START();
     BOA_START();

     emailrelay:=Temailrelay.CReate(SYS);
     emailrelay.START();
     emailrelay.free;


     logs.OutputCmd(Rootpath + '/bin/artica-ldap -iptables --start');
     fpsystem(SYS.LOCATE_PHP5_BIN() + ' ' + Rootpath+'/exec.ldap.rebuild.php >/dev/null 2>&1');


     ForceDirectories('/usr/share/artica-postfix/ressources/sessions/SessionData');
     ForceDirectories('/var/lib/php5');
     logs.OutputCmd('/bin/chmod 755 /var/lib/php5');
     logs.OutputCmd('/bin/chmod 755 /usr/share/artica-postfix/ressources/sessions/SessionData');

     xfce:=Txfce.Create;
     xfce.INSTALL_XFCE();
     xfce.Free;

     INSTANT_SEARCH();
     SYSTEM_CHANGE_MOTD();




end;
//##############################################################################
procedure myconf.SYSTEM_VERIFY_ISO();
begin

       if FileExists('/home/artica/packages/ZARAFA/zarafa.tar') then begin
          fpsystem('/bin/tar -xvf /home/artica/packages/ZARAFA/zarafa.tar -C /');
          fpsystem('/bin/rm /home/artica/packages/ZARAFA/zarafa.tar');
          fpsystem('/etc/init.d/artica-postfix restart mysql');
       end;

       if FileExists('/home/artica/packages/SQUID/SQUID.tar.gz') then begin
          fpsystem('/bin/tar -xvf /home/artica/packages/SQUID/SQUID.tar.gz -C /');
          fpsystem('/bin/rm /home/artica/packages/SQUID/SQUID.tar.gz');
          fpsystem('/etc/init.d/artica-postfix restart squid');
          fpsystem('/etc/init.d/artica-postfix restart squid');
          fpsystem('/usr/share/artica-postfix/bin/process1 --force');
       end;

       if FileExists('/home/artica/packages/kav4proxy-5.5-62.tar.gz') then begin
          fpsystem('/usr/share/artica-postfix/bin/artica-make APP_KAV4PROXY');
       end;

       if FileExists('/etc/artica-postfix/FROM_ISO') then begin
          writeln('Starting......: Artica was installed from ISO');
          if not FileExists('/bin/login.old') then begin
               writeln('Starting......: Change login binary');
               fpsystem('/bin/mv /bin/login /bin/login.old');
               fpsystem('/bin/ln -s /usr/share/artica-postfix/bin/artica-logon /bin/login');
               fpsystem('/bin/chmod 777 /usr/share/artica-postfix/bin/artica-logon');
               fpsystem('dpkg-divert --divert /bin/login.old /bin/login');
          end else begin
             writeln('Starting......: /bin/login.old exists');
          end;
          GETTY_CHANGE_INITTAB();
       end;


end;



procedure MyConf.START_ALL_DAEMONS();
var
   Rootpath:string;
   knel:integer;
   kernel_version:string;
   spfm:tspf;
   syslogng:Tsyslogng;
   stunnel:tstunnel;
   kavmilter:tkavmilter;
   kas3:Tkas3;
   bogom:tbogom;
   saslauthd:tsaslauthd;
   collectd:tcollectd;
   mailspy:tmailspy;
   retranslator:tkretranslator;
   dotclear:tdotclear;
   jcheckmail:tjcheckmail;
   dhcp3:tdhcp3;
   cups:tcups;
   zsmartd:Tsmartd;
   opengoo:topengoo;
   dstat:tdstat;
   rscync:trsync;
   openvpn:topenvpn;
   NetWorkAvailable:boolean;
   NoBootWithoutIP:integer;
   policydw:tpolicyd_weight;
   autofs:tautofs;
   nfs:tnfs;
   assp:tassp;
   pdns:tpdns;
   gluster:tgluster;
   zabbix:tzabbix;
   mldonkey:tmldonkey;
   backuppc:tbackuppc;
begin
     logs:=Tlogs.Create;
     spfm:=tspf.Create;
     NoBootWithoutIP:=0;
     if not TryStrToInt(SYS.GET_PERFS('NoBootWithoutIP'),NoBootWithoutIP) then NoBootWithoutIP:=0;


     kernel_version:=trim(SYSTEM_KERNEL_VERSION());
     kernel_version:=Copy(kernel_version,0,3);

     fpsystem(SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.virtuals-ip.php --just-add &');
     tcpip:=ttcpip.Create;
     NetWorkAvailable:=tcpip.isNetAvailable;
     if NoBootWithoutIP=0 then NetWorkAvailable:=true;



     logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: kernel version is '+kernel_version);
     knel:=StrToInt(AnsiReplaceStr(kernel_version,'.',''));
     if knel<26 then begin
        writeln('Your kernel version '+ kernel_version + ' is not supported');
        writeln('You need to upgrade your system to the newest version (>=2.6)');
        writeln('aborting...');
        halt(0);
     end;


     fpsystem('/etc/init.d/artica-postfix start wifi');

    
    logs.Debuglogs('############ gluster ##################');
    try
    gluster:=tgluster.Create(SYS);
    gluster.START();
    gluster.free;
    except
      logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: fatal error on gluster');
    end;



    if SYS.PROCESS_EXIST(SYS.PIDOF('artica-backup')) then begin
          logs.Syslogs('A backup process is currently in execution, stop process');
          fpsystem(get_ARTICA_PHP_PATH()+'/bin/process1');
    end;

    if SYS.PROCESS_EXIST(SYS.PIDOF('artica-update')) then begin
          logs.Syslogs('An update process is currently in execution, stop process');
          fpsystem(get_ARTICA_PHP_PATH()+'/bin/process1');
    end;

    if not SYS.PROCESS_EXIST(SYS.PIDOF('cron')) then begin
           if fileExists('/etc/init.d/ssh') then fpsystem('/etc/init.d/ssh start');
           if fileExists('/etc/init.d/sshd') then fpsystem('/etc/init.d/sshd start');
           if fileExists('/etc/init.d/cron') then fpsystem('/etc/init.d/cron start');
    END;

    logs.Debuglogs('############ autofs ##################');
    autofs:=tautofs.Create(SYS);
    autofs.START();
    autofs.free;

    mldonkey:=tmldonkey.CReate(SYS);
    mldonkey.START();
    mldonkey.free;

    backuppc:=tbackuppc.CReate(SYS);
    backuppc.START();
    backuppc.free;



    if NetWorkAvailable then begin
       logs.Debuglogs('############ nfs ##################');
       nfs:=tnfs.Create(SYS);
       nfs.START();
       nfs.free;
    end;


    logs.Debuglogs('############ Gayteway mode ##################');
    ARTICA_HAS_GAYTEWAY();
    logs.Debuglogs('############ apache groupware ##################');
      opengoo:=topengoo.Create(SYS);
      opengoo.START();
      opengoo.free;

     logs.Debuglogs('############ syslogng ##################');
     //Syslog-ng
     syslogng:=Tsyslogng.Create(SYS);
     syslogng.START();
     syslogng.Free;


     if NetWorkAvailable then begin
        logs.Debuglogs('############ dhcp ##################');
        dhcp3:=tdhcp3.Create(SYS);
        dhcp3.START();
        dhcp3.free;

        logs.Debuglogs('############ smartd ##################');
        zsmartd:=Tsmartd.Create(SYS);
        zsmartd.START();
        zsmartd.Free;

        logs.Debuglogs('############ dstat ##################');
        dstat:=Tdstat.Create(SYS);
        dstat.START();
        dstat.START_TOP_MEMORY();
        dstat.START_TOP_CPU();
        dstat.Free;

        logs.Debuglogs('############ rsyncd ##################');
        rscync:=Trsync.Create(SYS);
        rscync.START();
        rscync.Free;

        logs.Debuglogs('############ OpenVPN ##################');
        openvpn:=topenvpn.Create(SYS);
        openvpn.START();
        openvpn.Free;


     end else begin
         writeln('Starting......: No network currently available');
     end;



    if FileExists('/etc/cron.d/artica-update') then logs.DeleteFile('/etc/cron.d/artica-update');
    if FileExists('/etc/cron.d/artica.artica-update.scheduled') then logs.DeleteFile('/etc/cron.d/artica.artica-update.scheduled');

    if COMMANDLINE_PARAMETERS('--force') then begin
        SYSTEM_START_ARTICA_DAEMON();

    end;


    if not NetWorkAvailable then begin
       writeln('Starting......: No network currently available');
       exit;
    end;


     if FileExists('/opt/artica/license.expired.conf') then DeleteFile('/opt/artica/license.expired.conf');


     PERL_CREATE_DEFAULT_SCRIPTS();
     Rootpath:=get_ARTICA_PHP_PATH();
     logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: Rootpath='+ Rootpath);

     ForceDirectories('/opt/artica/etc/lire/converters');
     forcedirectories('/opt/artica/var/rrd/yorel');
     logs.OutputCmd('/bin/chmod -R 755 /opt/artica/var/rrd/yorel');
     logs.OutputCmd('/bin/chmod -R 0640 /etc/cron.d/');

     ln(Rootpath+'/bin/install/rrd/andalemono','/opt/artica/var/rrd/yorel/andalemono');


     if not FileExists('/etc/aliases') then begin
        if FileExists('/usr/bin/newaliases') then begin
            logs.DebugLogs('Starting......: create /etc/aliases file...');
            logs.OutputCmd('/bin/touch /etc/aliases');
            logs.OutputCmd('/usr/bin/newaliases');
        end;
     end;


     logs.Debuglogs('############ RRDTOOL_FIX ##################');
     RRDTOOL_FIX();
     SYSTEM_VERIFY_CRON_TASKS();

     if NetWorkAvailable then begin
        logs.Debuglogs('############ roundcube ##################');
        roundcube.START();
     end;
     YOREL_VERIFY_START();


     //saslauthd
     logs.Debuglogs('############ saslauthd ##################');
     saslauthd:=tsaslauthd.Create(SYS);
     saslauthd.START();
     saslauthd.Free;



     //dotclear
     logs.Debuglogs('############ dotclear ##################');
     dotclear:=tdotclear.CReate(SYS);
     dotclear.START();

     //collectd
     logs.Debuglogs('############ collectd ##################');
     collectd:=tcollectd.Create(SYS);
     collectd.START();


     logs.Debuglogs('############ clamav ##################');
     clamav.FRESHCLAM_START();
     clamav.CLAMD_START();


 if NetWorkAvailable then begin
     if FileExists(postfix.POSFTIX_POSTCONF_PATH()) then begin
        if FileExists('/etc/init.d/sendmail') then fpsystem('/etc/init.d/sendmail stop');
        logs.Debuglogs('Postfix exists... start and verify all daemons');
        if length(SYS.GET_INFO('HtmlsizeQueue'))=0 then SYS.set_INFO('HtmlsizeQueue','/var/spool/artica/htmlsize');
        if length(SYS.GET_INFO('CompressQueue'))=0 then SYS.set_INFO('CompressQueue','/var/spool/artica/compress');

        ForceDirectories(SYS.GET_INFO('HtmlsizeQueue'));
        ForceDirectories(SYS.GET_INFO('CompressQueue'));
        fpsystem('/bin/chmod -R 755 '+SYS.GET_INFO('HtmlsizeQueue')+' && /bin/chown -R postfix:postfix '+SYS.GET_INFO('HtmlsizeQueue'));
        fpsystem('/bin/chmod -R 755 '+SYS.GET_INFO('CompressQueue')+' && /bin/chown -R postfix:postfix '+SYS.GET_INFO('CompressQueue'));


        logs.Debuglogs('############ MYSQMAIL ##################');
        postfix.MYSQMAIL_START();

        logs.Debuglogs('############ policyd-weight ##################');
        policydw:=tpolicyd_weight.Create(SYS);
        policydw.START();
        policydw.Free;

        //assp
        logs.Debuglogs('############ ASSP ##################');
        assp:=Tassp.CReate(SYS);
        assp.START();
        assp.free;


        logs.Debuglogs('############ postfix ##################');
        postfix.POSTFIX_START();

        //cyrus
        logs.Debuglogs('############ CCYRUS ##################');
        CCYRUS:=TCYRUS.Create(SYS);
        CCYRUS.CYRUS_DAEMON_START();
        CCYRUS.Free;

        //clamav
        logs.Debuglogs('############ MILTER_START ##################');
        clamav.MILTER_START();
        logs.Debuglogs('############ spamass ##################');
        SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix start spamd');

        // Spamassassin-milter
        logs.Debuglogs('############ spamass MILTER_START ##################');
        SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix start spamd');

        logs.Debuglogs('############ SPFMILTER_START ##################');
        spfm.SPFMILTER_START();

        logs.Debuglogs('############ spamass MIMEDEFANG ##################');
        mimedef.MIMEDEFANG_START();

        //DKIM
        logs.Debuglogs('############ dkim ##################');
        dkim.DKIM_FILTER_START();

        //milter-bogom
        bogom:=tbogom.Create(SYS);
        bogom.START();
        bogom.Free;

        //mailspy
        mailspy:=tmailspy.Create(SYS);
        mailspy.START();
        mailspy.free;


        //stunnel
        stunnel:=Tstunnel.Create(SYS);
        stunnel.STUNNEL_START();
        stunnel.Free;

        //mailarchive
        mailarchive:=Tmailarchive.Create(SYS);
        mailarchive.START();
        mailarchive.free;

        //kavMilter
        kavmilter:=Tkavmilter.Create(SYS);
        kavmilter.START();

        //kaspersky AS
        kas3:=tkas3.Create(SYS);
        kas3.START();
        kas3.free;

        //miltergreylist
        miltergreylist.MILTER_GREYLIST_START();

        //amavis
        SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix start amavis');


        //jCheckmail
        jcheckmail:=tjcheckmail.Create(SYS);
        jcheckmail.START();
        jcheckmail.Free;

        //mailman
        mailman:=tmailman.Create(SYS);
        mailman.START();
        mailman.Free;

        //mailgraph
        logs.Debuglogs('############ mailgraph ##################');
        mailgraph.MAILGRAPH_START();
        logs.Debuglogs('############ ROUNDCUBE_START_SERVICE ##################');
        roundcube.ROUNDCUBE_START_SERVICE();
        roundcube.START();
        obm.SERVICE_START();
        logs.Debuglogs('############ Fetchmail ##################');
        fetchmail.FETCHMAIL_LOGGER_START();
        fetchmail.FETCHMAIL_START_DAEMON();

    end;
end;
     if FileExists(samba.SMBD_PATH()) then begin
     logs.Debuglogs('############ SAMBA ##################');
        samba.SAMBA_START();
        samba.WINBIND_START();
        cups:=tcups.Create;
        cups.START();
        cups.free;
        kav4samba.SERVICE_START();
     end;


     if FileExists(squid.SQUID_BIN_PATH()) then begin
          logs.Debuglogs('############ SQUID ##################');
          squid.SQUID_START();
          kav4proxy.KAV4PROXY_START();
          dansguardian.C_ICAP_START();
          dansguardian.DANSGUARDIAN_START();
          if FileExists(dansguardian.BIN_PATH()) then dansguardian.DANSGUARDIAN_TAIL_START();
          squid.PROXY_PAC_START();
     end;

     logs.Debuglogs('############ ntpd ##################');
     ntpd.NTPD_START();

     logs.Debuglogs('############ APACHE_ARTICA_START ##################');
     APACHE_ARTICA_START();

     logs.Debuglogs('############ ARTICA_FILTER_CHECK_PERMISSIONS ##################');
     ARTICA_FILTER_CHECK_PERMISSIONS();

     logs.Debuglogs('############ HOTWAYD_START ##################');
     HOTWAYD_START();

     logs.Debuglogs('############ dnsmasq ##################');
     dnsmasq:=Tdnsmasq.Create(SYS);
     dnsmasq.DNSMASQ_START_DAEMON();
     dnsmasq.Free;

     logs.Debuglogs('############ artica-ldap -inadyn ##################');
     SYS.THREAD_COMMAND_SET(get_ARTICA_PHP_PATH() + '/bin/artica-ldap -inadyn');
     logs.Debuglogs('############ PURE_FTPD_START ##################');
     Cpureftpd.PURE_FTPD_START();

     logs.Debuglogs('############ PDNS ##################');
     pdns:=tpdns.Create(SYS);
     try
        pdns.START();
     except
        logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: fatal error on pdns');
     end;
     pdns.Free;

     logs.Debuglogs('############ awstats ##################');
     awstats.START_SERVICE();

     logs.Debuglogs('############ bind9 ##################');
     bind9.START();

     logs.Debuglogs('############ retranslator ##################');
     retranslator:=tkretranslator.Create(SYS);
     retranslator.START();

     logs.Debuglogs('############ PHP ##################');
     SYS.THREAD_COMMAND_SET(SYS.LOCATE_PHP5_BIN()+ ' /usr/share/artica-postfix/cron.mysql-databases.php');
     SYS.THREAD_COMMAND_SET(SYS.LOCATE_PHP5_BIN()+ ' /usr/share/artica-postfix/exec.homeDirectoryBinded.php');
     SYS.THREAD_COMMAND_SET(SYS.LOCATE_PHP5_BIN()+ ' /usr/share/artica-postfix/exec.first.settings.php');


    if NetWorkAvailable then begin
       if not SYS.isoverloadedTooMuch() then begin
          logs.Debuglogs('############ Zabbix ##################');
          try
             zabbix:=tzabbix.Create(SYS);
             zabbix.START();
             zabbix.free;
          except
                logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: fatal error on Zabbix');
          end;
       end;
    end;


 if NetWorkAvailable then fpsystem(Paramstr(0) +' --status >/dev/null 2>&1 &');
  logs.Debuglogs('SYSTEM_START_ARTICA_ALL_DAEMON:: finish');


     if FileExists('/etc/artica-postfix/FROM_ISO') then begin
        if Not Fileexists('/etc/artica-postfix/rebooted.start') then begin
           logs.OutputCmd('touch /etc/artica-postfix/rebooted.start');
           logs.OutputCmd('/sbin/shutdown -r now');
        end;
     end;




end;
//##############################################################################
procedure myconf.START_MYSQL();
var
zmysql:tmysql_daemon;
begin
    logs.Debuglogs('############ mysql ##################');
        //Mysql:
      zmysql:=tmysql_daemon.Create(SYS);
      try
         zmysql.SERVICE_START();
      except
         logs.Syslogs('FATAL ERROR WHILE EXEC zmysql.SERVICE_START();');
      end;


      try
      zmysql.CLUSTER_MANAGEMENT_START();
      except
         logs.Syslogs('FATAL ERROR WHILE EXEC zmysql.CLUSTER_MANAGEMENT_START();');
      end;

      try
      zmysql.CLUSTER_REPLICA_START();
       except
         logs.Syslogs('FATAL ERROR WHILE EXEC zmysql.CLUSTER_REPLICA_START();');
      end;
      try
      zmysql.Free;
      except
        logs.Syslogs('FATAL ERROR WHILE EXEC zmysql.Free;');
      end;


end;


procedure myconf.BOA_TESTS_INIT_D();
var
l:TstringList;
begin

if fileExists('/etc/init.d/artica-boa') then exit;
l:=TstringList.Create;
l.Add('#!/bin/sh');
l.Add('#Begin /etc/init.d/artica-postfix');

 if fileExists('/sbin/chkconfig') then begin
    l.Add('# chkconfig: 2345 11 89');
    l.Add('# description: Artica-postfix boa Daemon');
 end;


l.Add('case "$1" in');
l.Add(' start)');
l.Add('    /usr/share/artica-postfix/bin/artica-install -watchdog boa $2 $3');
l.Add('    ;;');
l.Add('');
l.Add('  stop)');
l.Add('    /usr/share/artica-postfix/bin/artica-install -shutdown boa $2 $3');
l.Add('    ;;');
l.Add('');
l.Add(' restart)');
l.Add('     /usr/share/artica-postfix/bin/artica-install -watchdog boa $2 $3');
l.Add('     sleep 3');
l.Add('     /usr/share/artica-postfix/bin/artica-install -shutdown boa $2 $3');
l.Add('    ;;');
l.Add('');
l.Add('  *)');
l.Add('    echo "Usage: $0 {start|stop|restart}  (+ ''debug'' for more infos)"');
l.Add('    exit 1');
l.Add('    ;;');
l.Add('esac');
l.Add('exit 0');
l.SaveToFile('/etc/init.d/artica-boa');
l.Free;

 fpsystem('/bin/chmod +x /etc/init.d/artica-boa >/dev/null 2>&1');

 if FileExists('/usr/sbin/update-rc.d') then begin
    fpsystem('/usr/sbin/update-rc.d -f artica-boa defaults >/dev/null 2>&1');
 end;

  if FileExists('/sbin/chkconfig') then begin
     fpsystem('/sbin/chkconfig --add artica-boa >/dev/null 2>&1');
     fpsystem('/sbin/chkconfig --level 2345 artica-boa on >/dev/null 2>&1');
  end;

   LOGS.Debuglogs('Starting......: BOA install init.d scripts........:OK (/etc/init.d/artica-boa {start,stop,restart})');


end;



procedure myconf.BOA_STOP();
var
   count:integer;
   RootPath:string;
   pids:string;
 begin
 count:=0;

 if FileExists('/usr/sbin/boa') then RootPath:='/usr/sbin/boa';
 if length(Rootpath)=0 then Rootpath:=get_ARTICA_PHP_PATH()+'/bin/boa';

 if SYSTEM_PROCESS_EXIST(BOA_DAEMON_GET_PID()) then begin
        writeln('Stopping BOA.................: ' + BOA_DAEMON_GET_PID() + ' PID..');
        fpsystem('/bin/kill '+BOA_DAEMON_GET_PID());

        while SYSTEM_PROCESS_EXIST(BOA_DAEMON_GET_PID()) do begin
              sleep(100);
              inc(count);
              if count>20 then begin
                 fpsystem('/bin/kill -9 ' + BOA_DAEMON_GET_PID());
                 break;
              end;
        end;
        if SYSTEM_PROCESS_EXIST(BOA_DAEMON_GET_PID()) then begin
           writeln('Stopping BOA.................: Failed to stop PID ' + BOA_DAEMON_GET_PID());
        end;
  end else begin

     pids:=SYS.PidAllByProcessPath(Rootpath);
     if length(pids)>0 then begin
         writeln('Stopping BOA.................: '+pids);
         fpsystem('/bin/kill ' + pids);
         exit;
     end;

     writeln('Stopping BOA.................: Already stopped');
  end;


end;
//##############################################################################
procedure myconf.APACHE_ARTICA_STOP();
 var
    ApacheEnabled:integer;
    apache_artica:tapache_artica;
    framework:tframework;
begin
     ApacheEnabled:=0;
     if not TryStrToInt(APACHE_ARTICA_ENABLED(),ApacheEnabled) then ApacheEnabled:=0;

     framework:=Tframework.CReate(SYS);
     framework.STOP();
     lighttpd.LIGHTTPD_STOP();
     apache_artica:=tapache_artica.Create(SYS);
     apache_artica.STOP();
end;
//##############################################################################
function myconf.APACHE_ARTICA_ENABLED():string;
begin
if not FileExists(SYS.LOCATE_APACHE_BIN_PATH()) then exit('0');
if not FileExists(SYS.LOCATE_APACHE_LIBPHP5()) then exit('0');
if not FileExists(SYS.LOCATE_APACHE_MODSSLSO()) then exit('0');
if not FileExists(lighttpd.LIGHTTPD_BIN_PATH()) then exit('1');
result:=SYS.GET_INFO('ApacheArticaEnabled');
end;
//##############################################################################
procedure myconf.APACHE_ARTICA_START();
 var
    ApacheEnabled:integer;
    framework:tframework;
    zphpldapadmin:tphpldapadmin;
begin
     ApacheEnabled:=0;
  if not TryStrToInt(APACHE_ARTICA_ENABLED(),ApacheEnabled) then ApacheEnabled:=0;
   ForceDirectories('/usr/share/artica-postfix/ressources/sessions');
   fpsystem('/bin/chmod 755 /usr/share/artica-postfix/ressources/sessions');

  try
     zphpldapadmin:=Tphpldapadmin.Create(SYS);
     zphpldapadmin.CONFIG();
  finally

  end;


  Try
   framework:=Tframework.Create(SYS);
   framework.START();
   framework.free;
  except
    logs.Debuglogs('APACHE_ARTICA_START:: Error while loading framework function');
  end;


  logs.Debuglogs('Starting Apache..............: Apache bin: '+SYS.LOCATE_APACHE_BIN_PATH());
  logs.Debuglogs('Starting Apache..............: LibPhp5...: '+SYS.LOCATE_APACHE_LIBPHP5());
  logs.Debuglogs('Starting Apache..............: ModSSL....: '+SYS.LOCATE_APACHE_MODSSLSO());
  logs.Debuglogs('Starting Apache..............: lighttpd..: '+lighttpd.LIGHTTPD_BIN_PATH());


     if ApacheEnabled=0 then begin
        logs.Debuglogs('APACHE_ARTICA_START::ApacheEnabled=0 -> lighttpd.LIGHTTPD_START();');
        lighttpd.LIGHTTPD_START();
        logs.Debuglogs('APACHE_ARTICA_START::End...');
        exit;
     end;

     logs.Debuglogs('APACHE_ARTICA_START::ApacheEnabled=1 -> lighttpd.LIGHTTPD_STOP();');
     lighttpd.LIGHTTPD_STOP();
     apache_artica:=tapache_artica.CReate(SYS);
     logs.Debuglogs('APACHE_ARTICA_START::ApacheEnabled=1 -> apache_artica.START();');
     apache_artica.START();
     logs.Debuglogs('APACHE_ARTICA_START::End...');



end;
//##############################################################################







procedure myconf.OBM_SYNCHRO();
var
  logs:Tlogs;
  ini:TiniFile;
  l:TstringList;
  update:boolean;
  i:integer;
  path:string;
begin
if Get_INFOS('OBMEnabled')<>'1' then exit;
if not DirectoryExists('/usr/share/obm') then exit;
if not DirectoryExists('/opt/artica/mysql/mysql-data/obm') then exit;
ini:=TiniFile.Create('/etc/artica-postfix/obm.sync.conf');
logs:=Tlogs.Create;
l:=TstringList.Create;
l.Add('UserObm.MYD');
l.Add('UGroup.MYD');
l.Add('Domain.MYD');

update:=false;
   for i:=0 to l.Count-1 do begin
        path:='/opt/artica/mysql/mysql-data/obm/' + l.Strings[i];
        if ini.ReadInteger('OBM',l.Strings[i],0)<>logs.GetFileBytes(path) then begin
           logs.logs('OBM_SYNCHRO:: ' + l.Strings[i] + ' as moved' );
           ini.WriteInteger('OBM',l.Strings[i],logs.GetFileBytes(path));
           update:=true;
        end;

   end;

   if update then begin
      fpsystem('/opt/artica/bin/php ' + get_ARTICA_PHP_PATH() + '/cron.obm.synchro.php >/opt/artica/logs/cron.obm.synchro.php.tmp 2>&1');
      logs.mysql_logs('5','1',ReadFileIntoString('/opt/artica/logs/cron.obm.synchro.php.tmp'));
      DeleteFile('/opt/artica/logs/cron.obm.synchro.php.tmp');
      fpsystem(get_ARTICA_PHP_PATH() + '/bin/artica-ldap -mailboxes');
   end;
end;
//##############################################################################

function myconf.BACKUP_MYSQL():string;
begin
result:='';
fpsystem(get_ARTICA_PHP_PATH()+'/bin/artica-backup --backup &');
end;
//##############################################################################
function myconf.mysqldump_path():string;
begin
    if FileExists('/usr/bin/mysqldump') then exit('/usr/bin/mysqldump');
    if FileExists('/opt/artica/mysql/bin/mysqldump') then exit('/opt/artica/mysql/bin/mysqldump');
end;
//##############################################################################

function myconf.TEMP_DATE():string;
var
   txt:string;
   J:TstringList;
begin

fpsystem('date +%Y-%m-%H-%M >/opt/artica/logs/date.txt');
J:=TStringList.Create;
J.LoadFromFile('/opt/artica/logs/date.txt');
DeleteFile('/opt/artica/logs/date.txt');
txt:=trim(J.Strings[0]);
result:=txt;

end;
//##############################################################################
function myconf.TEMP_SEC():string;
var
   txt:string;
   J:TstringList;
begin

fpsystem('date +%s >/opt/artica/logs/date.txt');
J:=TStringList.Create;
J.LoadFromFile('/opt/artica/logs/date.txt');
DeleteFile('/opt/artica/logs/date.txt');
txt:=trim(J.Strings[0]);
result:=txt;

end;
//##############################################################################
function myconf.SASLPASSWD_PATH():string;
begin
  if FileExists('/opt/artica/bin/saslpasswd2') then exit('/opt/artica/bin/saslpasswd2');
  if FileExists('/usr/sbin/saslpasswd2') then exit('/usr/sbin/saslpasswd2');
end;
//##############################################################################
function myconf.ROUNDCUBE_DEFAULT_CONFIG():string;
var
   l:TstringList;
begin
l:=TStringList.Create;
l.Add('<?php');
l.Add('$rcmail_config = array();');
l.Add('$rcmail_config["debug_level"] = 1;');
l.Add('$rcmail_config["enable_caching"] = TRUE;');
l.Add('$rcmail_config["message_cache_lifetime"] = "10d";');
l.Add('$rcmail_config["auto_create_user"] = TRUE;');
l.Add('$rcmail_config["default_host"] = "127.0.0.1";');
l.Add('$rcmail_config["default_port"] = 143;');
l.Add('$rcmail_config["username_domain"] = "";');
l.Add('$rcmail_config["mail_domain"] = "";');
l.Add('$rcmail_config["virtuser_file"] = "";');
l.Add('$rcmail_config["virtuser_query"] = "";');
l.Add('$rcmail_config["smtp_server"] = "127.0.0.1";');
l.Add('$rcmail_config["smtp_port"] = 25;');
l.Add('$rcmail_config["smtp_user"] = "";');
l.Add('$rcmail_config["smtp_pass"] = "";');
l.Add('$rcmail_config["smtp_auth_type"] = "";');
l.Add('$rcmail_config["smtp_helo_host"] = "";');
l.Add('$rcmail_config["smtp_log"] = TRUE;');
l.Add('$rcmail_config["list_cols"] = array("subject", "from", "date", "size");');
l.Add('$rcmail_config["skin_path"] = "skins/default/";');
l.Add('$rcmail_config["skin_include_php"] = FALSE;');
l.Add('$rcmail_config["temp_dir"] = "temp/";');
l.Add('$rcmail_config["log_dir"] = "logs/";');
l.Add('$rcmail_config["session_lifetime"] = 10;');
l.Add('$rcmail_config["ip_check"] = false;');
l.Add('$rcmail_config["double_auth"] = false;');
l.Add('$rcmail_config["des_key"] = "rcmail-!24ByteDESkey*Str";');
l.Add('$rcmail_config["locale_string"] = "en";');
l.Add('$rcmail_config["date_short"] = "D H:i";');
l.Add('$rcmail_config["date_long"] = "d.m.Y H:i";');
l.Add('$rcmail_config["date_today"] = "H:i";');
l.Add('$rcmail_config["useragent"] = "RoundCube Webmail/0.1";');
l.Add('$rcmail_config["product_name"] = "RoundCube Webmail With Artica";');
l.Add('$rcmail_config["imap_root"] = "";');
l.Add('$rcmail_config["drafts_mbox"] = "Drafts";');
l.Add('$rcmail_config["junk_mbox"] = "Junk";');
l.Add('$rcmail_config["sent_mbox"] = "Sent";');
l.Add('$rcmail_config["trash_mbox"] = "Trash";');
l.Add('$rcmail_config["default_imap_folders"] = array("INBOX", "Drafts", "Sent", "Junk", "Trash");');
l.Add('$rcmail_config["create_default_folders"] = TRUE;');
l.Add('$rcmail_config["protect_default_folders"] = TRUE;');
l.Add('$rcmail_config["skip_deleted"] = FALSE;');
l.Add('$rcmail_config["read_when_deleted"] = TRUE;');
l.Add('$rcmail_config["flag_for_deletion"] = TRUE;');
l.Add('$rcmail_config["mdn_requests"] = 0;');
l.Add('$rcmail_config["default_charset"] = "ISO-8859-1";');
l.Add('$rcmail_config["enable_spellcheck"] = TRUE;');
l.Add('$rcmail_config["spellcheck_uri"] = "";');
l.Add('$rcmail_config["spellcheck_languages"] = array("en"=>"English", "de"=>"Deutsch");');
l.Add('$rcmail_config["generic_message_footer"] = "";');
l.Add('$rcmail_config["http_received_header"] = false;');
l.Add('$rcmail_config["mail_header_delimiter"] = NULL;');
l.Add('$rcmail_config["session_domain"] = "";');
l.Add('$rcmail_config["dont_override"] = array();');
l.Add('$rcmail_config["javascript_config"] = array("read_when_deleted", "flag_for_deletion");');
l.Add('$rcmail_config["include_host_config"] = false;');
l.Add('$rcmail_config["enable_installer"] = false;');
l.Add('$rcmail_config["pagesize"] = 40;');
l.Add('$rcmail_config["timezone"] = intval(date("O"))/100 - date("I");');
l.Add('$rcmail_config["dst_active"] = (bool)date("I");');
l.Add('$rcmail_config["prefer_html"] = TRUE;');
l.Add('$rcmail_config["htmleditor"] = TRUE;');
l.Add('$rcmail_config["prettydate"] = TRUE;');
l.Add('$rcmail_config["message_sort_col"] = "date";');
l.Add('$rcmail_config["message_sort_order"] = "DESC";');
l.Add('$rcmail_config["draft_autosave"] = 300;');
l.Add('$rcmail_config["preview_pane"] = FALSE;');
l.Add('$rcmail_config["max_pagesize"] = 200;');
l.Add('$rcmail_config["mime_magic"] = "/usr/share/misc/magic";');
l.Add('?>');
result:=l.Text;
l.free;
end;
//#############################################################################
function myconf.ROUNDCUBE_MYSQL_CONFIG():string;
var
l:TstringList;
root,password,port,st:string;
begin
  st      :='';
  result  :='';
  root    :=SYS.MYSQL_INFOS('database_admin');
  password:=SYS.MYSQL_INFOS('database_password');
  port    :=SYS.MYSQL_INFOS('port');

  if length(password)>0 then begin
     st:=root + ':' + password;
  end else begin
       st:=root;
  end;
l:=TstringList.Create;
l.Add('<?php');
l.Add('$rcmail_config = array();');
l.Add('$rcmail_config["db_dsnw"] ="mysql://' + st +'@127.0.0.1:' + port+'/roundcubemail";');
l.Add('$rcmail_config["db_dsnr"] = "";');
l.Add('$rcmail_config["db_backend"] = "db";');
l.Add('$rcmail_config["db_max_length"] = 512000;  // 500K');
l.Add('$rcmail_config["db_persistent"] = FALSE;');
l.Add('$rcmail_config["db_table_users"] = "users";');
l.Add('$rcmail_config["db_table_identities"] = "identities";');
l.Add('$rcmail_config["db_table_contacts"] = "contacts";');
l.Add('$rcmail_config["db_table_session"] = "session";');
l.Add('$rcmail_config["db_table_cache"] = "cache";');
l.Add('$rcmail_config["db_table_messages"] = "messages";');
l.Add('$rcmail_config["db_sequence_users"] = "user_ids";');
l.Add('$rcmail_config["db_sequence_identities"] = "identity_ids";');
l.Add('$rcmail_config["db_sequence_contacts"] = "contact_ids";');
l.Add('$rcmail_config["db_sequence_cache"] = "cache_ids";');
l.Add('$rcmail_config["db_sequence_messages"] = "message_ids";');
l.Add('?>');
l.SaveToFile('/usr/share/roundcubemail/config/db.inc.php');
l.free;
end;
//#############################################################################
procedure myconf.BOA_START();
var
   BoaPath:string;
   Rootpath:string;
   logs:Tlogs;
begin
logs:=tlogs.Create;


if FileExists('/usr/sbin/boa') then RootPath:='/usr/sbin/boa';
if length(Rootpath)=0 then Rootpath:=get_ARTICA_PHP_PATH()+'/bin/boa';
BoaPath:=Rootpath+' -c /etc/artica-postfix -f /etc/artica-postfix/httpd.conf -l 4';
BOA_TESTS_INIT_D();
ForceDirectories(get_ARTICA_PHP_PATH() + '/ressources/logs');



if not SYSTEM_PROCESS_EXIST(BOA_DAEMON_GET_PID()) then begin
        BOA_SET_CONFIG();
        BOA_FIX_ETC_HOSTS();
        logs.DebugLogs('Starting......: Boa BOA daemon...');
        logs.DebugLogs('Starting......: Boa using binary in '+Rootpath);
        logs.Debuglogs('Starting......: Boa boa http server settings in "/etc/artica-postfix/httpd.conf"');
        fpsystem(BoaPath +' >'+get_ARTICA_PHP_PATH() + '/ressources/logs/boa.start 2>&1');
        logs.OutputCmd('/bin/chmod 755 ' + get_ARTICA_PHP_PATH() + '/ressources/logs/boa.start');
   end else begin
        logs.DebugLogs('Starting......: BOA daemon is already running using PID ' + BOA_DAEMON_GET_PID()+ '...');
        exit;
     end;

if not SYSTEM_PROCESS_EXIST(BOA_DAEMON_GET_PID()) then begin
   logs.DebugLogs('Starting......: BOA failed to start');
   logs.Debuglogs('Starting......: ' + logs.ReadFromFile(get_ARTICA_PHP_PATH() + '/ressources/logs/boa.start'));
end else begin
logs.DebugLogs('Starting......: BOA Starting with new PID '+ BOA_DAEMON_GET_PID());
end;

end;
//##############################################################################
procedure myconf.BOA_FIX_ETC_HOSTS();
var
   RegExpr:TRegExpr;
   list:TstringList;
   i:Integer;
   found:boolean;
   hostname:string;
   wrtiteit:boolean;
begin
    found:=false;
    wrtiteit:=false;
    hostname:=LINUX_GET_HOSTNAME();
    list:=TStringList.Create;
    if FileExists('/etc/hosts') then begin
       RegExpr:=TRegExpr.Create;
       RegExpr.Expression:='^127\.\0\.0\.1\s+'+hostname;
       list.LoadFromFile('/etc/hosts');
       for i:=0 to list.Count-1 do begin
            if RegExpr.Exec(list.Strings[i]) then begin
                 list.Strings[i]:='127.0.0.1'+chr(9) + hostname + chr(9) + hostname;
                 found:=true;
                 break;
            end;
       end;
    end;


    RegExpr.Free;
    if not found then begin
       wrtiteit:=true;
       logs.Syslogs('BOA_FIX_ETC_HOSTS():: adding '+hostname+ ' as 127.0.0.1 in /etc/hosts');
       list.Add('127.0.0.1'+chr(9) + hostname + chr(9) + hostname);
    end;

    if wrtiteit then begin
    try
    list.SaveToFile('/etc/hosts');
    except
    logs.Syslogs('BOA_FIX_ETC_HOSTS():: FATAL ERROR WHILE SAVING /etc/hosts');
    end;
    end;
    list.free;
end;
//##############################################################################
function myconf.MAILGRAPH_RDD_PATH():string;
var
   RegExpr:TRegExpr;
   list:TstringList;
   i:Integer;
begin
  if not FileExists('/etc/init.d/mailgraph') then exit('/opt/artica/var/rrd/mailgraph');
  list:=TstringList.Create;
  list.LoadFromFile('/etc/init.d/mailgraph');
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='RRD_DIR="(.+?)"';
  for i:=0 to list.Count-1 do begin
       if RegExpr.Exec(list.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
  end;

  list.Free;
  RegExpr.Free;

end;
//##############################################################################
function MyConf.ARTICA_FILTER_CHECK_PERMISSIONS():string;
var
   queuePath:string;

begin
     result:='';

     QueuePath:=ARTICA_FILTER_QUEUEPATH();

     forcedirectories('/var/log/artica-postfix');
     forcedirectories('/usr/share/artica-postfix/LocalDatabases');
     forcedirectories('/var/quarantines');

     if not FileExists(QueuePath) then begin
        writeln('creating folder ' +  QueuePath);
        forcedirectories(QueuePath);

        fpsystem('/bin/chown -R postfix:postfix ' + QueuePath + ' >/dev/null 2>&1');
     end;

    forcedirectories(QueuePath+'/bightml');
    fpsystem('/bin/chmod 755 /var/log/artica-postfix');
    fpsystem('/bin/chown -R postfix:postfix ' + QueuePath + ' >/dev/null 2>&1');

    if FileExists('/usr/local/bin/dspam') then begin
         fpsystem('/bin/chown artica:root /usr/local/bin/dspam >/dev/null 2>&1');
         fpsystem('/bin/chown -R postfix:postfix /etc/dspam >/dev/null 2>&1');
         ForceDirectories('/usr/local/var/dspam/data >/dev/null 2>&1');
         ForceDirectories('/var/spool/dspam >/dev/null 2>&1');
         fpsystem('/bin/chown -R postfix:postfix /var/spool/dspam >/dev/null 2>&1');
         fpsystem('/bin/chown -R postfix:postfix /usr/local/var/dspam >/dev/null 2>&1');
    end;



end;
//##############################################################################




procedure myconf.ARTICA_STOP();
 var
    pid:string;
    count:integer;
    cron:tcron;
begin
count:=0;

   cron:=tcron.Create(SYS);
   forcedirectories('/etc/artica-postfix');
   cron.STOP();
   cron.free;


   if SYSTEM_PROCESS_EXIST(SYS.GET_PID_FROM_PATH('/etc/artica-postfix/artica-process1.pid')) then begin
        writeln('Stopping artica-process Number1..: '+SYS.GET_PID_FROM_PATH('/etc/artica-postfix/artica-process1.pid') + ' PID');
        while SYSTEM_PROCESS_EXIST(SYS.GET_PID_FROM_PATH('/etc/artica-postfix/artica-process1.pid')) do begin
        sleep(100);
        inc(count);
        fpsystem('/bin/kill -9 ' + ARTICA_DAEMON_GET_PID() + ' >/dev/null 2>&1');
        if count>30 then break;
        end;
   end;


   pid:=trim(SYSTEM_PROCESS_LIST_PID('/usr/share/artica-postfix/bin/process1'));
   if length(pid)>0 then begin
        fpsystem('/bin/kill -9 ' + pid);
   end;

end;
//##############################################################################
function Myconf.INADYN_PID():string;
var
   filedatas:TstringList;
   i:integer;
   pidlists:string;
   RegExpr:TRegExpr;
   D:Boolean;
begin
  pidlists:='';
  D:=COMMANDLINE_PARAMETERS('debug');


  fpsystem('/bin/ps ax | awk ''{if (match($5, ".*/bin/inadyn")) print $1}'' >/opt/artica/logs/inadyn.pids');
  if not FileExists('/opt/artica/logs/inadyn.pids') then begin
  if D then writeln('INADYN_PID:: unable to stat /opt/artica/logs/inadyn.pids');
  exit;
  end;
  filedatas:=TStringList.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='([0-9]+)';
  if FileExists('/opt/artica/logs/inadyn.pids') then   filedatas.LoadFromFile('/opt/artica/logs/inadyn.pids');
  For i:=0 to filedatas.Count-1 do begin
     if RegExpr.Exec(filedatas.Strings[i]) then begin
        if SYSTEM_PROCESS_EXIST(RegExpr.Match[1]) then begin
           pidlists:=pidlists + RegExpr.Match[1] + ' ';
           if D then writeln('INADYN_PID:: PID: ' + RegExpr.Match[1] );
        end;
     end;
  end;

  result:=trim(pidlists);

end;
//##############################################################################
function MyConf.get_MAILGRAPH_RRD():string;
var
   RegExpr:TRegExpr;
   php_path,cgi_path,filedatas:string;
begin

 php_path:=get_ARTICA_PHP_PATH();
 cgi_path:=php_path + '/bin/mailgraph/mailgraph1.cgi';
 if not FileExists(cgi_path) then exit;
 RegExpr:=TRegExpr.create;
 RegExpr.expression:='my \$rrd[|=| ]+[''|"]([\/a-zA-Z0-9-\._]+)[''|"];';
 filedatas:=ReadFileIntoString(cgi_path);
  if  RegExpr.Exec(filedatas) then begin
  result:=RegExpr.Match[1];
  end;
  RegExpr.Free;
end;
//##############################################################################
function MyConf.get_LINUX_DOMAIN_NAME():string;
var data:string;
begin
if not FileExists('/bin/hostname') then exit;
fpsystem('/bin/hostname -d >/opt/artica/logs/hostname.txt');
data:=ReadFileIntoString('tmp/hostname.txt');
result:=trim(data);
end;

//##############################################################################
function MyConf.get_MAILGRAPH_RRD_VIRUS():string;
var
   RegExpr:TRegExpr;
   php_path,cgi_path,filedatas:string;
begin

 php_path:=get_ARTICA_PHP_PATH();
 cgi_path:=php_path + '/bin/mailgraph/mailgraph1.cgi';
 if not FileExists(cgi_path) then exit;
 RegExpr:=TRegExpr.create;
 RegExpr.expression:='my \$rrd_virus[|=| ]+[''|"]([\/a-zA-Z0-9-\._]+)[''|"];';
 filedatas:=ReadFileIntoString(cgi_path);
  if  RegExpr.Exec(filedatas) then begin
  result:=RegExpr.Match[1];
  end;
  RegExpr.Free;
end;

//##############################################################################
procedure MyConf.StripDiezes(filepath:string);
begin
    set_FileStripDiezes(filepath);
end;
procedure MyConf.set_FileStripDiezes(filepath:string);
begin
 SYS.StripDiezes(filepath);
end;
 //##############################################################################
function MyConf.PHP5_LIB_MODULES_PATH():string;
begin
  if not FileExists('/opt/artica/bin/php-config') then exit;
  fpsystem('/opt/artica/bin/php-config  --extension-dir >/opt/artica/logs/tmp_php5_ext_dir');
  result:=trim(ReadFileIntoString('/opt/artica/logs/tmp_php5_ext_dir'));
end;
 //##############################################################################
 function MyConf.CRON_PID():string;
var
   conffile:string;
   RegExpr:TRegExpr;
   FileData:TStringList;

   i:integer;
begin
   result:='0';
  conffile:='/var/run/crond.pid';
  if not FileExists(conffile) then exit('0');
  RegExpr:=TRegExpr.Create;
  FileData:=TStringList.Create;
  FileData.LoadFromFile(conffile);
  RegExpr.Expression:='([0-9]+)';
  For i:=0 TO FileData.Count -1 do begin
      if RegExpr.Exec(FileData.Strings[i]) then begin
           result:=RegExpr.Match[1];
           break;
      end;
  end;
  FileData.Free;
  RegExpr.Free;
end;
 //##############################################################################
function MyConf.CYRUS_IMAPD_CONF_GET_INFOS(value:string):string;
var
   RegExpr:TRegExpr;
   list:TstringList;
   i:integer;
   D:boolean;
begin
D:=COMMANDLINE_PARAMETERS('debug');
 if not FileExists('/etc/imapd.conf') then begin
      if D then ShowScreen('IMAPD_CONF_GET_INFOS::Unable to locate /etc/imapd.conf');
      exit;
 end;

 RegExpr:=TRegExpr.create;
 RegExpr.expression:=value+'[:\s]+([a-z]+)';
 list:=TstringList.Create;
 for i:=0 to list.Count -1 do begin
       if RegExpr.exec(list.Strings[i]) then begin
              result:=Trim(RegExpr.Match[1]);
              if D then ShowScreen('IMAPD_CONF_GET_INFOS::found ' +list.Strings[i] + ' -> ' + result);
              break;
       end;
 end;
 List.Free;
 RegExpr.Free;
end;


function MyConf.Cyrus_get_admins:string;
var RegExpr:TRegExpr;
datas:string;
begin
 RegExpr:=TRegExpr.create;
 datas:=ReadFileIntoString('/etc/imapd.conf');
 RegExpr.expression:='admins[:\s]+([a-z\.\-_0-9]+)';
 if RegExpr.Exec(datas) then begin
     result:=Trim(RegExpr.Match[1]);
 end;
 RegExpr.Free;
end;
 //##############################################################################
function MyConf.Cyrus_get_value(value:string):string;
var RegExpr:TRegExpr;
datas:string;
begin
 RegExpr:=TRegExpr.create;
 datas:=ReadFileIntoString('/etc/imapd.conf');
 RegExpr.expression:=value+'[:\s]+([a-z\.\-_0-9\s]+)';
 if RegExpr.Exec(datas) then begin
     result:=Trim(RegExpr.Match[1]);
 end;
 RegExpr.Free;
end;
 //##############################################################################
function MyConf.Cyrus_get_adminpassword():string;
begin
result:=SYS.GET_INFO('CyrusAdminPassword');
end;
 //##############################################################################
procedure MyConf.Cyrus_set_adminpassword(val:string);
begin
SYS.set_INFO('CyrusAdminPassword',val);
end;
//#############################################################################
function MyConf.Cyrus_get_admin_name():string;
begin
result:=SYS.GET_INFO('CyrusAdminName');
end;
 //##############################################################################
procedure MyConf.Cyrus_set_admin_name(val:string);
begin
SYS.set_INFO('CyrusAdminName',val);
end;
 //##############################################################################
procedure MyConf.HOTWAYD_START();
begin
    if not FileExists('/opt/artica/sbin/hotwayd') then exit;
    if SYSTEM_PROCESS_EXIST(XINETD_PID()) then begin
      if ExtractFileName(ParamStr(0))<>'process1' then logs.DebugLogs('Starting......: xinetd already running using PID ' +XINETD_PID()+ '...');
      exit;
    end;
    logs.DebugLogs('Starting......: xinetd');
    If FileExists('/etc/init.d/xinetd') then fpsystem('/etc/init.d/xinetd start >/dev/null 2>&1');
end;
 //##############################################################################
function MyConf.HOTWAYD_VERSION():string;
var RegExpr:TRegExpr;
datas:string;
begin
if not FileExists('/opt/artica/sbin/hotwayd') then exit;
datas:=ExecPipe('/opt/artica/sbin/hotwayd -v');
RegExpr:=TRegExpr.create;
RegExpr.expression:='hotwayd v([0-9\.]+)';
if RegExpr.Exec(datas) then result:=RegExpr.Match[1];
RegExpr.free;
end;
 //##############################################################################

function MyConf.XINETD_PID();
begin
   if FileExists('/var/run/xinetd.pid') then begin
      result:=trim(ReadFileIntoString('/var/run/xinetd.pid'));
      exit;
   end;

end;
 //##############################################################################

function MyConf.Cyrus_get_servername:string;
var RegExpr:TRegExpr;
datas:string;
begin
 RegExpr:=TRegExpr.create;
 datas:=ReadFileIntoString('/etc/imapd.conf');
 RegExpr.expression:='servername[:\s]+([a-z\.\-_]+)';
 if RegExpr.Exec(datas) then begin
     result:=Trim(RegExpr.Match[1]);
 end;
 RegExpr.Free;
end;
 //#############################################################################

function MyConf.Cyrus_get_unixhierarchysep:string;
var RegExpr:TRegExpr;
datas:string;
begin
 RegExpr:=TRegExpr.create;
 datas:=ReadFileIntoString('/etc/imapd.conf');
 RegExpr.expression:='unixhierarchysep[:\s]+([a-z\.\-_]+)';
 if RegExpr.Exec(datas) then begin
     result:=Trim(RegExpr.Match[1]);
 end;
 RegExpr.Free;
end;
 //#############################################################################
function MyConf.Cyrus_get_virtdomain:string;
var RegExpr:TRegExpr;
datas:string;
begin
 RegExpr:=TRegExpr.create;
 datas:=ReadFileIntoString('/etc/imapd.conf');
 RegExpr.expression:='virtdomains[:\s]+([a-z\.\-_]+)';
 if RegExpr.Exec(datas) then begin
     result:=Trim(RegExpr.Match[1]);
 end;
 RegExpr.Free;
end;
 //#############################################################################
function MyConf.LINUX_GET_HOSTNAME:string;
var datas:string;
begin
 fpsystem('/bin/hostname >/opt/artica/logs/hostname.txt');
 datas:=ReadFileIntoString('/opt/artica/logs/hostname.txt');
 result:=Trim(datas);
end;
 //#############################################################################

function MyConf.postfix_get_virtual_mailboxes_maps():string;
var
mDatas:string;
RegExpr:TRegExpr;
begin
    mDatas:=ReadFileIntoString(postfix.POSFTIX_MASTER_CF_PATH());
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='virtual_mailbox_maps.+(hash:|mysql:)([0-9a-zA-Z\.\-_/]+)';
    if RegExpr.Exec(mDatas) then begin
       Result:=RegExpr.Match[2];
       RegExpr.free;
       exit;
    end;
end;
//##############################################################################
function MyConf.POSTFIX_HEADERS_CHECKS():string;
var
mDatas:string;
RegExpr:TRegExpr;
begin
    mDatas:=ExecPipe(postfix.POSFTIX_POSTCONF_PATH()+' -h header_checks');

    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='regexp:([0-9a-zA-Z\.\-_/]+)';
    if RegExpr.Exec(mDatas) then begin
       Result:=RegExpr.Match[1];
       RegExpr.free;
       exit;
    end;
end;
//##############################################################################
procedure MyConf.POSTFIX_CHECK_POSTMAP();
var
mDatas:TstringList;
RegExpr:TRegExpr;
local_path,FilePathName, FilePathNameTO:string;
i:integer;
xLOGS:Tlogs;
begin
    xLOGS:=Tlogs.Create;
    if not FileExists(postfix.POSFTIX_MASTER_CF_PATH()) then begin
       xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: /etc/postfix/master.cf doesn''t exists !!!???');
       exit;
    end;

    local_path:=get_ARTICA_PHP_PATH() + '/ressources/conf';
    if debug then writeln('Use ' + local_path + ' as detected config ');
    xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: Use ' + local_path + ' as detected config');

    mDatas:=TstringList.Create;
    mDatas.LoadFromFile(postfix.POSFTIX_MASTER_CF_PATH());
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='hash:([0-9a-zA-Z\.\-_/]+)';
    xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: FIND hash:([0-9a-zA-Z\.\-_/]+)');
    for i:=0 to  mDatas.Count -1 do begin
         if RegExpr.Exec(mDatas.Strings[i]) then begin
            FilePathName:=local_path + '/' +  ExtractFileName(RegExpr.Match[1]);
            FilePathNameTO:=RegExpr.Match[1];
            xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: Found "' + RegExpr.Match[1] + '" => "' +FilePathName + '" => "'+ FilePathNameTO + '"');


            if fileExists(local_path + '/' +  ExtractFileName(RegExpr.Match[1])) then begin
                    if debug then writeln('Update ' +ExtractFileName(RegExpr.Match[1]));
                    xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: /bin/mv ' + FilePathName + ' ' + FilePathNameTO);
                    fpsystem('/bin/mv ' + FilePathName + ' ' + FilePathNameTO);
                     if debug then writeln('postmap ' +FilePathNameTO);

                     xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: /bin/chmod 640 ' + FilePathNameTO);
                     fpsystem('/bin/chmod 640 ' + FilePathNameTO);
                     fpsystem('/bin/chown root ' + FilePathNameTO + ' >/dev/null 2>&1');
                     xLOGS.logs('MYCONF::POSTFIX_CHECK_POSTMAP:: /usr/sbin/postmap ' + FilePathNameTO);
                     fpsystem('/usr/sbin/postmap ' + FilePathNameTO);


            end else begin
                 if debug then writeln('No update operation for ' + RegExpr.Match[1] + ' (' + ExtractFileName(RegExpr.Match[1]) + ')');
            end;


         end;
    end;
    RegExpr.Free;
    mDatas.Free;
end;
//##############################################################################
function MyConf.ARTICA_DAEMON_GET_PID():string;
begin
    result:=SYS.GET_PID_FROM_PATH('/etc/artica-postfix/artica-agent.pid');
end;
//##############################################################################
function MyConf.BOA_DAEMON_GET_PID():string;
var
   BoaPath,PID,allpids:string;
   RegExpr:TRegExpr;
   D:BOOLEAN;
begin
D:=COMMANDLINE_PARAMETERS('debug');
BoaPath:=BOA_BIN_PATH();

pid:=SYS.PIDOF_PATTERN(BoaPath+' -c /etc/artica-postfix');
if length(trim(pid))>0 then exit(pid);

PID:=trim(SYS.GET_PID_FROM_PATH('/etc/artica-postfix/boa.pid'));
if D then writeln('BOA_DAEMON_GET_PID:: Found PID="',PID,'"');
if length(PID)>0 then begin
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:=PID;
   allpids:=SYSTEM_PROCESS_LIST_PID(BoaPath);
   if D then writeln('BOA_DAEMON_GET_PID:: Found allpids="',allpids,'"');
   if RegExpr.Exec(allpids) then result:=PID;
   RegExpr.Free
end;
if D then writeln('BOA_DAEMON_GET_PID:: Found PID FINAL="',result,'"');

end;
//##############################################################################
function MyConf.BOA_BIN_PATH():string;
begin
     if FileExists('/usr/sbin/boa') then exit('/usr/sbin/boa');
     if FileExists(get_ARTICA_PHP_PATH()+ '/bin/boa') then exit(get_ARTICA_PHP_PATH()+ '/bin/boa');
end;
//##############################################################################
function myconf.CLAMD_GETINFO(Key:String):string;
var
RegExpr:TRegExpr;
l:TStringList;
i:integer;
begin
 if not FileExists(CLAMD_CONF_PATH()) then exit;
 l:=TStringList.Create;
 RegExpr:=TRegExpr.Create;
 l.LoadFromFile(CLAMD_CONF_PATH());
 RegExpr.Expression:='^' + Key + '\s+(.+)';
 For i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        result:=RegExpr.Match[1];
        break;
     end;

 end;
  RegExpr.Free;
  l.free;
end;

//##############################################################################
function myconf.CLAMD_CONF_PATH():string;
begin
   if FileExists('/etc/clamav/clamd.conf') then exit('/etc/clamav/clamd.conf');
   if FileExists('/opt/artica/etc/clamd.conf') then exit('/opt/artica/etc/clamd.conf');
end;
//##############################################################################
procedure myconf.CLAMD_SETINFO(Key:String;value:string);
var
RegExpr:TRegExpr;
l:TStringList;
i:integer;
F:boolean;
begin
 f:=False;
 l:=TStringList.Create;
 if not FileExists(CLAMD_CONF_PATH()) then exit();



 RegExpr:=TRegExpr.Create;
 l.LoadFromFile(CLAMD_CONF_PATH());
 RegExpr.Expression:='^' + Key + '\s+(.+)';
 For i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        F:=true;
        l.Strings[i]:=key + ' ' + value;
        break;
     end;

 end;

  if not F then l.Add(key + ' ' + value);
  l.SaveToFile(CLAMD_CONF_PATH());
  RegExpr.Free;
  l.free;
end;
//##############################################################################
function MyConf.ReadFileIntoString(path:string):string;
var
   List:TstringList;
begin

      if not FileExists(path) then begin
        exit;
      end;

      List:=Tstringlist.Create;
      List.LoadFromFile(path);
      result:=List.Text;
      List.Free;
end;
//##############################################################################
procedure MyConf.killfile(path:string);
Var F : Text;
begin

 if not FileExists(path) then exit;
 if Debug then LOGS.logs('MyConf.killfile -> remove "' + path + '"');
TRY
 Assign (F,path);
 Erase (f);
 EXCEPT
 end;
end;
//##############################################################################
function MyConf.get_LINUX_MAILLOG_PATH():string;
begin
exit(SYS.MAILLOG_PATH());
end;
//##############################################################################
function MyConf.POSTFIX_LAST_ERRORS():string;
var logPath,cmdline:string;
D,A:boolean;
RegExpr:TRegExpr;
FileData:TstringList;
i:integer;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  result:='';
  logPath:=get_LINUX_MAILLOG_PATH();
  logs.logs('POSTFIX_LAST_ERRORS() -> ' + logpath);
  if not FileExists(logpath) then begin
     if D then ShowScreen('POSTFIX_LAST_ERRORS:: Error unable to stat "' + logPath + '"');
     exit;
  end;
  A:=COMMANDLINE_PARAMETERS('errors');
  D:=COMMANDLINE_PARAMETERS('debug');
   RegExpr:=TRegExpr.Create;
   FileData:=TstringList.CReate;
   ArrayList:=TstringList.CReate;
   RegExpr.Expression:='(fatal|failed|failure|deferred|Connection timed out|expired|rejected|warning)';
   cmdline:='/usr/bin/tail -n 2000 ' + logPath;
   logs.logs('POSTFIX_LAST_ERRORS() -> ' + cmdline);

   if D then ShowScreen('POSTFIX_LAST_ERRORS:: "'+cmdline+'"');
   FileData.LoadFromStream(ExecStream(cmdline,false));

   logs.logs('POSTFIX_LAST_ERRORS() ->tail -> ' + IntToStr(FileData.count) + ' lines');

   if D then ShowScreen('POSTFIX_LAST_ERRORS:: tail -> ' + IntToStr(FileData.count) + ' lines');
   For i:=0 to FileData.count-1 do begin
       RegExpr.Expression:='(postfix\/|cyrus\/)';
       if RegExpr.Exec(FileData.Strings[i]) then begin
          RegExpr.Expression:='(fatal|failed|failure|deferred|Connection timed out|expired|rejected)';
            if RegExpr.Exec(FileData.Strings[i]) then begin
               if A then writeln(FileData.Strings[i]);
               ArrayList.Add(FileData.Strings[i]);
            end;
       end;

   end;

   RegExpr.free;
   FileData.Free;


end;
//##############################################################################
function MyConf.GetIPAddressOfInterface( if_name:ansistring):ansistring;
var
 tt:ttcpip;

begin
tt:=ttcpip.Create;
result:=tt.IP_ADDRESS_INTERFACE(if_name);
end;
//##############################################################################
function MyConf.CheckInterface( if_name:string):boolean;
var
RegExpr:TRegExpr;
 datas : string;
begin
 Result:=False;
 if not FileExists('/sbin/ifconfig') then exit;

     fpsystem('/sbin/ifconfig ' + if_name + ' >/opt/artica/logs/ifconfig_' + if_name);
     datas:= ReadFileIntoString('/opt/artica/logs/ifconfig_' + if_name);
     RegExpr:=TRegExpr.create;
     RegExpr.expression:='adr\:([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)';
     if RegExpr.Exec(datas) then begin
       RegExpr.Free;
       Result:=True;
       exit;
   end;
end;
//##############################################################################
function MyConf.GetIPInterface( if_name:string):string;
var
RegExpr:TRegExpr;
 datas : string;
begin

 if not FileExists('/sbin/ifconfig') then exit;

     fpsystem('/sbin/ifconfig ' + if_name + ' >/opt/artica/logs/ifconfig_' + if_name);
     datas:= ReadFileIntoString('/opt/artica/logs/ifconfig_' + if_name);
     RegExpr:=TRegExpr.create;
     RegExpr.expression:='adr\:([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)';
     if RegExpr.Exec(datas) then begin
       RegExpr.Free;
       if length(RegExpr.Match[1])>0 then Result:=RegExpr.Match[1];
       exit;
   end;
end;
//##############################################################################
procedure MyConf.POSTFIX_REPLICATE_MAIN_CF(mainfile:string);
var
   conf_path,bounce_template_cf:string;
begin

     if not fileExists(mainfile) then begin
       ShowScreen('POSTFIX_REPLICATE_MAIN_CF:: Unable to stat ' + mainfile);
       exit;
     end;

        conf_path:=ExtractFilePath(mainfile);
        ShowScreen('POSTFIX_REPLICATE_MAIN_CF:: conf directory=' + conf_path);
        bounce_template_cf:=conf_path+ '/bounce.template.cf';
        ShowScreen('POSTFIX_REPLICATE_MAIN_CF:: -> ' + bounce_template_cf + ' ?');
        if FileExists(bounce_template_cf) then begin
            fpsystem('/bin/mv ' + bounce_template_cf + ' /etc/postfix');
            ShowScreen('POSTFIX_REPLICATE_MAIN_CF::  move ' + bounce_template_cf + ' (ok)');
            fpsystem('/bin/chown root:root /etc/postfix/bounce.template.cf >/dev/null 2>&1');
        end;


        logs.logsPostfix('replicate: ' + mainfile +' to /etc/postfix' );

        fpsystem('/bin/mv ' + mainfile + ' /etc/postfix');



        POSTFIX_CHECK_POSTMAP();
        logs.logsPostfix('replicate:restart postfix');
        postfix.POSFTIX_VERIFY_MAINCF();



end;
//#####################################################################################
function myConf.PERL_VERSION():string;
var
   version:string;
   RegExpr:TRegExpr;
begin
    if not FileExists(PERL_BIN_PATH()) then exit;
    RegExpr:=TRegExpr.Create;
    version:=ExecPipe(PERL_BIN_PATH()+' -v 2>&1');
    RegExpr.Expression:=' v([0-9\.]+)';
    if RegExpr.Exec(version) then result:=RegExpr.Match[1];
    RegExpr.free;
end;
//##################################################################################### 
function myConf.PERL_BIN_PATH():string;
begin
    if FileExists('/usr/local/bin/perl') then exit('/usr/local/bin/perl');
    if FileExists('/usr/bin/perl') then exit('/usr/bin/perl');
    if FileExists('/opt/artica/bin/perl') then exit('/opt/artica/bin/perl');
end;
//#################################################################################
function myConf.PERL_INCFolders():TstringList;
const
  CR = #$0d;
  LF = #$0a;
  CRLF = CR + LF;

var
    datas:string;
    F:TstringList;
    RegExpr:TRegExpr;
    L:TStringDynArray;
    i:integer;
begin
     datas:=ExecPipe(PERL_BIN_PATH() + ' -V 2>&1');
     RegExpr:=TRegExpr.Create;

     RegExpr.Expression:='@INC:(.+)';
     if RegExpr.Exec(datas) then begin
        l:=Explode(CRLF,RegExpr.Match[1]);
        F:=TstringList.Create;

        For i:=0 to length(l)-1 do begin
            if length(trim(l[i]))>3 then F.Add(trim(l[i]));
        end;
     end;

   result:=F;
   if ParamStr(1)='@INC' then begin
        For i:=0 to F.Count -1 do begin
            writeln(F.Strings[i]);
        end;
   end;

end;

//#####################################################################################
procedure MyConf.THREAD_COMMAND_SET(zcommands:string);
begin
     SYS.THREAD_COMMAND_SET(zcommands);
end;
//##############################################################################
function MyConf.get_LINUX_INET_INTERFACES():string;
var
 s:shortstring;
 f:text;
 p:LongInt;
 xInterfaces:string;
begin
 xInterfaces:='';
 assign(f,'/proc/net/dev');
 reset(f);
 while not eof(f) do begin
   readln(f,s);
   p:=pos(':',s);
   if ( p > 0 ) then begin
     delete(s, p, 255);
     while ( s <> '' ) and (s[1]=#32) do delete(s,1,1);
       if CheckInterface(s) then xInterfaces:=xInterfaces + ';'+ s + ':[' + GetIPAddressOfInterface(s) + ']';
   end;
 end;
 exit(xInterfaces);
 close(f);
 end;
//##############################################################################

procedure myconf.MAILGRAPGH_FIX_PERL();
begin
     if SYSTEM_GET_PLATEFORM()='686' then begin
    //     if FileExists('/opt/artica/lib/perl/5.8.8/i686-linux/RRDs.pm');
     end;

end;



//##############################################################################
function MyConf.SYSTEM_NETWORK_INITD():string;
begin
if FileExists('/etc/init.d/networking') then exit('/etc/init.d/networking');
if FileExists('/etc/init.d/network') then exit('/etc/init.d/network');
logs.logs('SYSTEM_NETWORK_INITD:: unable to locate init.d daemon');
end;



//##############################################################################
function MyConf.MAILGRAPGH_PID_PATH():string;
var
   RegExpr:TRegExpr;
   list:TstringList;
   i:integer;
begin
if not FileExists('/etc/init.d/mailgraph-init') then exit('');
list:=TstringList.Create;
 RegExpr:=TRegExpr.create;
 RegExpr.Expression:='^PID_FILE[\s''"=]([a-z0-9\-\/\.]+)';
 list.LoadFromFile('/etc/init.d/mailgraph-init');
 for i:=0 to list.Count-1 do begin
     if RegExpr.Exec(list.Strings[i]) then begin
         result:=RegExpr.Match[1];
         RegExpr.free;
         list.free;
         exit;
     end;
 end;
end;
//##############################################################################
function MyConf.SYSTEM_CRON_TASKS():TstringList;
const
  CR = #$0d;
  LF = #$0a;
  CRLF = CR + LF;

var
   list:TstringList;
   LineDatas:string;
   i:integer;
   D:boolean;
   C:boolean;
begin
   D:=COMMANDLINE_PARAMETERS('debug');
   C:=COMMANDLINE_PARAMETERS('list');
   list:=TstringList.Create;
   list.AddStrings(SYS.DirFiles('/etc/cron.d','*'));
   ArrayList:=TstringList.Create;
    for i:=0 to list.Count-1 do begin
          if D then ShowScreen('SYSTEM_CRON_TASKS:: File [' + list.Strings[i] + ']');
          LineDatas:='<cron>' + CRLF  +'<filename>/etc/cron.d/' + list.Strings[i] + '</filename>' + CRLF + '<filedatas>' + ReadFileIntoString('/etc/cron.d/' + list.Strings[i])+CRLF + '</filedatas>' + CRLF + '</cron>';
           ArrayList.Add(LineDatas);
           if C then showscreen(CRLF+'------------------------------------------------------------' + CRLF+LineDatas+CRLF + '------------------------------------------------------------'+CRLF);

    end;
   Result:=ArrayList;
   list.free;


end;
//##############################################################################

function MyConf.SYSTEM_IP_OVERINTERNET():string;
var
   F      :TstringList;
   RegExpr:TRegExpr;
begin
     result:='0.0.0.0';
     download_silent:=true;
     WGET_DOWNLOAD_FILE('http://checkip.dyndns.org/','/opt/artica/logs/dyndns.ip.org');
     if not FileExists('/opt/artica/logs/dyndns.ip.org') then exit;
     f:=TstringList.Create;
     f.LoadFromFile('/opt/artica/logs/dyndns.ip.org');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='([0-9\.]+)';
     if RegExpr.Exec(f.Text) then result:=trim(RegExpr.Match[1]);
     RegExpr.free;
     f.free;


end;
//##############################################################################


function MyConf.MYSQL_STATUS():string;
var mysql_init,pid_path,pid,status:string;
D:boolean;
begin
      D:=COMMANDLINE_PARAMETERS('debug');

      pid:='0';
      pid_path:=MYSQL_PID_PATH();
      pid:=SYS.GET_PID_FROM_PATH(pid_path);
      mysql_init:=MYSQL_INIT_PATH();
      if D then logs.logs('pid_path=' + pid_path + ' mysql_init=' + mysql_init + ' pid=' + pid);
      if length(mysql_init)=0 then begin
         result:='-1;0;0';
      end else begin
          if length(pid_path)=0 then result:='-1;0;0';
          if length(pid)=0 then result:='0;' + MYSQL_VERSION() + ';0';
          if SYSTEM_PROCESS_EXIST(pid) then begin
              status:='1';
              end else begin
                  status:='0';
              end;
       end;

      result:=status + ';' + MYSQL_VERSION() + ';' +pid;
            if D then  logs.logs('Mysql result=' + result);

end;
//##############################################################################

function MyConf.MYSQL_PID_PATH():string;
var
   mycnf_path:string;
   RegExpr:TRegExpr;
   list:TstringList;
   i:integer;
   D:boolean;
begin
  D:=COMMANDLINE_PARAMETERS('debug');

  mycnf_path:=MYSQL_MYCNF_PATH();
  if D then ShowScreen('MYSQL_PID_PATH::mycnf_path->' + mycnf_path);
  if length(mycnf_path)=0 then exit('');
  list:=TstringList.create;
  list.LoadFromFile(mycnf_path);
  RegExpr:=TRegExpr.create;
  RegExpr.Expression:='pid-file[\s=]+([\/a-z\.A-Z0-9]+)';
  for i:=0 to list.Count-1 do begin
          if RegExpr.Exec(list.Strings[i]) then begin
                result:=RegExpr.Match[1];
                list.Free;
                RegExpr.Free;
                if D then ShowScreen('MYSQL_PID_PATH::success->' + result);
                exit;
          end;
  end;
  if D then ShowScreen('MYSQL_PID_PATH::failed->');
end;
//##############################################################################
function MyConf.SYSTEM_USER_LIST():string;
var RegExpr:TRegExpr;
list:TstringList;
i:integer;
D:boolean;
begin
   result:='';
   RegExpr:=TRegExpr.Create;
   list:=TstringList.Create;
   ArrayList:=TstringList.Create;
   list.LoadFromFile('/etc/shadow');
   if ParamStr(1)='-userslist' then D:=true;

   RegExpr.Expression:='([a-zA-Z0-9\.\-\_\s]+):';
   for i:=0 to list.Count-1 do begin
         if D then ShowScreen('USER:' + RegExpr.Match[1]);
         if RegExpr.Exec(trim(list.Strings[i])) then begin
             if length(trim(RegExpr.Match[1]))>0 then ArrayList.Add(RegExpr.Match[1]);
         end;


   end;
list.free;
RegExpr.free;
end;


//##############################################################################
procedure MyConf.AVESERVER_REPLICATE_kav4mailservers(mainfile:string);
var pid,ForwardMailer:string;
stat:integer;
begin
pid:=AVESERVER_GET_PID();
     if not FileExists('/etc/init.d/aveserver') then begin
        lOGS.logs('AVESERVER_REPLICATE_kav4mailservers:: unable to stat /etc/init.d/aveserver');
        exit;
     end;

     if FileExists('/proc/' + pid + '/exe') then stat:=1 else stat:=0;

     if fileExists(mainfile) then begin
        fpsystem('/bin/mv ' + mainfile + ' /etc/kav/5.5/kav4mailservers/kav4mailservers.conf');
        if FileExists('/etc/init.d/kas3') then begin
                 lOGS.logs('AVESERVER_REPLICATE_kav4mailservers:: Kaspersky anti-spam exists in this system..');
                 ForwardMailer:=AVESERVER_GET_VALUE('smtpscan.general','ForwardMailer');
                 if ForwardMailer<>'smtp:127.0.0.1:9025' then begin
                    AVESERVER_SET_VALUE('smtpscan.general','ForwardMailer','smtp:127.0.0.1:9025');
                    AVESERVER_SET_VALUE('smtpscan.general','Protocol','smtp');
                 end;
        end;
        LOGS.logs('AVESERVER_REPLICATE_kav4mailservers::  -> AVESERVER_REPLICATE_TEMPLATES()');
        AVESERVER_REPLICATE_TEMPLATES();

        if stat=0 then fpsystem('/etc/init.d/aveserver start 2>&1');
        if stat=1 then fpsystem('/etc/init.d/aveserver reload 2>&1');
     end
        else begin
          LOGS.logs('AVESERVER_REPLICATE_kav4mailservers::  -> ' + mainfile + ' does not exists');
     end;

end;


//##############################################################################
function MyConf.SYSTEM_CRON_REPLIC_CONFIGS():string;
var
CronTaskPath:string;
CronTaskkDelete:string;
FileToDelete:string;
list:TstringList;
i:integer;
D:boolean;
FileCount:integer;
begin
     result:='';
     D:=COMMANDLINE_PARAMETERS('debug');
     if ParamStr(1)='-replic_cron'then D:=true;


    CronTaskPath:=get_ARTICA_PHP_PATH() + '/ressources/conf/cron';
    FileCount:=SYS.DirectoryCountFiles(CronTaskPath);
    if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: ' + CronTaskPath + ' store ' + IntTOStr(FileCount) + ' files' );
    lOGS.logs('SYSTEM_CRON_REPLIC_CONFIGS:: ' + CronTaskPath + ' store ' + IntTOStr(FileCount) + ' files');
    if FileCount=0 then begin
       exit;
    end;



 CronTaskkDelete:=CronTaskPath+ '/CrontaskToDelete';
 if FileExists(CronTaskkDelete) then begin
       list:=TstringList.Create;
       list.LoadFromFile(CronTaskkDelete);
       if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: ' + IntToStr(list.Count) + ' files to delete');


       for i:=0 to list.Count -1 do begin
            FileToDelete:='/etc/cron.d/' + trim(list.Strings[i]);
             if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: "'+ FileToDelete + '"');
             lOGS.logs('SYSTEM_CRON_REPLIC_CONFIGS:: Delete "'+ FileToDelete + '"');
             if fileExists(FileToDelete) then begin
                  if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: delete: ' + FileToDelete );
                  fpsystem('/bin/rm ' + FileToDelete);
             end;
       end;
  if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: delete: ' + CronTaskkDelete );
  fpsystem('/bin/rm ' + CronTaskkDelete);

 end;
  if FileExists(CronTaskPath + '/artica.cron.kasupdate') then fpsystem('/usr/local/ap-mailfilter3/bin/enable-updates.sh');

   fpsystem('/bin/mv '  + CronTaskPath + '/* ' + '/etc/cron.d/');
   fpsystem('/bin/chown root:root /etc/cron.d/* >/dev/null 2>&1');
   fpsystem('/etc/init.d/cron reload');
   if D then ShowScreen('SYSTEM_CRON_REPLIC_CONFIGS: Done...' );
  lOGS.logs('SYSTEM_CRON_REPLIC_CONFIGS:: Replicate cron task list done...');
end;
//##############################################################################
function MyConf.SYSTEM_DAEMONS_STATUS():string;
var RegExpr:TRegExpr;
mstr:string;
list:TstringList;
i:integer;
kas3:tkas3;
begin
  RegExpr:=TRegExpr.Create;
  list:=TstringList.Create;

    kas3:=tkas3.Create(SYS);
    mstr:=kas3.KAS_STATUS();
    kas3.free;

  list.Add('');

  RegExpr.Expression:='([0-9\-]+)-([0-9\-]+);([0-9\-]+)-([0-9\-]+);([0-9\-]+)-([0-9\-]+);([0-9\-]+)-([0-9\-]+)';
  if RegExpr.Exec(mstr) then begin
      list.Add('[APP_KAS3]');
      list.Add('ap-process-server='+RegExpr.Match[1]+ ';' +RegExpr.Match[2]);
      list.Add('ap-spfd='+RegExpr.Match[3]+ ';' +RegExpr.Match[4]);
      list.Add('kas-license='+RegExpr.Match[5]+ ';' +RegExpr.Match[6]);
      list.Add('kas-thttpd='+RegExpr.Match[7]+ ';' +RegExpr.Match[8]);
  end;


   list.Add('');
   mstr:=postfix.POSTFIX_STATUS();
   RegExpr.Expression:='([0-9\-]+);([0-9\.]+);([0-9\-]+)';
   if RegExpr.Exec(mstr) then begin
      list.Add('[APP_POSTFIX]');
      list.Add('postfix='+RegExpr.Match[3]+ ';' +RegExpr.Match[1]);
   end;





   list.Add('');


   list.Add('');


   list.Add('');
   mstr:=mailgraph.MAILGRAPGH_STATUS();
   RegExpr.Expression:='([0-9\-]+);([0-9\.\sa-zA-Z]+);([0-9\-]+)';
   if RegExpr.Exec(mstr) then begin
      list.Add('[APP_MAILGRAPH]');
      list.Add('mailgraph='+RegExpr.Match[3]+ ';' +RegExpr.Match[1]);
   end;

   list.Add('');
   mstr:=MYSQL_STATUS();
   RegExpr.Expression:='([0-9\-]+);([0-9\.\sa-zA-Z]+);([0-9\-]+)';
   if RegExpr.Exec(mstr) then begin
      list.Add('[APP_MYSQL]');
      list.Add('mysqld='+RegExpr.Match[3]+ ';' +RegExpr.Match[1]);
   end;



    if ParamStr(2)='all' then begin
          for i:=0 to list.Count-1 do begin
              ShowScreen(list.Strings[i]);

          end;

    end;

    RegExpr.free;
    result:=list.Text;
    list.free;


end;
//##############################################################################
function MyConf.AVESERVER_PATTERN_DATE():string;
var
   BasesPath:string;
   xml:string;
   RegExpr:TRegExpr;
begin
//#UpdateDate="([0-9]+)\s+([0-9]+)"#
 BasesPath:=AVESERVER_GET_VALUE('path','BasesPath');
 if not FileExists(BasesPath + '/master.xml') then exit;
 xml:=ReadFileIntoString(BasesPath + '/master.xml');
 RegExpr:=TRegExpr.Create;
 RegExpr.Expression:='UpdateDate="([0-9]+)\s+([0-9]+)"';
 if RegExpr.Exec(xml) then begin

 //date --date "$dte 3 days 5 hours 10 sec ago"

    result:=RegExpr.Match[1] + ';' + RegExpr.Match[2];
 end;
 RegExpr.Free;
end;
//##############################################################################
procedure MyConf.ExecProcess(commandline:string);
var
  P: TProcess;
 begin

  P := TProcess.Create(nil);
  P.CommandLine := commandline  + ' &';
  if debug then LOGS.Logs('MyConf.ExecProcess -> ' + commandline);
  P.Execute;
  P.Free;
end;
//##############################################################################
procedure MyConf.MonShell(cmd:string;sh:boolean);
var
  AProcess: TProcess;
 begin
      if sh then cmd:='sh -c "' + cmd + '"';

      try
        AProcess := TProcess.Create(nil);
        AProcess.CommandLine := cmd;
        AProcess.Execute;
     finally
        AProcess.Free;
     end;
end;
//##############################################################################
function MyConf.ExecPipe(commandline:string):string;
const
  READ_BYTES = 2048;
  CR = #$0d;
  LF = #$0a;
  CRLF = CR + LF;

var
  S: TStringList;
  M: TMemoryStream;
  P: TProcess;
  n: LongInt;
  BytesRead: LongInt;
  xRes:string;

begin
  // writeln(commandline);
  if length(trim(commandline))=0 then exit;
  M := TMemoryStream.Create;
  xRes:='';
  BytesRead := 0;
  P := TProcess.Create(nil);
  P.CommandLine := commandline;
  P.Options := [poUsePipes];
  if debug then LOGS.Logs('MyConf.ExecPipe -> ' + commandline);

  P.Execute;
  while P.Running do begin
    M.SetSize(BytesRead + READ_BYTES);
    n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end
    else begin
      Sleep(100);
    end;

  end;

  repeat
    M.SetSize(BytesRead + READ_BYTES);
    n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end;
  until n <= 0;
  M.SetSize(BytesRead);
  S := TStringList.Create;
  S.LoadFromStream(M);
  if debug then LOGS.Logs('Tprocessinfos.ExecPipe -> ' + IntTostr(S.Count) + ' lines');
  for n := 0 to S.Count - 1 do
  begin
    if length(S[n])>1 then begin

      xRes:=xRes + S[n] +CRLF;
    end;
  end;
  if debug then LOGS.Logs('Tprocessinfos.ExecPipe -> exit');
  S.Free;
  P.Free;
  M.Free;
  exit( xRes);
end;
//##############################################################################
function MyConf.SYSTEM_PROCESS_MEMORY(PID:string):integer;
begin
result:=SYSTEM_PROCESS_MEMORY_FATHER(PID);
end;
//##############################################################################
function myconf.SYSTEM_PROCESS_MEMORY_FATHER(PID:string):integer;
var
   l:TstringList;
   RegExpr:TRegExpr;
   i:Integer;
   FATHER:integer;
   D:Boolean;
   tempfile:string;
begin
D:=COMMANDLINE_PARAMETERS('debug');
result:=0;

PID:=trim(PID);
if PID='0' then begin
   if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER PID=',PID, ' aborting...');
   exit;
end;

if length(PID)=0 then begin
  if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER PID=NULL aborting...');
   exit;
end;

if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER PID=',PID);
l:=TstringList.Create;

  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^([0-9]+)';
  if not RegExpr.Exec(PID) then begin
     exit;
  end else begin
      PID:=RegExpr.Match[1];
      if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER FATHER PID after regex=',PID);
  end;


  FATHER:=SYSTEM_PROCESS_MEMORY_SINGLE(PID);


 if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER FATHER ',PID,'=',FATHER);

tempfile:='/opt/artica/logs/'+MD5FromString(PID);
if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER -> tempfile=',tempfile);
if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER -> /bin/ps -aeo "%p;%P;%a" --cols 500 >'+tempfile +' 2>&1');

fpsystem('/bin/ps -aeo "%p;%P;%a" --cols 500 >'+tempfile +' 2>&1');
if not FileExists(tempfile) then exit;

try
l.LoadFromFile(tempfile);
RegExpr.Expression:='([0-9]+);\s+'+PID+';.+';
if D then writeln('SYSTEM_PROCESS_MEMORY_FATHER Lines=',l.Count);
for i:=0 to l.Count -1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
          if D then writeln('FOUND ->',RegExpr.Match[1]);
          FATHER:=FATHER+SYSTEM_PROCESS_MEMORY_SINGLE(RegExpr.Match[1]);
    end else begin
       // if D then writeln('Could not parse ' + l.Strings[i] + ' regex ' + RegExpr.Expression);
    end;
end;
except
   writeln('SYSTEM_PROCESS_MEMORY_FATHER FATHER error on PID ',PID);
end;
DeleteFile(tempfile);
result:=FATHER;

end;
//##############################################################################
function MyConf.SYSTEM_PROCESS_MEMORY_SINGLE(PID:string):integer;
var
   S:Tstringlist;
   RegExpr:TRegExpr;
   I:INTEGER;
   D:boolean;
begin
     result:=0;
     D:=False;
     if length(PID)=0 then exit;
     if PID='0' then exit;
     D:=COMMANDLINE_PARAMETERS('debug');
     if D then writeln('SYSTEM_PROCESS_MEMORY_SINGLE::->',PID);

     if not FileExists('/proc/' + trim(PID) + '/status') then begin
        if D then writeln('SYSTEM_PROCESS_MEMORY_SINGLE:: Could not find /proc/' + trim(PID) + '/status');
        exit(0);
     end;
     s:=TStringList.Create;
     S.LoadFromFile('/proc/' + trim(PID) + '/status');
     if D then writeln('SYSTEM_PROCESS_MEMORY_SINGLE:: /proc/' + trim(PID) + '/status');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^VmRSS:\s+([0-9]+)';
     for i:=0 to s.Count-1 do begin
       if RegExpr.Exec(s.Strings[i]) then begin
          if D then writeln('SYSTEM_PROCESS_MEMORY_SINGLE :',PID,'=',RegExpr.Match[1],': ',s.Strings[i]);
          result:=StrToInt(trim(RegExpr.Match[1]));
          break;
       end;
     end;

s.free;
RegExpr.free;

end;



//##############################################################################
function MyConf.SYSTEM_PROCESS_STATUS(PID:string):string;
var
   S:Tstringlist;
   RegExpr:TRegExpr;
   I:INTEGER;
   D:boolean;
begin
     result:='';
     RegExpr:=TRegExpr.Create;

     if length(PID)=0 then exit;
     PID:=trim(PID);
     RegExpr.Expression:='^([0-9]+)';
     if PID='0' then exit;
     D:=False;
     D:=COMMANDLINE_PARAMETERS('debug');


     if D then writeln('SYSTEM_PROCESS_STATUS::->',PID);

     if RegExpr.Exec(PID) then begin
        PID:=RegExpr.Match[1];
        if D then writeln('SYSTEM_PROCESS_STATUS:: AFTER REGEX ->',PID);
     end else begin
        if D then writeln('SYSTEM_PROCESS_STATUS:: BAD MATCH REGEX ->',PID);
        exit;
     end;


     if not FileExists('/proc/' + trim(PID) + '/status') then begin
        if D then writeln('SYSTEM_PROCESS_STATUS:: Could not find /proc/' + trim(PID) + '/status');
        exit('0');
     end;
     s:=TStringList.Create;
     S.LoadFromFile('/proc/' + trim(PID) + '/status');
     if D then writeln('SYSTEM_PROCESS_STATUS:: /proc/' + trim(PID) + '/status');

     RegExpr.Expression:='^State:\s+([A-Z])\s+\(([a-zA-Z]+)\)';
     for i:=0 to s.Count-1 do begin
       if RegExpr.Exec(s.Strings[i]) then begin
          if D then writeln('SYSTEM_PROCESS_STATUS :',PID,'=',RegExpr.Match[2],': ',RegExpr.Match[1],' ',s.Strings[i]);
          result:=trim(RegExpr.Match[2]);
          break;
       end;
     end;

s.free;
RegExpr.free;

end;



//##############################################################################
function MyConf.ExecStream(commandline:string;ShowOut:boolean):TMemoryStream;
const READ_BYTES=1024;
var
  M: TMemoryStream;
  P: TProcess;
  n: LongInt;
  BytesRead: LongInt;
begin
  commandline:=commandline + ' 2>&1';
  M := TMemoryStream.Create;
  BytesRead := 0;
  P := TProcess.Create(nil);
  P.CommandLine := commandline;
  P.Options := [poUsePipes];
  if ShowOut then WriteLn('-- executing ' + commandline + ' --');
  if debug then LOGS.Logs('Tprocessinfos.ExecPipe -> ' + commandline);
  TRY
     P.Execute;
     while P.Running do begin
           M.SetSize(BytesRead + READ_BYTES);
           n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
           if n > 0 then begin
              Inc(BytesRead, n);
              end else begin
              Sleep(100);
           end;
     end;
  EXCEPT
        P.Free;
        exit;
  end;


  repeat
    M.SetSize(BytesRead + READ_BYTES);
    n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end;
  until n <= 0;
  M.SetSize(BytesRead);
  exit(M);
end;

//##############################################################################
function MyConf.LINUX_REPOSITORIES_INFOS(inikey:string):string;
var ConfFile:string;
ini:TiniFile;
begin

  ConfFile:=LINUX_CONFIG_INFOS();
  if length(ConfFile)=0 then exit;
  ini:=TIniFile.Create(ConfFile);
  result:=ini.ReadString('REPOSITORIES',inikey,'');
  ini.Free;
end;

//##############################################################################
function MyConf.LINUX_APPLICATION_INFOS(inikey:string):string;
var ConfFile:string;
ini:TiniFile;
begin

  ConfFile:=LINUX_CONFIG_INFOS();
  if length(ConfFile)=0 then exit;
  ini:=TIniFile.Create(ConfFile);
  result:=ini.ReadString('APPLICATIONS',inikey,'');
  ini.Free;
end;
//##############################################################################
function MyConf.LINUX_CONFIG_PATH():string;
var
   Distri,path,fullPath:string;
   D:Boolean;

begin
   D:=false;
   D:=COMMANDLINE_PARAMETERS('debug');
   Distri:=LINUX_DISTRIBUTION();
   if D then writeln('LINUX_CONFIG_PATH ->LINUX_DISTRIBUTION=' + Distri);
   path:=ExtractFileDir(ParamStr(0));
   fullPath:=path + '/install/distributions/' + Distri;
   if D then writeln('LINUX_CONFIG_PATH is path ? (' + fullPath + ')');
   if not DirectoryExists(fullpath) then begin
      logs.DebugLogs('Unable to locate necessary folder:"' + fullPath + '"');
      exit();
   end;
   result:=fullpath;
end;
//##############################################################################
function MyConf.LINUX_CONFIG_INFOS():string;
var
   Distri,path,fullPath,include:string;
   sini:TiniFile;


begin
   Distri:=LINUX_DISTRIBUTION();
   path:=ExtractFileDir(ParamStr(0));
   fullPath:=path + '/install/distributions/' + Distri + '/infos.conf';
   if not FileExists(fullpath) then begin
      logs.DebugLogs('Unable to locate necessary file:"' + fullPath + '"');
      exit();
   end;
    sini:=TiniFile.Create(fullPath);
    include:=sini.ReadString('INCLUDE','config','');
    sini.Free;
    if length(include)>0 then begin
          fullPath:=path + '/install/distributions/' + include + '/infos.conf';
          if not FileExists(fullpath) then begin
             logs.DebugLogs('Unable to locate include file:"' + fullPath + '"');
             exit();
          end;

    end;



   result:=fullpath;
end;
//##############################################################################
function Myconf.SYSTEM_DAEMONS_STOP_START(APPS:string;mode:string;return_string:boolean):string;
var commandline:string;
    log:Tlogs;
    cyr:Tcyrus;
begin
     cyr:=Tcyrus.Create(SYS);
     if APPS='APP_POSTFIX' then commandline:='/etc/init.d/postfix '+mode;
     if APPS='APP_AVESERVER' then CommandLine:='/etc/init.d/aveserver '+mode;
     if APPS='APP_KAS3' then CommandLine:='/etc/init.d/kas3 ' +mode;
     if APPS='APP_FETCHMAIL' then CommandLine:='/etc/init.d/fetchmail ' +mode;
     if APPS='APP_CYRUS' then CommandLine:=cyr.CYRUS_GET_INITD_PATH() + ' '+mode;
     if APPS='APP_MAILGRAPH' then CommandLine:='/etc/init.d/mailgraph-init ' + mode;
     if APPS='APP_MYSQL' then CommandLine:=MYSQL_INIT_PATH() + ' '+mode;
     if return_string=true then exit(CommandLine);
     log:=Tlogs.Create;
     log.logs('SYSTEM_DAEMONS_STOP_START::Perform operation ' + CommandLine);
     fpsystem(CommandLine);

end;
//##############################################################################
function MyConf.CRON_CREATE_SCHEDULE(ProgrammedTime:string;Croncommand:string;name:string):boolean;
 var FileDatas:TstringList;
begin
  result:=true;
  FileDatas:=TstringList.Create;
  FileDatas.Add(ProgrammedTime + ' ' + ' root ' + Croncommand + ' >/dev/null');
  ShowScreen('CRON_CREATE_SCHEDULE:: saving /etc/cron.d/artica.'+name + '.scheduled');
  FileDatas.SaveToFile('/etc/cron.d/artica.'+name + '.scheduled');
  FileDatas.free;


end;




function MyConf.LINUX_INSTALL_INFOS(inikey:string):string;
var ConfFile:string;
ini:TiniFile;
D:boolean;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  ConfFile:=LINUX_CONFIG_INFOS();
  if D then ShowScreen('LINUX_INSTALL_INFOS:: ConfFile="' + ConfFile + '"');

  if length(ConfFile)=0 then begin
     ShowScreen('LINUX_INSTALL_INFOS(' + inikey + ') unable to get configuration file path');
     exit;
  end;
  ini:=TIniFile.Create(ConfFile);
  result:=ini.ReadString('INSTALL',inikey,'');
  if length(result)=0 then ShowScreen('LINUX_INSTALL_INFOS([INSTALL]::' + inikey + ') this key has no datas');
  ini.Free;
  exit(result);
end;
//##############################################################################
function MyConf.LINUX_LDAP_INFOS(inikey:string):string;
var ConfFile:string;
ini:TiniFile;
begin

  ConfFile:=LINUX_CONFIG_INFOS();
  if length(ConfFile)=0 then begin
     writeln('LINUX_LDAP_INFOS(' + inikey + ') unable to get configuration file path');
     exit;
  end;
  ini:=TIniFile.Create(ConfFile);
  result:=ini.ReadString('LDAP',inikey,'');
  ini.Free;
  exit(result);
end;
//##############################################################################


//##############################################################################
function MyConf.LINUX_DISTRIBUTION():string;
var
   RegExpr:TRegExpr;
   FileTMP:TstringList;
   Filedatas:TstringList;
   i:integer;
   distri_name,distri_ver,distri_provider:string;
   D:boolean;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  if length(get_INFOS('LinuxDistribution'))>0 then begin
     exit(get_INFOS('LinuxDistribution'));
  end;

  RegExpr:=TRegExpr.Create;
  if FileExists('/etc/lsb-release') then begin
      if not FileExists('/etc/redhat-release') then begin
             if D then Writeln('/etc/lsb-release detected (not /etc/redhat-release detected)');
             fpsystem('/bin/cp /etc/lsb-release /opt/artica/logs/lsb-release');
             FileTMP:=TstringList.Create;
             FileTMP.LoadFromFile('/opt/artica/logs/lsb-release');
             for i:=0 to  FileTMP.Count-1 do begin
                 RegExpr.Expression:='DISTRIB_ID=(.+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_provider:=trim(RegExpr.Match[1]);
                 RegExpr.Expression:='DISTRIB_RELEASE=([0-9\.]+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_ver:=trim(RegExpr.Match[1]);
                 RegExpr.Expression:='DISTRIB_CODENAME=(.+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_name:=trim(RegExpr.Match[1]);
             end;

             result:=distri_provider + ' ' +  distri_ver + ' ' +  distri_name;
             set_INFOS('LinuxDistribution',result);
             RegExpr.Free;
             FileTMP.Free;
             exit();
      end;
  end;
  Filedatas:=TstringList.Create;
  if FileExists('/etc/debian_version') then begin
       if D then Writeln('/etc/debian_version detected');
       Filedatas:=TstringList.Create;
       Filedatas.LoadFromFile('/etc/debian_version');
       RegExpr.Expression:='([0-9\.]+)';
       if RegExpr.Exec(Filedatas.Strings[0]) then begin
          Set_infos('LinuxDistribution','Debian ' + RegExpr.Match[1] +' Gnu-linux');
          result:='Debian ' + RegExpr.Match[1] +' Gnu-linux';
          RegExpr.Free;
          Filedatas.Free;
          exit();
       end;
  end;
  //Fedora
  if FileExists('/etc/redhat-release') then begin
     Filedatas:=TstringList.Create;
     Filedatas.LoadFromFile('/etc/redhat-release');
     if D then Writeln('/etc/redhat-release detected -> ' + Filedatas.Strings[0]);

     RegExpr.Expression:='Fedora Core release\s+([0-9]+)';
     if RegExpr.Exec(Filedatas.Strings[0]) then begin
          Set_infos('LinuxDistribution','Fedora Core release ' + RegExpr.Match[1]);
          result:='Fedora Core release ' + RegExpr.Match[1];
          RegExpr.Free;
          Filedatas.Free;
          exit();
       end;
      RegExpr.Expression:='Fedora release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         Set_infos('LinuxDistribution','Fedora release ' + RegExpr.Match[1]);
         result:='Fedora release ' + RegExpr.Match[1];
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;

      //Mandriva
      RegExpr.Expression:='Mandriva Linux release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         Set_infos('LinuxDistribution','Mandriva Linux release ' + RegExpr.Match[1]);
         result:='Mandriva Linux release ' + RegExpr.Match[1];
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;
      //CentOS
      RegExpr.Expression:='CentOS release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         result:='CentOS release ' + RegExpr.Match[1];
         Set_infos('LinuxDistribution',result);
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;

    end;

   //Suse
   if FileExists('/etc/SuSE-release') then begin
       Filedatas:=TstringList.Create;
       Filedatas.LoadFromFile('/etc/SuSE-release');
       result:=trim(Filedatas.Strings[0]);
       Set_infos('LinuxDistribution',result);
       Filedatas.Free;
       exit;
   end;



end;
//##############################################################################
procedure MyConf.ShowScreen(line:string);
 begin
   writeln(line);
    logs.logs('MYCONF::' + line);
 END;
//##############################################################################
function MyConf.SYSTEM_KERNEL_VERSION():string;
begin
    exit(trim(ExecPipe('/bin/uname -r')));
end;
//##############################################################################
function MyConf.SYSTEM_LIBC_VERSION():string;
var
   head,returned,command:string;
   D:boolean;
   RegExpr:TRegExpr;
begin
///lib/libc.so.6 | /usr/bin/head -1

     D:=COMMANDLINE_PARAMETERS('debug');
     if FileExists('/usr/bin/head') then head:='/usr/bin/head';
     if length(head)=0 then begin
        if D then ShowScreen('SYSTEM_LIBC_VERSION:: unable to locate head tool');
        exit;
     end;

     if not fileExists('/lib/libc.so.6') then begin
        if D then ShowScreen('SYSTEM_LIBC_VERSION:: unable to stat /lib/libc.so.6');
        exit;
     end;
 command:='/lib/libc.so.6 | ' + head + ' -1';
 if D then ShowScreen('SYSTEM_LIBC_VERSION:: command="'+ command + '"');
 returned:=ExecPipe('/lib/libc.so.6 | ' + head + ' -1');
 if D then ShowScreen('SYSTEM_LIBC_VERSION:: returned="'+ returned + '"');
 RegExpr:=TRegExpr.Create;
 RegExpr.Expression:='version ([0-9\.]+)';
 if RegExpr.Exec(returned) then SYSTEM_LIBC_VERSION:=RegExpr.Match[1] else begin
      if D then ShowScreen('SYSTEM_LIBC_VERSION:: unable to match pattern');
      exit;
      end;
end;

//##############################################################################
function MyConf.SYSTEM_NETWORK_LIST_NICS():TStringList;
var
   list:TStringList;
   RegExpr,RegExprH,RegExprF,RegExprG,RegExprI:TRegExpr;
   i:integer;
   D,A:boolean;
   tmpstr:string;
begin
   A:=false;
   D:=COMMANDLINE_PARAMETERS('debug');
   if ParamStr(1)='-nics' then A:=true;
   tmpstr:=logs.FILE_TEMP();

   list:=TStringList.Create;
   ArrayList:=TStringList.Create;
   fpsystem('/sbin/ifconfig -a >'+tmpstr+' 2>&1');
   try
      list.LoadFromFile(tmpstr);
   except
      logs.logs('SYSTEM_NETWORK_LIST_NICS:: FATAL ERROR');
   end;

   logs.DeleteFile(tmpstr);
   logs.logs('SYSTEM_NETWORK_LIST_NICS:: include ' +INtToStr(list.Count) + ' parameters' );
      RegExpr:=TRegExpr.Create;
      RegExprH:=TRegExpr.Create;
      RegExprG:=TRegExpr.Create;
      RegExprF:=TRegExpr.Create;
      RegExprI:=TRegExpr.Create;
      RegExpr.Expression:='^([a-z0-9\:]+)\s+';
      RegExprF.Expression:='^vmnet([0-9\:]+)';
      RegExprG.Expression:='^sit([0-9\:]+)';
      RegExprH.Expression:='^([a-zA-Z0-9]+):avah';
      RegExprI.Expression:='pan([0-9]+)';

      for i:=0 to list.Count -1 do begin
        if D then ShowScreen('SYSTEM_NETWORK_LIST_NICS::"'+ list.Strings[i] + '"');
        if RegExpr.Exec(list.Strings[i]) then begin
           if not RegExprF.Exec(RegExpr.Match[1]) then begin
              if not RegExprH.Exec(RegExpr.Match[1]) then begin
                 if not RegExprI.Exec(RegExpr.Match[1]) then begin
                    if not RegExprG.Exec(RegExpr.Match[1]) then begin
                       if RegExpr.Match[1]<>'lo' then begin
                          if D then writeln('SYSTEM_NETWORK_LIST_NICS:: ^([a-z0-9\:]+)\s+=>"'+ list.Strings[i] + '"');
                          ArrayList.Add(RegExpr.Match[1]);
                          if A then writeln(RegExpr.Match[1]);
                       end;
                    end;
                 end;
              end;
           end;
        end;
   end;
   result:=ArrayList;
    List.Free;
    RegExpr.free;
    RegExprF.free;
    RegExprH.free;
    RegExprG.free;

end;

//##############################################################################
function MyConf.SYSTEM_NETWORK_INFO_NIC(nicname:string):string;
begin
    result:='';

     if FileExists('/etc/network/interfaces') then begin
         logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC :: Debian system');
         result:=SYSTEM_NETWORK_INFO_NIC_DEBIAN(nicname);
         exit;
     end;

     if DirectoryExists('/etc/sysconfig/network-scripts') then begin
      logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC :: redhat system');
      result:=SYSTEM_NETWORK_INFO_NIC_REDHAT(nicname);
      exit;
     end;

     if DirectoryExists('/etc/sysconfig/network/scripts') then begin
      logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC :: redhat system');
      result:=SYSTEM_NETWORK_INFO_NIC_REDHAT(nicname);
      exit;
     end;


end;
//##############################################################################
procedure MyConf.SYSTEM_NETWORKS_SET_NIC(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
begin
     if FileExists('/etc/network/interfaces') then begin
         logs.Debuglogs('SYSTEM_NETWORK_SET_NIC :: Debian system');
         SYSTEM_NETWORKS_SET_NIC_DEBIAN(nicname,ipadress,netmask,gateway,dhcp);
         exit;
     end;

     if DirectoryExists('/etc/sysconfig/network-scripts') then begin
        logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC :: redhat system');
        SYSTEM_NETWORKS_SET_NIC_REDHAT(nicname,ipadress,netmask,gateway,dhcp);
        exit;
     end;


     if DirectoryExists('/etc/sysconfig/network/scripts') then begin
        logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC :: redhat system');
        SYSTEM_NETWORKS_SET_NIC_REDHAT(nicname,ipadress,netmask,gateway,dhcp);
        exit;
     end;


end;
//##############################################################################
procedure MyConf.SYSTEM_NETWORKS_SET_NIC_DEBIAN(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
var
   RegExpr:TRegExpr;
   i:integer;
   l:TstringList;
   auto_line:integer;
   startline:integer;
   endline:integer;
begin
   if not FileExists('/etc/network/interfaces') then begin
      logs.SYSLOGS('WARNING unable to stat /etc/network/interfaces');
      exit;
   end;
   RegExpr:=TRegExpr.Create;

   l:=TstringList.Create;

   l.LoadFromFile('/etc/network/interfaces');

   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^auto\s+'+nicname;
       if RegExpr.Exec(l.Strings[i]) then begin
           auto_line:=i;
           logs.Debuglogs('Delete line ' + l.Strings[i]);
           l.Delete(auto_line);
           break;
       end;
   end;
  startline:=0;
  endline:=0;

  for i:=0 to l.Count-1 do begin
     if startline=0 then begin
        RegExpr.Expression:='^iface.+?'+nicname;
        if RegExpr.Exec(l.Strings[i]) then begin
           logs.Debuglogs('Start line ' + l.Strings[i]);
           startline:=i;
           continue;
        end;
     end;

     if startline>0 then begin
        RegExpr.Expression:='^iface.+';
        if RegExpr.Exec(l.Strings[i]) then begin
           logs.Debuglogs('End line ' + l.Strings[i-1]);
           endline:=i-1;
           break;
        end;
     end;
  end;
  RegExpr.free;
  if (startline>0) and (endline=0) then endline:=l.Count-1;


  for i:=startline to endline do begin
      l.Delete(startline);
  end;

  if dhcp='yes' then begin
     l.Add('auto ' + nicname);
     l.Add('iface ' + nicname+' inet dhcp');
     l.add('');
     l.SaveToFile('/etc/network/interfaces');
     l.Free;
     exit;
  end;

     l.Add('auto ' + nicname);
     l.Add('iface ' + nicname+' inet static');
     l.Add(chr(9)+'address ' +ipadress);
     l.Add(chr(9)+'gateway ' +gateway);
     l.Add(chr(9)+'netmask ' +netmask);
     l.SaveToFile('/etc/network/interfaces');
     l.Free;

     if fileExists('/sbin/ifup') then begin
        fpsystem('/sbin/ifdown ' + nicname);
        fpsystem('/sbin/ifup ' + nicname+ ' &');
        halt(0);
     end;

     if FileExists('/etc/init.d/networking') then fpsystem('/etc/init.d/networking restart &');

end;
//##############################################################################
procedure myconf.SYSTEM_NETWORKS_SET_HOSTNAME(name:string);
var
   RegExpr:TRegExpr;
   domainName:string;
   sysctl:string;
begin
    name:=trim(name);
    if length(name)=0 then exit;
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='^(.+?)\.(.+?)$';
    if RegExpr.Exec(name) then begin
       name:=RegExpr.Match[1];
       domainName:=RegExpr.Match[2];
    end;

    if FileExists('/etc/hostname') then begin
       logs.Debuglogs('SYSTEM_NETWORKS_SET_HOSTANME:: Change hostname is debian mode');
       logs.WriteToFile(trim(name),'/etc/hostname');

    end;

    if FileExists('/etc/HOSTNAME') then begin
       logs.Debuglogs('SYSTEM_NETWORKS_SET_HOSTANME:: Change hostname is redhat mode');
       logs.WriteToFile(trim(name),'/etc/HOSTNAME');
    end;

    if FileExists('/etc/hostname') then begin
       logs.Debuglogs('SYSTEM_NETWORKS_SET_HOSTANME:: Change hostname is ubuntu');
       logs.WriteToFile(trim(name),'/etc/HOSTNAME');
    end;

    sysctl:=SYS.LOCATE_GENERIC_BIN('sysctl');
    if length(domainName)>0 then begin
       writeln('domainname='+domainName);
       fpsystem(sysctl+' -w kernel.domainname='+domainName);
    end;
    fpsystem(sysctl+' -w kernel.hostname='+name);
    fpsystem(sysctl+' -p');

    SYSTEM_NETWORKS_SET_HOSTNAME_IN_HOSTS(name);
    if FileExists('/etc/init.d/hostname.sh') then fpsystem('/etc/init.d/hostname.sh start &');


end;
//##############################################################################
procedure myconf.SYSTEM_NETWORKS_SET_HOSTNAME_IN_HOSTS(name:string);
var
   l:TstringList;
   RegExpr:TRegExpr;
   domain:string;
   i:Integer;
   c:integer;
begin
l:=TstringList.Create;
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='^127[0-5\.]+\s+.+';
l.LoadFromFile('/etc/hosts');
c:=0;
for i:=0 to L.Count-1 do begin
 if RegExpr.Exec(l.Strings[c]) then begin
    logs.Debuglogs('Delete line ' + intToStr(c)+' "' + l.Strings[c]+'"');
    l.Delete(c);
    c:=c-1;
 end else begin
   logs.Debuglogs('skip line ' + intToStr(c)+' "' + l.Strings[c]+'"');
 end;
 c:=c+1;
 if c=l.Count-1 then break;
end;
domain:='.localhost';
RegExpr.Expression:='(.+?)\.(.+)';
if RegExpr.Exec(name) then begin
   domain:='.'+RegExpr.Match[2];
   name:=RegExpr.Match[1];
end;

l.Add('127.0.0.1'+chr(9)+'localhost.localdomain'+chr(9)+'localhost');
l.Add('127.0.0.1'+chr(9)+name+domain+chr(9)+name);
l.Add('127.0.0.2'+chr(9)+name+domain+chr(9)+name);
l.Add('');

l.SaveToFile('/etc/hosts');
l.Clear;


if FileExists('/etc/sysconfig/network') then begin
   RegExpr.Expression:='^HOSTNAME';
   l.LoadFromFile('/etc/sysconfig/network');
   for i:=0 to l.Count-1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
         l.Strings[i]:='HOSTNAME='+name;
         l.SaveToFile('/etc/sysconfig/network');
         fpsystem('hostname '+name);
         break;
      end;
   end;
end;


l.free;
RegExpr.free;
end;
//##############################################################################








procedure myconf.SYSTEM_NETWORKS_SET_NIC_REDHAT(nicname:string;ipadress:string;netmask:string;gateway:string;dhcp:string);
var
   TargetFolder:string;
   TargetFile:string;
   l:TstringList;
   BOOTPROTO:string;
   STARTMODE:string;
   USERCONTROL:string;
begin
TargetFolder:='';
if FileExists('/etc/sysconfig/network-scripts/ifcfg-lo') then TargetFolder:='/etc/sysconfig/network-scripts';
if FileExists('/etc/sysconfig/network/ifcfg-lo') then TargetFolder:='/etc/sysconfig/network';

logs.Debuglogs('SYSTEM_NETWORKS_SET_NIC_REDHAT:: TargetFolder='+TargetFolder);


if length(TargetFolder)=0 then begin
   logs.Debuglogs('SYSTEM_NETWORKS_SET_NIC_REDHAT:: TargetFolder=null aborting');
   exit;
end;


TargetFile:=TargetFolder+'/ifcfg-'+nicname;
if(dhcp='yes') then BOOTPROTO:='dhcp' else BOOTPROTO:='static';
STARTMODE:='auto';
USERCONTROL:='no';
l:=TstringList.Create;
l.Add('DEVICE='''+nicname+'''');
l.Add('BOOTPROTO='''+BOOTPROTO+'''');
l.Add('IPADDR='''+ipadress+'''');
l.Add('NETMASK='''+netmask+'''');
l.Add('STARTMODE='''+STARTMODE+'''');
l.Add('USERCONTROL='''+USERCONTROL+'''');
l.Add('GATEWAY='''+gateway+'''');

try
   l.SaveToFile(TargetFile);
except
   logs.Debuglogs('SYSTEM_NETWORKS_SET_NIC_REDHAT:: FATAL error while saving '+TargetFile);
   exit;
end;

    if fileExists('/sbin/ifup') then begin
        logs.OutputCmd('/sbin/ifdown ' + nicname);
        logs.OutputCmd('/sbin/ifup ' + nicname+ ' &');
        exit;
     end;
    l.free;
end;
//##############################################################################
function MyConf.SYSTEM_NETWORK_INFO_NIC_REDHAT(nicname:string):string;
var
   CatchList:TstringList;
   list:Tstringlist;
   i:Integer;
   configfile:string;
begin
  result:='';
  CatchList:=TStringList.create;
  CatchList.Add('METHOD=redhat');
  configfile:='';

  if fileExists('/etc/sysconfig/network-scripts/ifcfg-' + nicname) then  configfile:='/etc/sysconfig/network-scripts/ifcfg-' + nicname;
  if fileExists('/etc/sysconfig/network/ifcfg-' + nicname) then  configfile:='/etc/sysconfig/network/ifcfg-' + nicname;
  if length(configfile)=0 then exit;
  list:=TStringList.Create;
  if fileExists('/etc/sysconfig/network-scripts/ifcfg-' + nicname) then begin
        list.LoadFromFile('/etc/sysconfig/network-scripts/ifcfg-' + nicname);
        for i:=0 to list.Count-1 do begin
             CatchList.Add(list.Strings[i]);

        end;

  end;
 ArrayList:=TStringList.create;
 for i:=0 to CatchList.Count-1 do begin
         if ParamStr(1)='-nic-info' then  writeln(CatchList.Strings[i]);
          ArrayList.Add(CatchList.Strings[i]);
    end;
  CatchList.free;
  list.free;


end;

//##############################################################################
function MyConf.SYSTEM_NETWORK_IFCONFIG():string;
         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;

var
   D:boolean;
   resultats:string;
   i:integer;
begin
 SYSTEM_NETWORK_LIST_NICS();
 D:=COMMANDLINE_PARAMETERS('debug');
 resultats:='';

 for i:=0 to ArrayList.Count-1 do begin
    if D then ShowScreen('SYSTEM_NETWORK_IFCONFIG:: Parse ' + ArrayList.Strings[i]);
       resultats:=resultats + '[' + ArrayList.Strings[i] + ']'+CRLF;
       resultats:=resultats + SYSTEM_NETWORK_IFCONFIG_ETH(ArrayList.Strings[i]) + CRLF;
 end;
   exit(resultats);

end;
//#############################################################################
function MyConf.SYSTEM_ALL_IPS():string;
var
   A,D:boolean;
   LIST:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   LINE:String;

begin
   A:=False;
   D:=False;
   D:=COMMANDLINE_PARAMETERS('debug');
   result:='';
   if ParamStr(1)='-allips' then A:=True;
   LIST:=TstringList.Create;
   ArrayList:=TstringList.Create;


   fpsystem('/sbin/ifconfig -a >/opt/artica/logs/ifconfig.tmp');
   list.LoadFromFile('/opt/artica/logs/ifconfig.tmp');


   if D then ShowScreen('SYSTEM_ALL_IPS:: return '+ IntToStr(list.Count) + ' lines');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='inet (adr|addr):([0-9\.]+)';
   for i:=0 to list.Count-1 do begin
           if RegExpr.Exec(list.Strings[i]) then begin
              LINE:=RegExpr.Match[2];
              IF A then writeln(LINE);
              if D then writeln('SYSTEM_ALL_IPS: ',LINE);
              ArrayList.Add(LINE);
           end;
    end;
    RegExpr.free;
    LIST.Free;
end;
//#############################################################################
function MyConf.SYSTEM_PROCESS_PS():string;
var
   A,D:boolean;
   LIST:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   LINE:String;

begin
   result:='';
   A:=False;
   D:=False;
   D:=COMMANDLINE_PARAMETERS('debug');
   if ParamStr(1)='-ps' then A:=True;
   LIST:=TstringList.Create;
   ArrayList:=TstringList.Create;
   fpsystem('/bin/ps --no-heading -eo user:80,pid,pcpu,vsz,nice,etime,time,stime,args|sort -nbk 3|tail -50 >/opt/artica/tmp/taskmanager 2>&1');

   list.LoadFromFile('/opt/artica/tmp/taskmanager');
   if D then ShowScreen('SYSTEM_PROCESS_PS:: return '+ IntToStr(list.Count) + ' lines');
   RegExpr:=TRegExpr.Create;
   RegExpr.expression:='^(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+)';
   for i:=0 to list.Count-1 do begin
           if RegExpr.Exec(list.Strings[i]) then begin
              LINE:=RegExpr.Match[1]+';'+RegExpr.Match[2]+';'+RegExpr.Match[3]+';'+RegExpr.Match[4]+';'+RegExpr.Match[5]+';'+RegExpr.Match[6]+';'+RegExpr.Match[7]+';'+RegExpr.Match[8]+';'+RegExpr.Match[9] + ';'+SYSTEM_PROCESS_INFO(RegExpr.Match[2]);
              IF A then writeln(LINE);
              ArrayList.Add(LINE);
           end;
    end;
    RegExpr.free;
    LIST.Free;
end;



//#############################################################################
function MyConf.SYSTEM_PROCESS_INFO(PID:string):string;
var
   LIST:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   Resultats:string;
begin
 Resultats:='';
 if not FileExists('/proc/' + trim(PID) + '/status') then exit;
 LIST:=TstringList.Create;
 LIST.LoadFromFile('/proc/' + trim(PID) + '/status');
   RegExpr:=TRegExpr.Create;
   RegExpr.expression:='(.+?):\s+(.+)';
 for i:=0 to list.Count-1 do begin
     if RegExpr.Exec(list.Strings[i]) then begin
       Resultats:=Resultats +trim(RegExpr.Match[1])+'=' + trim(RegExpr.Match[2])+',';
     end;
 end;
     RegExpr.free;
    LIST.Free;
 exit(resultats);
end;
//#############################################################################

function MyConf.SYSTEM_NETWORK_IFCONFIG_ETH(ETH:string):string;
         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;

var
   D:boolean;
   RegExpr:TRegExpr;
   list:Tstringlist;
   resultats:string;
   i:integer;
begin
 D:=COMMANDLINE_PARAMETERS('debug');
 list:=TstringList.Create;
 list.LoadFromStream(ExecStream('/sbin/ifconfig -a ' + ETH,false));
 RegExpr:=TRegExpr.Create;
 resultats:='';
 for i:=0 to list.Count-1 do begin
    if D then ShowScreen('SYSTEM_NETWORK_IFCONFIG_ETH:: '+ ETH + 'parse '  + list.Strings[i]);
    RegExpr.Expression:='HWaddr\s+([0-9A-Z]{1,2}:[0-9A-Z]{1,2}:[0-9A-Z]{1,2}:[0-9A-Z]{1,2}:[0-9A-Z]{1,2}:[0-9A-Z]{1,2})';
    if RegExpr.Exec(list.Strings[i]) then resultats:=resultats + 'MAC='+ RegExpr.Match[1] + CRLF;

    RegExpr.Expression:='(Masque|Mask):([0-9\.]+)';
    if RegExpr.Exec(list.Strings[i]) then resultats:=resultats + 'NETMASK='+ RegExpr.Match[2] + CRLF;

    RegExpr.Expression:='inet (adr|addr):([0-9\.]+)';
    if RegExpr.Exec(list.Strings[i]) then resultats:=resultats + 'IPADDR='+ RegExpr.Match[2] + CRLF;

 end;
 if not FileExists('/usr/sbin/ethtool') then ShowScreen('SYSTEM_NETWORK_IFCONFIG_ETH:: unable to stat /usr/sbin/ethtool');
 list.LoadFromStream(ExecStream('/usr/sbin/ethtool ' + ETH,false));
 if D then ShowScreen('SYSTEM_NETWORK_IFCONFIG_ETH:: ' + ETH + ' ethtool report ' + IntToStr(list.Count) + ' lines');
 RegExpr.Expression:='\s+([a-zA-Z0-9\s+]+):\s+(.+)';
  for i:=0 to list.Count-1 do begin
       if RegExpr.Exec(list.Strings[i]) then resultats:= resultats+ RegExpr.Match[1] + '='+ RegExpr.Match[2] + CRLF;
  end;

 exit(resultats);
end;
//#############################################################################
function MyConf.SYSTEM_NETWORK_RECONFIGURE():string;
var
    D:boolean;
    list:Tstringlist;
    i:integer;
begin
   D:=COMMANDLINE_PARAMETERS('debug');
   result:='';
   if FileExists('/etc/network/interfaces') then begin
        if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: SYSTEM DEBIAN');
        if not FileExists(get_ARTICA_PHP_PATH() + '/ressources/conf/debian.interfaces') then begin
              if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: WARNING !!! unable to stat ' + get_ARTICA_PHP_PATH() + '/ressources/conf/debian.interfaces');
        end;

        fpsystem('/bin/mv  ' + get_ARTICA_PHP_PATH() + '/ressources/conf/debian.interfaces /etc/network/interfaces');
        fpsystem('/etc/init.d/networking force-reload');

   end;

   if DirectoryExists('/etc/sysconfig/network-scripts') then begin
      if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: SYSTEM REDHAT');
      if not FileExists(get_ARTICA_PHP_PATH() + '/ressources/conf/eth.list') then begin
         if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: WARNING !! unable to stat "'+ get_ARTICA_PHP_PATH() + '/ressources/conf/eth.list"');
      end;

      list:=Tstringlist.Create;
      List.LoadFromFile(get_ARTICA_PHP_PATH() + '/ressources/conf/eth.list');
      for i:=0 to list.Count-1 do begin
           if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: -> Modifyl/add ' +list.Strings[i]);
           fpsystem('/bin/mv ' + get_ARTICA_PHP_PATH() + '/ressources/conf/' + list.Strings[i] + ' /etc/sysconfig/network-scripts/');

      end;
      fpsystem('/bin/rm ' + get_ARTICA_PHP_PATH() + '/ressources/conf/eth.list');

      if FileExists(get_ARTICA_PHP_PATH() + '/ressources/conf/eth.del') then begin
          List.LoadFromFile(get_ARTICA_PHP_PATH() + '/ressources/conf/eth.del');
         for i:=0 to list.Count-1 do begin
             if D Then ShowScreen('SYSTEM_NETWORK_RECONFIGURE:: -> Delete ' +list.Strings[i]);
             if FileExists('/etc/sysconfig/network-scripts/' + list.Strings[i]) then fpsystem('/bin/rm /etc/sysconfig/network-scripts/' + list.Strings[i]);
         end;
         fpsystem('/bin/rm ' + get_ARTICA_PHP_PATH() + '/ressources/conf/eth.del');
      end;


      fpsystem('/etc/init.d/network restart');
   end;

end;
//#############################################################################




function MyConf.SYSTEM_NETWORK_INFO_NIC_DEBIAN(nicname:string):string;
var
   RegExpr:TRegExpr;
   l:TstringList;
   i:integer;
   startline:integer;
   endline:integer;
   CatchList:TstringList;
   final_text:string;
   key:string;
begin
        if not FileExists('/etc/network/interfaces') then begin
           logs.Debuglogs('Unable to stat /etc/network/interfaces');
           exit;
        end;



   if not FileExists('/etc/network/interfaces') then begin
      logs.SYSLOGS('WARNING unable to stat /etc/network/interfaces');
      exit;
   end;
   RegExpr:=TRegExpr.Create;

   l:=TstringList.Create;

   l.LoadFromFile('/etc/network/interfaces');

  startline:=0;
  endline:=0;

  for i:=0 to l.Count-1 do begin
     if startline=0 then begin
        RegExpr.Expression:='^iface.+?'+nicname;
        if RegExpr.Exec(l.Strings[i]) then begin
           startline:=i;
           continue;
        end;
     end;

     if startline>0 then begin
        RegExpr.Expression:='^iface.+';
        if RegExpr.Exec(l.Strings[i]) then begin
           endline:=i-1;
           break;
        end;
     end;
  end;

  if (startline>0) and (endline=0) then endline:=l.Count-1;

  logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC_DEBIAN:: From (' + IntToStr(startline) + ') line number to (' + IntToStr(endline)+') line number total='+ IntToStr(l.count));
  RegExpr.FRee;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^iface\s+'+nicname+'.+?(static|dhcp)';
  if RegExpr.Exec(l.Strings[startline]) then begin
      logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC_DEBIAN:: detect ' + RegExpr.Expression + '=' + l.Strings[startline] + ' "' + RegExpr.Match[1] +'"');
  end;
  CatchList:=TStringList.Create;
  CatchList.Add('BOOTPROTO=' +  RegExpr.Match[1]);
  CatchList.Add('METHOD=debian');
  CatchList.Add('DEVICE='+nicname);

  RegExpr.FRee;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(.+?)\s+(.+)';
  l.free;
  l:=TstringList.Create;
  l.LoadFromFile('/etc/network/interfaces');
  i:=0;
  startline:=startline+1;
  for i:=startline to endline do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          key:=trim(RegExpr.Match[1]);
          if key='address' then key:='IPADDR';
          if key='netmask' then key:='NETMASK';
          if key='gateway' then key:='GATEWAY';
          if key='broadcast' then key:='BROADCAST';
          if key='network' then key:='NETWORK';
          if key='metric' then key:='METRIC';
          CatchList.Add(key + '=' + RegExpr.Match[2]);
         logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC_DEBIAN:: detect ' + key+' = '+ RegExpr.Match[2]);
       end else begin
           logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC_DEBIAN:: failed to detect ' + l.Strings[i] + ' width ' + RegExpr.Expression);
       end;

  end;
   final_text:=CatchList.Text;
   result:=final_text;
   logs.Debuglogs('SYSTEM_NETWORK_INFO_NIC_DEBIAN::' + result);
   CatchList.free;
   l.free;
   RegExpr.Free;

end;
//##############################################################################


function MyConf.SYSTEM_GET_ALL_LOCAL_IP():string;
var
   list:TStringList;
   hash: THashStringList;
   RegExpr:TRegExpr;
   i:integer;
   D:boolean;
   virgule:string;
begin

   result:='';
   D:=COMMANDLINE_PARAMETERS('debug');
   list:=TStringList.Create;
   list.LoadFromStream(ExecStream('/sbin/ifconfig -a',false));
   hash:=  THashStringList.Create;
   for i:=1 to list.Count -1 do begin
      RegExpr:=TRegExpr.Create;
      RegExpr.Expression:='^([a-z0-9\:]+)\s+';
      if RegExpr.Exec(list.Strings[i]) then begin
         if D then ShowScreen('SYSTEM_GET_ALL_LOCAL_IP:: Found NIC "' + RegExpr.Match[1] + '"');
         hash[RegExpr.Match[1]] :=SYSTEM_GET_LOCAL_IP(RegExpr.Match[1]);
      end;
      RegExpr.Free;

   end;

    list.free;
    for i:=0 to hash.Count-1 do begin

        if length(hash[hash.HashCodes[i]])>0 then begin
           if ParamStr(1)='-iplocal' then writeln('NIC -> ',hash.HashCodes[i] + ':' + hash[hash.HashCodes[i]] + ':',i);
           virgule:=',';
           result:=result + hash[hash.HashCodes[i]] + virgule;
        end;

    end;

  if Copy(result,length(result),1)=',' then begin
     result:=Copy(result,1,length(result)-1);
  end;
  hash.Free;

end;
//##############################################################################
function myconf.SYSTEM_GET_LOCAL_DNS():string;
var
   bind9:tbind9;
   dnsmasq:tdnsmasq;
   forwarders:string;
   RegExpr:TRegExpr;
   i:integer;
   l:TstringList;
begin
   bind9:=tbind9.Create(SYS);
   dnsmasq:=Tdnsmasq.Create(SYS);
   if FileExists(bind9.bin_path()) then begin
        logs.Debuglogs('SYSTEM_GET_LOCAL_DNS():: bind9 is installed');
        forwarders:=bind9.forwarders();
   end else begin
       if fileExists(dnsmasq.DNSMASQ_BIN_PATH()) then begin
           forwarders:=dnsmasq.Forwarders();
       end;
   end;
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^nameserver\s+(.+)';
   l:=TstringList.Create;
   try
      l.LoadFromFile('/etc/resolv.conf');
   except
       logs.Syslogs('myconf.SYSTEM_GET_LOCAL_DNS():: FATAL ERROR while reading /etc/resolv.conf');
       l.free;
   end;

      for i:=0 to l.Count-1 do begin
           if RegExpr.Exec(l.Strings[i]) then begin
                 if trim(RegExpr.Match[1])='127.0.0.1' then begin
                       if length(forwarders)>0 then result:=result + forwarders;
                 end else begin
                     result:=result + trim(RegExpr.Match[1])+';';
                 end;
           end;
      end;

l.free;
RegExpr.free;
end;
//##############################################################################
function MyConf.SYSTEM_GET_LOCAL_GATEWAY(ifname:string):string;
var
   tmp:string;
   RegExpr:TRegExpr;
   l:TstringList;
   i:integer;
   D:boolean;
begin
D:=false;
d:=logs.COMMANDLINE_PARAMETERS('--verbose');
if d then writeln('');
result:='0.0.0.0';
tmp:=LOGS.FILE_TEMP();
fpsystem('/sbin/route -n >' + tmp + ' 2>&1');
if not FileExists(tmp) then exit();
RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^0.0.0.0\s+([0-9\.]+).+?'+ifname;
   l:=TstringList.Create;
   l.LoadFromFile(tmp);

for i:=0 to l.Count-1 do begin
           if RegExpr.Exec(l.Strings[i]) then begin
              if d then writeln('/sbin/route -n match ',l.Strings[i]);
              result:=RegExpr.Match[1];
              break;
           end;
end;
if d then writeln('');
l.free;
RegExpr.free;

end;
//##############################################################################
function MyConf.SYSTEM_GET_LOCAL_IP(ifname:string):string;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.SYSTEM_GET_LOCAL_IP(ifname);
 tt.free;
end;
//##############################################################################
function MyConf.SYSTEM_GET_LOCAL_MASK(ifname:string):string;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.IP_MASK_INTERFACE(ifname);
 tt.free;
end;

//##############################################################################

function MyConf.SYSTEM_GET_LOCAL_BROADCAST(ifname:string):string;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.IP_BROADCAST_INTERFACE(ifname);
 tt.free;
end;
//##############################################################################

function MyConf.SYSTEM_GET_LOCAL_MAC(ifname:string):string;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.LOCAL_MAC(ifname);
 tt.free;
end;
//##############################################################################
function MyConf.InterfacesList(): String;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.InterfacesList();
 tt.free;
end;
//##############################################################################

function MyConf.IsWireless(ifname:string): boolean;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.IsWireless(ifname);
 tt.free;
end;
//##############################################################################
function MyConf.IsIfaceDown(ifname:string): boolean;
var
 tt:ttcpip;
begin
 tt:=ttcpip.Create;
 result:=tt.IsIfaceDown(ifname);
 tt.free;
end;
//##############################################################################

function MyConf.SYSTEM_PROCESS_EXISTS(processname:string):boolean;
begin
   result:=SYS.PROCESS_EXISTS_BY_NAME(processname);
end;
//##############################################################################
function MyConf.SYSTEM_PROCESS_LIST_PID(processname:string):string;
begin
   result:=SYS.PROCESS_LIST_PID(processname);
end;
//##############################################################################
procedure myconf.POSTFIX_CONFIGURE_MAIN_CF();
begin
fpsystem('/bin/chown root:root /etc/postfix/main.cf /etc/postfix/master.cf >/dev/null 2>&1' );
postfix.POSTFIX_STOP();
postfix.POSTFIX_START();
end;
//##############################################################################
function myconf.XINETD_BIN():string;
begin
    if FileExists('/usr/sbin/xinetd') then exit('/usr/sbin/xinetd');
end;
//##############################################################################
function myconf.SYSTEM_GET_FOLDERSIZE(folderpath:string):string;
var
   RegExpr      :TRegExpr;
   s1Logs       :Tlogs;
begin
   RegExpr:=TRegExpr.Create;
   s1Logs:=TLogs.Create;
   if folderpath='/opt/artica' then exit;
   if not FileExists(SYS.DU_PATH()) then begin
      logs.Syslogs('SYSTEM_GET_FOLDERSIZE:: unable to stat any "du" tool');
   end;

 if SYS.PROCESS_EXIST(SYS.PIDOF(SYS.DU_PATH())) then begin
    logs.Debuglogs('Other instance of du exists, aborting');
     exit;
 end;
 RegExpr.Expression:='(.+)\s+'+folderpath;
 if RegExpr.Exec(ExecPipe(SYS.DU_PATH()+' -c -s -h ' + folderpath)) then result:=RegExpr.Match[1];
 RegExpr.Free;
 s1Logs.free;


end;
//##############################################################################
procedure myconf.DeleteFile(Path:string);
begin
if PathIsDirectory(Path) then exit;

   if FileExists(Path) then begin
     fpsystem('/bin/rm -f ' + path + ' >/dev/null 2>&1');
   end;

end;
//##############################################################################
PROCEDURE myconf.BuildDeb(targetfile:string;targetversion:string);
var
   RegExpr      :TRegExpr;
   L            :TstringList;
   i            :integer;
begin
  if Not FileExists(targetfile) then exit;
  L:=TStringList.Create;
  L.LoadFromFile(targetfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='Version:';
  for i:=0 to L.Count-1 do begin
   if RegExpr.Exec(l.Strings[i]) then begin
      l.Strings[i]:='Version: ' + targetversion;
      l.SaveToFile(targetfile);
      break;
   end;
  end;
end;


PROCEDURE myconf.RRDTOOL_FIX();
var logs:Tlogs;
begin
    logs:=Tlogs.Create;
    forcedirectories('/opt/artica/bin');
    if not FileExists('/opt/artica/bin/rrdtool') then begin
       if FileExists(RRDTOOL_BIN_PATH()) then begin
          logs.Debuglogs('RRDTOOL_FIX:: create symlink -> '+RRDTOOL_BIN_PATH());
          ln(RRDTOOL_BIN_PATH(),'/opt/artica/bin/rrdtool');
       end;
    end;
    logs.Debuglogs('RRDTOOL_FIX:: end..');
end;
//##############################################################################
function myconf.FileSize_ko(path:string):longint;
begin
result:=SYS.FileSize_ko(path);
end;
//##############################################################################
function myconf.SYSTEM_FILE_MIN_BETWEEN_NOW(filepath:string):LongInt;
begin
result:=SYSTEM_FILE_BETWEEN_NOW(filepath);
end;
//##############################################################################
function myconf.SYSTEM_FILE_BETWEEN_NOW(filepath:string):LongInt;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
if not FileExists(filepath) then exit(0);
    fa:=FileAge(filepath);
    maint:=Now;
    S:=FileDateTodateTime(fa);
    result:=MinutesBetween(maint,S);
end;
//##############################################################################
function myconf.SYSTEM_FILE_SECONDS_BETWEEN_NOW(filepath:string):LongInt;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
if not FileExists(filepath) then exit(0);
    fa:=FileAge(filepath);
    maint:=Now;
    S:=FileDateTodateTime(fa);
    result:=SecondsBetween(maint,S);
end;
//##############################################################################
function myconf.SYSTEM_FILE_DAYS_BETWEEN_NOW(filepath:string):LongInt;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
if not FileExists(filepath) then exit(0);
    fa:=FileAge(filepath);
    maint:=Now;
    S:=FileDateTodateTime(fa);
    result:=DaysBetween(maint,S);
end;
//##############################################################################
function myconf.SYSTEM_FILE_TIME(filepath:string):string;
var
   fa   : Longint;
   S    : TDateTime;
   maintenant : Tsystemtime;
   zDate:string;
   XFL:Tlogs;
begin
if not FileExists(filepath) then exit('');
    XFL:=Tlogs.Create;
    fa:=FileAge(filepath);
    S:=FileDateTodateTime(fa);
    DateTimeToSystemTime(S,maintenant);
   zDate := XFL.FormatHeure(maintenant.Year)+'-' +XFL.FormatHeure(maintenant.Month)+ '-' + XFL.FormatHeure(maintenant.Day)+ chr(32)+XFL.FormatHeure(maintenant.Hour)+':'+XFL.FormatHeure(maintenant.minute)+':'+ XFL.FormatHeure(maintenant.second);
   XFL.Free;
   result:=zDate;
end;
//##############################################################################

procedure myconf.StatFile(path:string);
var
    info : stat;
    S    : TDateTime;
    fa   : Longint;
    maint:TDateTime;
begin
if not FileExists(path) then begin
   writeln('not a file');
   if Not DirectoryExists(path) then begin
      writeln('not a dir');
      exit;
    end;
end;
  if fpstat(path,info)<>0 then
     begin
       writeln('Fstat failed. Errno : ',fpgeterrno);
       halt (1);
     end;
  writeln;
  writeln ('Result of fstat on file ' + path);
  writeln ('Inode         : ',info.st_ino);
  writeln ('Mode          : ',info.st_mode);
  writeln ('nlink         : ',info.st_nlink);
  writeln ('uid           : ',info.st_uid);
  writeln ('gid           : ',info.st_gid);
  writeln ('rdev          : ',info.st_rdev);
  writeln ('Size          : ',info.st_size);
  writeln ('Blksize       : ',info.st_blksize);
  writeln ('Blocks        : ',info.st_blocks);
  writeln ('atime         : ',info.st_atime);
  writeln ('mtime         : ',info.st_mtime);
  writeln ('ctime         : ',info.st_ctime);
  writeln ('Human Date    : ',SYSTEM_FILE_TIME(path));


  if FileSymbolicExists(path) then begin
  writeln ('Symbolic      : ','Yes');
  writeln ('Link          : ',fpReadlink(path));


  StatFileSymbolic(path);
  end else begin
  writeln ('Symbolic      : ','No');
  end;

  writeln ('Directory     : ',PathIsDirectory(path));



   fa:=FileAge(path);
   maint:=Now;
  If Fa<>-1 then begin
    S:=FileDateTodateTime(fa);
    writeln ('From    : ',DateTimeToStr(S));
  end;
  writeln ('Between : ',MinutesBetween(maint,S),' minutes');

end;
function myconf.MD5FromFile(path:string):string;
var
Digest:TMD5Digest;
begin
Digest:=MD5File(path);
exit(MD5Print(Digest));
end;
//##############################################################################
function myconf.ln(frompath:string;topath:string):boolean;
var
s:string;
logs:Tlogs;
begin
    logs:=Tlogs.Create;
    result:=true;
    if Not FileExists(frompath) then begin
       logs.Syslogs('Unable to create a symbolic link ' + frompath + 'does not exists');
       exit;
    end;
    try
       if FileSymbolicExists(topath) then begin
          s:=fpReadlink(topath);
          if s=frompath then exit(true);
       end;
    except
      logs.Debuglogs('FATAL ERROR  myconf.ln() function on FileSymbolicExists() return back');
      exit;
    end;

    try
    If  fpSymLink (PChar(frompath),PChar(topath))<>0 then begin
        logs.logs('Error linking ' + frompath + ' to ' +topath + ' E=' + IntToStr(fpgeterrno));
        exit(false);
    end;
    except
       logs.Debuglogs('FATAL ERROR  myconf.ln() function on fpSymLink() return');
      exit;
    end;


end;
//##############################################################################

function myconf.MD5FromString(value:string):string;
var
Digest:TMD5Digest;
begin
Digest:=MD5String(value);
exit(MD5Print(Digest));
end;
//##############################################################################
function myconf.FileSymbolicExists(path:string):boolean;
var
info :stat;
begin
result:=false;
if Not FileExists(path) then exit;
 if fpLStat (path,@info)=0 then
    begin
    if fpS_ISLNK(info.st_mode) then exit(true);
    exit;
      Writeln ('File is a link');
    if fpS_ISREG(info.st_mode) then
      Writeln ('File is a regular file');
    if fpS_ISDIR(info.st_mode) then
      Writeln ('File is a directory');
    if fpS_ISCHR(info.st_mode) then
      Writeln ('File is a character device file');
    if fpS_ISBLK(info.st_mode) then
      Writeln ('File is a block device file');
    if fpS_ISFIFO(info.st_mode) then
      Writeln ('File is a named pipe (FIFO)');
    if fpS_ISSOCK(info.st_mode) then
      Writeln ('File is a socket');
    end else begin
    logs.logs('FileSymbolicExists:: Fstat failed. Errno : ' + IntToStr(fpgeterrno));
    end;

end;
//##############################################################################
function myconf.PathIsDirectory(path:string):boolean;
var
info :stat;
D:boolean;
begin
result:=false;
if not FileExists(path) then exit;
D:=COMMANDLINE_PARAMETERS('debug');
if not D then D:=COMMANDLINE_PARAMETERS('--verbose');
 if fpLStat (path,@info)=0 then
    begin

    if fpS_ISDIR(info.st_mode) then
      result:=True;
    end else begin
    if D then  writeln('PathIsDirectory:: Fstat failed. Errno : ',fpgeterrno, ' ',path);
    end;

end;
//##############################################################################
function myconf.StatFileSymbolic(Path:string):string;
var
   info : stat;
begin
result:='';
if  fplstat (Path,@info)<>0 then
     begin
     writeln('LStat failed. Errno : ',fpgeterrno);
     halt (1);
     end;
  writeln ('Inode   : ',info.st_ino);
  writeln ('Mode    : ',info.st_mode);
  writeln ('nlink   : ',info.st_nlink);
  writeln ('uid     : ',info.st_uid);
  writeln ('gid     : ',info.st_gid);
  writeln ('rdev    : ',info.st_rdev);
  writeln ('Size    : ',info.st_size);
  writeln ('Blksize : ',info.st_blksize);
  writeln ('Blocks  : ',info.st_blocks);
  writeln ('atime   : ',info.st_atime);
  writeln ('mtime   : ',info.st_mtime);
  writeln ('ctime   : ',info.st_ctime);

end;
//******************************************************************************
procedure myconf.PATCHING_PERL_TO_ARTICA(TargetPath:string);
var
   D     :Boolean;
   cmd   :string;
   l     :TstringList;
   ltmp  :TStringList;
   i     :integer;
begin

D:=COMMANDLINE_PARAMETERS('debug');
forceDirectories('/opt/artica/logs');

if not FileExists('/usr/bin/find') then begin
   if D then writeln('PATCHING_PERL_TO_ARTICA: unable to stat /usr/bin/find');
   exit;
end;

    cmd:='/usr/bin/find '+TargetPath+'|sed ''s/\.\'+'/'+'/'+'/;'' >/opt/artica/logs/find.tmp';
    if D then writeln('PATCHING_PERL_TO_ARTICA: ' + cmd);
    fpsystem(cmd);

if not FileExists('/opt/artica/logs/find.tmp') then begin
   if D then writeln('PATCHING_PERL_TO_ARTICA: unable to stat /opt/artica/logs/find.tmp');
   exit;
end;
    l:=TstringList.Create;
    l.LoadFromFile('/opt/artica/logs/find.tmp');
    ltmp:=TstringList.Create;
    For i:=0 to l.Count-1 do begin
          if FileExists(l.Strings[i]) then begin
              if D then writeln('PATCHING_PERL_TO_ARTICA: Loading ',l.Strings[i]);
              ltmp.LoadFromFile(l.Strings[i]);
              if length(ltmp.Text)>0 then begin
                 if pos('!',ltmp.Strings[0])>0 then begin
                    writeln('patching ', l.Strings[i],' lenght :', length(ltmp.Text));
                    ltmp.Strings[0]:='#!' + PERL_BIN_PATH();
                    ltmp.SaveToFile(l.Strings[i]);
                 end;
              end;

          end;

    end;

end;
//******************************************************************************
function myconf.SYSTEM_ISIP_LOCAL(ipToTest:string):boolean;
var
   D:boolean;
   i:integer;
begin
   result:=false;
      D:=COMMANDLINE_PARAMETERS('--verbose');
      if not D then  D:=COMMANDLINE_PARAMETERS('debug');

   SYSTEM_ALL_IPS();

   for i:=0 to ArrayList.Count -1 do begin
        if D then writeln('SYSTEM_ISIP_LOCAL: ',ipToTest,'?=',trim(ArrayList.Strings[i]));
        if trim(ipToTest)=trim(ArrayList.Strings[i]) then begin
            if D then writeln('SYSTEM_ISIP_LOCAL:: Found local ip');
            result:=true;
            break;
        end;
   end;

end;
//******************************************************************************
FUNCTION myconf.SYSTEM_GET_SYSLOG_PATH():string;
var logspath:string;
begin
   logspath:=get_INFOS('syslog_path');
   if length(logspath)=0 then begin
      if FileExists('/var/log/syslog') then logspath:='/var/log/syslog';
   end;
   if length(logspath)=0 then begin
      logs.logs('SYSTEM_GET_SYSLOG_PATH:: unable to locate syslog !!');
      logs.logs('SYSTEM_GET_SYSLOG_PATH:: please add a value [INFOS] "syslog_path=path"');
   end;

      result:=logspath;

end;
//******************************************************************************
procedure myconf.INSTANT_SEARCH();
var
 InstantSearchEnable:integer;
 InstantSearchCrawlPeriod:integer;
 period:integer;
 timepath:string;
begin

InstantSearchCrawlPeriod:=0;
InstantSearchEnable:=0;
logs.Debuglogs('###################### INSTANT_SEARCH ######################');
timepath:='/etc/artica-postfix/InstantSearch.time';

   if not FileExists(timepath) then fpsystem('/bin/touch '+timepath);

if FileExists(timepath) then begin
   period:=SYS.FILE_TIME_BETWEEN_MIN(timepath);
end;



   logs.Debuglogs('InstantSearch Starting, enable='+SYS.GET_INFO('InstantSearchEnable')+', period='+SYS.GET_INFO('InstantSearchCrawlPeriod')+', current='+IntToStr(period));
   if not TryStrToInt(SYS.GET_INFO('InstantSearchEnable'),InstantSearchEnable) then InstantSearchEnable:=0;
   if not TryStrToInt(SYS.GET_INFO('InstantSearchCrawlPeriod'),InstantSearchCrawlPeriod) then InstantSearchCrawlPeriod:=0;


   if InstantSearchEnable=1 then begin
      if InstantSearchCrawlPeriod>119 then begin
            if period>InstantSearchCrawlPeriod then begin
               fpsystem(SYS.EXEC_NICE() +SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.xapian.index.php &');
               logs.DeleteFile(timepath);
               fpsystem('/bin/touch '+timepath);
            end;
      end;
   end;

   logs.Debuglogs('End InstantSearch');
logs.Debuglogs('#############################################################');

end;
//******************************************************************************


procedure myconf.WRITE_STATUS();
var
   TimeInt:integer;
   path:string;
   fulldata:string;
begin
     path:=get_ARTICA_PHP_PATH()+'/ressources/logs/global.status.ini';
     TimeInt:=SYS.FILE_TIME_BETWEEN_MIN(path);
     if TimeInt>=1 then begin
        fulldata:=GLOBAL_STATUS();
        logs.DeleteFile(path);
        logs.WriteToFile(fulldata,path);
        fpsystem('/bin/chown www-data:www-data '+get_ARTICA_PHP_PATH()+'/ressources/logs/*.ini');
        logs.WriteToFile(STATUS_PATTERN_DATABASES(),get_ARTICA_PHP_PATH()+'/ressources/logs/pattern.status.ini');
     end;

end;

//******************************************************************************

FUNCTION myconf.GLOBAL_STATUS():string;

         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;

 var
 ini:string;
 syslogng:Tsyslogng;
 cron:tcron;
 ldap:Topenldap;
 xffce:Txfce;
 kavmilter:tkavmilter;
 kas3:Tkas3;
 dnsmasq:tdnsmasq;
 bogom:tbogom;
 saslauthd:tsaslauthd;
 stunnel:tstunnel;
 mailspy:tmailspy;
 amavis:tamavis;
 retranslator:tkretranslator;
 dotclear:tdotclear;
 dhcp:tdhcp3;
 Messagerie:boolean;
 POSFTIX_POSTCONF_PATH:string;
 openvpn:Topenvpn;
 cups:tcups;
 smartd:Tsmartd;
 rsync:trsync;
 policyd_weight:tpolicyd_weight;
 LSHW_TIME:Integer;
 autofs:tautofs;
 nfs:Tnfs;
 framework:tframework;
 assp:tassp;
 pdns:tpdns;
 gluster:tgluster;
 zabbix:tzabbix;
 hamachi:thamachi;
 zvmtools:tvmtools;
 monit:tmonit;
 zarafa_server:tzarafa_server;
 zwifi:twifi;
 opengoo:topengoo;
 emailrelay:temailrelay;
 mldonkey:tmldonkey;
 backuppc:tbackuppc;
 kav4fs:tkav4fs;
 ocsi:Tocsi;
 ocsagent:tocsagent;
begin
LSHW_TIME:=0;
INSTANT_SEARCH();


   if FileExists(SYS.LOCATE_LSHW()) then begin
      LSHW_TIME:=SYS.FILE_TIME_BETWEEN_MIN('/usr/share/artica-postfix/ressources/logs/LSHW.NET.HTML');
      if LSHW_TIME=0 then LSHW_TIME:=10000;
      if LSHW_TIME>6000 then begin
         //http://ezix.org/project/wiki/HardwareLiSter
         logs.DeleteFile('/usr/share/artica-postfix/ressources/logs/LSHW.NET.HTML');
         logs.DeleteFile('/usr/share/artica-postfix/ressources/logs/LSHW.PROC.HTML');
         if not SYS.PROCESS_EXIST(SYS.PIDOF(SYS.LOCATE_LSHW())) then begin
            fpsystem(SYS.LOCATE_LSHW()+' -html -C network >/usr/share/artica-postfix/ressources/logs/LSHW.NET.HTML 2>&1 &');
            fpsystem(SYS.LOCATE_LSHW()+' -html -C processor >/usr/share/artica-postfix/ressources/logs/LSHW.PROC.HTML 2>&1 &');
         end;
      end else begin
         logs.Debuglogs('GLOBAL_STATUS():: LSHW -> '+ IntToStr(LSHW_TIME)+ ' minutes, needs more than 6000 to update...');
      end;
   end else begin

       logs.Debuglogs('GLOBAL_STATUS():: UNABLE TO STAT LSHW');
   end;



   Messagerie:=true;
   ini:='';

   opengoo:=topengoo.Create(SYS);
   ini:=ini+ opengoo.STATUS()+CRLF;
   opengoo.free;



// ------------------------------------ SQUID ------------------------------------

   if FileExists(squid.SQUID_BIN_PATH()) then begin
      ini:=ini+ squid.SQUID_STATUS() + CRLF;
   end;
   ini:=ini+SYSLOGER_STATUS()+CRLF;
   POSFTIX_POSTCONF_PATH:=postfix.POSFTIX_POSTCONF_PATH();
   logs.Debuglogs('postfix.POSFTIX_POSTCONF_PATH()='+POSFTIX_POSTCONF_PATH);
if not FileExists(POSFTIX_POSTCONF_PATH) then begin
   logs.Debuglogs('postfix.POSFTIX_POSTCONF_PATH() report null');
   Messagerie:=false;
end;
   //artica-make
   ini:=ini+ ARTICA_MAKE_STATUS()+CRLF;

   emailrelay:=Temailrelay.CReate(SYS);
   ini:=ini+ emailrelay.STATUS()+CRLF;

   backuppc:=tbackuppc.CReate(SYS);
   ini:=ini+ backuppc.STATUS()+CRLF;
   backuppc.free;

   mldonkey:=tmldonkey.Create(SYS);
   ini:=ini+ mldonkey.STATUS()+CRLF;
   mldonkey.free;

   ocsi:=tocsi.Create(SYS);
   ini:=ini+ ocsi.STATUS()+CRLF;
   ocsi.free;

   ocsagent:=tocsagent.Create(SYS);
   ini:=ini+ ocsagent.STATUS()+CRLF;
   ocsagent.free;



   //retranslator
    logs.Debuglogs('retranslator STATUS ----------------------------------');
   retranslator:=tkretranslator.Create(SYS);
   ini:=ini+ retranslator.STATUS()+CRLF;
   retranslator.Free;

   kav4fs:=Tkav4fs.Create(SYS);
   ini:=ini+ kav4fs.STATUS()+CRLF;
   kav4fs.free;



   //boa [monit ok]
    logs.Debuglogs('boa STATUS ----------------------------------');
   try
      ini:=ini+BOA_DAEMON_STATUS();
   except
         logs.Syslogs('GLOBAL_STATUS():: FATAL ERROR WHILE TESTING BOA');
   end;

   //hamachi
    logs.Debuglogs('hamachi STATUS ----------------------------------');
   try
      hamachi:=thamachi.Create(SYS);
      ini:=ini+hamachi.STATUS();
      hamachi.free;
   except
         logs.Syslogs('GLOBAL_STATUS():: FATAL ERROR WHILE TESTING HAMACHI');
   end;

   logs.Debuglogs('WIFI STATUS ----------------------------------');
   try
      zwifi:=twifi.Create(SYS);
      ini:=ini+zwifi.STATUS();
      zwifi.free;
   except
         logs.Syslogs('GLOBAL_STATUS():: FATAL ERROR WHILE TESTING WIFI');
   end;

       logs.Debuglogs('zvmtools STATUS ----------------------------------');
   //vmtools
   try
      zvmtools:=tvmtools.Create(SYS);
      ini:=ini+zvmtools.STATUS();
      zvmtools.free;
   except
         logs.Syslogs('GLOBAL_STATUS():: FATAL ERROR WHILE TESTING VMTOOLS');
   end;

   //dhcp
   logs.Debuglogs('DHCP STATUS ----------------------------------');
   dhcp:=tdhcp3.Create(SYS);
   ini:=ini+ dhcp.STATUS()+CRLF;

   //dotclear
   logs.Debuglogs('dotclear STATUS ----------------------------------');
   SYS:=Tsystem.Create();
   dotclear:=tdotclear.Create(SYS);
   ini:=ini+ dotclear.STATUS()+CRLF;
   dotclear.Free;

   //monit
   logs.Debuglogs('MONIT STATUS ----------------------------------');
   monit:=tmonit.Create(SYS);
   ini:=ini+monit.STATUS()+CRLF;


   //pdns
   logs.Debuglogs('PDNS STATUS ----------------------------------');
   pdns:=tpdns.Create(SYS);
   ini:=ini+ pdns.STATUS()+CRLF;
   pdns.Free;

   //openvpn
   logs.Debuglogs('OPENVPN STATUS ----------------------------------');
   openvpn:=Topenvpn.Create(SYS);
   ini:=ini+ openvpn.STATUS()+CRLF;
   openvpn.free;

  //smartd
  logs.Debuglogs('SMARTD STATUS ----------------------------------');
  smartd:=Tsmartd.Create(SYS);
  ini:=ini+smartd.STATUS()+CRLF;
  smartd.Free;

  //rsync
  logs.Debuglogs('RSYNC STATUS ----------------------------------');
  rsync:=trsync.Create(SYS);
  ini:=ini+rsync.STATUS()+CRLF;
  ini:=ini+rsync.STATUS_STUNNEL()+CRLF;
  rsync.free;
  logs.Debuglogs('----------------------------------');

  //autofs
  logs.Debuglogs('autofs STATUS ----------------------------------');
  autofs:=tautofs.CReate(SYS);
  ini:=ini+autofs.STATUS()+CRLF;
  autofs.FRee;
  logs.Debuglogs('----------------------------------');

  //nfs
  logs.Debuglogs('NFS STATUS ----------------------------------');
  nfs:=tnfs.Create(SYS);
  ini:=ini+nfs.STATUS()+CRLF;
  nfs.FRee;
  logs.Debuglogs('----------------------------------');

  //zabbix
  logs.Debuglogs('ZABBIX STATUS ----------------------------------');
  zabbix:=tzabbix.Create(SYS);
  ini:=ini+zabbix.STATUS()+CRLF;
  ini:=ini+zabbix.STATUS_AGENT()+CRLF;
  zabbix.FRee;
  logs.Debuglogs('----------------------------------');

  //gluster
  logs.Debuglogs('GLUSTER STATUS ----------------------------------');
  gluster:=tgluster.Create(SYS);
  ini:=ini+gluster.STATUS()+CRLF;
  gluster.FRee;

  //framework
  try
     logs.Debuglogs('framework STATUS ----------------------------------');
     framework:=tframework.Create(SYS);
     ini:=ini+framework.STATUS()+CRLF;
  except
        logs.Syslogs('framework:=tframework.Create(SYS), FATAL ERROR');
  end;


// ------------------------------------ POSTFIX ------------------------------------



   if Messagerie then begin
     logs.Debuglogs('MYSQMAIL_STATUS STATUS ----------------------------------');
     ini:=ini+ postfix.MYSQMAIL_STATUS();



     //mailspy
     logs.Debuglogs('mailspy STATUS ----------------------------------');
     mailspy:=tmailspy.Create(SYS);
     ini:=ini+ mailspy.STATUS()+CRLF;
     mailspy.free;

     //postfix
     logs.Debuglogs('postfix STATUS ----------------------------------');
     ini:=ini+ postfix.STATUS()+CRLF;

     //kavmilter
     logs.Debuglogs('kavmilter STATUS ----------------------------------');
     kavmilter:=Tkavmilter.Create(SYS);
     ini:=ini+ kavmilter.STATUS()+CRLF;
     kavmilter.Free;

     //amavis
     logs.Debuglogs('amavis STATUS ----------------------------------');
     amavis:=tamavis.Create(SYS);
     ini:=ini+ amavis.STATUS()+CRLF;
     amavis.Free;


     //mailman
     logs.Debuglogs('mailman STATUS ----------------------------------');
     mailman:=tmailman.Create(SYS);
     ini:=ini+ mailman.STATUS();
     mailman.free;

     //policyd-weight
     logs.Debuglogs('policyd-weight STATUS ----------------------------------');
     policyd_weight:=tpolicyd_weight.Create(SYS);
     ini:=ini+ policyd_weight.STATUS();
     policyd_weight.free;

     //assp
     logs.Debuglogs('ASSP STATUS ----------------------------------');
     assp:=Tassp.Create(SYS);
     ini:=ini+ assp.STATUS();
     assp.free;

     //kas3
     logs.Debuglogs('kas3 STATUS ----------------------------------');
     kas3:=tkas3.Create(SYS);
     ini:=ini+ kas3.STATUS()+CRLF;
     kas3.free;

     //bogo-filter
     logs.Debuglogs('starting status bogom');
     bogom:=tbogom.Create(SYS);
     ini:=ini+ bogom.STATUS()+CRLF;
     ini:=ini+ bogom.BOGOFILTER_STATUS()+CRLF;
     bogom.Free;

     //fetchmail
     logs.Debuglogs('fetchmail STATUS ----------------------------------');
     logs.Debuglogs('starting status FETCHMAIL');
     ini:=ini+fetchmail.STATUS()+CRLF;



     //spamassassin
     logs.Debuglogs('SPAMASSASSIN_STATUS STATUS ----------------------------------');
     ini:=ini+spamass.SPAMASSASSIN_STATUS()+CRLF;


     //milter-greylist
     logs.Debuglogs('SPAMASSASSIN_STATUS STATUS ----------------------------------');
     ini:=ini+miltergreylist.STATUS()+CRLF;

     //DKIM
     logs.Debuglogs('starting status dkim');
     ini:=ini+dkim.STATUS()+CRLF;

     //Mailgraph
     logs.Debuglogs('mailgraph STATUS ----------------------------------');
     ini:=ini+mailgraph.STATUS()+CRLF;



     //Mailarchive
     logs.Debuglogs('Mailarchive STATUS ----------------------------------');
     mailarchive:=Tmailarchive.Create(SYS);
     ini:=ini+ mailarchive.STATUS()+CRLF;
     mailarchive.free;

     //SPF Milter
     logs.Debuglogs('starting status SPFMILTER_STATUS');
     ini:=ini+spfm.SPFMILTER_STATUS()+CRLF;

     //MimeDefang
     logs.Debuglogs('starting status MIMEDEFANG_STATUS');
     ini:=ini+mimedef.MIMEDEFANG_STATUS()+CRLF;

     //roundcube
     logs.Debuglogs('roundcube STATUS ---------------------------------- (monit)');
     ini:=ini+roundcube.STATUS()+CRLF;

     //zarafa
     logs.Debuglogs('Zarafa STATUS ---------------------------------- (monit)');
     try
        zarafa_server:=tzarafa_server.Create(SYS);
        ini:=ini+zarafa_server.STATUS()+CRLF;
     except
       logs.Debuglogs('ERROR !! Zarafa STATUS ----------------------------------');
     end;


   end;

logs.Debuglogs('starting status BIND9');
ini:=ini+ bind9.STATUS()+CRLF;

logs.Debuglogs('starting status FDM');
ini:=ini+ fdm.STATUS()+CRLF;

 logs.Debuglogs('starting status preload');
 ini:=ini+ PRELOAD_STATUS()+CRLF;

 logs.Debuglogs('starting status gdm');
 ini:=ini+ GDM_STATUS()+CRLF;

 //XFCE
 logs.Debuglogs('starting status xfce');
 xffce:=txfce.Create;
 ini:=ini+ xffce.XFCE_STATUS()+CRLF;


 logs.Debuglogs('starting status inetd');
 ini:=ini+ SYS.INETD_STATUS()+CRLF;


 //syslog-ng
 syslogng:=Tsyslogng.Create(SYS);
 ini:=ini+ syslogng.STATUS()+CRLF;

 //Artica-cron
  logs.Debuglogs('roundcube STATUS ---------------------------------- (monit)');
 cron:=Tcron.Create(SYS);
 ini:=ini+ cron.STATUS()+CRLF;

   ini:=ini+ Cpureftpd.PURE_FTPD_STATUS()+CRLF;


   ldap:=topenldap.Create;
   xffce:=txfce.Create;

   //dnsmasq
   logs.Debuglogs('dnsmasq STATUS ---------------------------------- (monit)');
   dnsmasq:=tdnsmasq.Create(SYS);
   ini:=ini+ dnsmasq.STATUS()+CRLF;



   //saslauthd
   logs.Debuglogs('dnsmasq STATUS ---------------------------------- (monit)');
   saslauthd:=tsaslauthd.Create(SYS);
   ini:=ini+ saslauthd.STATUS()+CRLF;
   saslauthd.FRee;


//mysql
  logs.Debuglogs('mysql STATUS ---------------------------------- (monit)');
  ini:=ini+ zmysql.STATUS()+CRLF;


//ldap
  logs.Debuglogs('LDAP STATUS ---------------------------------- (monit)');
  ini:=ini+ ldap.STATUS()+CRLF;

//collected
  logs.Debuglogs('collectd STATUS ---------------------------------- (monit)');
  collectd:=tcollectd.Create(SYS);
  ini:=ini+ collectd.STATUS()+CRLF;
  collectd.Free;

//pureftpd
   logs.Debuglogs('pureftpd STATUS ---------------------------------- (monit)');
   ini:=ini+Cpureftpd.PURE_FTPD_STATUS()+CRLF;

//cyrus-imap
   logs.Debuglogs('CYRUS STATUS ---------------------------------- (monit)');
   ini:=ini+CCYRUS.CYRUS_STATUS()+CRLF;


   ini:=ini+obm.STATUS()+CRLF;

//ntpd
   logs.Debuglogs('ntpd STATUS ---------------------------------- (monit)');
   ini:=ini+ntpd.NTPD_STATUS()+CRLF;

   ini:=ini+IPTABLES_STATUS()+CRLF;

//lighttpd
   logs.Debuglogs('lighttpd STATUS ---------------------------------- (monit)');
   ini:=ini+lighttpd.STATUS()+CRLF;


//clamav
   logs.Debuglogs('CLAMAV_STATUS STATUS ---------------------------------- (monit)');
   ini:=ini+clamav.CLAMAV_STATUS()+CRLF;
   logs.Debuglogs('starting status FRESHCLAM_STATUS');


// ------------------------------------ SAMBA ------------------------------------
if fileExists(samba.SMBD_PATH()) then begin
   logs.Debuglogs('CLAMAV_STATUS STATUS ---------------------------------- (monit)');
   ini:=ini+samba.SAMBA_STATUS()+CRLF;

   ini:=ini+ kav4samba.STATUS()+CRLF;

//cups
   logs.Debuglogs('CUPS STATUS ---------------------------------- (monit)');
   cups:=tcups.Create;
   ini:=ini+ cups.STATUS()+CRLF;
   cups.free;
end;



//console-kit
ini:=ini+CONSOLEKIT_STATUS()+CRLF;


//stunnel;
logs.Debuglogs('starting status STUNNEL_STATUS');
stunnel:=tstunnel.CReate(SYS);
ini:=ini+stunnel.STUNNEL_STATUS()+CRLF;
stunnel.Free;
result:=ini;
monit:=tmonit.Create(SYS);
monit.wakeup();
monit.free;
   logs.Debuglogs('end status....');
   xffce.free;
end;
//#########################################################################################
FUNCTION myconf.IPTABLES_STATUS():string;
var
   ini:TstringList;
begin

ini:=TstringList.Create;
  ini.Add('[IPTABLES]');
  if FileExists(IPTABLES_PATH())then ini.Add('running=1') else  ini.Add('running=0');
  if FileExists(IPTABLES_PATH())then ini.Add('application_installed=1');
  ini.Add('application_enabled=' +get_INFOS('IptablesEnabled'));
      ini.Add('master_pid=0');
      ini.Add('master_memory=0');
      try
         ini.Add('master_version=' + IPTABLES_VERSION());
      except
         ini.Add('master_version=ERROR');
      end;
      ini.Add('status=kernel');
      ini.Add('service_name=APP_IPTABLES');
result:=ini.Text;
ini.free
end;
//#########################################################################################
function myconf.STATUS_PATTERN_DATABASES():string;

var
   clm:TClamav;
   l:TstringList;
begin

  clm:=TClamav.Create;
  l:=TstringList.Create;
  l.Add(clm.PATTERNS_VERSIONS());
  result:=l.Text;
  l.free;
end;
//#########################################################################################
FUNCTION myconf.BACKUP_ARTICA_STATUS():string;
var
   ini:TstringList;
   conf:TiniFile;
   mailpath:string;
begin
if not FileExists('/etc/artica-postfix/artica-backup.conf') then exit;
conf:=TiniFile.Create('/etc/artica-postfix/artica-backup.conf');
mailpath:=conf.ReadString('backup','backup_path','/opt/artica/backup');
ini:=TstringList.Create;
  ini.Add('[ARTICA_BACKUP]');
  if FileExists('/etc/cron.d/artica-cron-backup') then begin
     ini.Add('running=1');
     ini.Add('application_enabled=1');

 end else begin
     ini.Add('running=0');
     ini.Add('application_enabled=0');
 end;

      ini.Add('master_pid=0');
      ini.Add('master_memory='+IntToStr(SYS.FOLDER_SIZE(mailpath)));
      ini.Add('master_version=' +conf.ReadString('backup','backup_time','03:00'));
      ini.Add('status=task');
      ini.Add('service_name=APP_ARTICA_BACKUP');
result:=ini.Text;
ini.free
end;
//#########################################################################################
FUNCTION myconf.IPTABLES_LIST_NICS():string;
var
   l:Tstringlist;
   RegExpr:TRegExpr;
   i:integer;
   logs:Tlogs;
begin
result:='';
  l:=Tstringlist.Create;
  l.LoadFromFile('/proc/net/dev');
  logs:=Tlogs.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^(.+?):';
  for i:=0 to l.Count-1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          if trim(RegExpr.Match[1])<>'lo' then result:=result + trim(RegExpr.Match[1]) + ';';
      end else begin
         logs.logs('IPTABLES_LIST_NICS:: unable to match ' +l.Strings[i] );
      end;

  end;
  RegExpr.Free;
  l.free;

end;
//#########################################################################################
FUNCTION myconf.IPTABLES_CURRENT_RULES():string;
var
   l:Tstringlist;
begin
  if not fileExists(IPTABLES_PATH()) then exit;
  fpsystem(IPTABLES_PATH() + ' -L -v -n >/opt/artica/logs/iptables.tmp 2>&1');
  if not FileExists('/opt/artica/logs/iptables.tmp') then exit;
  l:=Tstringlist.Create;
  l.LoadFromFile('/opt/artica/logs/iptables.tmp');
  DeleteFile('/opt/artica/logs/iptables.tmp');
  result:=l.Text;
  l.free;

end;
//#########################################################################################
FUNCTION myconf.IPTABLES_EVENTS():string;
var
   l:Tstringlist;
begin
  if not fileExists(IPTABLES_PATH()) then exit;
  fpsystem('/bin/cat /var/log/messages|/usr/bin/tail -n 100|grep IN= >/opt/artica/logs/iptables.tmp');
  if not FileExists('/opt/artica/logs/iptables.tmp') then exit;
  l:=Tstringlist.Create;
  l.LoadFromFile('/opt/artica/logs/iptables.tmp');
  DeleteFile('/opt/artica/logs/iptables.tmp');
  result:=l.Text;
  l.free;

end;
//#########################################################################################
FUNCTION myconf.CYRUS_IMAP_GET_VALUE(key:string):string;
var
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
begin

  if not FileExists('/etc/imapd.conf') then exit;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^'+key+':(.+)';
  l:=TstringList.Create;
  l.LoadFromFile('/etc/imapd.conf');
  for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=trim(RegExpr.Match[1]);
       RegExpr.free;
       l.free;
       exit;
    end;
  end;
 RegExpr.free;
l.free;
end;
//#########################################################################################
FUNCTION myconf.PRELOAD_VERSION():string;
var
   tmp:string;
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
begin


if not FileExists(SYS.LOCATE_PRELOAD()) then begin
   exit;
end;
  tmp:=logs.FILE_TEMP();
  fpsystem(SYS.LOCATE_PRELOAD() + ' -v >' + tmp + ' 2>&1');
  if not FileExists(tmp) then exit;
  l:=TstringList.Create;
  l.LoadFromFile(tmp);
  logs.DeleteFile(tmp);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='preload\s+([0-9\.]+)';
  for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
  end;
  l.free;
  RegExpr.free;
end;
//#########################################################################################
FUNCTION myconf.PRELOAD_PID():string;
begin

if not FileExists(SYS.LOCATE_PRELOAD()) then begin
   exit;
end;
  result:=SYS.PidByProcessPath(SYS.LOCATE_PRELOAD());
end;
//#########################################################################################
FUNCTION myconf.PRELOAD_STATUS():string;
var
   ini:TstringList;
   pid:string;
begin
  if not FileExists(SYS.LOCATE_PRELOAD()) then begin
     exit;
  end;
  ini:=TstringList.Create;
  pid:=PRELOAD_PID();

  ini.Add('[PRELOAD]');
  if SYS.PROCESS_EXIST(pid) then ini.Add('running=1') else  ini.Add('running=0');
  ini.Add('application_installed=1');
  ini.Add('application_enabled=1');
  ini.Add('master_pid='+ pid);
  ini.Add('master_memory=' + IntToStr(SYS.PROCESS_MEMORY(pid)));
  ini.Add('master_version=' +PRELOAD_VERSION());
  ini.Add('status='+SYS.PROCESS_STATUS(pid));
  ini.Add('service_name=APP_PRELOAD');

  if not SYS.PROCESS_EXIST(pid) then begin
         ini.Add('service_disabled=1');
   end;

//  ini.Add('service_cmd=kav4samba');
  result:=ini.Text;
  ini.free;
end;


FUNCTION myconf.ADD_PROCESS_QUEUE(command:string):string;
var
   l:TstringList;
   logs:Tlogs;
begin
   result:='';
   l:=TstringList.Create;
   logs:=Tlogs.Create;
   logs.OutputCmd('/etc/init.d/artica-postfix start daemon');

   if FileExists('/etc/artica-postfix/orders.queue') then begin
      logs.Debuglogs('ADD_PROCESS_QUEUE:: loading /etc/artica-postfix/orders.queue');
      l.LoadFromFile('/etc/artica-postfix/orders.queue');
   end;

   logs.Debuglogs('ADD_PROCESS_QUEUE:: adding command "'+command+'"');
   try
      l.Add(command);
   except
      logs.Debuglogs('ADD_PROCESS_QUEUE:: ->fatal error adding command');
      exit;
   end;


   try

   l.SaveToFile('/etc/artica-postfix/orders.queue');
   except
     logs.Debuglogs('ADD_PROCESS_QUEUE:: ->fatal error');
     exit;
   end;
   logs.Debuglogs('ADD_PROCESS_QUEUE:: ->success');
   l.Free;
end;
//#########################################################################################
procedure myconf.deb_files_extists_between(patha:string;pathb:string);
var
lista:TstringList;
z:Tsystem;
i:integer;
thepath:string;
begin
lista:=Tstringlist.Create;
z:=Tsystem.Create;
lista:=z.RecusiveListFiles(patha);
 for i:=0 to lista.Count-1 do begin
        thepath:=AnsiReplaceText(lista.Strings[i],patha,pathb);
        if not PathIsDirectory(thepath) then begin
           if FileExists(thepath) then writeln(thepath);
        end;
 end;
end;
//#########################################################################################
function myconf.MYSQL_DATABASE_CHECK_LIST(BasePath:string):Tstringlist;
var  l:TstringList;
begin

l:=TstringList.CReate;
l.Add(BasePath + '/mysql/proc.frm');
l.Add(BasePath + '/mysql/host.MYD');
l.Add(BasePath + '/mysql/user.MYI');
l.Add(BasePath + '/mysql/func.MYD');
l.Add(BasePath + '/mysql/help_relation.frm');
l.Add(BasePath + '/mysql/time_zone.frm');
l.Add(BasePath + '/mysql/time_zone_transition.MYI');
l.Add(BasePath + '/mysql/help_category.frm');
l.Add(BasePath + '/mysql/db.MYD');
l.Add(BasePath + '/mysql/help_keyword.MYI');
l.Add(BasePath + '/mysql/slow_log.CSV');
l.Add(BasePath + '/mysql/time_zone_leap_second.MYD');
l.Add(BasePath + '/mysql/procs_priv.frm');
l.Add(BasePath + '/mysql/slow_log.frm');
l.Add(BasePath + '/mysql/time_zone.MYD');
l.Add(BasePath + '/mysql/slow_log.CSM');
l.Add(BasePath + '/mysql/time_zone_transition.MYD');
l.Add(BasePath + '/mysql/help_relation.MYD');
l.Add(BasePath + '/mysql/procs_priv.MYI');
l.Add(BasePath + '/mysql/time_zone_transition_type.MYI');
l.Add(BasePath + '/mysql/host.frm');
l.Add(BasePath + '/mysql/tables_priv.MYI');
l.Add(BasePath + '/mysql/tables_priv.MYD');
l.Add(BasePath + '/mysql/event.MYI');
l.Add(BasePath + '/mysql/time_zone_transition_type.MYD');
l.Add(BasePath + '/mysql/time_zone_name.MYD');
l.Add(BasePath + '/mysql/ndb_binlog_index.frm');
l.Add(BasePath + '/mysql/func.frm');
l.Add(BasePath + '/mysql/user.MYD');
l.Add(BasePath + '/mysql/ndb_binlog_index.MYI');
l.Add(BasePath + '/mysql/user.frm');
l.Add(BasePath + '/mysql/time_zone_name.frm');
l.Add(BasePath + '/mysql/servers.frm');
l.Add(BasePath + '/mysql/help_topic.frm');
l.Add(BasePath + '/mysql/procs_priv.MYD');
l.Add(BasePath + '/mysql/columns_priv.MYI');
l.Add(BasePath + '/mysql/general_log.CSV');
l.Add(BasePath + '/mysql/help_keyword.MYD');
l.Add(BasePath + '/mysql/db.frm');
l.Add(BasePath + '/mysql/proc.MYI');
l.Add(BasePath + '/mysql/ndb_binlog_index.MYD');
l.Add(BasePath + '/mysql/time_zone_leap_second.frm');
l.Add(BasePath + '/mysql/host.MYI');
l.Add(BasePath + '/mysql/event.MYD');
l.Add(BasePath + '/mysql/event.frm');
l.Add(BasePath + '/mysql/time_zone_transition.frm');
l.Add(BasePath + '/mysql/db.MYI');
l.Add(BasePath + '/mysql/columns_priv.frm');
l.Add(BasePath + '/mysql/time_zone_leap_second.MYI');
l.Add(BasePath + '/mysql/help_category.MYI');
l.Add(BasePath + '/mysql/plugin.MYI');
l.Add(BasePath + '/mysql/func.MYI');
l.Add(BasePath + '/mysql/tables_priv.frm');
l.Add(BasePath + '/mysql/servers.MYI');
l.Add(BasePath + '/mysql/help_relation.MYI');
l.Add(BasePath + '/mysql/proc.MYD');
l.Add(BasePath + '/mysql/help_topic.MYI');
l.Add(BasePath + '/mysql/time_zone_transition_type.frm');
l.Add(BasePath + '/mysql/plugin.MYD');
l.Add(BasePath + '/mysql/help_topic.MYD');
l.Add(BasePath + '/mysql/time_zone.MYI');
l.Add(BasePath + '/mysql/plugin.frm');
l.Add(BasePath + '/mysql/general_log.CSM');
l.Add(BasePath + '/mysql/servers.MYD');
l.Add(BasePath + '/mysql/help_keyword.frm');
l.Add(BasePath + '/mysql/columns_priv.MYD');
l.Add(BasePath + '/mysql/general_log.frm');
l.Add(BasePath + '/mysql/time_zone_name.MYI');
l.Add(BasePath + '/mysql/help_category.MYD');
result:=l;
end;
//#########################################################################################

procedure myconf.OPENSSL_CERTIFCATE_CONFIG();
begin
   SYS.OPENSSL_CERTIFCATE_CONFIG();
end;
//#########################################################################################
function myconf.SYSTEM_LOCAL_SID():string;
var
   FILI        :TstringList;
   RegExpr     :TRegExpr;
   i           :integer;
   slogs       :tlogs;
   filetemp    :string;
   sdate       :string;
   newsid      :string;

begin
  slogs:=Tlogs.Create;
  filetemp:=slogs.FILE_TEMP();
  fpsystem('/usr/bin/net getlocalsid >'+filetemp+' 2>&1');
  FILI:=TstringList.Create;
  if not FileExists(filetemp) then begin
     slogs.Syslogs('myconf.SYSTEM_LOCAL_SID(): FATAL ERROR LINE 10985');
     exit;
  end;

  FILI.LoadFromFile(filetemp);
  slogs.DeleteFile(filetemp);

  RegExpr:=TRegExpr.Create;
  for i:=0 to FILI.Count-1 do begin
     RegExpr.Expression:='is:\s+(.+)';
     if RegExpr.Exec(FILI.Strings[i]) then begin
        result:=RegExpr.Match[1];
        break;
     end;

     RegExpr.Expression:='Can.+?t fetch domain SID for';
     if RegExpr.Exec(FILI.Strings[i]) then begin
        slogs.Syslogs('myconf.SYSTEM_LOCAL_SID():: WARNING, unable to obtain SID: '+FILI.Strings[i]+' try to create a new one Line 11005');
        sdate:=FormatDateTime('ddmmhhyyyy', Now);
        newsid:='S-1-5-21-2596694876-1976058220-'+sdate;
        slogs.Syslogs('myconf.SYSTEM_LOCAL_SID():: Create a new SID '+newsid);
        fpsystem('/usr/bin/net setlocalsid '+newsid);
        result:=newsid;
        break;
     end;


  end;

  if ParamStr(1)='--local-sid' then begin
     writeln(result);
  end;

  slogs.free;
  RegExpr.Free;
  FILI.free;
end;
//#########################################################################################
procedure myconf.SYSTEM_CHANGE_MOTD();
var l:TstringList;
begin
forceDirectories('/opt/artica/logs');
fpsystem('/bin/uname -a >/opt/artica/logs/uname.tmp');



if Not FileExists('/etc/motd') then exit;
l:=TstringList.Create;
l.Add(get_LINUX_DISTRI());
l.Add(ReadFileIntoString('/opt/artica/logs/uname.tmp'));
l.Add('');
l.Add('Some programs included with the artica system are free software;');
l.Add('the exact distribution terms for each program are described in the');
l.Add('individual files in /usr/share/doc/*/copyright.');
l.Add('Only Kaspersky products requires a licence file, see according README');
l.Add('Artica & this system comes with ABSOLUTELY NO WARRANTY, to the extent permitted by');
l.Add('applicable law.');
l.Add('To access official Artica documentation, please visit:');
l.Add('http://www.artica.fr');
l.SaveToFile('/etc/motd');
l.free;
end;


 //#########################################################################################
procedure myconf.ParseMyqlQueue();
var
   QueuePath     :string;
   target_path   :string;
   i             :integer;
   database_name :string;
   D:boolean;
begin

  logs.Debuglogs('');
  logs.Debuglogs('');
  logs.Debuglogs('ParseMyqlQueue #########################################################################################');

  D:=COMMANDLINE_PARAMETERS('verbose');
  i:=0;
  QueuePath:='/opt/artica/mysql/artica-queue';
  if not DirectoryExists(QueuePath) then forcedirectories(Queuepath);


  SYS.PROCESS_LIST_PID(ParamStr(0) + ' --ParseMyqlQueue');
  try
  if SYS.PLISTPID.Count>6 then begin
     logs.Debuglogs('ParseMyqlQueue()::Maximum process for parsing mysql queue is reach...');
     exit;
  end;
  except

  exit;
  end;

  if get_INFOS('BadMysqlPassword')='1' then begin
     logs.Debuglogs('ParseMyqlQueue():: Bad mysql password aborting...');
     logs.Debuglogs('#########################################################################################');
     exit;
  end;



   if D then writeln('run in verbose mode');


  SYS.DirFiles(QueuePath , '*');
  if SYS.DirListFiles.Count=0 then begin
     logs.Debuglogs('ParseMyqlQueue():: 0 files in queue');
     logs.Debuglogs('#########################################################################################');
     exit;
  end;

  logs.Debuglogs('ParseMyqlQueue():: ' + IntToStr(SYS.DirListFiles.Count) + ' files in queue');
  if not logs.Connect() then begin
        if(SYS.DirListFiles.Count)>100 then fpsystem('/bin/rm -rf  /opt/artica/mysql/artica-queue/*');
        logs.Debuglogs('ParseMyqlQueue():: unable to connect, aborting');
        logs.Debuglogs('#########################################################################################');
        exit;
  end;
  logs.Debuglogs('ParseMyqlQueue():: ' + IntToStr(SYS.DirListFiles.Count) + ' files in queue');

  for i:=0 to SYS.DirListFiles.Count-1 do begin
      target_path:=QueuePath + '/' + SYS.DirListFiles.Strings[i];
      if fileExists(target_path) then begin
         database_name:=MYSQL_DETERMINE_DATABASE_IN_FILEQUERY(target_path);
         if length(database_name)>0 then begin

            if logs.QUERY_SQL(pChar(ReadFileIntoString(target_path)),database_name) then begin
               LOGS.logs('ParseMyqlQueue():: Success execute mysql queue file ' + target_path);
               logs.Debuglogs('ParseMyqlQueue():: Process SQL file: ' + target_path + ' (success) file ' + IntToStr(i) + '/' + intToStr(SYS.DirListFiles.Count));
               DeleteFile(target_path);
            end else begin
               LOGS.logs('ParseMyqlQueue():: Failed execute mysql queue file ' + target_path);
               logs.Debuglogs('ParseMyqlQueue():: sProcess SQL file: ' + target_path + '(failed) file ' + IntToStr(i) + '/' + intToStr(SYS.DirListFiles.Count));
            end;
         end;

      end;

  end;
  logs.Disconnect();
        logs.Debuglogs('#########################################################################################');
  halt(0);
end;
//#########################################################################################
function myconf.Explode(const Separator, S: string; Limit: Integer = 0):TStringDynArray;
var
  SepLen       : Integer;
  F, P         : PChar;
  ALen, Index  : Integer;
begin
  SetLength(Result, 0);
  if (S = '') or (Limit < 0) then
    Exit;
  if Separator = '' then
  begin
    SetLength(Result, 1);
    Result[0] := S;
    Exit;
  end;
  SepLen := Length(Separator);
  ALen := Limit;
  SetLength(Result, ALen);

  Index := 0;
  P := PChar(S);
  while P^ <> #0 do
  begin
    F := P;
    P := StrPos(P, PChar(Separator));
    if (P = nil) or ((Limit > 0) and (Index = Limit - 1)) then
      P := StrEnd(F);
    if Index >= ALen then
    begin
      Inc(ALen, 5); // mehrere auf einmal um schneller arbeiten zu können
      SetLength(Result, ALen);
    end;
    SetString(Result[Index], F, P - F);
    Inc(Index);
    if P^ <> #0 then
      Inc(P, SepLen);
  end;
  if Index < ALen then
    SetLength(Result, Index); // wirkliche Länge festlegen
end;
//#########################################################################################

procedure myconf.splitexample(s:string;sep:string);
var
   tb:TStringDynArray;
   i:integer;
begin
    writeln('Explode ' + s + ' by sep=' + sep);
    tb:=Explode(sep,s);
    for i:=0 to length(tb) do begin
        writeln(i,' ',tb[i]);

    end;


end;
//#########################################################################################
procedure myconf.PERL_CREATE_DEFAULT_SCRIPTS();
var
   l:TstringList;
   rootpath:string;

begin
  rootpath:=get_ARTICA_PHP_PATH();
  l:=TstringList.Create;
if Not FileExists(rootpath+'/bin/install/kavgroup/kas-compile-artica.pl') then begin
writeln('PERL_CREATE_DEFAULT_SCRIPTS():: Creating '+rootpath+'/bin/install/kavgroup/kas-compile-artica.pl');
l.Add('#!/usr/local/ap-mailfilter3/bin/perl -w');
l.Add('use strict;');
l.Add('');
l.Add('use FindBin qw($Bin);');
l.Add('use lib "/usr/local/ap-mailfilter3/control/lib";');
l.Add('');
l.Add('use vars qw($CONST $CONFIG $LANG $MENU @ERR);');
l.Add('');
l.Add('use CGI qw(:standard);');
l.Add('use CGI::Carp;');
l.Add('#use POSIX qw(strftime);');
l.Add('use Data::Dumper;');
l.Add('');
l.Add('BEGIN {');
l.Add('  require "cgiutil.pl";');
l.Add('  require "config.pl";');
l.Add('  require "stsconfig.pl";');
l.Add('  require "rc/design.pl";');
l.Add('  require "utils.pl";');
l.Add('};');
l.Add('');
l.Add('my %param = GetParams();');
l.Add('my %error;');
l.Add('');
l.Add('my ($checks,$defines,$basedef);');
l.Add('');
l.Add('$error{error} = $LANG->{error}{cant_access_policy_data} unless( STSCFG_IsReady() );');
l.Add('');
l.Add('if(!defined($error{error}) )');
l.Add('{');
l.Add('  STSConfig::compile();');
l.Add('  if( STSCFG_Succeeded(\%error,''STSConfig::compile'',$LANG->{error}{cant_build_profiles}, $LANG->{error}{warn_build_profiles}) )');
l.Add('  {');
l.Add('    $error{notice} = $LANG->{message}{applied};');
l.Add('  }');
l.Add('');
l.Add('  RestartHelper(\%error);');
l.Add('}');
l.Add('');
l.Add('STSCFG_PushErrorLog() if( $error{warning} || $error{error} );');
l.Add('');
l.Add('');
l.Add('# Build page');
l.Add('');
l.Add('');
l.Add('ErrorBlock( top=>1, %error ) if( $error{warning} || $error{error} );');
l.Add('ErrorBlock( %error );');
l.Add('');
forcedirectories(rootpath+'/bin/install/kavgroup');
l.SaveToFile(rootpath+'/bin/install/kavgroup/kas-compile-artica.pl');
fpsystem('/bin/chmod 777 ' + rootpath+'/bin/install/kavgroup/kas-compile-artica.pl');
l.Clear;
end;


if not FileExists(rootpath+'/bin/install/parse_avstat.pl') then begin
writeln('PERL_CREATE_DEFAULT_SCRIPTS():: Creating '+rootpath+'/bin/install/parse_avstat.pl');
l.Add('#!/usr/bin/perl -w');
l.Add('#');
l.Add('# Really useful when script is run from the relative path');
l.Add('BEGIN { unshift @INC, $1 if $0 =~ /(.*)[\/]/; }');
l.Add('');
l.Add('use Time::Local;');
l.Add('use File::Copy;');
l.Add('use Shell;');
l.Add('use strict;');
l.Add('');
l.Add('require ''stat-lib.pl'';');
l.Add('');
l.Add('sub usage');
l.Add('{');
l.Add('    print "parse_avstat.pl {-n=day_num|-ds=dd.mm.yyyy [-de=dd.mm.yyyy]} {-sd=stat_dir} {-h} {parse_log_name}\n";');
l.Add('    print "   parse_log_name - analyse parse_log_name file\n\n";');
l.Add('    print "   -n=day_num     - get statistics for day_num last days\n";');
l.Add('    print "   -ds=dd.mm.yyyy - get statistics from -ds date to -de(or to now).\n";');
l.Add('    print "   -sd=stat_dir   - save statistics to stat_dir\n";');
l.Add('    print "   -r             - reanalyse log.\n";');
l.Add('    print "   -h             - this message\n";');
l.Add('    print "   -x             - don''t move file\n";');
l.Add('    print "   -d             - delete log file after processing\n";');
l.Add('    exit;');
l.Add('}');
l.Add('');
l.Add('');
l.Add('if( $#ARGV == -1 ){');
l.Add('    usage;');
l.Add('}');
l.Add('');
l.Add('my $arg;');
l.Add('my $stat_dir="./";');
l.Add('my $daysec = 86400;');
l.Add('my $list_breaker='','';');
l.Add('my $cur_time = time;');
l.Add('my @tm = localtime($cur_time);');
l.Add('my $start_time;');
l.Add('my $start_timestamp=0;');
l.Add('my $end_time = $tm[3].".".($tm[4]+1).".".($tm[5]+1900);');
l.Add('my $end_timestamp=$cur_time;');
l.Add('my $log_filename="";');
l.Add('my $append_data=1;');
l.Add('my $move_file=1;');
l.Add('my $delete_stat=0;');
l.Add('');
l.Add('foreach $arg (@ARGV){');
l.Add('	if( $arg=~/^-n=(\d+)/){');
l.Add('		my $ndays = $1;');
l.Add('		@tm = localtime($cur_time-$ndays*$daysec);');
l.Add('		$start_time = $tm[3].".".($tm[4]+1).".".($tm[5]+1900);');
l.Add('		$start_timestamp = timelocal(0,0,0,$tm[3],$tm[4],$tm[5]);');
l.Add('	}elsif( $arg=~/^-ds=(\d+).(\d+).(\d+)/){');
l.Add('		$start_time = int($1).".".int($2).".".int($3);');
l.Add('		$start_timestamp = timelocal(0,0,0,int($1),int($2)-1,int($3)-1900);');
l.Add('	}elsif( $arg=~/^-de=(\d+).(\d+).(\d+)/){');
l.Add('		$end_time = int($1).".".int($2).".".int($3);');
l.Add('		$end_timestamp = timelocal(0,0,0,int($1),int($2)-1,int($3)-1900);');
l.Add('		$move_file=0;');
l.Add('	}elsif( $arg=~/^-sd=(.*)/){');
l.Add('		$stat_dir=$1;');
l.Add('	}elsif( $arg=~/^-r/){');
l.Add('		$append_data=0;');
l.Add('	}elsif( $arg=~/^-d/){');
l.Add('		$delete_stat=1;');
l.Add('	}elsif( $arg=~/^-x/){');
l.Add('		$move_file=0;');
l.Add('	}elsif( $arg=~/^-h/){');
l.Add('		usage;');
l.Add('	}elsif( $arg=~/^-/){');
l.Add('		print "Unknown option ''$arg'' or missed required argument.\n\n";');
l.Add('		usage;');
l.Add('	}else{');
l.Add('		$log_filename=trim_string($arg);');
l.Add('		');
l.Add('	}');
l.Add('}');
l.Add('if($log_filename eq ""){');
l.Add('	print "Logfile name is empty\n";');
l.Add('	exit;');
l.Add('}');
l.Add('#print "Start time: $start_time\n";');
l.Add('#print "End time: $end_time\n";');
l.Add('#print "End timestamp: ".localtime($end_timestamp)."\n";');
l.Add('#exit;');
l.Add('if(!($stat_dir=~/[\\\/]$/)){');
l.Add('	$stat_dir=$stat_dir."/";');
l.Add('}');
l.Add('');
l.Add('if (!-d $stat_dir) {');
l.Add('	print "Directory ''$stat_dir'' does not exist\n";');
l.Add('	exit;');
l.Add('}');
l.Add('');
l.Add('if (!-f $log_filename) {');
l.Add('	print "Logfile ''$log_filename'' does not exist\n";');
l.Add('	exit;');
l.Add('}');
l.Add('');
l.Add('my $rcpt_stat=$stat_dir."rcpt.stat";');
l.Add('my $sndr_stat=$stat_dir."sndr.stat";');
l.Add('my $virs_stat=$stat_dir."virs.stat";');
l.Add('my $ip_stat=$stat_dir."ip.stat";');
l.Add('my $total_stat=$stat_dir."total.stat";');
l.Add('my $time_stat=$stat_dir."time.stat";');
l.Add('my $line;');
l.Add('my $msg_id;');
l.Add('my %stats=();');
l.Add('load_stat(\%stats, $rcpt_stat, "rcpt");');
l.Add('load_stat(\%stats, $sndr_stat, "sndr");');
l.Add('load_stat(\%stats, $virs_stat, "virs");');
l.Add('load_stat(\%stats, $ip_stat, "ip");');
l.Add('load_stat(\%stats, $total_stat, "result");');
l.Add('load_time_stat(\%stats, $time_stat);');
l.Add('if(!$append_data){');
l.Add('	set_delete_flag(\%stats, $start_timestamp, $end_timestamp);');
l.Add('}');
l.Add('#delete_stat(\%stats, $start_timestamp, $end_timestamp);');
l.Add('');
l.Add('my $new_log_filename;');
l.Add('if($move_file){');
l.Add('#    $new_log_filename = $stat_dir.$log_filename."_".$end_timestamp;');
l.Add('    $new_log_filename = $log_filename."_".$end_timestamp;');
l.Add('    touch($log_filename);');
l.Add('    move($log_filename, $new_log_filename) or die "move ''$log_filename'' to ''$new_log_filename'' failed: $!";');
l.Add('#    touch($log_filename);');
l.Add('    $log_filename = $new_log_filename;');
l.Add('}');
l.Add('');
l.Add('open(LOG, "<$log_filename")         or die "can''t open $log_filename: $!";');
l.Add('while(<LOG>){');
l.Add('	$line = $_;');
l.Add('	if( !parse_stat_line($line, $start_timestamp, $end_timestamp, \%stats) )');
l.Add('	{');
l.Add('	    print("Bad line: $line\n");');
l.Add('	}');
l.Add('	');
l.Add('}');
l.Add('close LOG;');
l.Add('');
l.Add('save_stat(\%stats, $rcpt_stat, "rcpt");');
l.Add('save_stat(\%stats, $sndr_stat, "sndr");');
l.Add('save_stat(\%stats, $virs_stat, "virs");');
l.Add('save_stat(\%stats, $ip_stat, "ip");');
l.Add('save_stat(\%stats, $total_stat, "result");');
l.Add('save_time_stat(\%stats, $time_stat);');
l.Add('');
l.Add('');
l.SaveToFile(rootpath+'/bin/install/parse_avstat.pl');
fpsystem('/bin/chmod 777 ' + rootpath+'/bin/install/parse_avstat.pl');
end;

l.free;

end;
procedure myconf.MYSQL_UPGRADE();
var
   admin,password,cmd:string;

begin

if not fileexists('/usr/bin/mysql_upgrade') then begin
   writeln('myconf.MYSQL_UPGRADE():: unable to stat /usr/bin/mysql_upgrade');
   exit;
end;
logs:=Tlogs.Create;
admin:=logs.MYSQL_INFOS('database_admin');
password:=logs.MYSQL_INFOS('database_password');
if length(password)>0 then password:=' --password='+password;
cmd:='/usr/bin/mysql_upgrade --force --user='+admin+password;
fpsystem(cmd);
end;



procedure myconf.MYSQL_CHANGE_ROOT_PASSWORD();
var
   i:integer;
   pid_grant:string;
   root:string;
   password:string;
   commandline:string;
   sqlstring:string;
   l:TstringList;
   tempfile:string;
   logs:Tlogs;
   RegExpr     :TRegExpr;
   rootExists:boolean;
   servername:string;
   syslog:tsyslogng;
   obm:tobm;
   count:integer;
   mysqld_safe:string;
   incTimeout:integer;
   socket:string;
begin

  if not FileExists(zmysql.daemon_bin_path()) then begin
     writeln('Mysql is not installed here...');
     exit;
  end;
  rootExists:=false;
  socket:=zmysql.SERVER_PARAMETERS('socket');

  if ParamStr(2)='--inline' then begin
       root:=ParamStr(3);
       password:=Paramstr(4);
  end else begin
      root    :=SYS.MYSQL_INFOS('database_admin');
      password:=SYS.MYSQL_INFOS('database_password');

  end;

   if not FileExists(SYS.LOCATE_mysqld_safe()) then begin
         writeln('Unable to stat mysqld_safe');
         mysqld_safe:=SYS.LOCATE_mysqld_bin();
   end else begin
       mysqld_safe:='/bin/sh ' + SYS.LOCATE_mysqld_safe();
   end;


   if not FileExists(SYS.LOCATE_mysql_bin()) then begin
        writeln('Unable to stat mysql bin');
        exit;
   end;

     logs:=Tlogs.Create;
     tempfile:=logs.FILE_TEMP();

   writeln('Stopping Artica daemon');
   fpsystem('/etc/init.d/artica-postfix stop daemon');
   writeln('Stopping mysql...');
   syslog:=tsyslogng.Create(SYS);
   syslog.STOP();

   zmysql.SERVICE_STOP();
   writeln('Running mysql in grant tables...');
   writeln('/bin/sh ' + mysqld_safe+' --skip-grant-tables --skip-external-locking');
   writeln('');

   fpsystem(mysqld_safe+' --skip-grant-tables --skip-external-locking &');


   for i:=0 to 50 do begin
       pid_grant:=SYS.PIDOF_PATTERN(zmysql.daemon_bin_path());
       if length(pid_grant)>0 then break;
       sleep(500);
   end;



   if length(pid_grant)=0 then begin
       writeln('Timeout while running mysqld_safe.. Abort...');
       zmysql.SERVICE_START();
       fpsystem('/etc/init.d/artica-postfix start daemon');
       exit;
   end;

   writeln('Mysql in grant mode is running pid ' + pid_grant);
   sqlstring:='SELECT User from user WHERE User="' + root+'"';
   commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' 2>&1';
   fpsystem(commandline);
   incTimeout:=0;
   WHILE zmysql.CHECK_ERRORS_INFILE(tempfile) do begin
           writeln('Verify if ' + root + ' exists error detected, retry...');
           sleep(5);
           fpsystem(commandline);
           inc(incTimeout);
           if incTimeout>20 then break;
   end;

   writeln('Verify if ' + root + ' exists');


   writeln(logs.ReadFromFile(tempfile));
   writeln('');

   l:=TstringList.Create;
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='<field name="User">(.+?)</';
   l.LoadFromFile(tempfile);
   logs.DeleteFile(tempfile);
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          if LowerCase(trim(RegExpr.Match[1]))=LowerCase(root) then begin
             rootExists:=true;
             break;
          end;
       end;
   end;

   if rootExists then begin
      writeln(root +' Already exists in database, updating password has ['+password+']');
      sqlstring:='UPDATE user SET password=PASSWORD("' + password+'") WHERE user="'+root+'"';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' ';
      fpsystem(commandline);
      writeln('Results:');
      writeln(SYS.ReadFileIntoString(tempfile));
      logs.DeleteFile(tempfile);
      writeln('FLUSH PRIVILEGES:');

      sqlstring:='FLUSH PRIVILEGES;';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' ';
      fpsystem(commandline);
      writeln('Results:');
      writeln(SYS.ReadFileIntoString(tempfile));
      logs.DeleteFile(tempfile);

   end else begin
      servername:=SYS.HOSTNAME_g();
      writeln(root +' did not exists in database, Adding user with hostname "'+servername+'"');
      sqlstring:='INSERT INTO `user` (`Host`, `User`, `Password`, `Select_priv`, `Insert_priv`,';
      sqlstring:=sqlstring+'`Update_priv`, `Delete_priv`, `Create_priv`, `Drop_priv`, `Reload_priv`,';
      sqlstring:=sqlstring+'`Shutdown_priv`, `Process_priv`, `File_priv`, `Grant_priv`, `References_priv`,';
      sqlstring:=sqlstring+'`Index_priv`, `Alter_priv`, `Show_db_priv`, `Super_priv`, `Create_tmp_table_priv`,';
      sqlstring:=sqlstring+'`Lock_tables_priv`, `Execute_priv`, `Repl_slave_priv`, `Repl_client_priv`, `Create_view_priv`,';
      sqlstring:=sqlstring+'`Show_view_priv`, `Create_routine_priv`, `Alter_routine_priv`, `Create_user_priv`, `ssl_type`,';
      sqlstring:=sqlstring+'`ssl_cipher`, `x509_issuer`, `x509_subject`, `max_questions`, `max_updates`, `max_connections`,';
      sqlstring:=sqlstring+'`max_user_connections`) VALUES';
      sqlstring:=sqlstring+'("localhost", "'+root+'", PASSWORD("' + password+'"),';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y",';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "", "", "", "", 0, 0, 0, 0)';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' ';
      fpsystem(commandline);
      writeln(SYS.ReadFileIntoString(tempfile));
      logs.DeleteFile(tempfile);
      sqlstring:='INSERT INTO `user` (`Host`, `User`, `Password`, `Select_priv`, `Insert_priv`,';
      sqlstring:=sqlstring+'`Update_priv`, `Delete_priv`, `Create_priv`, `Drop_priv`, `Reload_priv`,';
      sqlstring:=sqlstring+'`Shutdown_priv`, `Process_priv`, `File_priv`, `Grant_priv`, `References_priv`,';
      sqlstring:=sqlstring+'`Index_priv`, `Alter_priv`, `Show_db_priv`, `Super_priv`, `Create_tmp_table_priv`,';
      sqlstring:=sqlstring+'`Lock_tables_priv`, `Execute_priv`, `Repl_slave_priv`, `Repl_client_priv`, `Create_view_priv`,';
      sqlstring:=sqlstring+'`Show_view_priv`, `Create_routine_priv`, `Alter_routine_priv`, `Create_user_priv`, `ssl_type`,';
      sqlstring:=sqlstring+'`ssl_cipher`, `x509_issuer`, `x509_subject`, `max_questions`, `max_updates`, `max_connections`,';
      sqlstring:=sqlstring+'`max_user_connections`) VALUES';
      sqlstring:=sqlstring+'("127.0.0.1", "'+root+'", PASSWORD("' + password+'"),';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y",';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "", "", "", "", 0, 0, 0, 0)';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' ';
      fpsystem(commandline);
      writeln(SYS.ReadFileIntoString(tempfile));
      logs.DeleteFile(tempfile);
      sqlstring:='INSERT INTO `user` (`Host`, `User`, `Password`, `Select_priv`, `Insert_priv`,';
      sqlstring:=sqlstring+'`Update_priv`, `Delete_priv`, `Create_priv`, `Drop_priv`, `Reload_priv`,';
      sqlstring:=sqlstring+'`Shutdown_priv`, `Process_priv`, `File_priv`, `Grant_priv`, `References_priv`,';
      sqlstring:=sqlstring+'`Index_priv`, `Alter_priv`, `Show_db_priv`, `Super_priv`, `Create_tmp_table_priv`,';
      sqlstring:=sqlstring+'`Lock_tables_priv`, `Execute_priv`, `Repl_slave_priv`, `Repl_client_priv`, `Create_view_priv`,';
      sqlstring:=sqlstring+'`Show_view_priv`, `Create_routine_priv`, `Alter_routine_priv`, `Create_user_priv`, `ssl_type`,';
      sqlstring:=sqlstring+'`ssl_cipher`, `x509_issuer`, `x509_subject`, `max_questions`, `max_updates`, `max_connections`,';
      sqlstring:=sqlstring+'`max_user_connections`) VALUES';
      sqlstring:=sqlstring+'("localhost", "'+root+'", PASSWORD("' + password+'"),';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y",';
      sqlstring:=sqlstring+'"Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "", "", "", "", 0, 0, 0, 0)';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -s -X -e '''+sqlstring+''' mysql >' + tempfile + ' ';
      fpsystem(commandline);
      writeln(SYS.ReadFileIntoString(tempfile));
      logs.DeleteFile(tempfile);
      sqlstring:='FLUSH PRIVILEGES;';
      commandline:=SYS.LOCATE_mysql_bin() + ' -N -S '+socket+' -s -X -e '''+sqlstring+''' mysql >' + tempfile + '';
      fpsystem(commandline);
      logs.DeleteFile(tempfile);
   end;



writeln('Change roundcube properties if exists');
roundcube.DEBIAN_CONFIG();
writeln('Change Samba-Audit properties if exists');
samba.SAMBA_AUDIT();
writeln('Stopping mysql in grant mode pid ' + pid_grant);


fpsystem('/bin/kill ' + pid_grant);
 count:=0;
 while SYS.PROCESS_EXIST(pid_grant) do begin
           fpsystem('/bin/kill '+pid_grant);
           sleep(300);
           count:=count+1;
           write('.');
           if count>30 then begin
              writeln('');
              writeln('Stopping mysql...............: timeout while killing grant mode');
              break;
            end;
     end;


writeln('Run mysql in normal mode...');
   writeln('');
   writeln('');
fpsystem('/etc/init.d/artica-postfix restart mysql');
obm:=tobm.Create(SYS);
obm.MYSQL_SETTING();
syslog.START();
writeln('Starting Artica...');
fpsystem('/etc/init.d/artica-postfix start daemon');



   writeln('');
   writeln('');
   writeln('');
   writeln('');
   writeln('');
writeln('');
SYS.set_MYSQL('database_admin',root);
SYS.set_MYSQL('database_password',password);
fpsystem(get_ARTICA_PHP_PATH()+'/bin/process1 --force &');
SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix restart apache-groupware &');
SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix restart zarafa &');
SYS.THREAD_COMMAND_SET('/etc/init.d/artica-postfix restart roundcube &');
writeln('Done....');

end;
//#########################################################################################
function myconf.GDM_STATUS():string;
var
pidpath:string;
begin
   pidpath:=logs.FILE_TEMP();
   fpsystem(SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.status.php --gdm >'+pidpath +' 2>&1');
   result:=logs.ReadFromFile(pidpath);
   logs.DeleteFile(pidpath);
end;
//#########################################################################################
function myconf.ARTICA_MAKE_STATUS():string;
var
   ini:TstringList;
   pid:string;
begin
   pid:=SYS.PidByProcessPath(get_ARTICA_PHP_PATH()+'/bin/artica_make');
   ini:=TstringList.Create;

   ini.Add('[ARTICA_MAKE]');

   if SYS.PROCESS_EXIST(pid) then begin
      ini.Add('running=1');
      ini.Add('service_disabled=1');
   end else  begin
      ini.Add('running=1');
      ini.Add('service_disabled=1');
   end;

   ini.Add('application_installed=1');
   ini.Add('master_pid='+ pid);
   ini.Add('master_memory=' + IntToStr(SYS.PROCESS_MEMORY(pid)));
   ini.Add('master_version=' + ARTICA_VERSION());
   ini.Add('status='+SYS.PROCESS_STATUS(pid));
   ini.Add('service_name=APP_ARTICA_MAKE');
   result:=ini.Text;
   ini.free;

end;
//#########################################################################################
function myconf.GDM_VERSION():string;
 var
    RegExpr:TRegExpr;
    filetemp:string;
    gdm_bin:string;
    SYS:Tsystem;
    LOGS:Tlogs;
begin
  SYS:=Tsystem.Create();
  logs:=Tlogs.Create;
  gdm_bin:=SYS.LOCATE_GENERIC_BIN('gdm');
  if length(gdm_bin)=0 then exit;

     if not FileExists(gdm_bin) then begin
        logs.Debuglogs('myconf.GDM_VERSION():: not installed');
        exit;
     end;

  result:=SYS.GET_CACHE_VERSION('APP_GDM');
  if length(result)>2 then exit;
  RegExpr:=TRegExpr.Create;
  filetemp:=LOGS.FILE_TEMP();
 // writeln(gdm_bin+' --version');
  fpsystem(gdm_bin+' --version >' + filetemp + ' 2>&1');
  if not FileExists(filetemp) then exit;
  RegExpr.Expression:='GDM\s+([0-9\.]+)';
  RegExpr.Exec(LOGS.ReadFromFile(filetemp));
  logs.DeleteFile(filetemp);
  result:=RegExpr.Match[1];
  RegExpr.free;
  SYS.SET_CACHE_VERSION('APP_GDM',result);

end;
//#########################################################################################
function myconf.ATMAIL_VERSION():string;
 var
    RegExpr:TRegExpr;
    l:TstringList;
    i:integer;
    D:boolean;

begin
D:=false;
if paramStr(1)='--atopenmail' then D:=True;
  if Not FileExists('/usr/share/artica-postfix/mail/libs/Atmail/Config.php') then begin
     logs.Debuglogs('ATMAIL_VERSION() unable to stat /usr/share/artica-postfix/mail/libs/Atmail/Config.php');
     exit;
  end;


  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='version''\s+=>.+?([0-9\.]+)';
  if D then writeln('Pattern=' ,RegExpr.Expression);
  l:=TstringList.Create;
  L.LoadFromFile('/usr/share/artica-postfix/mail/libs/Atmail/Config.php');
  for i:=0 to l.Count-1 do begin

   if RegExpr.Exec(l.Strings[i]) then begin
      result:=RegExpr.Match[1];
      break;
   end;
  end;
  l.free;
  RegExpr.free;
end;
//#########################################################################################
function myconf.NMAP_VERSION():string;
  var
   RegExpr:TRegExpr;
   tmpstr:string;
   l:TstringList;
   i:integer;
   path:string;
begin



     path:='/usr/bin/nmap';
     if not FileExists(path) then begin
        logs.Debuglogs('myconf.NMAP_VERSION():: nmap is not installed');
        exit;
     end;


   result:=SYS.GET_CACHE_VERSION('APP_NMAP');
   if length(result)>0 then exit;
   tmpstr:=logs.FILE_TEMP();
   fpsystem(path+' -V >'+tmpstr+' 2>&1');


     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile(tmpstr);
     RegExpr.Expression:='version\s+([0-9A-Z\.]+)';
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            break;
         end;
     end;
l.Free;
RegExpr.free;
SYS.SET_CACHE_VERSION('APP_NMAP',result);
logs.Debuglogs('APP_NMAP:: -> ' + result);
end;
//#############################################################################
function myconf.GNUPLOT_VERSION():string;
  var
   RegExpr:TRegExpr;
   tmpstr:string;
   l:TstringList;
   i:integer;
   path:string;
   d:boolean;
begin

     d:=false;
     d:=SYS.COMMANDLINE_PARAMETERS('--verbose');

     path:='/usr/bin/gnuplot';
     if not FileExists(path) then begin
        logs.Debuglogs('myconf.GNUPLOT_VERSION():: gnuplot is not installed');
        exit;
     end;


   result:=SYS.GET_CACHE_VERSION('APP_GNUPLOT');
   if length(result)>0 then exit;
   tmpstr:=logs.FILE_TEMP();
   fpsystem(path+' -V >'+tmpstr+' 2>&1');


     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile(tmpstr);
     RegExpr.Expression:='gnuplot\s+([0-9A-Z\.]+)\s+patchlevel\s+([0-9]+)';
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1]+'.'+RegExpr.Match[2];
            break;
         end else begin
          if d then writeln('Not match: "',l.Strings[i],'"');
         end;


     end;
l.Free;
RegExpr.free;
SYS.SET_CACHE_VERSION('APP_GNUPLOT',result);
logs.Debuglogs('APP_GNUPLOT:: -> ' + result);
end;
//#############################################################################
function myconf.DSTAT_VERSION():string;
  var
   RegExpr:TRegExpr;

   tmpstr:string;
   l:TstringList;
   i:integer;
   path:string;
begin



     path:='/usr/bin/dstat';
     if not FileExists(path) then begin
        logs.Debuglogs('myconf.DSTAT_VERSION():: dstat is not installed');
        exit;
     end;


   result:=SYS.GET_CACHE_VERSION('APP_DSTAT');
   if length(result)>0 then exit;
   tmpstr:=path;



     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile(tmpstr);
     RegExpr.Expression:='VERSION\s+=.+?([0-9\.]+)';
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            break;
         end;
     end;
l.Free;
RegExpr.free;
SYS.SET_CACHE_VERSION('APP_DSTAT',result);
logs.Debuglogs('APP_DSTAT:: -> ' + result);
end;
//#############################################################################
function myconf.WINEXE_VERSION():string;
  var
   RegExpr:TRegExpr;

   tmpstr:string;
   l:TstringList;
   i:integer;
   path:string;
begin



     path:='/usr/bin/winexe';
     if not FileExists(path) then begin
        logs.Debuglogs('myconf.WINEXE_VERSION():: dstat is not installed');
        exit;
     end;


   result:=SYS.GET_CACHE_VERSION('APP_WINEXE');
   if length(result)>0 then exit;
   tmpstr:=logs.FILE_TEMP();

   fpsystem(path+' -v >' + tmpstr+' 2>&1');



     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile(tmpstr);
     RegExpr.Expression:='winexe version\s+([0-9\.]+)';
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            break;
         end;
     end;
l.Free;
RegExpr.free;
SYS.SET_CACHE_VERSION('APP_WINEXE',result);
logs.Debuglogs('APP_WINEXE:: -> ' + result);
end;
//#############################################################################

procedure myconf.CLEAN_QUARANTINES();
var
   l:Tstringlist;
   tmpstr:string;
   mailcount:integer;
    RegExpr:TRegExpr;
    i:integer;
    QuarantineAutoCleanEnabled:integer;
    QuarantineMaxDayToLive:integer;
    Size:integer;
begin

QuarantineMaxDayToLive:=0;
QuarantineAutoCleanEnabled:=0;

if not FileExists('/usr/bin/find') then begin
   logs.Syslogs('CLEAN_QUARANTINE: WARNING unable to stat /usr/bin/find');
   logs.NOTIFICATION('WARNING: unable to stat /usr/bin/find','Artica will be not able to clean your quarantine directory without this tool','system');
   exit;
end;
if not TryStrToint(SYS.GET_INFO('QuarantineAutoCleanEnabled'),QuarantineAutoCleanEnabled) then QuarantineAutoCleanEnabled:=0;
if not TryStrToint(SYS.GET_INFO('QuarantineMaxDayToLive'),QuarantineMaxDayToLive) then QuarantineMaxDayToLive:=15;

if QuarantineAutoCleanEnabled=0 then exit;

QuarantineMaxDayToLive:=QuarantineMaxDayToLive*1440;

logs.Debuglogs('QuarantineMaxDayToLive: '+IntToStr(QuarantineMaxDayToLive)+' minutes to live for files');

tmpstr:=logs.FILE_TEMP();
if SYS.PROCESS_EXIST(SYS.PIDOF_PATTERN('/usr/bin/find /opt/artica/share/www/original_messages/quarantines')) then begin
   logs.Syslogs('myconf.CLEAN_QUARANTINES() already instance executed');
   exit;
end;
fpsystem('/usr/bin/find /opt/artica/share/www/original_messages/quarantines >'+tmpstr+' 2>&1');
l:=Tstringlist.Create;
mailcount:=0;
Size:=0;
l.LoadFromFile(tmpstr);
logs.DeleteFile(tmpstr);
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='\/quarantines\/sources';
for i:=0 to l.Count-1 do begin
    if length(trim(l.Strings[i]))=0 then continue;
    if RegExpr.Exec(l.Strings[i]) then continue;
    if not FileExists(l.Strings[i]) then continue;
    if sys.IsDirectory(l.Strings[i]) then continue;


    if SYS.FILE_TIME_BETWEEN_MIN(l.Strings[i])>QuarantineMaxDayToLive then begin
       logs.DeleteFile(l.Strings[i]);
       Size:=Size+SYS.FileSize_ko(l.Strings[i]);
       inc(mailcount);
    end;

end;

logs.Syslogs(IntTostr(mailcount)+' quarantine message(s) deleted on disk ('+IntTostr(Size) +'Ko free)');
if mailcount>0 then begin
   logs.NOTIFICATION(IntTostr(mailcount)+' quarantine messages deleted on disk',IntTostr(mailcount) +' messages deleted :' +IntTostr(Size) +'Ko free for the system disk','system');
end;
l.free;
RegExpr.free;


end;
//#############################################################################
 function myconf.BOA_DAEMON_STATUS():string;
 var
    pidpath:string;
 begin
  SYS.MONIT_DELETE('APP_BOA');
  pidpath:=logs.FILE_TEMP();
  fpsystem(SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.status.php --boa >'+pidpath +' 2>&1');
  result:=logs.ReadFromFile(pidpath);
  logs.DeleteFile(pidpath);
end;
//#############################################################################
function myconf.LMB_LUNDIMATIN_VERSION():string;

         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;

 var
    ini:string;
    pid:string;
 begin
    ini:='';
    pid:=BOA_DAEMON_GET_PID();
    logs.Debuglogs('starting status BOA');
    ini:=ini+ '[BOA]'+CRLF;
    if SYS.PROCESS_EXIST(pid) then ini:=ini+ 'running=1'+CRLF else  ini:=ini+ 'running=0'+CRLF;
   ini:=ini+ 'application_installed=1'+CRLF;
   ini:=ini+ 'master_pid='+ pid+CRLF;
   ini:=ini+ 'master_memory=' + IntToStr(SYS.PROCESS_MEMORY(pid))+CRLF;
   ini:=ini+ 'master_version=0.94.13'+CRLF;
   ini:=ini+ 'status='+SYS.PROCESS_STATUS(pid)+CRLF;
   ini:=ini+ 'service_name=APP_BOA'+CRLF;
   ini:=ini+ 'service_cmd=boa'+CRLF;
  result:=ini;
end;
//#############################################################################
procedure myconf.SYSLOGER_START();
var
   pid:string;
   pidint:integer;
   log_path:string;
   count:integer;
   cmd:string;
   CountTail:Tstringlist;
   syslogs:string;
   TAIL_STARTUP:string;
begin

syslogs:=SYS.LOCATE_SYSLOG_PATH();
if not FileExists(syslogs) then begin
      logs.DebugLogs('Starting......: sysloger unable to stat syslog file');
      exit;
end;

pid:=SYSLOGER_PID();
if SYS.PROCESS_EXIST(pid) then begin
      logs.DebugLogs('Starting......: sysloger already running with pid '+pid);
      CountTail:=Tstringlist.Create;
      CountTail.AddStrings(SYS.PIDOF_PATTERN_PROCESS_LIST('/usr/bin/tail -f -n 0 '+syslogs));
      logs.DebugLogs('Starting......: sysloger realtime process number:'+IntToStr(CountTail.Count));
      if CountTail.Count>3 then fpsystem('/etc/init.d/artica-postfix restart sysloger');
      CountTail.free;
      exit;
end;
log_path:=syslogs;
TAIL_STARTUP:=SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.syslog.php';
logs.DebugLogs('Starting......: sysloger realtime logs path: '+log_path);

pid:=SYS.PIDOF_PATTERN('/usr/bin/tail -f -n 0 '+log_path);
count:=0;
pidint:=0;
      while SYS.PROCESS_EXIST(pid) do begin
          if count>0 then break;
          if not TryStrToInt(pid,pidint) then continue;
          logs.DebugLogs('Starting......: sysloger realtime logs stop tail pid '+pid);
          if pidint>0 then  fpsystem('/bin/kill '+pid);
          sleep(200);
          pid:=SYS.PIDOF_PATTERN('/usr/bin/tail -f -n 0 '+log_path);
          inc(count);
      end;

cmd:='/usr/bin/tail -f -n 0 '+log_path+'|'+TAIL_STARTUP+ ' &';
logs.Debuglogs(cmd);
fpsystem(cmd);
pid:=SYSLOGER_PID();
count:=0;
while not SYS.PROCESS_EXIST(pid) do begin
        sleep(100);
        inc(count);
        if count>40 then begin
           logs.DebugLogs('Starting......: sysloger realtime logs (timeout)');
           break;
        end;
        pid:=SYSLOGER_PID();
  end;

pid:=SYSLOGER_PID();

if SYS.PROCESS_EXIST(pid) then begin
      logs.DebugLogs('Starting......: sysloger realtime logs success with pid '+pid);
      exit;
end else begin
    logs.DebugLogs('Starting......: sysloger realtime logs failed');
end;
end;
//#####################################################################################
function myconf.SYSLOGER_PID():string;
var
   pid:string;
   TAIL_STARTUP:string;
begin
TAIL_STARTUP:=SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.syslog.php';
if FileExists('/etc/artica-postfix/exec.syslog.php.pid') then begin
   pid:=SYS.GET_PID_FROM_PATH('/etc/artica-postfix/exec.syslog.php.pid');
   logs.Debuglogs('DANSGUARDIAN_TAIL_PID /etc/artica-postfix/exec.syslog.php.pid='+pid);
   if SYS.PROCESS_EXIST(pid) then result:=pid;
   exit;
end;


result:=SYS.PIDOF_PATTERN(TAIL_STARTUP);
logs.Debuglogs(TAIL_STARTUP+' pid='+pid);
end;
//#####################################################################################
function myconf.SYSLOGER_STATUS():string;
var
pidpath:string;
begin
   SYS.MONIT_DELETE('APP_SYSLOGER');
   pidpath:=logs.FILE_TEMP();
   fpsystem(SYS.LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.status.php --sysloger >'+pidpath +' 2>&1');
   result:=logs.ReadFromFile(pidpath);
   logs.DeleteFile(pidpath);
end;
//#####################################################################################
procedure myconf.SYSLOGER_STOP();
var
   pid,syslogs:string;
   pidint,i:integer;
   count:integer;
   CountTail:Tstringlist;
begin
pid:=SYSLOGER_PID();
syslogs:=SYS.LOCATE_SYSLOG_PATH();
if not SYS.PROCESS_EXIST(pid) then begin
      writeln('Stopping sysloger: Already stopped');
      CountTail:=Tstringlist.Create;
      try
         CountTail.AddStrings(SYS.PIDOF_PATTERN_PROCESS_LIST('/usr/bin/tail -f -n 0 '+syslogs));
         writeln('Stopping sysloger: Tail processe(s) number '+IntToStr(CountTail.Count));
      except
        logs.Debuglogs('Stopping sysloger: fatal error on SYS.PIDOF_PATTERN_PROCESS_LIST() function');
      end;

      count:=0;
     for i:=0 to CountTail.Count-1 do begin;
          pid:=CountTail.Strings[i];
          if count>100 then break;
          if not TryStrToInt(pid,pidint) then continue;
          writeln('Stopping sysloger: Stop tail pid '+pid);
          if pidint>0 then  fpsystem('/bin/kill '+pid);
          sleep(100);
          inc(count);
      end;
      exit;
end;

writeln('Stopping sysloger: Stopping pid '+pid);
fpsystem('/bin/kill '+pid);

pid:=SYSLOGER_PID();
if not SYS.PROCESS_EXIST(pid) then begin
      writeln('Stopping sysloger: Stopped');
end;


CountTail:=Tstringlist.Create;
CountTail.AddStrings(SYS.PIDOF_PATTERN_PROCESS_LIST('/usr/bin/tail -f -n 0 '+syslogs));
writeln('Stopping sysloger: Tail processe(s) number '+IntToStr(CountTail.Count));
count:=0;
     for i:=0 to CountTail.Count-1 do begin;
          pid:=CountTail.Strings[i];
          if count>100 then break;
          if not TryStrToInt(pid,pidint) then continue;
          writeln('Stopping sysloger: Stop tail pid '+pid);
          if pidint>0 then  fpsystem('/bin/kill '+pid);
          sleep(100);
          inc(count);
      end;


end;
//#####################################################################################
function myconf.LMB_VERSION():string;
var
   l:Tstringlist;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
begin
tmpstr:='/usr/local/share/artica/lmb_src/config/config_serveur.inc.php';
if not FileExists(tmpstr) then exit;
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='_SERVER\[.+?VERSION.+?\].+?([0-9\.])';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;

end;
    l.free;
    RegExpr.free;
end;
//#####################################################################################
function myconf.GROUPOFFICE_VERSION():string;
var
   l:Tstringlist;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
begin
tmpstr:='/usr/local/share/artica/group-office/classes/base/config.class.inc.php';
if not FileExists(tmpstr) then exit;
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='var\s+\$version.+?([0-9\.]+)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;

end;
    l.free;
    RegExpr.free;
end;
//#####################################################################################
function myconf.hpinlinux_VERSION():string;
var
   l:Tstringlist;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
begin

     result:=SYS.GET_CACHE_VERSION('APP_HPINLINUX');
     if length(result)>1 then exit;

tmpstr:='/usr/local/share/hpinlinux/getweb';
if not FileExists(tmpstr) then exit;
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='VERSION=.+?v\s+([0-9\.]+)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;
end;
     SYS.SET_CACHE_VERSION('APP_HPINLINUX',result);
    l.free;
    RegExpr.free;
end;
//#####################################################################################
function myconf.PHPMYADMIN_VERSION():string;
var
   l:Tstringlist;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
   D:boolean;
begin

     D:=false;
     result:=SYS.GET_CACHE_VERSION('APP_PHPMYADMIN');
     if length(result)>2 then exit;
     D:=SYS.COMMANDLINE_PARAMETERS('--phpmyadmin');
     tmpstr:='/usr/share/phpmyadmin/libraries/Config.class.php';
     if not FileExists(tmpstr) then tmpstr:='/usr/share/artica-postfix/mysql/libraries/Config.class.php';


     if not FileExists(tmpstr) then begin
        if D then writeln('Unable to stat '+tmpstr);
        exit;
     end;
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);

if D then writeln('File:',tmpstr);

RegExpr:=TRegExpr.Create;
if D then writeln('Lines:',l.Count);
RegExpr.Expression:='\(.+?PMA_VERSION.+?([0-9\.]+).*?\)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;
end;
     SYS.SET_CACHE_VERSION('APP_PHPMYADMIN',result);
    l.free;
    RegExpr.free;
end;
//#####################################################################################
function myconf.DRUPAL_VERSION():string;
var
   l:Tstringlist;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
   D:boolean;
begin

     D:=false;
     result:=SYS.GET_CACHE_VERSION('APP_DRUPAL');
     if length(result)>2 then exit;
     D:=SYS.COMMANDLINE_PARAMETERS('--drupal');
     tmpstr:='/usr/share/drupal/modules/system/system.info';



     if not FileExists(tmpstr) then begin
        if D then writeln('Unable to stat '+tmpstr);
        exit;
     end;
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);

if D then writeln('File:',tmpstr);

RegExpr:=TRegExpr.Create;
if D then writeln('Lines:',l.Count);
RegExpr.Expression:='version = "([0-9\.]+)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=RegExpr.Match[1];
       break;
    end;
end;
     SYS.SET_CACHE_VERSION('APP_DRUPAL',result);
    l.free;
    RegExpr.free;
end;
//#####################################################################################



procedure myconf.LISTDIRS_RECURSIVE(path:string);
var
   i:integer;
begin
   SYS.DirDir(path);
   for i:=0 to SYS.DirListFiles.Count-1 do begin
     writeln( SYS.DirListFiles.Strings[i]);

   end;
end;
//#####################################################################################
procedure myconf.GETTY_CHANGE_INITTAB();
var
l:Tstringlist;
RegExpr:TRegExpr;
i:integer;
begin
l:=Tstringlist.Create;
try
   l.LoadFromFile('/etc/inittab');
except
   exit;
end;
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='ERASED BY ARTICA';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       RegExpr.free;
       l.free;
       exit;
    end;
end;

l.Clear;
l.free;
l:=Tstringlist.Create;

l.add('# /etc/inittab: init(8) configuration.');
l.add('# $Id: inittab,v 1.91 2002/01/25 13:35:21 miquels Exp $');
l.add('# ERASED BY ARTICA for autologon');
l.add('');
l.add('id:2:initdefault:');
l.add('si::sysinit:/etc/init.d/rcS');
l.add('~~:S:wait:/sbin/sulogin');
l.add('l0:0:wait:/etc/init.d/rc 0');
l.add('l1:1:wait:/etc/init.d/rc 1');
l.add('l2:2:wait:/etc/init.d/rc 2');
l.add('l3:3:wait:/etc/init.d/rc 3');
l.add('l4:4:wait:/etc/init.d/rc 4');
l.add('l5:5:wait:/etc/init.d/rc 5');
l.add('l6:6:wait:/etc/init.d/rc 6');
l.add('z6:6:respawn:/sbin/sulogin');
l.add('ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now');
l.add('pf::powerwait:/etc/init.d/powerfail start');
l.add('pn::powerfailnow:/etc/init.d/powerfail now');
l.add('po::powerokwait:/etc/init.d/powerfail stop');
l.add('');
l.add('1:2345:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty1');
l.add('2:23:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty2');
l.add('3:23:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty3');
l.add('4:23:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty4');
l.add('5:23:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty5');
l.add('6:23:respawn:/sbin/getty -i -n -l /usr/share/artica-postfix/bin/artica-logon 38400 tty6');
l.add('');
logs.WriteToFile(l.Text,'/etc/inittab');
writeln('Modify /etc/inittab done.....');
l.free;
end;
//#####################################################################################
end.

