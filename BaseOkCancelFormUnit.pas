{*******************************************************
* Project: VistaMedTools2
* Unit: BaseOkCancelFormUnit.pas
* Description: Базовая форма диалога Ok/Calce
* 
* Created: 30.03.2025 7:50:45
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit BaseOkCancelFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseLayoutFormUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013DarkGray,
  dxSkinscxPCPainter, dxLayoutContainer, dxLayoutControl, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Menus,
  dxLayoutControlAdapters, ActnList, StdCtrls, cxButtons;

type
  TBaseOkCancelForm = class(TBaseLayoutForm)
    btnOk: TcxButton;
    layOk: TdxLayoutItem;
    btnCancel: TcxButton;
    layCancel: TdxLayoutItem;
    actOk: TAction;
    actCancel: TAction;
    lagButtons: TdxLayoutGroup;
    sepButtons: TdxLayoutSeparatorItem;
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
  private
  protected
    procedure DoCancel; virtual;
    procedure DoOK; virtual;
  public
  end;

implementation

{$R *.dfm}

procedure TBaseOkCancelForm.actCancelExecute(Sender: TObject);
begin
  inherited;
  DoCancel();
end;

procedure TBaseOkCancelForm.actOkExecute(Sender: TObject);
begin
  inherited;
  DoOK();
end;

procedure TBaseOkCancelForm.DoCancel;
begin
  // TODO -cMM: TBaseOkCancelForm.DoCancel default body inserted
end;

procedure TBaseOkCancelForm.DoOK;
begin
  // TODO -cMM: TBaseOkCancelForm.DoOK default body inserted
end;

end.
