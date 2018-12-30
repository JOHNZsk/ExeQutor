unit Nastaveni;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles, DBUdaje, Generics.Collections,
  Skript, GUIDObjekt, ipwxmlw, ipwcore, ipwxmlp, Slozka, Vcl.Dialogs;

type
  TExecutorNastaveni = class(TDataModule)
    xmlparse: TipwXMLp;
    xmlread: TipwXMLw;
    FileSaveDialog1: TFileSaveDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    t_soubor_nazev: string;
    t_neukladat: Boolean;
    t_chyba_config: Boolean;

    t_central_login: string;
    t_central_heslo: string;
    t_central_role: string;

    t_zaloha_cesta: string;

    t_slozky: TObjectDictionary<TGUIDstring,TSlozka>;
    t_slozky_poradi: TList<TGUIDstring>;

    t_databaze: TObjectDictionary<TGUIDstring,TDBUdaje>;
    t_databaze_poradi: TList<TGUIDstring>;

    t_skripty: TObjectDictionary<TGUIDstring,TSkript>;
    t_skripty_poradi: TList<TGUIDstring>;

    procedure NactiDatabazeSlozkyXML;
    procedure NactiSkriptyXML;

    procedure UlozDatabazeSlozkyXML;
    procedure UlozSkriptyXML;

  public
    { Public declarations }
    property CentralLogin: string read t_central_login write t_central_login;
    property CentralHeslo: string read t_central_heslo write t_central_heslo;
    property CentralRole: string read t_central_role write t_central_role;

    property ZalohaCesta: string read t_zaloha_cesta write t_zaloha_cesta;

    property Slozky: TObjectDictionary<string,TSlozka> read t_slozky;
    property SlozkyPoradi: TList<string> read t_slozky_poradi;
    property Databaze: TObjectDictionary<string,TDBUdaje> read t_databaze;
    property DatabazePoradi: TList<string> read t_databaze_poradi;
    property Skripty: TObjectDictionary<string,TSkript> read t_skripty;
    property SkriptyPoradi: TList<string> read t_skripty_poradi;

    procedure NactiNastaveniXML(p_nazev: string);
    procedure UlozNastaveniXML;

    procedure UlozSkript(p_skript: TSkript);
    procedure SmazSkript(p_skript: TSkript);
    procedure PosunSkriptNahoru(p_skript: TSkript);
    procedure PosunSkriptDolu(p_skript: TSkript);

    procedure UlozDatabazi(p_databaze: TDBUdaje);
    procedure SmazDatabazi(p_databaze: TDBUdaje);
    procedure PosunDatabaziNahoru(p_databaze: TDBUdaje);
    procedure PosunDatabaziDolu(p_databaze: TDBUdaje);

    procedure UlozSlozku(p_slozka: TSlozka);
    procedure SmazSlozku(p_slozka: TSlozka);
    procedure PosunSlozkuNahoru(p_slozka: TSlozka);
    procedure PosunSlozkuDolu(p_slozka: TSlozka);

    function VytvorGUID: string;
  end;

var
  ExecutorNastaveni: TExecutorNastaveni;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TExecutorNastaveni.DataModuleCreate(Sender: TObject);
begin
  t_soubor_nazev:='';
  t_neukladat:=False;
  t_chyba_config:=True;

  t_central_login:='';
  t_central_heslo:='';
  t_central_role:='';

  t_zaloha_cesta:='';

  t_databaze:=TObjectDictionary<string,TDBUdaje>.Create([doOwnsValues]);
  t_skripty:=TObjectDictionary<string,TSkript>.Create([doOwnsValues]);
  t_slozky:=TObjectDictionary<string,TSlozka>.Create([doOwnsValues]);

  t_databaze_poradi:=TList<string>.Create;
  t_skripty_poradi:=TList<string>.Create;
  t_slozky_poradi:=TList<string>.Create;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.DataModuleDestroy(Sender: TObject);
begin
  t_databaze.Free;
  t_databaze_poradi.Free;
  t_skripty.Free;
  t_skripty_poradi.Free;
  t_slozky.Free;
  t_slozky_poradi.Free;
end;

////////////////////////////////////////////////////////////////////////////////
// Naètení dat z XML
////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.NactiDatabazeSlozkyXML;
var
  i: Integer;
  slozka: TSlozka;
  v_pocet_slozek: Integer;
  slozkai: Integer;
  databaze: TDBUdaje;
