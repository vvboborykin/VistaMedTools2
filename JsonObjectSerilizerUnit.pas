{*******************************************************
* Project: VistaMedTools2
* Unit: JsonObjectSerilizerUnit.pas
* Description: сериализаторv объекта TPersistent в/из JSON
*
* Created: 30.03.2025 20:34:48
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit JsonObjectSerilizerUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, TypInfo, DJson, Contnrs;

type
  TJsonObjectSerilizer = class
  private
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
    function SaveObjectListToJson(AJSONArray: IJSONArray; vObjValue: TObjectList):
        IJSONArray;
    function SaveObjectToJson(AJsonObj: IJSONObject; AObject: TPersistent):
        IJSONObject;
    function SaveObjectPropToJson(AJsonObj: IJSONObject; AObject: TPersistent;
        AProp: PPropInfo): IJSONObject;
    function SaveStringsToJson(AJSONArray: IJSONArray; vObjValue: TStrings):
        IJSONArray;
  public
    //1 загрузить объект из потока JSON
    procedure LoadObjectStateFromStream(AStream: TStream; AObject: TPersistent);
    //1 загрузить объект из файла
    procedure LoadObjectStateFromFile(AFileName: String; AObject: TPersistent);
    //1 сохранить состояние объекта в JSON поток
    procedure SaveObjectStateToStream(AStream: TStream; AObject: TPersistent);
  end;

implementation

resourcestring
  SItems = 'Items';
  SObject = 'Object';
  SClassName = 'ClassName';


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
  vPropCount: Integer;
  vPropList: PPropList;
begin
  vPropCount := GetPropList(AObject.ClassInfo, vPropList);
  for I := 0 to vPropCount-1 do
    LoadObjectPropFromJson(AJson, AObject, vPropList[I]);
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
    LoadObjectFromJson(vCurrentObjectJson[SObject].AsObject, vNewObject);
  end;
end;

procedure TJsonObjectSerilizer.LoadObjectPropFromJson(AJsonObj: IJSONObject;
    AObject: TPersistent; AProp: PPropInfo);
var
  vObjValue: TObject;
  vPropJson: IJSONValue;
  vPropName: string;
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
        if vObjValue is TPersistent then
          LoadObjectFromJson(vPropJson.AsObject, vObjValue as TPersistent)
        else
        if vObjValue is TStrings then
          LoadStringsFromJson(vPropJson.AsArray, vObjValue as TStrings)
        else
        if vObjValue is TObjectList then
          LoadObjectListFromJson(vPropJson.AsArray, vObjValue as TObjectList)
        else
        if vObjValue is TCollection then
          LoadCollectionFromJson(vPropJson.AsArray, vObjValue as TCollection)
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
      vJSONObject.Add(SClassName, vItem.ClassName);
      vJSONObject.Add(SObject, SaveObjectToJson(vJSONObject, vItem as TPersistent));
      AJSONArray.Add(vJSONObject);
    end;
  end;
end;

function TJsonObjectSerilizer.SaveObjectListToJson(AJSONArray: IJSONArray;
    vObjValue: TObjectList): IJSONArray;
var
  I: Integer;
  vItem: TObject;
  vJSONObject: IJSONObject;
begin
  Result := AJSONArray;
  for I := 0 to vObjValue.Count-1 do
  begin
    vItem := vObjValue[I];
    if (vItem <> nil) and (vItem is TPersistent) then
    begin
      vJSONObject := JSONBuilder.BuildObject.Build;
      vJSONObject.Add(SClassName, vItem.ClassName);
      vJSONObject.Add(SObject, SaveObjectToJson(vJSONObject, vItem as TPersistent));
      AJSONArray.Add(vJSONObject);
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
        if vObjValue is TPersistent then
        begin
          AJsonObj.Add(vPropName,
            SaveObjectPropToJson(JSONBuilder.BuildObject.Build,
              vObjValue as TPersistent, AProp));
        end
        else
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
        end;
      end;
    end;
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
  vPropCount: Integer;
  vPropList: PPropList;
begin
  Result := AJsonObj;
  vPropCount := GetPropList(AObject.ClassInfo, vPropList);
  for I := 0 to vPropCount-1 do
    SaveObjectPropToJson(AJsonObj, AObject, vPropList[I]);
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
