{*******************************************************
* Project: VistaMedTools2
* Unit: BaseFormUnit.pas
* Description: ������� ����� ����������
* 
* Created: 30.03.2025 7:12:01
* Copyright (C) 2025 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit BaseFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList;

type
  TBaseForm = class(TForm)
    aclMain: TActionList;
  private
    FParams: TObject;
    procedure SetParams(Value: TObject);
  protected
    //1 ������������� ����� ����������� �� �����������
    procedure Init(AParams: TObject); virtual;
  public
    //1 ������� ����� �������� � ���������� ������������� �� ��������� ������ �����
    class function IsOk(AParams: TObject = nil; AAppOwner: Boolean = True):
        Boolean; virtual;
    //1 ��������� �����
    property Params: TObject read FParams write SetParams;
  end;

implementation

{$R *.dfm}

procedure TBaseForm.Init(AParams: TObject);
begin
  Params := AParams;
end;

class function TBaseForm.IsOk(AParams: TObject = nil; AAppOwner: Boolean =
    True): Boolean;
var
  vForm: TBaseForm;
  vOwner: TComponent;
begin
  vOwner := nil;
  if AAppOwner then
    vOwner := Application;
  vForm := Self.Create(vOwner);
  try
    vForm.Init(AParams);
    Result := IsPositiveResult(vForm.ShowModal);
  finally
    vForm.Free;
  end;
end;

procedure TBaseForm.SetParams(Value: TObject);
begin
  if FParams <> Value then
  begin
    FParams := Value;
  end;
end;

end.
