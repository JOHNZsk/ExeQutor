unit Skript;

interface
  uses Generics.Collections, GUIDObjekt, ipwXMLp, ipwXMLw;

  type TSkript=class(TGUIDObjekt)
    private

      procedure NactiVyjimkyXML(p_zdroj: TipwXMLp; p_poradi: Integer);
    public
      Nazev: string;
      Text: string;
      Oznacen: Boolean;
      Poradi: Integer;
      Autocommit: Boolean;
      Neprovadet: TList<TGUIDstring>;

      constructor Create;

      procedure NactiXML(p_zdroj: TipwXMLp; p_poradi: Integer);
      procedure UlozXML(p_cil: TipwXMLw; p_poradi: Integer);

      destructor Destroy; override;
  end;

implementation
  uses System.SysUtils;

  constructor TSkript.Create;
  begin
    inherited;

    Neprovadet:=TList<TGUIDstring>.Create;
  end;

  ////////////////////////////////////////////////////////////////////////////////

  procedure TSkript.NactiVyjimkyXML(p_zdroj: TipwXMLp; p_poradi: Integer);
  var
    v_pocet_vyjimek: Integer;
    i: Integer;
    vyjimkyi: Integer;
  begin
    p_zdroj.XPath:='/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Vyjimky';

    v_pocet_vyjimek:=p_zdroj.XChildrenCount;
    vyjimkyi:=1;

    for i := 0 to v_pocet_vyjimek-1 do
    begin
      if(p_zdroj.XChildName[i]='Vyjimka') then
      begin
        p_zdroj.XPath:='/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Vyjimky/Vyjimka['+IntToStr(vyjimkyi)+']';

        Neprovadet.Add(p_zdroj.XText);

        Inc(vyjimkyi);
        p_zdroj.XPath:='/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Vyjimky';
      end;
    end;
  end;

  ////////////////////////////////////////////////////////////////////////////////

  procedure TSkript.NactiXML(p_zdroj: TipwXMLp; p_poradi: Integer);
  begin
    p_zdroj.XPath:='/Executor/Skripty/Skript['+IntToStr(p_poradi)+']';

    GUID:=p_zdroj.Attr('GUID');
    Nazev:=p_zdroj.Attr('nazev');
    Poradi:=StrToIntDef(p_zdroj.Attr('poradi'),-1);
    Oznacen:=StrToBoolDef(p_zdroj.Attr('oznacen'),True);
    Autocommit:=StrToBoolDef(p_zdroj.Attr('autocommit'),True);

    if p_zdroj.HasXPath('/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Vyjimky') then NactiVyjimkyXML(p_zdroj,p_poradi);

    if p_zdroj.HasXPath('/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Text') then
    begin
      p_zdroj.XPath:='/Executor/Skripty/Skript['+IntToStr(p_poradi)+']/Text';
      Text:=p_zdroj.XText;
    end
    else Text:='CHYBA!!!';
  end;

  //////////////////////////////////////////////////////////////////////////////

  procedure TSkript.UlozXML(p_cil: TipwXMLw; p_poradi: Integer);
  var
    vyjimka: TGUIDstring;
  begin
    p_cil.StartElement('Skript','');
    p_cil.WriteAttribute('GUID','',GUID);
    p_cil.WriteAttribute('nazev','',Nazev);
    p_cil.WriteAttribute('oznacen','',BoolToStr(Oznacen,True));
    p_cil.WriteAttribute('poradi','',IntToStr(p_poradi));
    p_cil.WriteAttribute('autocommit','',BoolToStr(Autocommit,True));
    p_cil.StartElement('Text','');
    p_cil.WriteString(Text);
    p_cil.EndElement;
    p_cil.StartElement('Vyjimky','');

    for vyjimka in Neprovadet do
    begin
      p_cil.StartElement('Vyjimka','');
      p_cil.WriteString(vyjimka);
      p_cil.EndElement;
    end;

    p_cil.EndElement;
    p_cil.EndElement;
  end;

  //////////////////////////////////////////////////////////////////////////////

  destructor TSkript.Destroy;
  begin
    Neprovadet.Free;

    inherited;
  end;

end.
