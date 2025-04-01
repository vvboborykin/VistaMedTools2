{*******************************************************
* Project: VistaMedTools2
* Unit: JsonObjectSerilizerUnit.pas
* Description: Сервис сохранения/восстановления состояния объекта TPersistent в/из JSON
*
* Created: 30.03.2025 20:34:48
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit JsonObjectSerilizerUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, TypInfo, DJson, Contnrs;

type
  /// <summary>TJsonObjectSerilizer
  /// Сервис сохранения/восстановления состояния объекта TPersistent в/из JSON
  /// </summary>
  TJsonObjectSerilizer = class
  private
    FFixupList: TStringList;
    procedure DeserializeObjectProp(vObjValue: TObject; vPropJson: IJSONValue;
        AObject: TPersistent; AProp: PPropInfo);
    procedure LoadCollectionFromJson(AJSONArray: IJSONArray; ACollection:
        TCollection);
    procedure LoadObjectFromJson(AJson: IJSONObject; AObject: TPersistent);
    procedure LoadObjectListFromJson(AJSONArray: IJSONArray; AObjectList:
        TObjectList);
    procedure LoadStringsFromJson(AJSONArray: IJSONArray; AStrings: TStrings);
    procedure LoadObjectPropFromJson(AJsonObj: IJSONObject; AObject: TPersistent;
        AProp: PPropInfo);
    function SaveCollectionToJson(AJSONArray: IJSONArray; ACollection:
        TCollection): IJSONArray;
    function SaveObjectListToJson(AJSONArray: IJSONArray; AObjectList:
        TObjectList): IJSONArray;
    function SaveObjectToJson(AJsonObj: IJSONObject; AObject: TPersistent):
        IJSONObject;
    function SaveObjectPropToJson(AJsonObj: IJSONObject; AObject: TPersistent;
        AProp: PPropInfo): IJSONObject;
    function SaveStringsToJson(AJSONArray: IJSONArray; vObjValue: TStrings):
        IJSONArray;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>TJsonObjectSerilizer.LoadObjectStateFromStream
    /// загрузить состояние объекта из потока JSON
    /// </summary>
    /// <param name="AStream"> (TStream) поток, содержащий данные JSON</param>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// загружается</param>
    procedure LoadObjectStateFromStream(AStream: TStream; AObject: TPersistent);
    /// <summary>TJsonObjectSerilizer.LoadObjectStateFromFile
    /// загрузить состояние объекта из файла JSON
    /// </summary>
    /// <param name="AFileName"> (String) имя JSON файла</param>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// загружается</param>
    procedure LoadObjectStateFromFile(AFileName: String; AObject: TPersistent);
    /// <summary>TJsonObjectSerilizer.LoadObjectStateFromJsonString
    /// загрузить состояние объекта из JSON строки
    /// </summary>
    /// <param name="AString"> (String) строка JSON содержащая информацию о  состоянии
    /// объекта</param>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// загружается</param>
    procedure LoadObjectStateFromJsonString(AString: String; AObject: TPersistent);
    /// <summary>TJsonObjectSerilizer.SaveObjectStateToStream
    /// сохранить состояние объекта в JSON поток
    /// </summary>
    /// <param name="AStream"> (TStream) поток, в который записывается состояние
    /// объекта</param>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// сохраняется</param>
    procedure SaveObjectStateToStream(AStream: TStream; AObject: TPersistent);
    /// <summary>TJsonObjectSerilizer.SaveObjectStateToFile
    /// сохранить объект в JSON файл
    /// </summary>
    /// <param name="AFileName"> (String) имя JSON файла, в который сохраняется
    /// состояние объекта</param>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// сохраняется</param>
    procedure SaveObjectStateToFile(AFileName: String; AObject: TPersistent);
    /// <summary>TJsonObjectSerilizer.SaveObjectStateToJsonString
    /// сохранить состояние объекта в JSON строку
    /// </summary>
    /// JSON строка содержащая состояние объекта
    /// <returns> String
    /// </returns>
    /// <param name="AObject"> (TPersistent) объект, состояние которого
    /// сохраняется</param>
    function SaveObjectStateToJsonString(AObject: TPersistent): String;
  end;

implementation

resourcestring
  SObjectId = 'ObjectId';
  SProperties = 'Properties';
  SItems = 'Items';
  SObject = 'Object';
  SClassName = 'ClassName';


constructor TJsonObjectSerilizer.Create;
begin
  inherited Create;
  FFixupList := TStringList.Create();
end;

destructor TJsonObjectSerilizer.Destroy;
begin
  FreeAndNil(FFixupList);
  inherited Destroy;
end;

procedure TJsonObjectSerilizer.DeserializeObjectProp(vObjValue: TObject;
    vPropJson: IJSONValue; AObject: TPersistent; AProp: PPropInfo);
var
  vClass: TClass;
  vIndexFixup: Integer;
  vObj: IJSONObject;
begin
  vObj := vPropJson.AsObject;
  if (vObjValue = nil) then
  begin
    vIndexFixup := FFixupList.IndexOf(vObj[SObjectId].AsString);
    if vIndexFixup >= 0 then
      vObjValue := FFixupList.Objects[vIndexFixup];
    vClass := FindClass(vObj[SClassName].AsString);
    vObjValue := TPersistentClass(vClass).Create;
    SetObjectProp(AObject, AProp, vObjValue);
    FFixupList.AddObject(vObj[SObjectId], vObjValue);
  end;
  
  if vObjValue <> nil then
    LoadObjectFromJson(vPropJson.AsObject, vObjValue as TPersistent);
end;

procedure TJsonObjectSerilizer.LoadCollectionFromJson(AJSONArray: IJSONArray;
    ACollection: TCollection);
var
  I: Integer;
  vClassName: string;
  vCurrentObjectJson: IJSONObject;
  vNewObject: TCollectionItem;
begin
  for I := 0 to AJSONArray.Count-1 do
  begin
    vCurrentObjectJson := AJSONArray[I].AsObject;
    vClassName := vCurrentObjectJson[SClassName].AsString;
    vNewObject := TCollectionItemClass(FindClass(vClassName)).Create(ACollection);
    LoadObjectFromJson(vCurrentObjectJson[SObject].AsObject, vNewObject);
  end;
end;

procedure TJsonObjectSerilizer.LoadObjectFromJson(AJson: IJSONObject; AObject:
    TPersistent);
var
  I: Integer;
  vJSONProperties: IJSONObject;
  vPropCount: Integer;
  vPropList: PPropList;
begin
  vJSONProperties := AJson[SProperties].AsObject;
  vPropCount := GetPropList(AObject.ClassInfo, vPropList);
  for I := 0 to vPropCount-1 do
    LoadObjectPropFromJson(vJSONProperties, AObject, vPropList[I]);
end;

procedure TJsonObjectSerilizer.LoadObjectListFromJson(AJSONArray: IJSONArray;
    AObjectList: TObjectList);
var
  I: Integer;
  vClassName: string;
  vCurrentObjectJson: IJSONObject;
  vNewObject: TPersistent;
begin
  for I := 0 to AJSONArray.Count-1 do
  begin
    vCurrentObjectJson := AJSONArray[I].AsObject;
    vClassName := vCurrentObjectJson[SClassName].AsString;
    vNewObject := TPersistentClass(FindClass(vClassName)).Create;
    AObjectList.Add(vNewObject);
    LoadObjectFromJson(vCurrentObjectJson.AsObject, vNewObject);
  end;
end;

procedure TJsonObjectSerilizer.LoadObjectPropFromJson(AJsonObj: IJSONObject;
    AObject: TPersistent; AProp: PPropInfo);
var
  vClass: TClass;
  vObjectId: Integer;
  vObjValue: TObject;
  vPropJson: IJSONValue;
  vPropName: string;
  vTypeData: PTypeData;
  vWideString: WideString;
begin
  vPropName := AProp.Name;
  vPropJson := AJsonObj[vPropName];
  if vPropJson <> nil then
  begin
    case AProp.PropType^.Kind of
      tkInteger: SetOrdProp(AObject, AProp, vPropJson.Value);
      tkChar: SetOrdProp(AObject, AProp, Ord(vPropJson.AsString[1]));
      tkEnumeration: SetEnumProp(AObject, AProp, vPropJson.AsString);
      tkFloat: SetFloatProp(AObject, AProp, StrToFloat(vPropJson.AsString));
      tkString, tkLString: SetStrProp(AObject, AProp, vPropJson.AsString);
      tkSet: SetSetProp(AObject, AProp, vPropJson.AsString);
      tkWString:
      begin
        vWideString := UTF8Decode(vPropJson.AsString);
        SetWideStrProp(AObject, AProp, vWideString);
      end;
      tkVariant: SetVariantProp(AObject, AProp, vPropJson.Value);
      tkClass:
      begin
        vObjValue := GetObjectProp(AObject, AProp);
        vTypeData := GetTypeData(AProp.PropType^);

        if vObjValue is TStrings then
          LoadStringsFromJson(vPropJson.AsArray, vObjValue as TStrings)
        else
        if vObjValue is TObjectList then
          LoadObjectListFromJson(vPropJson.AsArray, vObjValue as TObjectList)
        else
        if vObjValue is TCollection then
          LoadCollectionFromJson(vPropJson.AsArray, vObjValue as TCollection)
        else
        if vTypeData.ClassType.InheritsFrom(TPersistent) then
        begin
          (*TODO: extracted code
          if (vObjValue = nil) then
          begin
            vClass := FindClass(vPropJson.AsObject[SClassName].AsString);
            vObjValue := TPersistentClass(vClass).Create;
            SetObjectProp(AObject, AProp, vObjValue);
          end;
          if vObjValue <> nil then
            LoadObjectFromJson(vPropJson.AsObject, vObjValue as TPersistent);
          *)
          DeserializeObjectProp(vObjValue, vPropJson, AObject, AProp);
        end;
      end;
    end;

  end;
end;

procedure TJsonObjectSerilizer.LoadObjectStateFromFile(AFileName: String;
    AObject: TPersistent);
var
  vFileStream: TFileStream;
begin
  vFileStream := TFileStream.Create(AFileName, fmOpenRead, fmShareDenyWrite);
  try
    LoadObjectStateFromStream(vFileStream, AObject);
  finally
    vFileStream.Free;
  end;
end;

procedure TJsonObjectSerilizer.LoadObjectStateFromJsonString(AString: String;
    AObject: TPersistent);
var
  vStream: TStringStream;
begin
  vStream := TStringStream.Create(AString);
  vStream.Seek(0, 0);
  try
    LoadObjectStateFromStream(vStream, AObject);
  finally
    vStream.Free;
  end;
end;

procedure TJsonObjectSerilizer.LoadObjectStateFromStream(AStream: TStream;
    AObject: TPersistent);
var
  vJson: IJSONObject;
begin
  if (AStream <> nil) and (AObject <> nil) then
  begin
    vJson := TJSONReader.ReadFromStream(AStream).AsObject;
    LoadObjectFromJson(vJson, AObject);
  end;
end;

procedure TJsonObjectSerilizer.LoadStringsFromJson(AJSONArray: IJSONArray;
    AStrings: TStrings);
var
  I: Integer;
begin
  for I := 0 to AJSONArray.Count-1 do
    AStrings.Add(AJSONArray[I].AsString);
end;

function TJsonObjectSerilizer.SaveCollectionToJson(AJSONArray: IJSONArray;
    ACollection: TCollection): IJSONArray;
var
  I: Integer;
  vItem: TCollectionItem;
  vJSONObject: IJSONObject;
begin
  Result := AJSONArray;
  for I := 0 to ACollection.Count-1 do
  begin
    vItem := ACollection.Items[I];
    if (vItem <> nil) and (vItem is TPersistent) then
    begin
      vJSONObject := JSONBuilder.BuildObject.Build;
      AJSONArray.Add(vJSONObject);
      SaveObjectToJson(vJSONObject, vItem as TPersistent);
    end;
  end;
end;

function TJsonObjectSerilizer.SaveObjectListToJson(AJSONArray: IJSONArray;
    AObjectList: TObjectList): IJSONArray;
var
  I: Integer;
  vItem: TObject;
  vJSONObject: IJSONObject;
begin
  Result := AJSONArray;
  for I := 0 to AObjectList.Count-1 do
  begin
    vItem := AObjectList[I];
    if (vItem <> nil) and (vItem is TPersistent) then
    begin
      vJSONObject := JSONBuilder.BuildObject.Build;
      AJSONArray.Add(vJSONObject);
      SaveObjectToJson(vJSONObject, vItem as TPersistent);
    end;
  end;
end;

function TJsonObjectSerilizer.SaveObjectPropToJson(AJsonObj: IJSONObject;
    AObject: TPersistent; AProp: PPropInfo): IJSONObject;
var
  vObjValue: TObject;
  vPropName: string;
  vWideString: WideString;
begin
  Result := AJsonObj;
  vPropName := AProp.Name;
  case AProp.PropType^.Kind of
    tkInteger: AJsonObj.Add(vPropName, GetOrdProp(AObject, AProp));
    tkChar: AJsonObj.Add(vPropName, Char(GetOrdProp(AObject, AProp)));
    tkEnumeration: AJsonObj.Add(vPropName, GetEnumProp(AObject, AProp));
    tkFloat: AJsonObj.Add(vPropName, GetFloatProp(AObject, AProp));
    tkString, tkLString: AJsonObj.Add(vPropName, GetStrProp(AObject, AProp));
    tkSet: AJsonObj.Add(vPropName, GetSetProp(AObject, AProp));
    tkWString:
    begin
      vWideString := GetWideStrProp(AObject, AProp);
      AJsonObj.Add(vPropName, UTF8Encode(vWideString));
    end;
    tkVariant:
      AJsonObj.Add(vPropName, VarToStr(GetVariantProp(AObject, AProp)));
    tkClass:
    begin
      vObjValue := GetObjectProp(AObject, AProp);
      if vObjValue <> nil then
      begin
        if vObjValue is TStrings then
        begin
          AJsonObj.Add(vPropName,
            SaveStringsToJson(JSONBuilder.BuildArray.Build,
              vObjValue as TStrings));
        end
        else
        if vObjValue is TObjectList then
        begin
          AJsonObj.Add(vPropName,
            SaveObjectListToJson(JSONBuilder.BuildArray.Build,
              vObjValue as TObjectList));
        end
        else
        if vObjValue is TCollection then
        begin
          AJsonObj.Add(vPropName,
            SaveCollectionToJson(JSONBuilder.BuildArray.Build,
              vObjValue as TCollection));
        end
        else
        if vObjValue is TPersistent then
        begin
          AJsonObj.Add(vPropName,
            SaveObjectToJson(JSONBuilder.BuildObject.Build,
              vObjValue as TPersistent));
        end
        else;
      end;
    end;
  end;
end;

procedure TJsonObjectSerilizer.SaveObjectStateToFile(AFileName: String;
    AObject: TPersistent);
var
  vFileStream: TFileStream;
begin
  vFileStream := TFileStream.Create(AFileName, fmCreate, fmShareDenyWrite);
  try
    SaveObjectStateToStream(vFileStream, AObject);
  finally
    vFileStream.Free;
  end;
end;

function TJsonObjectSerilizer.SaveObjectStateToJsonString(AObject:
    TPersistent): String;
var
  vStream: TStringStream;
begin
  vStream := TStringStream.Create('');
  try
    SaveObjectStateToStream(vStream, AObject);
    Result := vStream.DataString;
  finally
    vStream.Free;
  end;
end;

procedure TJsonObjectSerilizer.SaveObjectStateToStream(AStream: TStream;
    AObject: TPersistent);
var
  vJson: IJSONObject;
begin
  if (AStream <> nil) and (AObject <> nil) then
  begin
    vJson := JSONBuilder.BuildObject.Build;
    SaveObjectToJson(vJson, AObject);
    TJSONWriter.WriteToStream(vJson, AStream);
  end;
end;

function TJsonObjectSerilizer.SaveObjectToJson(AJsonObj: IJSONObject; AObject:
    TPersistent): IJSONObject;
var
  I: Integer;
  vJSONProperties: IJSONObject;
  vPropCount: Integer;
  vPropList: PPropList;
begin
  Result := AJsonObj;
  AJsonObj.Add(SClassName, AObject.ClassName);
  AJsonObj.Add(SObjectId, IntToStr(Integer(AObject)));
  vJSONProperties := JSONBuilder.BuildObject.Build;
  AJsonObj.Add(SProperties, vJSONProperties);
  vPropCount := GetPropList(AObject.ClassInfo, vPropList);
  for I := 0 to vPropCount-1 do
    SaveObjectPropToJson(vJSONProperties, AObject, vPropList[I]);
end;

function TJsonObjectSerilizer.SaveStringsToJson(AJSONArray: IJSONArray;
    vObjValue: TStrings): IJSONArray;
var
  I: Integer;
begin
  Result := AJSONArray;
  for I := 0 to vObjValue.Count-1 do
    AJSONArray.Add(vObjValue[I]);
end;

end.
