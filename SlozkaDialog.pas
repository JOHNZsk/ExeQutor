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
  private
    { Private declarations }
    t_guid: string;

  public
    { Public declarations }
    property GUID: string read t_guid write t_guid;
    procedure Vycisti;
    procedure Napln(p_slozka: TSlozka);
  end;

var
  SlozkaDlg: TSlozkaDlg;

implementation

{$R *.dfm}

procedure TSlozkaDlg.Vycisti;
begin
  GUID:='';
  Nazev.Text:='';
end;

procedure TSlozkaDlg.Napln(p_slozka: TSlozka);
begin
  GUID:=p_slozka.GUID;
  Nazev.Text:=p_slozka.Nazev;
end;

end.
