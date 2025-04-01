unit JsonObjectSerilizerUnitTests;

interface

uses
  JsonObjectSerilizerUnit,
  TestFrameWork,
  Contnrs;

type
  TJsonObjectSerilizerTests = class(TTestCase)
  private
    FFileName: string;
    FPassword: string;
    FSerializer: TJsonObjectSerilizer;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreate;
    procedure TestDestroy;
    procedure TestLoadObjectStateFromStream;
    procedure TestLoadObjectStateFromFile;
    procedure TestLoadObjectStateFromJsonString;
    procedure TestSaveObjectStateToStream;
    procedure TestSaveObjectStateToFile;
    procedure TestSaveObjectStateToJsonString;
  end;

implementation

uses SysUtils, Classes, TestObjectUnit;

{ TJsonObjectSerilizerTests }

procedure TJsonObjectSerilizerTests.SetUp;
begin
  inherited;
  FFileName := 'c:\temp\TJsonObjectSerilizerTests_TestSaveObjectStateToFile.json';
  FPassword := 'Владивосток';
  FSerializer := TJsonObjectSerilizer.Create;
end;

procedure TJsonObjectSerilizerTests.TearDown;
begin
  FSerializer.Free;
  inherited;
end;

procedure TJsonObjectSerilizerTests.TestCreate;
var
  vObject: TJsonObjectSerilizer;
begin
  vObject := TJsonObjectSerilizer.Create();
  Self.CheckTrue(vObject <> nil);
  vObject.Free;
end;

procedure TJsonObjectSerilizerTests.TestDestroy;
var
  vObject: TJsonObjectSerilizer;
begin
  vObject := TJsonObjectSerilizer.Create();
  FreeAndNil(vObject);
  Self.CheckTrue(vObject = nil);
end;

procedure TJsonObjectSerilizerTests.TestLoadObjectStateFromFile;
begin

end;

procedure TJsonObjectSerilizerTests.TestLoadObjectStateFromJsonString;
begin

end;

procedure TJsonObjectSerilizerTests.TestLoadObjectStateFromStream;
begin

end;

procedure TJsonObjectSerilizerTests.TestSaveObjectStateToFile;
var
  vTestObject: TTestObject;
begin
  vTestObject := TTestObject.CreateObjectForJson;
  try
    FSerializer.SaveObjectStateToFile(FFileName, vTestObject, FPassword);
    CheckTrue(FileExists(FFileName));
  finally
    vTestObject.Free;
  end;
end;

procedure TJsonObjectSerilizerTests.TestSaveObjectStateToJsonString;
begin

end;

procedure TJsonObjectSerilizerTests.TestSaveObjectStateToStream;
var
  vStream: TStringStream;
  vTestObject: TTestObject;
begin
  vStream := TStringStream.Create('');
  vTestObject := TTestObject.CreateObjectForJson;
  try
    FSerializer.SaveObjectStateToStream(vStream, vTestObject, FPassword);
    CheckNotEqualsString('', vStream.DataString);
  finally
    vStream.Free;
    vTestObject.Free;
  end;
end;

initialization

  TestFramework.RegisterTest('JsonObjectSerilizerUnitTests Suite',
    TJsonObjectSerilizerTests.Suite);

end.
 