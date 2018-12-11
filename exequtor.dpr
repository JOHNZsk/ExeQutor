program exequtor;

uses
  Vcl.Forms,
  GUI1 in 'GUI1.pas' {Form1},
  DBUdaje in 'DBUdaje.pas',
  Nastaveni in 'Nastaveni.pas' {ExecutorNastaveni: TDataModule},
  SkriptEditDialog in 'SkriptEditDialog.pas' {SkriptEditDlg},
  Skript in 'Skript.pas',
  DBEditDialog in 'DBEditDialog.pas' {DBEditDlg},
  UpdateDialog in 'UpdateDialog.pas' {UpdateDlg},
  Slozka in 'Slozka.pas',
  GUIDObjekt in 'GUIDObjekt.pas',
  SlozkyDialog in 'SlozkyDialog.pas' {SlozkyDlg},
  SlozkaDialog in 'SlozkaDialog.pas' {SlozkaDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TExecutorNastaveni, ExecutorNastaveni);
  Application.CreateForm(TSkriptEditDlg, SkriptEditDlg);
  Application.CreateForm(TDBEditDlg, DBEditDlg);
  Application.CreateForm(TUpdateDlg, UpdateDlg);
  Application.CreateForm(TSlozkyDlg, SlozkyDlg);
  Application.CreateForm(TSlozkaDlg, SlozkaDlg);
  Application.Run;
end.
