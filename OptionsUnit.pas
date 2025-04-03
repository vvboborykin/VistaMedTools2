{*******************************************************
* Project: VistaMedTools2
* Unit: OptionsUnit.pas
* Description: параметры работы приложения
* 
* Created: 03.04.2025 10:59:57
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit OptionsUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils;

type

{$M+}
  TBaseOptions = class(TPersistent)
  end;

  TUserOptions = class(TBaseOptions)
  private
    FConnectionString: String;
    procedure SetConnectionString(Value: String);
  published
    property ConnectionString: String read FConnectionString write
        SetConnectionString;
  end;

  TMyEnum = (menOne, men2);

  TAppOptions = class(TBaseOptions)
  private
    FBoolVal: Boolean;
    FConnectionString: String;
    FIntVal: Integer;
    FLines: TStringList;
    FMyEnum: TMyEnum;
    FRurVar: Variant;
    FUserOptions: TUserOptions;
    procedure SetBoolVal(Value: Boolean);
    procedure SetConnectionString(Value: String);
    procedure SetIntVal(Value: Integer);
    procedure SetMyEnum(Value: TMyEnum);
    procedure SetRurVar(Value: Variant);
    procedure SetUserOptions(Value: TUserOptions);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property BoolVal: Boolean read FBoolVal write SetBoolVal;
    property ConnectionString: String read FConnectionString write
        SetConnectionString;
    property IntVal: Integer read FIntVal write SetIntVal;
    property Lines: TStringList read FLines;
    property MyEnum: TMyEnum read FMyEnum write SetMyEnum;
    property RurVar: Variant read FRurVar write SetRurVar;
    property UserOptions: TUserOptions read FUserOptions write SetUserOptions;
  end;


implementation

constructor TAppOptions.Create;
begin
  inherited Create;
  FLines := TStringList.Create();
  FUserOptions := TUserOptions.Create();
end;

destructor TAppOptions.Destroy;
begin
  FreeAndNil(FUserOptions);
  FreeAndNil(FLines);
  inherited Destroy;
end;

procedure TAppOptions.SetBoolVal(Value: Boolean);
begin
  if FBoolVal <> Value then
  begin
    FBoolVal := Value;
  end;
end;

procedure TAppOptions.SetConnectionString(Value: String);
begin
  if FConnectionString <> Value then
  begin
    FConnectionString := Value;
  end;
end;

procedure TAppOptions.SetIntVal(Value: Integer);
begin
  if FIntVal <> Value then
  begin
    FIntVal := Value;
  end;
end;

procedure TAppOptions.SetMyEnum(Value: TMyEnum);
begin
  if FMyEnum <> Value then
  begin
    FMyEnum := Value;
  end;
end;

procedure TAppOptions.SetRurVar(Value: Variant);
begin
  if FRurVar <> Value then
  begin
    FRurVar := Value;
  end;
end;

procedure TAppOptions.SetUserOptions(Value: TUserOptions);
begin
  if FUserOptions <> Value then
  begin
    FUserOptions := Value;
  end;
end;

procedure TUserOptions.SetConnectionString(Value: String);
begin
  if FConnectionString <> Value then
  begin
    FConnectionString := Value;
  end;
end;

end.
