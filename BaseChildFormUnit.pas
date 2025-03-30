{*******************************************************
* Project: VistaMedTools2
* Unit: BaseChildFormUnit.pas
* Description: базовая дочерняя  MDI форма 
* 
* Created: 30.03.2025 11:13:13
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit BaseChildFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseLayoutFormUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013DarkGray,
  dxSkinscxPCPainter, ActnList, dxLayoutContainer, dxLayoutControl;

type
  TBaseChildForm = class(TBaseLayoutForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

implementation

uses
  MainFormUnit;

{$R *.dfm}

procedure TBaseChildForm.FormCreate(Sender: TObject);
begin
  inherited;
  MainForm.RegisterChildForm(Self);
end;

procedure TBaseChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  MainForm.UnRegisterChildForm(Self);
end;

end.
