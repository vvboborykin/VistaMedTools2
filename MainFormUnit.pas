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
  cxClasses, dxRibbon, StdActns, AppEvnts;

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
    procedure actAboutExecute(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowAboutForm;
    procedure UpdateCaption;
  public
    procedure RegisterChildForm(AForm: TForm);
    procedure UnRegisterChildForm(AForm: TForm);
  end;

var
  MainForm: TMainForm;

implementation

uses
  AboutFormUnit, DevExpressDataUnit, BaseChildFormUnit, JsonObjectSerilizerUnit, OptionsUnit;

{$R *.dfm}

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  inherited;
  ShowAboutForm();
end;

procedure TMainForm.FormClick(Sender: TObject);
var
  vCs: string;
  vOptions: TOptions;
begin
  inherited;
  vOptions := TOptions.Create;
  with TJsonObjectSerilizer.Create do
  begin
//    vOptions.Names.Add('имя 1');
//    vOptions.Names.Add('имя 2');
//    vOptions.ObjList.Add(TItem.Create);
//    vOptions.ObjList.Add(TItem.Create);
//    SaveObjectStateToFile('c:\temp\1.json', vOptions);
    LoadObjectStateFromFile('c:\temp\1.json', vOptions);
    if vOptions.ObjList.Count = 0 then
      ShowMessage('111');
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  UpdateCaption();
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
