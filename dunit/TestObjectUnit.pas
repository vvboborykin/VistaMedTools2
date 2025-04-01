unit TestObjectUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, Contnrs;


type
  TTestObject = class(TPersistent)
  private
    FItems: TObjectList;
    FLines: TStringList;
    FName: string;
    FTestRef: TTestObject;
    procedure SetName(Value: string);
    procedure SetTestRef(Value: TTestObject);
  public
    constructor Create;
    destructor Destroy; override;
  published
    class function CreateObjectForJson: TTestObject;
    property Items: TObjectList read FItems;
    property Lines: TStringList read FLines;
    property Name: string read FName write SetName;
    property TestRef: TTestObject read FTestRef write SetTestRef;
  end;


implementation

constructor TTestObject.Create;
begin
  inherited Create;
  FLines := TStringList.Create();
  FItems := TObjectList.Create(False);
end;

destructor TTestObject.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FLines);
  inherited Destroy;
end;

class function TTestObject.CreateObjectForJson: TTestObject;
begin
  Result := TTestObject.Create;
  Result.Name := 'Master';
  Result.TestRef := TTestObject.Create;
  Result.TestRef.Name := 'Slave';
  Result.Lines.Add('Один');
  Result.Lines.Add('Два');
  Result.Lines.Add('Три');
  Result.Items.Add(Result);
  Result.Items.Add(Result.TestRef);
end;

procedure TTestObject.SetName(Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
  end;
end;

procedure TTestObject.SetTestRef(Value: TTestObject);
begin
  if FTestRef <> Value then
  begin
    FTestRef := Value;
  end;
end;

end.
