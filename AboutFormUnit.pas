{*******************************************************
* Project: VistaMedTools2
* Unit: AboutFormUnit.pas
* Description: Форма с информацией о программе
* 
* Created: 30.03.2025 8:44:47
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit AboutFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOkCancelFormUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013DarkGray,
  dxSkinscxPCPainter, Menus, dxLayoutControlAdapters, dxLayoutContainer,
  ExtCtrls, ActnList, StdCtrls, cxButtons, dxLayoutControl,
  dxGDIPlusClasses;

type
  TAboutForm = class(TBaseOkCancelForm)
    layAbout: TdxLayoutItem;
    imgAbout: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
