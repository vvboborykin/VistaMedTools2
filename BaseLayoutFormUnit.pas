{*******************************************************
* Project: VistaMedTools2
* Unit: BaseLayoutFormUnit.pas
* Description: ФОрма с авторасположением элекментов управления
* 
* Created: 30.03.2025 7:17:45
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit BaseLayoutFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013DarkGray,
  dxSkinscxPCPainter, dxLayoutContainer, dxLayoutControl, ActnList;

type
  TBaseLayoutForm = class(TBaseForm)
    lagRoot: TdxLayoutGroup;
    lacMain: TdxLayoutControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  DevExpressDataUnit;

{$R *.dfm}

end.
