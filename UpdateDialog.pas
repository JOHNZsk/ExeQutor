unit UpdateDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, DBUdaje,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, Data.DB, Skript, Vcl.ComCtrls;

type
  TUpdateDlg = class(TForm)
    Button1: TButton;
    DB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDTransaction1: TFDTransaction;
    Script: TFDScript;
    InitTimer: TTimer;
    Memo1: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure InitTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScriptConsolePut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure ScriptError(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure FormCreate(Sender: TObject);
    procedure ScriptProgress(Sender: TObject);
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

procedure TUpdateDlg.FormCreate(Sender: TObject);
begin
  Memo1.Font.Name:='Consolas';
end;

procedure TUpdateDlg.FormShow(Sender: TObject);
begin
  Caption:='Probíhá update databáze';
  InitTimer.Enabled:=True;
  Button1.Enabled:=False;
  Enabled:=False;
  Memo1.Clear;
end;

////////////////////////////////////////////////////////////////////////////////

function TUpdateDlg.PripojDatabazu(p_databaza: TDBUdaje): Boolean;
begin
  if(DB.Connected) then OdpojDatabazu(p_databaza);
  begin
    try
      Memo1.SelAttributes.Color := clSilver;
      Memo1.Lines.Add('Pøipojování k databázi');

      var v_slozka:=ExecutorNastaveni.Slozky[p_databaza.Slozka];

      DB.Params.Clear;

      DB.Params.Add('Database='+p_databaza.Cesta);
      DB.Params.Add('Server='+p_databaza.Server);
      DB.Params.Add('DriverID=FB');
      DB.Params.Add('PageSize=16384');

      if p_databaza.Login<>'' then DB.Params.Add('Password='+p_databaza.Heslo)
      else if v_slozka.Login<>'' then  DB.Params.Add('Password='+v_slozka.Heslo)
      else DB.Params.Add('Password='+ExecutorNastaveni.CentralHeslo);

      if p_databaza.Login<>'' then DB.Params.Add('User_Name='+p_databaza.Login)
      else if v_slozka.Login<>'' then  DB.Params.Add('User_Name='+v_slozka.Login)
      else DB.Params.Add('User_Name='+ExecutorNastaveni.CentralLogin);

      DB.Params.Add('Protocol=TCPIP');
      DB.Params.Add('DropDatabase=No');

      if p_databaza.Login<>'' then DB.Params.Append('RoleName='+p_databaza.Rola)
      else if v_slozka.Login<>'' then DB.Params.Append('RoleName='+v_slozka.Role)
      else if ExecutorNastaveni.CentralRole<>'' then DB.Params.Append('RoleName='+ExecutorNastaveni.CentralRole);

      DB.Open;
    except
      on e: EFDException do
      begin
        Memo1.SelAttributes.Color := clRed;
        Memo1.Lines.Add('Výjimka: '+e.Message);
      end;
    end;
  end;

  Result:=DB.Connected;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.ScriptConsolePut(AEngine: TFDScript; const AMessage: string; AKind: TFDScriptOutputKind);
var
  v_text: string;
begin
  case AKind of
    soSeparator:
    begin
      Memo1.SelAttributes.Color := clSilver;
      v_text:='SEP';
    end;
    soEcho:
    begin
      Memo1.SelAttributes.Color := clBlack;
      v_text:='EHO';
    end;
    soScript:
    begin
      Memo1.SelAttributes.Color := clGreen;
      v_text:='SCR';
    end;
    soInfo:
    begin
      Memo1.SelAttributes.Color := clBlue;
      v_text:='INF';
    end;
    soError:
    begin
      Memo1.SelAttributes.Color := clRed;
      v_text:='ERR';
    end;
    soConnect:
    begin
      Memo1.SelAttributes.Color := clGreen;
      v_text:='CON';
    end;
    soServerOutput:
    begin
      Memo1.SelAttributes.Color := clBlue;
      v_text:='SOP';
    end;
    soUserOutput:
    begin
      Memo1.SelAttributes.Color := clBlue;
      v_text:='UOP';
    end;
    soCommand:
    begin
      Memo1.SelAttributes.Color := clBlue;
      v_text:='CMD';
    end;
    soMacro:
    begin
      Memo1.SelAttributes.Color := clGreen;
      v_text:='MCR';
    end;
    soData:
    begin
      Memo1.SelAttributes.Color := clBlue;
      v_text:='DTA';
    end;
    soParam:
    begin
      Memo1.SelAttributes.Color := clGreen;
      v_text:='PRM';
    end;
  end;

  Memo1.Lines.Add(v_text+' '+AMessage);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.ScriptError(ASender, AInitiator: TObject; var AException: Exception);
begin
  Memo1.SelAttributes.Color := clRed;
  Memo1.Lines.Add('Výjimka: '+AException.Message);
end;

procedure TUpdateDlg.ScriptProgress(Sender: TObject);
begin
  Memo1.Repaint;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.OdpojDatabazu(p_databaza: TDBUdaje);
begin
  DB.Connected:=False;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.UpdatujDatabazu(p_databaze: TDBUdaje);
var
  v_script: TFDSQLScript;
  v_skriptguid,v_cesta: string;
  v_skript: TSkript;
  v_zalohovat,v_spustit_skript: Boolean;
begin
  Memo1.SelAttributes.Color := clSilver;
  Memo1.Lines.Add('Update databáze '+p_databaze.Nazev);

  if PripojDatabazu(p_databaze) then
  begin
    Memo1.SelAttributes.Color := clGreen;
    Memo1.Lines.Add('Pøipojení úspìšné');

    v_zalohovat:=False;
    v_spustit_skript:=False;
    v_script:=nil;
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
            if v_script=nil then
            begin
              v_script:=Script.SQLScripts.Add;
              v_script.SQL.Text:=v_skript.Text;
              v_spustit_skript:=True;
            end
            else v_script.SQL.Add(v_skript.Text);
          end;
        end;
      end;
    end;

    if v_spustit_skript then
    begin
      try
        if not Script.ValidateAll then
        begin
          Memo1.SelAttributes.Color := clSilver;
          Memo1.Lines.Add('Validace skriptu s chybama');
        end;
        if not Script.ExecuteAll then
        begin
          Memo1.SelAttributes.Color := clSilver;
          Memo1.Lines.Add('Provedeni skriptu s chybama');
        end;
      except
        Memo1.SelAttributes.Color := clSilver;
        Memo1.Lines.Add('Skript se nepovedlo dokoncit');
      end;
    end;

    OdpojDatabazu(p_databaze);

    if v_zalohovat then ZalohujDatabazu(p_databaze,v_cesta);
  end;

  Memo1.SelAttributes.Color := clSilver;
  Memo1.Lines.Add('Dokonèen update databáze '+p_databaze.Nazev);
  Memo1.Lines.Add('');
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

procedure TUpdateDlg.ZalohujDatabazu(p_databaza: TDBUdaje; p_cesta: string);
var
  cmdline: string;
  parametre: string;
  v_vysledok: DWORD;
begin
  Memo1.Lines.Add('Zalohovani databáze');
  cmdline:='"'+ExecutorNastaveni.ZalohaCesta+'"';

  var v_slozka:=ExecutorNastaveni.Slozky(p_databaza.Slozka);

  parametre:='-backup -user ';
  if p_databaza.Login<>'' then parametre:=parametre+p_databaza.Login
  else if v_slozka.Login<>'' then parametre:=parametre+v_slozka.Login
  else parametre:=parametre+ExecutorNastaveni.CentralLogin;

  parametre:=parametre+' -password ';
  if p_databaza.Login<>'' then parametre:=parametre+p_databaza.Heslo
  else if v_slozka.Login<>'' then parametre:=parametre+v_slozka.Heslo
  else parametre:=parametre+ExecutorNastaveni.CentralHeslo;

  parametre:=parametre+' -service service_mgr "'+Copy(p_databaza.Cesta,Pos(':',p_databaza.Cesta)+1,maxInt)+'" "'+Trim(p_cesta)+ExtractFileName(p_databaza.Cesta)+'.fbk"';

  var prikaz:='/C "'+cmdline+' '+parametre+'"';

  Memo1.Lines.Add(prikaz);

  v_vysledok:=$FFFFFFFF;

  VykonajPrikaz(prikaz,Handle,v_vysledok);
  Memo1.Lines.Add('Vysledek: '+IntToStr(v_vysledok));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUpdateDlg.InitTimerTimer(Sender: TObject);
begin
  InitTimer.Enabled:=False;

  for var v_dbguid in ExecutorNastaveni.DatabazePoradi do
  begin
    var v_db:=ExecutorNastaveni.Databaze[v_dbguid];
    if v_db.Oznacena then UpdatujDatabazu(v_db);
  end;

  Caption:='Update databází proveden';
  Button1.Enabled:=True;
  Enabled:=True;
end;

end.
