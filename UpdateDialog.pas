unit UpdateDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, DBUdaje,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, Data.DB, Skript;

type
  TUpdateDlg = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    DB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDTransaction1: TFDTransaction;
    Script: TFDScript;
    InitTimer: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure InitTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScriptConsolePut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure ScriptError(ASender, AInitiator: TObject;
      var AException: Exception);
  private
    { Private declarations }
    function PripojDatabazu(p_databaza: TDBUdaje): Boolean;
    procedure OdpojDatabazu(p_databaza: TDBudaje);
    procedure UpdatujDatabazu(p_databaze: TDBUdaje);
    procedure ZalohujDatabazu(p_databaza: TDBUdaje; p_cesta: string);
  public
    { Public declarations }
  end;

var
  UpdateDlg: TUpdateDlg;

implementation
  uses Shellapi, GUI1, Nastaveni, RzTreeVw;

{$R *.dfm}

procedure TUpdateDlg.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.FormShow(Sender: TObject);
begin
  InitTimer.Enabled:=True;
  Enabled:=False;
  Memo1.Clear;
end;

////////////////////////////////////////////////////////////////////////////////

function TUpdateDlg.PripojDatabazu(p_databaza: TDBUdaje): Boolean;
begin
  if(DB.Connected) then OdpojDatabazu(p_databaza);
  begin
    try
      Memo1.Lines.Add('Pøipojování hlavního pøipojení na primární databázi');

      DB.Params.Clear;

      DB.Params.Add('Database='+p_databaza.Cesta);
      DB.Params.Add('Server='+p_databaza.Server);
      DB.Params.Add('DriverID=FB');
      DB.Params.Add('PageSize=16384');

      if p_databaza.Heslo<>'' then DB.Params.Add('Password='+p_databaza.Heslo)
      else DB.Params.Add('Password='+ExecutorNastaveni.CentralHeslo);

      if p_databaza.Login<>'' then DB.Params.Add('User_Name='+p_databaza.Login)
      else DB.Params.Add('User_Name='+ExecutorNastaveni.CentralLogin);

      DB.Params.Add('Protocol=TCPIP');
      DB.Params.Add('DropDatabase=No');

      if p_databaza.Rola<>'' then DB.Params.Append('RoleName='+p_databaza.Rola)
      else if ExecutorNastaveni.CentralRole<>'' then DB.Params.Append('RoleName='+ExecutorNastaveni.CentralRole);

      DB.Open;
    except
      on e: EFDException do
      begin
        //ZaznamenajVynimku(e,'Pripoj databazu');
      end;
    end;
  end;

  Result:=DB.Connected;
end;

procedure TUpdateDlg.ScriptConsolePut(AEngine: TFDScript; const AMessage: string; AKind: TFDScriptOutputKind);
begin
  case AKind of
    soSeparator: ;
    soEcho: ;
    soScript: ;
    soInfo: ;
    soError: ;
    soConnect: ;
    soServerOutput: ;
    soUserOutput: ;
    soCommand: ;
    soMacro: ;
    soData: ;
    soParam: ;
  end;

  Memo1.Lines.Add(AMessage);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.ScriptError(ASender, AInitiator: TObject; var AException: Exception);
begin
  Memo1.Lines.Add('Výjimka: '+AException.Message);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.OdpojDatabazu(p_databaza: TDBUdaje);
begin
  DB.Connected:=False;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.UpdatujDatabazu(p_databaze: TDBUdaje);
var
  v_udaje: TDBUdaje;
  v_script: TFDSQLScript;
  v_skriptguid,v_cesta: string;
  v_skript: TSkript;
  v_zalohovat,v_spustit_skript: Boolean;
begin
  Memo1.Lines.Add('Update databaze '+p_databaze.Nazev);

  if PripojDatabazu(p_databaze) then
  begin
    Memo1.Lines.Add('Ustaveno hlavní pøipojení na primární databázi');

    v_zalohovat:=False;
    v_spustit_skript:=False;
    Script.SQLScripts.Clear;

    for v_skriptguid in ExecutorNastaveni.SkriptyPoradi do
    begin

      if ExecutorNastaveni.Skripty.TryGetValue(v_skriptguid,v_skript) then
      begin
        if v_skript.Oznacen and (not v_skript.Neprovadet.Contains(p_databaze.GUID)) then
        begin
          if Pos('BACKUP DATABASE',v_skript.Text)=1 then
          begin
            v_zalohovat:=True;
            v_cesta:=Copy(v_skript.Text,17,MaxInt);
          end
          else
          begin
            v_script:=Script.SQLScripts.Add;
            v_script.SQL.Text:=v_skript.Text;
            v_spustit_skript:=True;
          end;
        end;
      end;
    end;

    if v_spustit_skript then
    begin
      try
        if not Script.ValidateAll then Memo1.Lines.Add('Validace skriptu s chybama');
        if not Script.ExecuteAll then Memo1.Lines.Add('Provedeni skriptu s chybama');
      except
        Memo1.Lines.Add('Skript se nepovedlo dokoncit');
      end;
    end;

    OdpojDatabazu(p_databaze);

    if v_zalohovat then ZalohujDatabazu(p_databaze,v_cesta);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function VykonajPrikaz(p_prikaz: string; p_handle: HWND; var p_exitkod: DWORD): Boolean;