begin
  xmlparse.XPath:='/Executor/SlozkyDatabaze';

  t_skripty.Clear;

  v_pocet_slozek:=xmlparse.XChildrenCount;
  slozkai:=1;

  for i := 0 to v_pocet_slozek-1 do
  begin
    if(xmlparse.XChildName[i]='Slozka') then
    begin
      slozka:=TSlozka.Create;
      slozka.NactiXML(xmlparse,slozkai,t_databaze);
      t_slozky.Add(slozka.GUID,slozka);

      Inc(slozkai);
      xmlparse.XPath:='/Executor/SlozkyDatabaze';
    end;
  end;

  t_slozky_poradi.Count:=t_slozky.Count;
  for slozka in t_slozky.Values do t_slozky_poradi[slozka.Poradi]:=slozka.GUID;

  t_databaze_poradi.Count:=t_databaze.Count;
  for databaze in t_databaze.Values do t_databaze_poradi[databaze.Poradi]:=databaze.GUID;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.NactiSkriptyXML;
var
  i: Integer;
  skript: TSkript;
  v_pocet_skriptu: Integer;
  skripti: Integer;
begin
  xmlparse.XPath:='/Executor/Skripty';

  t_skripty.Clear;

  v_pocet_skriptu:=xmlparse.XChildrenCount;
  skripti:=1;

  for i := 0 to v_pocet_skriptu-1 do
  begin
    if(xmlparse.XChildName[i]='Skript') then
    begin
      skript:=TSkript.Create;
      skript.NactiXML(xmlparse,skripti);
      t_skripty.Add(skript.GUID,skript);

      Inc(skripti);
      xmlparse.XPath:='/Executor/Skripty';
    end;
  end;

  t_skripty_poradi.Count:=t_skripty.Count;
  for skript in t_skripty.Values do t_skripty_poradi[skript.Poradi]:=skript.GUID;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.NactiNastaveniXML(p_nazev: string);
begin
  t_chyba_config:=False;

  t_neukladat:=True;
  try
    t_soubor_nazev:=p_nazev;

    xmlparse.Reset;
    xmlparse.BuildDOM:=True;
    xmlparse.ParseFile(p_nazev);
    xmlparse.Flush;

    if xmlparse.HasXPath('/Executor') then
    begin
      if xmlparse.HasXPath('/Executor/Nastaveni') then
      begin
        xmlparse.XPath:='/Executor/Nastaveni';

        if xmlparse.HasXPath('/Executor/Nastaveni/Databaze') then
        begin
          xmlparse.XPath:='/Executor/Nastaveni/Databaze';

          t_central_login:=xmlparse.Attr('login');
          t_central_heslo:=xmlparse.Attr('heslo');
          t_central_role:=xmlparse.Attr('role');
        end
        else
        begin
          t_central_login:='';
          t_central_heslo:='';
          t_central_role:='';
        end;

        if xmlparse.HasXPath('/Executor/Nastaveni/Zaloha') then
        begin
          xmlparse.XPath:='/Executor/Nastaveni/Zaloha';
          t_zaloha_cesta:=xmlparse.Attr('cestaGBAK');
        end
        else t_zaloha_cesta:='';
      end;

      if xmlparse.HasXPath('/Executor/SlozkyDatabaze') then NactiDatabazeSlozkyXML;
      if xmlparse.HasXPath('/Executor/Skripty') then NactiSkriptyXML;
    end
    else t_chyba_config:=True;
  finally
    t_neukladat:=False;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Ukládání dat
////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.UlozDatabazeSlozkyXML;
var
  slozka: TSlozka;
begin
  xmlread.StartElement('SlozkyDatabaze','' );

  for var slozkaguid in t_slozky_poradi do
  begin
    slozka:=t_slozky[slozkaguid];
    slozka.UlozXML(xmlread,t_slozky_poradi.IndexOf(slozkaguid),t_databaze_poradi,t_databaze);
  end;

  xmlread.EndElement;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.UlozSkriptyXML;
var
  skript: TSkript;
begin
  xmlread.StartElement('Skripty','' );

  for var skriptguid in t_skripty_poradi do
  begin
    skript:=t_skripty[skriptguid];
    skript.UlozXML(xmlread,t_skripty_poradi.IndexOf(skriptguid));
  end;

  xmlread.EndElement;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.UlozNastaveniXML;
