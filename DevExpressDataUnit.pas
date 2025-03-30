{*******************************************************
* Project: VistaMedTools2
* Unit: DevExpressDataUnit.pas
* Description: Параметры компонентов DevExpress
* 
* Created: 30.03.2025 7:14:01
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit DevExpressDataUnit;

interface

uses
  SysUtils, Classes, dxLayoutLookAndFeels, cxClasses, cxLocalization;

type
  TDevExpressData = class(TDataModule)
    lalLf: TdxLayoutLookAndFeelList;
    dxLayoutSkinLookAndFeel1: TdxLayoutSkinLookAndFeel;
    locRus: TcxLocalizer;
    dxLayoutStandardLookAndFeel1: TdxLayoutStandardLookAndFeel;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LoadRus;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DevExpressData: TDevExpressData;

implementation

{$R *.dfm}

procedure TDevExpressData.DataModuleCreate(Sender: TObject);
begin
  LoadRus;
end;

procedure TDevExpressData.LoadRus;
begin
  locRus.Locale := 1049;
end;

{$R DevExpress_ru.res}

end.
