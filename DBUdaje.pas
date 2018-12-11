unit DBUdaje;

interface
  uses GUIDObjekt, ipwxmlw, ipwxmlp;

  type TDBUdaje=class(TGUIDObjekt)
    public
      Slozka: TGUIDstring;
      Poradi: Integer;
      Nazev: string;
      Server: string;
      Cesta: string;
      Login: string;
      Heslo: string;
      Rola: string;
      Oznacena: Boolean;

      procedure NactiXML(p_zdroj: TipwXMLp; p_slozka_guid: string; p_slozka_poradi,p_poradi: Integer);
      procedure UlozXML(p_cil: TipwXMLw; p_poradi: Integer);
  end;

implementation
  uses System.SysUtils;

  procedure TDBUdaje.NactiXML(p_zdroj: TipwXMLp; p_slozka_guid: string; p_slozka_poradi,p_poradi: Integer);
  begin
    p_zdroj.XPath:='/Executor/SlozkyDatabaze/Slozka['+IntToStr(p_slozka_poradi)+']/SlozkaDatabaze/Databaze['+IntToStr(p_poradi)+']';

    Slozka:=p_slozka_guid;
    GUID:=p_zdroj.Attr('GUID');
    Poradi:=StrToIntDef(p_zdroj.Attr('poradi'),-1);
    Nazev:=p_zdroj.Attr('nazev');
    Server:=p_zdroj.Attr('server');
    Cesta:=p_zdroj.Attr('cesta');
    Login:=p_zdroj.Attr('login');
    Heslo:=p_zdroj.Attr('heslo');
    Rola:=p_zdroj.Attr('role');
    Oznacena:=StrToBoolDef(p_zdroj.Attr('oznacena'),True);
  end;

  //////////////////////////////////////////////////////////////////////////////

  procedure TDBUdaje.UlozXML(p_cil: TipwXMLw; p_poradi: Integer);
  begin
    p_cil.StartElement('Databaze','');
    p_cil.WriteAttribute('GUID','',GUID);
    p_cil.WriteAttribute('poradi','',IntToStr(p_poradi));
    p_cil.WriteAttribute('nazev','',Nazev);
    p_cil.WriteAttribute('server','',Server);
    p_cil.WriteAttribute('cesta','',Cesta);
    p_cil.WriteAttribute('login','',Login);
    p_cil.WriteAttribute('heslo','',Heslo);
    p_cil.WriteAttribute('role','',Rola);
    p_cil.WriteAttribute('oznacena','',BoolToStr(Oznacena,True));
    p_cil.EndElement;
  end;
end.