var
  SEInfo: TShellExecuteInfo;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0) ;
  SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;

  with SEInfo do begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := p_handle;
    lpFile:=PChar('cmd.exe');
    lpParameters :=PChar(p_prikaz);
    nShow := SW_HIDE;
  end;

  if ShellExecuteEx(@SEInfo) then
  begin
    WaitForSingleObject(SEInfo.hProcess, INFINITE);
    GetExitCodeProcess(SEInfo.hProcess,p_exitkod);
    CloseHandle(SEInfo.hProcess);
    Result:=True;
  end
  else Result:=False;
end;

////////////////////////////////////////////////////////////////////////////////

//'/C ""c:\Program Files\Firebird\Firebird_2_5\bin\gbak.exe" -backup -user SYSDBA -password masterkey -service service_mgr "\Users\kandrik\Documents\Embarcadero\Studio\Projects\starmon-ep\LOCALBASE-NAC.GDB" "C:\Users\kandrik\Documents\Embarcadero\Studio\Projects\Starmon-ep\logy\db\201812081000.fbk""'
//'/C ""c:\Program Files\Firebird\Firebird_2_5\bin\gbak.exe" -backup -user SYSDBA -password masterkey -service service_mgr "C:\Users\kandrik\Documents\Embarcadero\Studio\Projects\starmon-ep\LOCALBASE-ZDA.GDB" "C:\Users\Kandrik\documents\EP\zalohy\priprava gvd\'#$D#$A'LOCALBASE-ZDA.GDB.fbk""'
//'/C ""c:\Program Files\Firebird\Firebird_2_5\bin\gbak.exe" -backup -user SYSDBA -password masterkey -service service_mgr "\Users\kandrik\Documents\Embarcadero\Studio\Projects\starmon-ep\LOCALBASE-TRBCH.GDB" "C:\Users\Kandrik\documents\EP\zalohy\priprava gvd\LOCALBASE-TRBCH.GDB.fbk""'


procedure TUpdateDlg.ZalohujDatabazu(p_databaza: TDBUdaje; p_cesta: string);
var
  cmdline: string;
  parametre: string;
  prikaz: string;
  v_vysledok: DWORD;
begin
  Memo1.Lines.Add('Zalohovani databáze');
  cmdline:='"'+ExecutorNastaveni.ZalohaCesta+'"';

  parametre:='-backup -user ';
  if p_databaza.Login<>'' then parametre:=parametre+p_databaza.Login
  else parametre:=parametre+ExecutorNastaveni.CentralLogin;

  parametre:=parametre+' -password ';
  if p_databaza.Heslo<>'' then parametre:=parametre+p_databaza.Heslo
  else parametre:=parametre+ExecutorNastaveni.CentralHeslo;

  parametre:=parametre+' -service service_mgr "'+Copy(p_databaza.Cesta,Pos(':',p_databaza.Cesta)+1,maxInt)+'" "'+Trim(p_cesta)+ExtractFileName(p_databaza.Cesta)+'.fbk"';

  prikaz:='/C "'+cmdline+' '+parametre+'"';

  Memo1.Lines.Add(prikaz);

  v_vysledok:=$FFFFFFFF;

  VykonajPrikaz(prikaz,Handle,v_vysledok);
  Memo1.Lines.Add('Vysledok: '+IntToStr(v_vysledok));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.InitTimerTimer(Sender: TObject);
var
  i: Integer;
begin
  InitTimer.Enabled:=False;

  for var v_dbguid in ExecutorNastaveni.DatabazePoradi do
  begin
    var v_db:=ExecutorNastaveni.Databaze[v_dbguid];
    if v_db.Oznacena then UpdatujDatabazu(v_db);
  end;

  Enabled:=True;
end;

end.
