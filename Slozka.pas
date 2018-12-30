unit Slozka;

interface
  uses GUIDObjekt, DBUdaje, Generics.Collections, IpwXMLp, IpwXMLw;

  type TSlozka=class(TGUIDObjekt)
    private
      procedure UlozDatabazeXML(p_cil: TipwXMLw; p_databaze_poradi: TList<TGUIDstring>; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
    public
      Nazev: string;
      Poradi: Integer;
      Login: string;
      Heslo: string;
      Role: string;

      procedure NactiXML(p_zdroj: TipwXMLp; p_poradi: Integer; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
      procedure UlozXML(p_cil: TipwXMLw; p_poradi: Integer; p_databaze_poradi: TList<TGUIDstring>; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
  end;

implementation
  uses System.SysUtils;

  ////////////////////////////////////////////////////////////////////////////////

  procedure TSlozka.NactiXML(p_zdroj: TipwXMLp; p_poradi: Integer; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
  var
    v_pocet_databazi: Integer;
    dbi: Integer;
    i: Integer;
    databaze: TDBUdaje;
  begin
    p_zdroj.XPath:='/Executor/SlozkyDatabaze/Slozka['+IntToStr(p_poradi)+']';

    GUID:=p_zdroj.Attr('GUID');
    Nazev:=p_zdroj.Attr('nazev');
    Poradi:=StrToIntDef(p_zdroj.Attr('poradi'),-1);
    Login:=p_zdroj.Attr('login');
    Heslo:=p_zdroj.Attr('heslo');
    Role:=p_zdroj.Attr('role');

    if p_zdroj.HasXPath('/Executor/SlozkyDatabaze/Slozka['+IntToStr(p_poradi)+']/SlozkaDatabaze') then
    begin
      p_zdroj.XPath:='/Executor/SlozkyDatabaze/Slozka['+IntToStr(p_poradi)+']/SlozkaDatabaze';

      v_pocet_databazi:=p_zdroj.XChildrenCount;
      dbi:=1;

      for i := 0 to v_pocet_databazi-1 do
      begin
        if p_zdroj.XChildName[i]='Databaze' then
        begin
          databaze:=TDBUdaje.Create;
          databaze.NactiXML(p_zdroj,GUID,p_poradi,dbi);
          p_databaze_udaje.Add(databaze.GUID,databaze);

          Inc(dbi);
          p_zdroj.XPath:='/Executor/SlozkyDatabaze/Slozka['+IntToStr(p_poradi)+']/SlozkaDatabaze';
        end;
      end;
    end;
  end;

  ////////////////////////////////////////////////////////////////////////////////

  procedure TSlozka.UlozDatabazeXML(p_cil: TipwXMLw; p_databaze_poradi: TList<TGUIDstring>; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
  var
    dbguid: TGUIDstring;
    dbudaje: TDBUdaje;
  begin
    p_cil.StartElement('SlozkaDatabaze','');

    for dbguid in p_databaze_poradi do
    begin
      dbudaje:=p_databaze_udaje[dbguid];
      if dbudaje.Slozka=GUID then dbudaje.UlozXML(p_cil,p_databaze_poradi.IndexOf(dbguid));
    end;

    p_cil.EndElement;
  end;

  //////////////////////////////////////////////////////////////////////////////

  procedure TSlozka.UlozXML(p_cil: TipwXMLw; p_poradi: Integer; p_databaze_poradi: TList<TGUIDstring>; p_databaze_udaje: TObjectDictionary<TGUIDstring,TDBUdaje>);
  begin
    p_cil.StartElement('Slozka','');
    p_cil.WriteAttribute('GUID','',GUID);
    p_cil.WriteAttribute('nazev','',Nazev);
    p_cil.WriteAttribute('poradi','',IntToStr(p_poradi));
    p_cil.WriteAttribute('login','',Login);
    p_cil.WriteAttribute('heslo','',Heslo);
    p_cil.WriteAttribute('role','',Role);

    UlozDatabazeXML(p_cil,p_databaze_poradi,p_databaze_udaje);

    p_cil.EndElement;
  end;
end.
