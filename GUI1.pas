unit GUI1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, DBUdaje,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  Vcl.StdCtrls, FireDAC.Comp.Script, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Generics.Collections, RzTreeVw;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DatabazuUpravit: TButton;
    GroupBox1: TGroupBox;
    MainMenu1: TMainMenu;
    Soubor1: TMenuItem;
    Nastnastaven1: TMenuItem;
    N1: TMenuItem;
    Konec1: TMenuItem;
    GroupBox2: TGroupBox;
    Skripty: TListView;
    Panel1: TPanel;
    SkriptPridat: TButton;
    Panel2: TPanel;
    Skripty1: TMenuItem;
    N2: TMenuItem;
    Pidatdatabzi1: TMenuItem;
    Button5: TButton;
    SkriptDolu: TButton;
    SkriptNahoru: TButton;
    SkriptSmazat: TButton;
    DatabazuPridat: TButton;
    OpenDialog1: TOpenDialog;
    SkriptUpravit: TButton;
    Splitter1: TSplitter;
    DatabazeNahoru: TButton;
    DattabazeDolu: TButton;
    Databaze: TRzCheckTree;
    Sprvasloek1: TMenuItem;
    DatabazeKopirovat: TButton;
    procedure Konec1Click(Sender: TObject);
    procedure SkriptPridatClick(Sender: TObject);
    procedure Nastnastaven1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Skripty1Click(Sender: TObject);
    procedure SkriptSmazatClick(Sender: TObject);
    procedure SkriptNahoruClick(Sender: TObject);
    procedure SkriptDoluClick(Sender: TObject);
    procedure SkriptUpravitClick(Sender: TObject);
    procedure SkriptyItemChecked(Sender: TObject; Item: TListItem);
    procedure FormShow(Sender: TObject);
    procedure DatabazuPridatClick(Sender: TObject);
    procedure DatabazuUpravitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SkriptyDblClick(Sender: TObject);
    procedure DatabazeDblClick(Sender: TObject);
    procedure Sprvasloek1Click(Sender: TObject);
    procedure DatabazeKopirovatClick(Sender: TObject);
    procedure DatabazeStateChange(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState);
  private
    { Private declarations }
    procedure NaplnDatabaze;
    procedure NaplnSkripty;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses SkriptEditDialog, Skript, Nastaveni, DBEditDialog, UpdateDialog,
  SlozkyDialog;

procedure TForm1.SkriptPridatClick(Sender: TObject);
begin
  SkriptEditDlg.Vycisti;
  SkriptEditDlg.NastavDatabaze(ExecutorNastaveni.Databaze);
  SkriptEditDlg.GUID:=ExecutorNastaveni.VytvorGUID;

  if SkriptEditDlg.ShowModal=mrOk then
  begin
    var v_skript:=TSkript.Create;
    v_skript.GUID:=SkriptEditDlg.GUID;
    v_skript.Poradi:=-1;
    v_skript.Nazev:=SkriptEditDlg.Nazev.Text;
    v_skript.Text:=SkriptEditDlg.Memo1.Text;

    SkriptEditDlg.NaplnVyjimky(v_skript.Neprovadet);

    ExecutorNastaveni.UlozSkript(v_skript);

    NaplnSkripty;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SkriptDoluClick(Sender: TObject);
var
  skriptguid: string;
  skript: TSkript;
begin
  if Skripty.ItemIndex>=0 then
  begin
    skriptguid:=ExecutorNastaveni.SkriptyPoradi[Skripty.ItemIndex];
    if ExecutorNastaveni.Skripty.TryGetValue(skriptguid,skript) then
    begin
      ExecutorNastaveni.PosunSkriptDolu(skript);
      NaplnSkripty;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SkriptNahoruClick(Sender: TObject);
var
  skriptguid: string;
  skript: TSkript;
begin
  if Skripty.ItemIndex>=0 then
  begin
    skriptguid:=ExecutorNastaveni.SkriptyPoradi[Skripty.ItemIndex];
    if ExecutorNastaveni.Skripty.TryGetValue(skriptguid,skript) then
    begin
      ExecutorNastaveni.PosunSkriptNahoru(skript);
      NaplnSkripty;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SkriptSmazatClick(Sender: TObject);
var
  skriptguid: string;
  skript: TSkript;
begin
  if Skripty.ItemIndex>=0 then
  begin
    skriptguid:=ExecutorNastaveni.SkriptyPoradi[Skripty.ItemIndex];
    if ExecutorNastaveni.Skripty.TryGetValue(skriptguid,skript) then
    begin
      ExecutorNastaveni.SmazSkript(skript);
      NaplnSkripty;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SkriptUpravitClick(Sender: TObject);
