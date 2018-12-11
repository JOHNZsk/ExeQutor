unit DBEditDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, DBUdaje,
  Generics.Collections;

type
  TDBEditDlg = class(TForm)
    Panel1: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    Nazev: TEdit;
    Panel5: TPanel;
    Label3: TLabel;
    Cesta: TEdit;
    Panel6: TPanel;
    Label4: TLabel;
    Server: TEdit;
    Panel4: TPanel;
    Label2: TLabel;
    Heslo: TEdit;
    Panel7: TPanel;
    Label5: TLabel;
    Role: TEdit;
    Panel8: TPanel;
    Label6: TLabel;
    Login: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel9: TPanel;
    Label7: TLabel;
    LoginCentral: TRadioButton;
    LoginLocal: TRadioButton;
    Panel2: TPanel;
    Label8: TLabel;
    Slozka: TComboBox;
    SlozkyUprav: TButton;
    HesloSkryt: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure LoginCentralClick(Sender: TObject);
    procedure HesloSkrytClick(Sender: TObject);
    procedure SlozkyUpravClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SlozkaChange(Sender: TObject);
  private
    { Private declarations }
    t_guid: string;
    t_vybrana_slozka: string;
  public
    { Public declarations }
    property GUID: string read t_guid write t_guid;
    property VybranaSlozka: string read t_vybrana_slozka write t_vybrana_slozka;

    procedure Vycisti;
    procedure NaplnSlozky;
    procedure Napln(p_databaze: TDBUdaje);
  end;

var
  DBEditDlg: TDBEditDlg;

implementation
  uses Vcl.Dialogs, Nastaveni, System.UITypes, SlozkyDialog, Slozka, GUIDObjekt;

{$R *.dfm}

procedure TDBEditDlg.OKBtnClick(Sender: TObject);
var
  ok: Boolean;
  chyby: string;
begin
  ok:=True;
  chyby:='';

  if VybranaSlozka='' then
  begin
    if Slozka.ItemIndex>=0 then VybranaSlozka:=(Slozka.Items.Objects[Slozka.ItemIndex] as TSlozka).GUID;
    if VybranaSlozka='' then
    begin
      if chyby<>'' then chyby:=chyby+#13+#10;
      chyby:=chyby+'Chybí složka';
      ok:=False;
    end;
  end;

  if GUID='' then
  begin
    GUID:=ExecutorNastaveni.VytvorGUID;
    if GUID='' then
    begin
      if chyby<>'' then chyby:=chyby+#13+#10;
      chyby:=chyby+'Chyba pøi vytváøení: Nevytvoøil se GUID';
      ok:=False;
    end
    else MessageDlg('GUID byl doplnìn dodateènì. Záznam se uloží, nicménì zkontrolujte, zda ho nemáte uložen dvakrát.',mtWarning,[mbOk],0);
  end;

  if Nazev.Text='' then
  begin
    if chyby<>'' then chyby:=chyby+#13+#10;
    chyby:=chyby+'Chybí název';
    ok:=False;
  end;

  if Server.Text='' then
  begin
    if chyby<>'' then chyby:=chyby+#13+#10;
    chyby:=chyby+'Chybí adresa servru, pro lokální DB uveïte 127.0.0.1';
    ok:=False;
  end;

  if Cesta.Text='' then
  begin
    if chyby<>'' then chyby:=chyby+#13+#10;
    chyby:=chyby+'Chybí cesta k DB';
    ok:=False;
  end;

  if LoginLocal.Checked then
  begin
    if Login.Text='' then
    begin
      if chyby<>'' then chyby:=chyby+#13+#10;
      chyby:=chyby+'Chybí uživatelské jméno';
      ok:=False;
    end;

    if Heslo.Text='' then
    begin
      if chyby<>'' then chyby:=chyby+#13+#10;
      chyby:=chyby+'Chybí heslo';
      ok:=False;
    end;
  end;

  if not ok then
  begin
    ModalResult:=mrNone;
    MessageDlg(chyby,mtError,[mbOk],0);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.SlozkaChange(Sender: TObject);
begin
  if Slozka.ItemIndex>=0 then VybranaSlozka:=(Slozka.Items.Objects[Slozka.ItemIndex] as TSlozka).GUID
  else VybranaSlozka:='';
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.SlozkyUpravClick(Sender: TObject);
begin
  if SlozkyDlg.ShowModal=mrOk then NaplnSlozky;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.NaplnSlozky;
var
  v_slozka: TSlozka;
  v_selected: TGUIDstring;
begin
  Slozka.Items.BeginUpdate;

  try
    for var v_slozkaguid in ExecutorNastaveni.SlozkyPoradi do
    begin
      if ExecutorNastaveni.Slozky.TryGetValue(v_slozkaguid,v_slozka) then Slozka.AddItem(v_slozka.Nazev,v_slozka);
    end;

    if VybranaSlozka<>'' then
    begin
      for var i := 0 to Slozka.Items.Count-1 do
      begin
        if(Slozka.Items.Objects[i] as TSlozka).GUID=VybranaSlozka then
        begin
          Slozka.ItemIndex:=i;
          break;
        end;
      end;
    end;
  finally
    Slozka.Items.EndUpdate;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.Vycisti;
begin
  GUID:='';
  VybranaSlozka:='';
  Slozka.ItemIndex:=-1;

  Nazev.Text:='';
  Server.Text:='';
  Cesta.Text:='';

  LoginCentral.Checked:=True;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.FormCreate(Sender: TObject);
begin
  t_vybrana_slozka:='';
  t_guid:='';
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.HesloSkrytClick(Sender: TObject);
begin
  if HesloSkryt.Checked then Heslo.PasswordChar:='*'
  else Heslo.PasswordChar:=#0;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.LoginCentralClick(Sender: TObject);
begin
  if LoginLocal.Checked then
  begin
    Login.Enabled:=True;
    Heslo.Enabled:=True;
    Role.Enabled:=True;
  end
  else
  begin
    Login.Enabled:=False;
    Heslo.Enabled:=False;
    Role.Enabled:=False;

    Login.Text:='';
    Heslo.Text:='';
    Role.Text:='';
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TDBEditDlg.Napln(p_databaze: TDBUdaje);
begin
  GUID:=p_databaze.GUID;

  Nazev.Text:=p_databaze.Nazev;
  Server.Text:=p_databaze.Server;
  Cesta.Text:=p_databaze.Cesta;
  VybranaSlozka:=p_databaze.Slozka;
  var v_vybslozka:=ExecutorNastaveni.Slozky[VybranaSlozka];
  Slozka.ItemIndex:=Slozka.Items.IndexOfObject(v_vybslozka);

  HesloSkryt.Checked:=True;

  if p_databaze.Login='' then LoginCentral.Checked:=True
  else
  begin
    LoginLocal.Checked:=True;
    Login.Text:=p_databaze.Login;
    Heslo.Text:=p_databaze.Heslo;
    Role.Text:=p_databaze.Rola;
  end;
end;

end.
