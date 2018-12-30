unit NastaveniDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TNastaveniDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
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
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Label1: TLabel;
    CestaGBAK: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Priprav;
    procedure Vystup;
  end;

var
  NastaveniDlg: TNastaveniDlg;

implementation

{$R *.dfm}

uses Nastaveni;
////////////////////////////////////////////////////////////////////////////////

procedure TNastaveniDlg.Priprav;
begin
  Login.Text:=ExecutorNastaveni.CentralLogin;
  Heslo.Text:=ExecutorNastaveni.CentralHeslo;
  Role.Text:=ExecutorNastaveni.CentralRole;
  CestaGBAK.Text:=ExecutorNastaveni.ZalohaCesta;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TNastaveniDlg.Vystup;
begin
  ExecutorNastaveni.CentralLogin:=Login.Text;
  ExecutorNastaveni.CentralHeslo:=Heslo.Text;
  ExecutorNastaveni.CentralRole:=Role.Text;
  ExecutorNastaveni.ZalohaCesta:=CestaGBAK.Text;

  ExecutorNastaveni.UlozNastaveniXML;
end;
end.
