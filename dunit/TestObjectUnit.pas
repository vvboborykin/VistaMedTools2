unit TestObjectUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, Contnrs, TestFrameWork;


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
    procedure ValidateState(ACase: TTestCase);
  published
    class function CreateObjectForJson: TTestObject;
    property Items: TObjectList read FItems;
    property Lines: TStringList read FLines;
    property Name: string read FName write SetName;
    property TestRef: TTestObject read FTestRef write SetTestRef;
  end;


implementation

resourcestring
  SThree = '���';
  STwo = '���';
  SOne = '����';
  SSlave = 'Slave';
  SMaster = 'Master';

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
  Result.Name := SMaster;
  Result.TestRef := TTestObject.Create;
  Result.TestRef.Name := SSlave;
  Result.Lines.Add(SOne);
  Result.Lines.Add(STwo);
  Result.Lines.Add(SThree);
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

procedure TTestObject.ValidateState(ACase: TTestCase);
begin
  ACase.CheckTrue(Name = SMaster, '��� �������');
  ACase.CheckTrue(TestRef <> Self, '������ �� ������ ������');
  ACase.CheckTrue(TestRef.Name = SSlave, '��� ������� �������');
  ACase.CheckTrue(Lines.Count = 3, '���������� �����');
  ACase.CheckTrue(Lines[0] = SOne, '������ ������');
  ACase.CheckTrue(Lines[1] = STwo, '������ ������');
  ACase.CheckTrue(Lines[2] = SThree, '������ ������');
  ACase.CheckTrue(Items.Count = 2, '���������� �������� � ������');
  ACase.CheckTrue(Items[0] = Self, '������ ������ � ������');
  ACase.CheckTrue(Items[1] = TestRef, '������ ������ � ������');
end;

initialization
  RegisterClass(TTestObject);

end.
