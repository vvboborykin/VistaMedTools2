{*******************************************************
* Project: VistaMedTools2
* Unit: MainFormUnit.pas
* Description: главная форма приложенния
* 
* Created: 30.03.2025 10:52:17
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormUnit, ActnList, VersionInfoUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore,
  dxSkinOffice2013DarkGray, dxSkinsdxRibbonPainter,
  dxRibbonCustomizationForm, dxSkinsdxBarPainter, ImgList, dxBar,
  cxClasses, dxRibbon, StdActns, AppEvnts, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TMainForm = class(TBaseForm)
    tabMainTabWork: TdxRibbonTab;
    ribMain: TdxRibbon;
    bamMain: TdxBarManager;
    iml32: TcxImageList;
    actAbout: TAction;
    dxbrHelp: TdxBar;
    btnAbout: TdxBarLargeButton;
    dxbrWindows: TdxBar;
    WindowClose1: TWindowClose;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrange1: TWindowArrange;
    btn1: TdxBarButton;
    btn2: TdxBarButton;
    btn3: TdxBarButton;
    btn4: TdxBarButton;
    btn5: TdxBarButton;
    btn6: TdxBarButton;
    apeMain: TApplicationEvents;
    procedure FormDestroy(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMyStrings: TStringList;
    procedure ShowAboutForm;
    procedure UpdateCaption;
  public
    procedure RegisterChildForm(AForm: TForm);
    procedure UnRegisterChildForm(AForm: TForm);
  published
    property MyStrings: TStringList read FMyStrings;
  end;

var
  MainForm: TMainForm;

implementation

uses
  AboutFormUnit, DevExpressDataUnit, BaseChildFormUnit, JsonSerializerUnit, OptionsUnit;

{$R *.dfm}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FMyStrings.Free;
  inherited;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  inherited;
  ShowAboutForm();
end;

procedure TMainForm.FormClick(Sender: TObject);
var
  vAppOptions: TAppOptions;
  vFileName: string;
const
  CStr = 'Победителя шоу «Танцы со звездами» Алексея Леденева отправили ' +
    'под арест, он стал фигурантом уголовного дела о миллионном хищении ' +
    'денежных средств у концерна «Калашников». Его обвиняют в поставках бракованных комплектующих.';
  SPass = '';
begin
  inherited;
  vFileName := 'c:\temp\333.json';
  vAppOptions := TAppOptions.Create;
  try
    vAppOptions.ConnectionString := CStr;
    vAppOptions.Lines.Add('1');
    vAppOptions.Lines.Add('2');
    vAppOptions.Lines.Add('3');

    vAppOptions.UserOptions.ConnectionString := CStr;
    vAppOptions.IntVal := 15;
    vAppOptions.BoolVal := True;
    vAppOptions.MyEnum := men2;
    vAppOptions.RurVar := Now;

    JsonSerializer.SerializeObjectToFile(vAppOptions, vFileName, SPass);

    vAppOptions.ConnectionString := '';
    vAppOptions.Lines.Clear;
    vAppOptions.UserOptions.ConnectionString := '';
    vAppOptions.IntVal := 0;
    vAppOptions.BoolVal := False;
    vAppOptions.MyEnum := menOne;
    vAppOptions.RurVar := MinDateTime;


    JsonSerializer.DeserializeObjectFromFile(vAppOptions, vFileName, SPass);
    Assert(vAppOptions.ConnectionString = CStr);
    Assert(vAppOptions.Lines.Count = 3);
    Assert(vAppOptions.UserOptions.ConnectionString = CStr);
    Assert(vAppOptions.IntVal = 15);
    Assert(vAppOptions.BoolVal);
    Assert(vAppOptions.MyEnum = men2);
    Assert(VarIsType(vAppOptions.RurVar, varDate));

  finally
    vAppOptions.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  UpdateCaption();
  FMyStrings := TStringList.Create;
end;

procedure TMainForm.RegisterChildForm(AForm: TForm);
begin
  // TODO -cMM: TMainForm.RegisterChildForm default body inserted
end;

procedure TMainForm.ShowAboutForm;
begin
  TAboutForm.IsOk();
end;

procedure TMainForm.UnRegisterChildForm(AForm: TForm);
begin
  // TODO -cMM: TMainForm.UnRegisterChildForm default body inserted
end;

procedure TMainForm.UpdateCaption;
begin
  Caption := Application.Title + '. Версия ' +  GetAppVersionInfo;
end;

end.