begin
  if not t_neukladat then
  begin
    if (t_soubor_nazev<>'') or FileSaveDialog1.Execute  then
    begin
      if t_soubor_nazev='' then t_soubor_nazev:=FileSaveDialog1.FileName;
      

      xmlread.Config('Charset=windows-1250');
      xmlread.OutputFile:=t_soubor_nazev;
      xmlread.WriteXMLDeclaration('1.0',True,False);
      xmlread.StartElement('Executor','');
      xmlread.StartElement('Nastaveni','');
      xmlread.StartElement('Databaze','');
      xmlread.WriteAttribute('login','',t_central_login);
      xmlread.WriteAttribute('heslo','',t_central_heslo);
      xmlread.WriteAttribute('role','',t_central_role);
      xmlread.EndElement;

      xmlread.StartElement('Zaloha','');
      xmlread.WriteAttribute('cestaGBAK','',t_zaloha_cesta);
      xmlread.EndElement;
      xmlread.EndElement;

      UlozDatabazeSlozkyXML;
      UlozSkriptyXML;

      xmlread.Close;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Práce s vnitøními strukturami
////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.UlozDatabazi(p_databaze: TDBUdaje);
begin
  if not t_databaze.ContainsKey(p_databaze.GUID) then t_databaze.Add(p_databaze.GUID,p_databaze);
  if not t_databaze_poradi.Contains(p_databaze.GUID) then t_databaze_poradi.Add(p_databaze.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.SmazDatabazi(p_databaze: TDBUdaje);
begin
  t_databaze_poradi.Remove(p_databaze.GUID);
  t_databaze.Remove(p_databaze.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunDatabaziNahoru(p_databaze: TDBUdaje);
begin
  var index:=t_databaze_poradi.IndexOf(p_databaze.GUID);

  if(index>0) then
  begin
    t_databaze_poradi.Remove(p_databaze.GUID);
    t_databaze_poradi.Insert(index-1,p_databaze.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunDatabaziDolu(p_databaze: TDBUdaje);
begin
  var index:=t_databaze_poradi.IndexOf(p_databaze.GUID);

  if(index<t_databaze_poradi.Count-1) then
  begin
    t_databaze_poradi.Remove(p_databaze.GUID);
    t_databaze_poradi.Insert(index+1,p_databaze.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////


procedure TExecutorNastaveni.UlozSlozku(p_slozka: TSlozka);
begin
  if not t_slozky.ContainsKey(p_slozka.GUID) then t_slozky.Add(p_slozka.GUID,p_slozka);
  if not t_slozky_poradi.Contains(p_slozka.GUID) then t_slozky_poradi.Add(p_slozka.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.SmazSlozku(p_slozka: TSlozka);
begin
  t_slozky_poradi.Remove(p_slozka.GUID);
  t_slozky.Remove(p_slozka.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunSlozkuNahoru(p_slozka: TSlozka);
begin
  var index:=t_slozky_poradi.IndexOf(p_slozka.GUID);

  if(index>0) then
  begin
    t_slozky_poradi.Remove(p_slozka.GUID);
    t_slozky_poradi.Insert(index-1,p_slozka.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunSlozkuDolu(p_slozka: TSlozka);
begin
  var index:=t_slozky_poradi.IndexOf(p_slozka.GUID);

  if(index<t_slozky_poradi.Count-1) then
  begin
    t_slozky_poradi.Remove(p_slozka.GUID);
    t_slozky_poradi.Insert(index+1,p_slozka.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.UlozSkript(p_skript: TSkript);
begin
  if not t_skripty.ContainsKey(p_skript.GUID) then t_skripty.Add(p_skript.GUID,p_skript);
  if not t_skripty_poradi.Contains(p_skript.GUID) then t_skripty_poradi.Add(p_skript.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.SmazSkript(p_skript: TSkript);
begin
  t_skripty_poradi.Remove(p_skript.GUID);
  t_skripty.Remove(p_skript.GUID);
  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunSkriptNahoru(p_skript: TSkript);
begin
  var index:=t_skripty_poradi.IndexOf(p_skript.GUID);

  if(index>0) then
  begin
    t_skripty_poradi.Remove(p_skript.GUID);
    t_skripty_poradi.Insert(index-1,p_skript.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TExecutorNastaveni.PosunSkriptDolu(p_skript: TSkript);
begin
  var index:=t_skripty_poradi.IndexOf(p_skript.GUID);

  if(index<t_skripty_poradi.Count-1) then
  begin
    t_skripty_poradi.Remove(p_skript.GUID);
    t_skripty_poradi.Insert(index+1,p_skript.GUID);
  end;

  UlozNastaveniXML;
end;

////////////////////////////////////////////////////////////////////////////////

function TExecutorNastaveni.VytvorGUID: string;
var
  v_guid: TGUID;
begin
  if(CreateGUID(v_guid)=0) then Result:=GuidToString(v_guid)
  else raise EResNotFound.Create('Nelze tvoøit GUID');
end;

end.
