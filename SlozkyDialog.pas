unit SlozkyDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TSlozkyDlg = class(TForm)
    CancelBtn: TButton;
    Panel1: TPanel;
    ListView1: TListView;
    SlozkaPridat: TButton;
    SlozkaDolu: TButton;
    SlozkaUpravit: TButton;
    GroupBox1: TGroupBox;
    SlozkaNahoru: TButton;
    SlozkaSmazat: TButton;
    SlozkaZkopirovat: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure SlozkaPridatClick(Sender: TObject);
    procedure SlozkaUpravitClick(Sender: TObject);
    procedure SlozkaZkopirovatClick(Sender: TObject);
    procedure SlozkaSmazatClick(Sender: TObject);
    procedure SlozkaNahoruClick(Sender: TObject);
    procedure SlozkaDoluClick(Sender: TObject);
  private
    { Private declarations }
    t_zmena: Boolean;

    procedure NaplnSlozky;
  public
    { Public declarations }
  end;

var
  SlozkyDlg: TSlozkyDlg;

implementation
  uses Nastaveni, Slozka, SlozkaDialog, Vcl.Dialogs, System.UITypes;

{$R *.dfm}

procedure TSlozkyDlg.NaplnSlozky;
begin
  ListView1.Items.Clear;

  for var v_slozkaguid in ExecutorNastaveni.SlozkyPoradi do
  begin
    var v_slozka: TSlozka;
    if ExecutorNastaveni.Slozky.TryGetValue(v_slozkaguid,v_slozka) then
    begin
      var item:=ListView1.Items.Add;
      item.Caption:=v_slozka.Nazev;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaDoluClick(Sender: TObject);
var
  v_slozka: TSlozka;
begin
  if ListView1.ItemIndex>=0 then
  begin
    var v_slozkaguid:=ExecutorNastaveni.SlozkyPoradi[ListView1.ItemIndex];
    if ExecutorNastaveni.Slozky.TryGetValue(v_slozkaguid,v_slozka) then
    begin
      ExecutorNastaveni.PosunSlozkuDolu(v_slozka);

      t_zmena:=True;

      NaplnSlozky;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaNahoruClick(Sender: TObject);
var
  v_slozka: TSlozka;
begin
  if ListView1.ItemIndex>=0 then
  begin
    var v_slozkaguid:=ExecutorNastaveni.SlozkyPoradi[ListView1.ItemIndex];
    if ExecutorNastaveni.Slozky.TryGetValue(v_slozkaguid,v_slozka) then
    begin
      ExecutorNastaveni.PosunSlozkuNahoru(v_slozka);

      t_zmena:=True;

      NaplnSlozky;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaPridatClick(Sender: TObject);
begin
  SlozkaDlg.Priprav;
  SlozkaDlg.GUID:=ExecutorNastaveni.VytvorGUID;

  if SlozkaDlg.ShowModal=mrOk then
  begin
    var v_slozka:=TSlozka.Create;
    v_slozka.Poradi:=-1;
    SlozkaDlg.Vystup(v_slozka);
    NaplnSlozky;

    t_zmena:=True;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaSmazatClick(Sender: TObject);
var
  v_slozka: TSlozka;
begin
  if ListView1.ItemIndex>=0 then
  begin
    var v_slozkaguid:=ExecutorNastaveni.SlozkyPoradi[ListView1.ItemIndex];
    if ExecutorNastaveni.Slozky.TryGetValue(v_slozkaguid,v_slozka) then
    begin
      if MessageDlg('Opravdu smazat složku '+v_slozka.Nazev+'? Smaže sa vèetnì databází v ní uložených',mtConfirmation,mbYesNo,0)=mrYes then
      begin
        ExecutorNastaveni.SmazSlozku(v_slozka);

        t_zmena:=True;

        NaplnSlozky;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaUpravitClick(Sender: TObject);
var
  v_slozka: TSlozka;
begin
  if ListView1.ItemIndex>=0 then
  begin
    var slozkaguid:=ExecutorNastaveni.SlozkyPoradi[ListView1.ItemIndex];
    if ExecutorNastaveni.Slozky.TryGetValue(slozkaguid,v_slozka) then
    begin
      SlozkaDlg.Priprav;
      SlozkaDlg.Vstup(v_slozka);

      if SlozkaDlg.ShowModal=mrOk then
      begin
        SlozkaDlg.Vystup(v_slozka);
        NaplnSlozky;

        t_zmena:=True;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.SlozkaZkopirovatClick(Sender: TObject);
var
  v_slozka: TSlozka;
begin
  if ListView1.ItemIndex>=0 then
  begin
    var slozkaguid:=ExecutorNastaveni.SlozkyPoradi[ListView1.ItemIndex];
    if ExecutorNastaveni.Slozky.TryGetValue(slozkaguid,v_slozka) then
    begin
      SlozkaDlg.Priprav;
      SlozkaDlg.Vstup(v_slozka);
      SlozkaDlg.GUID:=ExecutorNastaveni.VytvorGUID;

      if SlozkaDlg.ShowModal=mrOk then
      begin
        v_slozka:=TSlozka.Create;
        SlozkaDlg.Vystup(v_slozka);
        NaplnSlozky;

        t_zmena:=True;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.CancelBtnClick(Sender: TObject);
begin
  if t_zmena then ModalResult:=mrOk
  else ModalResult:=mrCancel;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.FormCreate(Sender: TObject);
begin
  t_zmena:=False;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TSlozkyDlg.FormShow(Sender: TObject);
begin
  t_zmena:=False;
  NaplnSlozky;
end;

end.
