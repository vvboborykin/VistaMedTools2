unit JsonObjectSerilizerUnitTests;

interface

uses
  JsonObjectSerilizerUnit, TestFrameWork, Contnrs;

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
    procedure TestSaveObjectStateToStream;
    procedure TestSaveObjectStateToFile;
    procedure TestSaveObjectStateToJsonString;
    procedure TestLoadObjectStateFromStream;
    procedure TestLoadObjectStateFromFile;
    procedure TestLoadObjectStateFromJsonString;
  end;

implementation

uses
  SysUtils, Classes, TestObjectUnit, StrUtils;

{ TJsonObjectSerilizerTests }

const
  CJsonString = '{"ClassName":"TTestObject","ObjectId":"36582544",' +
  '"Properties":{"Items":[{"ClassName":"TTestObject","ObjectId":"36582544"},' +
  '{"ClassName":"TTestObject","ObjectId":"36582612",' +
  '"Properties":{"Name":"Slave"}}],"Lines":["Один","Два","Три"],' +
  '"Name":"Master","TestRef":{"ClassName":"TTestObject","ObjectId":"36582612"}}}';

procedure TJsonObjectSerilizerTests.SetUp;
begin
  inherited;
  FFileName :=
    'c:\temp\TJsonObjectSerilizerTests_TestSaveObjectStateToFile.json';
  FPassword := '';
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
var
  vTestObject: TTestObject;
begin
  vTestObject := TTestObject.Create;
  try
    FSerializer.LoadObjectStateFromFile(FFileName, vTestObject, FPassword);
    vTestObject.ValidateState(Self);
  finally
    vTestObject.Free;
  end;
end;

procedure TJsonObjectSerilizerTests.TestLoadObjectStateFromJsonString;
var
  vTestObject: TTestObject;
begin
  vTestObject := TTestObject.Create;
  try
    FSerializer.LoadObjectStateFromJsonString(CJsonString, vTestObject, FPassword);
    vTestObject.ValidateState(Self);
  finally
    vTestObject.Free;
  end;
end;

procedure TJsonObjectSerilizerTests.TestLoadObjectStateFromStream;
var
  vStringStream: TStringStream;
  vTestObject: TTestObject;
begin
  vStringStream := TStringStream.Create(CJsonString);
  vTestObject := TTestObject.Create;
  try
    FSerializer.LoadObjectStateFromStream(vStringStream, vTestObject, FPassword);
    vTestObject.ValidateState(Self);
  finally
    vTestObject.Free;
    vStringStream.Free;
  end;
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
var
  vJsonString: string;
  vTestObject1: TTestObject;
begin
  vTestObject1 := TTestObject.CreateObjectForJson;
  try
    vJsonString := FSerializer.SaveObjectStateToJsonString(vTestObject1, '');
    CheckTrue(AnsiContainsText(vJsonString, 'Master'));
    CheckTrue(AnsiContainsText(vJsonString, 'Slave'));
    CheckTrue(AnsiContainsText(vJsonString, 'Один'), 'Искажен русский текст');
  finally
    vTestObject1.Free;
  end;
end;

procedure TJsonObjectSerilizerTests.TestSaveObjectStateToStream;
var
  vJsonString: String;
  vStream: TStringStream;
  vTestObject1: TTestObject;
begin
  vStream := TStringStream.Create('');
  vTestObject1:= TTestObject.CreateObjectForJson;
  try
    FSerializer.SaveObjectStateToStream(vStream, vTestObject1, FPassword);
    vJsonString := vStream.DataString;

    CheckTrue(AnsiContainsText(vJsonString, 'Master'));
    CheckTrue(AnsiContainsText(vJsonString, 'Slave'));
    CheckTrue(AnsiContainsText(vJsonString, 'Один'), 'Искажен русский текст');
  finally
    vStream.Free;
    vTestObject1.Free;
  end;
end;

initialization
  TestFramework.RegisterTest('JsonObjectSerilizerUnitTests Suite',
    TJsonObjectSerilizerTests.Suite);

end.
 
