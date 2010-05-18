unit vmwaretools;

{$MODE DELPHI}
{$LONGSTRINGS ON}

interface

uses
    Classes, SysUtils,variants,strutils,IniFiles, Process,logs,unix,RegExpr,zsystem;



  type
  tvmtools=class


private
     LOGS:Tlogs;
     SYS:TSystem;
     artica_path:string;
     function PID_PATH():string;
public
    procedure   Free;
    constructor Create(const zSYS:Tsystem);
    function    VERSION():string;
    function    BIN_PATH():string;
    function    PID_NUM():string;
    procedure   START();
    procedure   STOP();
    function    STATUS:string;
    function    INITD_PATH():string;
    procedure   RELOAD();
END;

implementation

constructor tvmtools.Create(const zSYS:Tsystem);
begin
       forcedirectories('/etc/artica-postfix');
       LOGS:=tlogs.Create();
       SYS:=zSYS;



       if not DirectoryExists('/usr/share/artica-postfix') then begin
              artica_path:=ParamStr(0);
              artica_path:=ExtractFilePath(artica_path);
              artica_path:=AnsiReplaceText(artica_path,'/bin/','');

      end else begin
          artica_path:='/usr/share/artica-postfix';
      end;
end;
//##############################################################################
procedure tvmtools.free();
begin
    logs.Free;

end;
//##############################################################################
function tvmtools.BIN_PATH():string;
begin
   if FileExists('/usr/sbin/vmware-guestd') then exit('/usr/sbin/vmware-guestd');
end;
//##############################################################################
function tvmtools.INITD_PATH():string;
begin
if FileExists('/etc/init.d/vmware-tools') then exit('/etc/init.d/vmware-tools');
end;
//##############################################################################
function tvmtools.PID_PATH():string;
begin
exit('/var/run/vmware-guestd.pid');
end;
//##############################################################################
function tvmtools.PID_NUM():string;
begin
    if not FIleExists(BIN_PATH()) then exit;
    result:=SYS.PIDOF('vmware-guestd');
end;
//##############################################################################
function tvmtools.VERSION():string;
var
    RegExpr:TRegExpr;
    FileDatas:TStringList;
    i:integer;
    BinPath:string;
    filetmp:string;
begin

result:=SYS.GET_CACHE_VERSION('APP_VMTOOLS');
if length(result)>2 then exit;

filetmp:='/etc/vmware-tools/manifest.txt.shipped';
if not FileExists(BIN_PATH()) then exit;
if not FileExists(filetmp) then exit;

    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='guestd\.version.+?([0-9\.]+)';
    FileDatas:=TStringList.Create;
    FileDatas.LoadFromFile(filetmp);
    for i:=0 to FileDatas.Count-1 do begin
        if RegExpr.Exec(FileDatas.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
        end;
    end;
             RegExpr.free;
             FileDatas.Free;
SYS.SET_CACHE_VERSION('APP_VMTOOLS',result);

end;
//#############################################################################
procedure tvmtools.RELOAD();
var
   count:integer;
   pid:string;
begin
    if not FileExists(INITD_PATH()) then exit;
    fpsystem(INITD_PATH()+' reload');

end;

procedure tvmtools.START();
var
   count:integer;
   pid:string;
begin
    pid:=PID_NUM();
    IF sys.PROCESS_EXIST(pid) then begin
       logs.DebugLogs('Starting......: VmwareTools Already running PID '+ pid);
       exit;
    end;

    if not FileExists(INITD_PATH()) then begin
       logs.DebugLogs('Starting......: VmwareTools is not installed');
       exit;
    end;


    fpsystem(INITD_PATH()+' start &');



 while not SYS.PROCESS_EXIST(PID_NUM()) do begin
        sleep(100);
        inc(count);
        if count>10 then begin
           logs.DebugLogs('Starting......: VmwareTools (timeout)');
           break;
        end;
  end;

pid:=PID_NUM();
    IF sys.PROCESS_EXIST(pid) then begin
       logs.DebugLogs('Starting......: VmwareTools successfully started and running PID '+ pid);
       exit;
    end;

logs.DebugLogs('Starting......: VmwareTools failed');

end;


//#############################################################################
procedure tvmtools.STOP();
var
   count:integer;
   pid:string;
   tmp:string;
   l:Tstringlist;
   i:integer;
   tt:integer;
   path:string;
    RegExpr:TRegExpr;
begin
  fpsystem(INITD_PATH()+' stop');
end;


//#############################################################################
function tvmtools.STATUS:string;
var
ini:TstringList;
pid:string;
begin
   ini:=TstringList.Create;
   ini.Add('[APP_VMTOOLS]');
   if not fileExists(BIN_PATH()) then begin
      ini.Add('application_installed=0');
      ini.Add('service_disabled=0');
      result:=ini.Text;
      ini.free;
      exit;
   end;

   ini.Add('master_version='+VERSION());
   ini.Add('service_name=APP_VMTOOLS');
   ini.Add('service_cmd=vmtools');
   ini.Add('service_disabled=1');

   if SYS.MONIT_CONFIG('APP_VMTOOLS',PID_PATH(),'vmtools') then begin
    ini.Add('monit=1');
    result:=ini.Text;
    ini.free;
    exit;
   end;

   pid:=PID_NUM();
   if SYS.PROCESS_EXIST(pid) then ini.Add('running=1') else  ini.Add('running=0');
   ini.Add('application_installed=1');
   ini.Add('application_enabled=1');
   ini.Add('master_pid='+ pid);
   ini.Add('master_memory=' + IntToStr(SYS.PROCESS_MEMORY(pid)));
   ini.Add('status='+SYS.PROCESS_STATUS(pid));
   result:=ini.Text;
   ini.free;

end;
//##############################################################################


end.