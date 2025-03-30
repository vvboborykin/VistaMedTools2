{*******************************************************
* Project: VistaMedTools2
* Unit: AboutFormUnit.pas
* Description: Форма с информацией о программе
* 
* Created: 30.03.2025 10:38:03
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit AboutFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormUnit, ActnList, frxpngimage, ExtCtrls, dxGDIPlusClasses,
  StdCtrls;

type
  TAboutForm = class(TBaseForm)
    imgAbout: TImage;
    lblVersion: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgAboutClick(Sender: TObject);
  private
  public
  end;

implementation

uses
  VersionInfoUnit;

{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  inherited;
  lblVersion.Caption := 'Версия ' + GetAppVersionInfo;
end;

procedure TAboutForm.FormDeactivate(Sender: TObject);
begin
  inherited;
  Close();
end;

procedure TAboutForm.FormKeyUp(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  Close();
end;

procedure TAboutForm.imgAboutClick(Sender: TObject);
begin
  inherited;
  Close();
end;

end.