var
  skriptguid: string;
  v_skript: TSkript;
begin
  if Skripty.ItemIndex>=0 then
  begin
    skriptguid:=ExecutorNastaveni.SkriptyPoradi[Skripty.ItemIndex];
    if ExecutorNastaveni.Skripty.TryGetValue(skriptguid,v_skript) then
    begin
      SkriptEditDlg.Vycisti;
      SkriptEditDlg.NastavDatabaze(ExecutorNastaveni.Databaze);
      SkriptEditDlg.Napln(v_skript);

      if SkriptEditDlg.ShowModal=mrOk then
      begin
        v_skript.Nazev:=SkriptEditDlg.Nazev.Text;
        v_skript.Text:=SkriptEditDlg.Memo1.Text;
        v_skript.Neprovadet.Clear;

        SkriptEditDlg.NaplnVyjimky(v_skript.Neprovadet);

        ExecutorNastaveni.UlozSkript(v_skript);
        NaplnSkripty;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button1Click(Sender: TObject);
begin
  UpdateDlg.ShowModal;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DatabazuUpravitClick(Sender: TObject);
var
  dbguid: string;
  v_databaze: TDBUdaje;
begin
  if (Databaze.Selected.Index>=0) and (Databaze.Selected.Data<>nil) and (TObject(Databaze.Selected.Data) is TDBUdaje) then
  begin
    v_databaze:=TDBUdaje(Databaze.Selected.Data);
    DBEditDlg.Vycisti;
    DBEditDlg.NaplnSlozky;
    DBEditDlg.Napln(v_databaze);

    if DBEditDlg.ShowModal=mrOk then
    begin
      v_databaze.GUID:=DBEditDlg.GUID;
      v_databaze.Slozka:=DBEditDlg.VybranaSlozka;
      v_databaze.Nazev:=DBEditDlg.Nazev.Text;
      v_databaze.Cesta:=DBEditDlg.Cesta.Text;
      v_databaze.Server:=DBEditDlg.Server.Text;
      v_databaze.Login:=DBEditDlg.Login.Text;
      v_databaze.Heslo:=DBEditDlg.Heslo.Text;
      v_databaze.Rola:=DBEditDlg.Role.Text;

      ExecutorNastaveni.UlozDatabazi(v_databaze);

      NaplnDatabaze;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DatabazuPridatClick(Sender: TObject);
var
  v_databaze: TDBUdaje;
begin
  DBEditDlg.Vycisti;
  DBEditDlg.NaplnSlozky;
  DBEditDlg.GUID:=ExecutorNastaveni.VytvorGUID;
  DBEditDlg.HesloSkryt.Checked:=False;

  if DBEditDlg.ShowModal=mrOk then
  begin
    v_databaze:=TDBUdaje.Create;
    v_databaze.Slozka:=DBEditDlg.VybranaSlozka;
    v_databaze.GUID:=DBEditDlg.GUID;
    v_databaze.Nazev:=DBEditDlg.Nazev.Text;
    v_databaze.Cesta:=DBEditDlg.Cesta.Text;
    v_databaze.Server:=DBEditDlg.Server.Text;
    v_databaze.Login:=DBEditDlg.Login.Text;
    v_databaze.Heslo:=DBEditDlg.Heslo.Text;
    v_databaze.Rola:=DBEditDlg.Role.Text;

    ExecutorNastaveni.UlozDatabazi(v_databaze);

    NaplnDatabaze;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DatabazeDblClick(Sender: TObject);
begin
  DatabazuUpravitClick(DatabazuUpravit);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DatabazeKopirovatClick(Sender: TObject);
var
  dbguid: string;
  v_databaze: TDBUdaje;
begin
  if (Databaze.Selected.Index>=0) and (Databaze.Selected.Data<>nil) and (TObject(Databaze.Selected.Data) is TDBUdaje) then
  begin
    v_databaze:=TDBUdaje(Databaze.Selected.Data);

    DBEditDlg.Vycisti;
    DBEditDlg.Napln(v_databaze);
    DBEditDlg.GUID:=ExecutorNastaveni.VytvorGUID;

    if DBEditDlg.ShowModal=mrOk then
    begin
      v_databaze:=TDBUdaje.Create;
      v_databaze.GUID:=DBEditDlg.GUID;
      v_databaze.Nazev:=DBEditDlg.Nazev.Text;
      v_databaze.Cesta:=DBEditDlg.Cesta.Text;
      v_databaze.Server:=DBEditDlg.Server.Text;
      v_databaze.Login:=DBEditDlg.Login.Text;
      v_databaze.Heslo:=DBEditDlg.Heslo.Text;
      v_databaze.Rola:=DBEditDlg.Role.Text;

      ExecutorNastaveni.UlozDatabazi(v_databaze);

      NaplnDatabaze;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DatabazeStateChange(Sender: TObject; Node: TTreeNode; NewState: TRzCheckState);
