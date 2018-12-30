unit SlozkaDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Slozka;

type
  TSlozkaDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Nazev: TEdit;
    GroupBox2: TGroupBox;
    Panel4: TPanel;
    Label2: TLabel;
    Heslo: TEdit;
    Panel7: TPanel;
    Label5: TLabel;
    Role: TEdit;
    Panel8: TPanel;
    Label6: TLabel;
    Login: TEdit;
    Panel9: TPanel;
    Label7: TLabel;
    LoginCentral: TRadioButton;
    LoginLocal: TRadioButton;
    HesloSkryt: TCheckBox;
    procedure HesloSkrytClick(Sender: TObject);
    procedure LoginCentralClick(Sender: TObject);
  private
    { Private declarations }
    t_guid: string;

  public
    { Public declarations }
    property GUID: string read t_guid write t_guid;
    procedure Priprav;
    procedure Vstup(p_slozka: TSlozka);
    procedure Vystup(p_slozka: TSlozka);
  end;

var
  SlozkaDlg: TSlozkaDlg;

implementation

{$R *.dfm}

uses Nastaveni;

procedure TSlozkaDlg.HesloSkrytClick(Sender: TObject);
begin
  if HesloSkryt.Checked then Heslo.PasswordChar:='*'
  else Heslo.PasswordChar:=#0;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkaDlg.LoginCentralClick(Sender: TObject);
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

procedure TSlozkaDlg.Priprav;
begin
  GUID:='';
  Nazev.Text:='';
  LoginCentral.Checked:=True;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkaDlg.Vstup(p_slozka: TSlozka);
begin
  GUID:=p_slozka.GUID;
  Nazev.Text:=p_slozka.Nazev;
  Login.Text:=p_slozka.Login;
  Heslo.Text:=p_slozka.Heslo;
  Role.Text:=p_slozka.Role;

  HesloSkryt.Checked:=True;

  if p_slozka.Login='' then LoginCentral.Checked:=True
  else
  begin
    LoginLocal.Checked:=True;
    Login.Text:=p_slozka.Login;
    Heslo.Text:=p_slozka.Heslo;
    Role.Text:=p_slozka.Role;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkaDlg.Vystup(p_slozka: TSlozka);
begin
  p_slozka.GUID:=GUID;
  p_slozka.Nazev:=Nazev.Text;
  p_slozka.Login:=Login.Text;
  p_slozka.Heslo:=Heslo.Text;
  p_slozka.Role:=Role.Text;

  ExecutorNastaveni.UlozSlozku(p_slozka);
end;


end.
