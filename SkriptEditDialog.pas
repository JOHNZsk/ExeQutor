unit SkriptEditDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.CheckLst, Skript,
  Generics.Collections, DBUdaje, SynEditHighlighter, SynHighlighterSQL, SynEdit,
  SynMemo;

type
  TSkriptEditDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Výjimky: TLabel;
    Nazev: TEdit;
    Vyjimky: TCheckListBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    Label2: TLabel;
    AutocommitAno: TRadioButton;
    AutocommitNe: TRadioButton;
    Memo1: TSynMemo;
    SynSQLSyn1: TSynSQLSyn;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    t_guid: string;
    t_databaze: TList<string>;

    procedure NaplnVyjimky(var p_cil: TList<string>);
  public
    { Public declarations }
    property GUID: string read t_guid write t_guid;

    procedure Vycisti;
    procedure Vstup(p_skript: TSkript);
    procedure Vystup(p_skript: TSkript);

    procedure NastavDatabaze(p_databaze: TObjectDictionary<string,TDBUdaje>);
  end;

var
  SkriptEditDlg: TSkriptEditDlg;

implementation

{$R *.dfm}

uses Nastaveni, Slozka;

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

procedure TSkriptEditDlg.Vstup(p_skript: TSkript);
var
  i: Integer;
begin
  GUID:=p_skript.GUID;
  Nazev.Text:=p_skript.Nazev;
  Memo1.Text:=p_skript.Text;

  if p_skript.Autocommit then AutocommitAno.Checked:=True
  else AutocommitNe.Checked:=True;

  for i := 0 to t_databaze.Count-1 do
  begin
    if p_skript.Neprovadet.Contains(t_databaze[i]) then
    begin
      Vyjimky.Checked[i]:=True;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.Vystup(p_skript: TSkript);
begin
  p_skript.GUID:=GUID;
  p_skript.Nazev:=Nazev.Text;
  p_skript.Text:=Memo1.Text;
  p_skript.Autocommit:=AutocommitAno.Checked;

  p_skript.Neprovadet.Clear;
  NaplnVyjimky(p_skript.Neprovadet);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSkriptEditDlg.NastavDatabaze(p_databaze: TObjectDictionary<string,TDBUdaje>);
begin
  for var v_slozkaguid in ExecutorNastaveni.SlozkyPoradi do
  begin
    var v_slozka:=ExecutorNastaveni.Slozky[v_slozkaguid];

    for var v_dbguid in ExecutorNastaveni.DatabazePoradi do
    begin
      var v_databaze:=ExecutorNastaveni.Databaze[v_dbguid];

      if v_databaze.Slozka=v_slozka.GUID then
      begin
        Vyjimky.Items.Add(v_slozka.Nazev+'/'+v_databaze.Nazev);
        t_databaze.Add(v_databaze.GUID);
      end;
    end;
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
