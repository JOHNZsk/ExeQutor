unit SkriptEditDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.CheckLst, Skript,
  Generics.Collections, DBUdaje;

type
  TSkriptEditDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Výjimky: TLabel;
    Nazev: TEdit;
    Vyjimky: TCheckListBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    t_guid: string;
    t_databaze: TList<string>;
  public
    { Public declarations }
    property GUID: string read t_guid write t_guid;
    procedure Vycisti;
    procedure Napln(p_skript: TSkript);
    procedure NastavDatabaze(p_databaze: TObjectDictionary<string,TDBUdaje>);
    procedure NaplnVyjimky(var p_cil: TList<string>);
  end;

var
  SkriptEditDlg: TSkriptEditDlg;

implementation

{$R *.dfm}

procedure TSkriptEditDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.Vycisti;
begin
  Nazev.Text:='';
  GUID:='';
  Memo1.Text:='';
  Vyjimky.Items.Text:='';
  t_databaze.Clear;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.FormCreate(Sender: TObject);
begin
  t_databaze:=TList<string>.Create;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.FormDestroy(Sender: TObject);
begin
  t_databaze.Free;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.Napln(p_skript: TSkript);
var
  i: Integer;
begin
  Nazev.Text:=p_skript.Nazev;
  GUID:=p_skript.GUID;
  Memo1.Text:=p_skript.Text;

  for i := 0 to t_databaze.Count-1 do
  begin
    if p_skript.Neprovadet.Contains(t_databaze[i]) then
    begin
      Vyjimky.Checked[i]:=True;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.NastavDatabaze(p_databaze: TObjectDictionary<string,TDBUdaje>);
var
  v_databaze: TDBUdaje;
begin
  for v_databaze in p_databaze.Values do
  begin
    Vyjimky.Items.Add(v_databaze.Nazev);
    t_databaze.Add(v_databaze.GUID);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.NaplnVyjimky(var p_cil: TList<string>);
var
  i: Integer;
begin
  for i := 0 to Vyjimky.Items.Count-1 do
  begin
    if Vyjimky.Checked[i] then
    begin
      p_cil.Add(t_databaze[i]);
    end;
  end;
end;

end.
