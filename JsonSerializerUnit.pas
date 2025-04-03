{*******************************************************
* Project: VistaMedTools2
* Unit: JsonSerializerUnit.pas
* Description: сервис сериализации/десериализации объектов в/из JSON
*
* Created: 03.04.2025 8:19:21
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit JsonSerializerUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, DJson, TypInfo;

type
  /// <summary>TJsonSerializer
  /// сервис сериализации/десериализации объектов в/из JSON
  /// </summary>
  TJsonSerializer = class
  private
    function CancSavePersistentProp(ASourceObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CanLoadObjectProp(ADestObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CanLoadPersistentProp(ADestObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CanLoadStringsProp(ADestObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CanSaveObjectProp(ASourceObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CanSaveStringsProp(ASourceObject: TPersistent; AProp: PPropInfo):
      Boolean;
    function CreateJsonArray: IJSONArray;
    function CreateJsonObject: IJSONObject;
    function Decrypt(AEncryptedString, APassword: string): string;
    function Encrypt(APlainString, APassword: string): string;
    function LoadDecryptedStringFromStream(AStream: TStream; APassword: string):
      string;
    procedure LoadObjectFromJson(AJsonObject: IJSONObject; ADestObject:
      TPersistent);
    procedure LoadObjectFromPlainString(ADestObject: TPersistent; APlainString:
      string);
    procedure LoadPersistentObjectProp(ADestObject: TPersistent; AProp:
      PPropInfo; AJsonValue: IJSONValue);
    procedure LoadProp(ADestObject: TPersistent; AJsonObject: IJSONObject; AProp:
      PPropInfo);
    procedure LoadStringsProp(ADestObject: TPersistent; AProp: PPropInfo;
      AJsonValue: IJSONValue);
    procedure LoadVariantProp(ADestObject: TPersistent; AProp: PPropInfo;
        AJsonValue: IJSONValue);
    procedure SaveEncryptedStringToStream(AStream: TStream; APlainString,
      APassword: string);
    procedure SaveObjectToJson(ASourceObject: TPersistent; AJsonObject:
      IJSONObject);
    function SaveObjectToPlainString(ASourceObject: TPersistent): string;
    procedure SaveObjectToStream(ASourceObject: TPersistent; ADestStream:
      TStringStream);
    function SavePersistentObjectProp(ASourceObject: TPersistent; AProp:
      PPropInfo): IJSONObject;
    procedure SaveProp(ASourceObject: TPersistent; AJsonObject: IJSONObject;
      AProp: PPropInfo);
    function SaveStringsProp(ASourceObject: TPersistent; AProp: PPropInfo):
      IJSONArray;
    function SaveVariantProp(ASourceObject: TPersistent; AProp: PPropInfo):
      IJSONObject;
  public
    /// <summary>TJsonSerializer.SerializeObjectToFile
    /// сериализовать объект в файл
    /// </summary>
    /// <param name="ASourceObject"> (TPersistent)  исходный объект для
    /// сериализации</param>
    /// <param name="AFileName"> (String) имя файла для записи результата сериализации</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    procedure SerializeObjectToFile(ASourceObject: TPersistent; AFileName:
      string; APassword: string);
    /// <summary>TJsonSerializer.SerializeObjectToStream
    /// сериализовать объект в строку
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASourceObject"> исходный объект для
    /// сериализации</param>
    /// <param name="AStream"> (TStream) поток - получатель JSON</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    procedure SerializeObjectToStream(ASourceObject: TPersistent; AStream:
      TStream; APassword: string);
    /// <summary>TJsonSerializer.SerializeObjectToString
    /// сериализовать объект в строку
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASourceObject"> (TPersistent) исходный объект для
    /// сериализации</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    function SerializeObjectToString(ASourceObject: TPersistent; APassword:
      string): string;

    /// <summary>TJsonDeserializer.DeserializeObjectFromFile
    /// десериализовать объект из файла
    /// </summary>
    /// <param name="ASourceObject"> (TPersistent)  исходный объект для
    /// сериализации</param>
    /// <param name="AFileName"> (String) имя файла для записи результата сериализации</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    procedure DeserializeObjectFromFile(ASourceObject: TPersistent; AFileName:
      string; APassword: string);
    /// <summary>TJsonDeserializer.DeserializeObjectFromStream
    /// десериализовать объект из строки
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASourceObject"> исходный объект для
    /// сериализации</param>
    /// <param name="AStream"> (TStream) поток - получатель JSON</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    procedure DeserializeObjectFromStream(ASourceObject: TPersistent; AStream:
      TStream; APassword: string);
    /// <summary>TJsonDeserializer.DeserializeObjectFromString
    /// десериализовать объект из строки
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASourceObject"> (TPersistent) исходный объект для
    /// сериализации</param>
    /// <param name="APassword"> (string) пароль для шифрования JSON</param>
    procedure DeserializeObjectFromString(ASourceObject: TPersistent;
      AJSONString, APassword: string);
  end;

/// <summary>procedure JsonSerializer
/// синглтон службы TJsonSerializer
/// </summary>
/// <returns> TJsonSerializer
/// </returns>
function JsonSerializer: TJsonSerializer;

implementation

uses
  CryptoServiceUnit;

resourcestring
  SVarValue = 'VarValue';
  SVarType = 'VarType';

var
  FSingleton: TJsonSerializer;

function JsonSerializer: TJsonSerializer;
begin
  Result := FSingleton;
end;

resourcestring
  SAStreamIsNil = 'AStream is nil';
  SASourceObjectIsNil = 'ASourceObject is nil';
  SClassNotRegistered = 'Class %s not registered';

function TJsonSerializer.CancSavePersistentProp(ASourceObject: TPersistent;
  AProp: PPropInfo): Boolean;
var
  vObjectValue: TObject;
begin
  vObjectValue := GetObjectProp(ASourceObject, AProp);
  Result := (vObjectValue is TPersistent)
    and (FindClass(vObjectValue.ClassName) <> nil);
end;

function TJsonSerializer.CanLoadObjectProp(ADestObject: TPersistent; AProp:
  PPropInfo): Boolean;
begin
  Result := (ADestObject <> nil) and (GetObjectProp(ADestObject, AProp) <> nil);
end;

function TJsonSerializer.CanLoadPersistentProp(ADestObject: TPersistent; AProp:
  PPropInfo): Boolean;
begin
  Result := (ADestObject <> nil) and (AProp <> nil) and (GetObjectProp(ADestObject,
    AProp) is TPersistent);
end;

function TJsonSerializer.CanLoadStringsProp(ADestObject: TPersistent; AProp:
  PPropInfo): Boolean;
var
  vObjValue: TObject;
begin
  vObjValue := GetObjectProp(ADestObject, AProp);
  Result := (vObjValue <> nil) and (vObjValue is TStrings);
end;

function TJsonSerializer.CanSaveObjectProp(ASourceObject: TPersistent; AProp:
  PPropInfo): Boolean;
var
  vPropValue: TObject;
begin
  vPropValue := GetObjectProp(ASourceObject, AProp);
  Result := (vPropValue <> nil);
end;

function TJsonSerializer.CanSaveStringsProp(ASourceObject: TPersistent; AProp:
  PPropInfo): Boolean;
var
  vPropValue: TObject;
begin
  vPropValue := GetObjectProp(ASourceObject, AProp);
  Result := (vPropValue <> nil) and (vPropValue is TStrings) and ((vPropValue as
    TStrings).Count > 0);
end;

function TJsonSerializer.CreateJsonArray: IJSONArray;
begin
  Result := JSONBuilder.BuildArray.Build;
end;

function TJsonSerializer.CreateJsonObject: IJSONObject;
begin
  Result := JSONBuilder.BuildObject.Build;
end;

function TJsonSerializer.Decrypt(AEncryptedString, APassword: string): string;
begin
  Result := AEncryptedString;
  if APassword <> '' then
    Result := CryptoService.DecryptString(AEncryptedString, APassword);
end;

procedure TJsonSerializer.DeserializeObjectFromFile(ASourceObject: TPersistent;
  AFileName, APassword: string);
var
  vSourceFileStream: TFileStream;
begin
  vSourceFileStream := TFileStream.Create(AFileName, fmOpenRead, fmShareDenyWrite);
  try
    DeserializeObjectFromStream(ASourceObject, vSourceFileStream, APassword);
  finally
    vSourceFileStream.Free;
  end;
end;

procedure TJsonSerializer.DeserializeObjectFromStream(ASourceObject: TPersistent;
  AStream: TStream; APassword: string);
var
  vPlainString: string;
begin
  if ASourceObject = nil then
    raise Exception.CreateFmt(SASourceObjectIsNil, []);
  if AStream = nil then
    raise Exception.CreateFmt(SAStreamIsNil, []);

  vPlainString := LoadDecryptedStringFromStream(AStream, APassword);
  LoadObjectFromPlainString(ASourceObject, vPlainString);
end;

procedure TJsonSerializer.DeserializeObjectFromString(ASourceObject: TPersistent;
  AJSONString, APassword: string);
begin

end;

function TJsonSerializer.Encrypt(APlainString, APassword: string): string;
begin
  Result := APlainString;
  if (APassword <> '') then
    Result := CryptoService.EncryptString(APlainString, APassword);
end;

function TJsonSerializer.LoadDecryptedStringFromStream(AStream: TStream;
  APassword: string): string;
var
  vStringStream: TStringStream;
begin
  vStringStream := TStringStream.Create('');
  try
    vStringStream.CopyFrom(AStream, 0);
    Result := Decrypt(vStringStream.DataString, APassword);
  finally
    vStringStream.Free;
  end;
end;

procedure TJsonSerializer.LoadObjectFromJson(AJsonObject: IJSONObject;
  ADestObject: TPersistent);
var
  I: Integer;
  vPropCount: Integer;
  vPropList: PPropList;
begin
  vPropCount := GetPropList(ADestObject, vPropList);
  for I := 0 to vPropCount - 1 do
    LoadProp(ADestObject, AJsonObject, vPropList[I]);
end;

procedure TJsonSerializer.LoadObjectFromPlainString(ADestObject: TPersistent;
  APlainString: string);
var
  vRootJson: IJSONObject;
  vUtfString: string;
begin
  vUtfString := AnsiToUtf8(APlainString);
  vRootJson := TJSONReader.Read(vUtfString).AsObject;
  LoadObjectFromJson(vRootJson, ADestObject);
end;

procedure TJsonSerializer.LoadPersistentObjectProp(ADestObject: TPersistent;
  AProp: PPropInfo; AJsonValue: IJSONValue);
var
  vObjectValue: TObject;
begin
  vObjectValue := GetObjectProp(ADestObject, AProp);
  if (vObjectValue <> nil) and (vObjectValue is TPersistent)
    and (AJsonValue.ValueType = jsObject) then
  begin
    LoadObjectFromJson(AJsonValue.AsObject, vObjectValue as TPersistent);
  end;
end;

procedure TJsonSerializer.LoadProp(ADestObject: TPersistent; AJsonObject:
  IJSONObject; AProp: PPropInfo);
var
  vJsonValue: IJSONValue;
  vPropName: string;
  vWideString: string;
begin
  vPropName := AProp.Name;
  vJsonValue := AJsonObject[vPropName];
  if (vJsonValue <> nil) then
  begin
    case AProp.PropType^.Kind of
      tkInteger:
        SetOrdProp(ADestObject, AProp, vJsonValue.Value);
      tkChar:
        SetOrdProp(ADestObject, AProp, vJsonValue.Value);
      tkEnumeration:
        SetEnumProp(ADestObject, AProp, vJsonValue.AsString);
      tkFloat:
        SetFloatProp(ADestObject, AProp, vJsonValue.AsNumber);
      tkString, tkLString:
        SetStrProp(ADestObject, AProp, vJsonValue.AsString);
      tkSet:
        SetSetProp(ADestObject, AProp, vJsonValue.AsString);
      tkInt64:
        SetInt64Prop(ADestObject, AProp, StrToInt64(vJsonValue.AsString));
      tkWString:
        begin
          vWideString := vJsonValue.AsString;
          SetWideStrProp(ADestObject, AProp, vWideString);
        end;
      tkClass:
        if CanLoadObjectProp(ADestObject, AProp) then
        begin
          if CanLoadStringsProp(ADestObject, AProp) then
            LoadStringsProp(ADestObject, AProp, vJsonValue)
          else if CanLoadPersistentProp(ADestObject, AProp) then
            LoadPersistentObjectProp(ADestObject, AProp, vJsonValue);
        end;
      tkVariant:
        LoadVariantProp(ADestObject, AProp, vJsonValue);
    end;
  end;
end;

procedure TJsonSerializer.LoadStringsProp(ADestObject: TPersistent; AProp:
  PPropInfo; AJsonValue: IJSONValue);
var
  I: Integer;
  vStringsValue: TStrings;
begin
  vStringsValue := GetObjectProp(ADestObject, AProp) as TStrings;
  if AJsonValue.ValueType = jsArray then
  begin
    for I := 0 to AJsonValue.AsArray.Count - 1 do
      vStringsValue.Add(AJsonValue.AsArray.Element[I].AsString);
  end
  else
    vStringsValue.Add(AJsonValue.AsString);
end;

procedure TJsonSerializer.LoadVariantProp(ADestObject: TPersistent; AProp:
    PPropInfo; AJsonValue: IJSONValue);
var
  vJsonObj: IJSONObject;
  vVarStr: string;
  vVarType: TVarType;
begin
  if AJsonValue.ValueType = jsObject then
  begin
    vJsonObj := AJsonValue.AsObject;
    if vJsonObj[SVarType] <> nil then
    begin
      vVarType := vJsonObj[SVarType].Value;
      if vVarType = varEmpty then
        SetVariantProp(ADestObject, AProp, Unassigned)
      else
      if vVarType = varNull then
        SetVariantProp(ADestObject, AProp, Null)
      else
      begin
        vVarStr := vJsonObj[SVarValue].Value;
        SetVariantProp(ADestObject, AProp, VarAsType(vVarStr, vVarType));
      end;
    end;
  end;
end;

procedure TJsonSerializer.SaveEncryptedStringToStream(AStream: TStream;
  APlainString, APassword: string);
var
  vStringStream: TStringStream;
begin
  vStringStream := TStringStream.Create(Encrypt(APlainString, APassword));
  try
    AStream.CopyFrom(vStringStream, 0);
  finally
    vStringStream.Free;
  end;
end;

procedure TJsonSerializer.SaveObjectToJson(ASourceObject: TPersistent;
  AJsonObject: IJSONObject);
var
  I: Integer;
  vPropCount: Integer;
  vPropList: PPropList;
begin
  vPropCount := GetPropList(ASourceObject, vPropList);
  for I := 0 to vPropCount - 1 do
    SaveProp(ASourceObject, AJsonObject, vPropList[I]);
end;

function TJsonSerializer.SaveObjectToPlainString(ASourceObject: TPersistent):
  string;
var
  vPlainString: string;
  vStringStream: TStringStream;
begin
  vStringStream := TStringStream.Create('');
  try
    SaveObjectToStream(ASourceObject, vStringStream);
    vPlainString := Utf8ToAnsi(vStringStream.DataString);
  finally
    vStringStream.Free;
  end;
  Result := vPlainString;
end;

procedure TJsonSerializer.SaveObjectToStream(ASourceObject: TPersistent;
  ADestStream: TStringStream);
var
  vRootJson: IJSONObject;
begin
  if ASourceObject <> nil then
  begin
    vRootJson := CreateJsonObject;
    SaveObjectToJson(ASourceObject, vRootJson);
    TJSONWriter.WriteToStream(vRootJson, ADestStream);
    ADestStream.Seek(0, 0);
  end;
end;

function TJsonSerializer.SavePersistentObjectProp(ASourceObject: TPersistent;
  AProp: PPropInfo): IJSONObject;
begin
  Result := CreateJsonObject;
  SaveObjectToJson(GetObjectProp(ASourceObject, AProp) as TPersistent, Result);
end;

procedure TJsonSerializer.SaveProp(ASourceObject: TPersistent; AJsonObject:
  IJSONObject; AProp: PPropInfo);
var
  vPropName: string;
  vTypeData: PTypeData;
begin
  vPropName := AProp.Name;
  vTypeData := GetTypeData(AProp.PropType^);
  case AProp.PropType^.Kind of
    tkInteger:
      AJsonObject.Add(vPropName, GetOrdProp(ASourceObject, AProp));
    tkChar:
      AJsonObject.Add(vPropName, Char(GetOrdProp(ASourceObject, AProp)));
    tkEnumeration:
      AJsonObject.Add(vPropName, GetEnumProp(ASourceObject, AProp));
    tkFloat:
      AJsonObject.Add(vPropName, GetFloatProp(ASourceObject, AProp));
    tkString, tkLString:
      AJsonObject.Add(vPropName, GetStrProp(ASourceObject, AProp));
    tkSet:
      AJsonObject.Add(vPropName, GetSetProp(ASourceObject, AProp));
    tkInt64:
      AJsonObject.Add(vPropName, IntToStr(GetInt64Prop(ASourceObject, AProp)));
    tkWString:
      AJsonObject.Add(vPropName, GetWideStrProp(ASourceObject, AProp));
    tkClass:
      if CanSaveObjectProp(ASourceObject, AProp) then
      begin
        if CanSaveStringsProp(ASourceObject, AProp) then
          AJsonObject.Add(vPropName, SaveStringsProp(ASourceObject, AProp))
        else if CancSavePersistentProp(ASourceObject, AProp) then
          AJsonObject.Add(vPropName, SavePersistentObjectProp(ASourceObject,
            AProp));
      end;
    tkVariant:
      AJsonObject.Add(vPropName, SaveVariantProp(ASourceObject, AProp));
  end;
end;

function TJsonSerializer.SaveStringsProp(ASourceObject: TPersistent; AProp:
  PPropInfo): IJSONArray;
var
  I: Integer;
  vStringsValue: TStrings;
begin
  Result := CreateJsonArray;
  vStringsValue := GetObjectProp(ASourceObject, AProp) as TStrings;
  for I := 0 to vStringsValue.Count - 1 do
    Result.Add(vStringsValue[I]);
end;

function TJsonSerializer.SaveVariantProp(ASourceObject: TPersistent; AProp:
  PPropInfo): IJSONObject;
var
  vValue: Variant;
  vVarType: Word;
begin
  Result := CreateJsonObject;
  vValue := GetVariantProp(ASourceObject, AProp);
  vVarType := VarType(vValue);
  Result.Add(SVarType, vVarType);
  Result.Add(SVarValue, VarToStr(vValue));
end;

procedure TJsonSerializer.SerializeObjectToFile(ASourceObject: TPersistent;
  AFileName: string; APassword: string);
var
  vDestFileStream: TFileStream;
begin
  vDestFileStream := TFileStream.Create(AFileName, fmCreate, fmShareDenyWrite);
  try
    SerializeObjectToStream(ASourceObject, vDestFileStream, APassword);
  finally
    vDestFileStream.Free;
  end;
end;

procedure TJsonSerializer.SerializeObjectToStream(ASourceObject: TPersistent;
  AStream: TStream; APassword: string);
var
  vPlainString: string;
begin
  if ASourceObject = nil then
    raise Exception.CreateFmt(SASourceObjectIsNil, []);
  if AStream = nil then
    raise Exception.CreateFmt(SAStreamIsNil, []);

  vPlainString := SaveObjectToPlainString(ASourceObject);
  SaveEncryptedStringToStream(AStream, vPlainString, APassword);
end;

function TJsonSerializer.SerializeObjectToString(ASourceObject: TPersistent;
  APassword: string): string;
var
  vStringStream: TStringStream;
begin
  vStringStream := TStringStream.Create('');
  try
    SerializeObjectToStream(ASourceObject, vStringStream, APassword);
    Result := vStringStream.DataString;
  finally
    vStringStream.Free;
  end;
end;

initialization
  FSingleton := TJsonSerializer.Create;


finalization
  FreeAndNil(FSingleton);

end.
