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
  Dialogs, BaseFormUnit, ActnList, VersionInfoUnit;

type
  TMainForm = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    procedure UpdateCaption;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  AboutFormUnit;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  UpdateCaption();
end;

procedure TMainForm.FormClick(Sender: TObject);
begin
  inherited;
  TAboutForm.IsOk();
end;

procedure TMainForm.UpdateCaption;
begin
  Caption := Application.Title + '. Версия ' +  GetAppVersionInfo;
end;

end.