begin
  if(Node.Data<>nil) and (TObject(Node.Data) is TDBUdaje) then
  begin
    var v_db: TDBUdaje:=TDBUdaje(Node.Data);

    if (NewState=csChecked) and (not v_db.Oznacena) then
    begin
      v_db.Oznacena:=True;
      ExecutorNastaveni.UlozDatabazi(v_db);
      NaplnDatabaze;
    end
    else if (NewState<>csChecked) and (v_db.Oznacena) then
    begin
      v_db.Oznacena:=False;
      ExecutorNastaveni.UlozDatabazi(v_db);
      NaplnDatabaze;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.FormDestroy(Sender: TObject);
begin

end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.FormShow(Sender: TObject);
begin
  Nastnastaven1Click(Nastnastaven1);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Konec1Click(Sender: TObject);
begin
  Close;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Nastnastaven1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then ExecutorNastaveni.NactiNastaveniXML(OpenDialog1.FileName);
  NaplnDatabaze;
  NaplnSkripty;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Skripty1Click(Sender: TObject);
begin
  SkriptPridatClick(SkriptPridat);
end;

procedure TForm1.SkriptyDblClick(Sender: TObject);
begin
  SkriptUpravitClick(SkriptUpravit);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.SkriptyItemChecked(Sender: TObject; Item: TListItem);
var
  v_skript: TSkript;
begin
  if Item.Caption<>'' then
  begin
    var skriptguid:=ExecutorNastaveni.SkriptyPoradi[Item.Index];
    if ExecutorNastaveni.Skripty.TryGetValue(skriptguid,v_skript) then
    begin
      if v_skript.Oznacen<>Item.Checked then
      begin
        v_skript.Oznacen:=Item.Checked;
        ExecutorNastaveni.UlozSkript(v_skript);
      end;
    end;
  end;
end;

procedure TForm1.Sprvasloek1Click(Sender: TObject);
begin
  if SlozkyDlg.ShowModal=mrOk then NaplnDatabaze;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.NaplnDatabaze;
var
  slozkaItem,databazeItem: TTreeNode;
begin
  Databaze.Items.Clear;
  slozkaItem:=nil;

  for var v_slozkaguid in ExecutorNastaveni.SlozkyPoradi do
  begin
    var v_slozka:=ExecutorNastaveni.Slozky[v_slozkaguid];
    slozkaItem:=Databaze.Items.Add(slozkaItem,v_slozka.Nazev);
    slozkaItem.Data:=v_slozka;

    for var v_databazeguid in ExecutorNastaveni.DatabazePoradi do
    begin
      var v_databaze:=ExecutorNastaveni.Databaze[v_databazeguid];
      if(v_databaze.Slozka=v_slozka.GUID) then
      begin
        databazeItem:=Databaze.Items.AddChild(slozkaItem,v_databaze.Nazev);
        databazeItem.Data:=v_databaze;

        if v_databaze.Oznacena then Databaze.ItemState[databazeItem.Index]:=csChecked
        else Databaze.ItemState[databazeItem.Index]:=csUnchecked;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.NaplnSkripty;
var
  v_skriptguid: string;
  v_skript: TSkript;
  i: Integer;
  item: TListItem;
  nezpracovavat,vyjimky: string;
  pom_db: TDBUdaje;
begin
  Skripty.Clear;

  i:=1;
  for v_skriptguid in ExecutorNastaveni.SkriptyPoradi do
  begin
    v_skript:=ExecutorNastaveni.Skripty[v_skriptguid];
    item:=Skripty.Items.Add;
    item.Caption:=IntToStr(i);
    item.Checked:=v_skript.Oznacen;
    item.SubItems.Add(v_skript.Nazev);

    vyjimky:='';

    for nezpracovavat in v_skript.Neprovadet do
    begin
      if ExecutorNastaveni.Databaze.TryGetValue(nezpracovavat,pom_db) then
      begin
        if vyjimky<>'' then vyjimky:=vyjimky+', ';
        vyjimky:=vyjimky+pom_db.Nazev;
      end;
    end;

    item.SubItems.Add(vyjimky);

    Inc(i);
  end;
end;
end.
