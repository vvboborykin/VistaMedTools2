unit VersionInfoUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, JvVersionInfo;



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
