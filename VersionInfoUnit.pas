{*******************************************************
* Project: VistaMedTools2
* Unit: VersionInfoUnit.pas
* Description: Модуль Информации о версии приложения
* 
* Created: 02.04.2025 20:12:14
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit VersionInfoUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, JvVersionInfo;

/// <summary>procedure GetAppVersionInfo
/// Информация о версии приложения в виде строки
/// </summary>
/// <returns> String
/// </returns>
function GetAppVersionInfo: String;

implementation

function GetAppVersionInfo: String;
begin
  with JvVersionInfo.TJvVersionInfo.Create(ParamStr(0)) do
  begin
    Result := FileVersion;
    Free;
  end;
end;

end.
