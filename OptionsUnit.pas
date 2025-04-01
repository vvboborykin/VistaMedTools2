unit OptionsUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils, Contnrs;

type
  TItem = class(TPersistent)
  private
    FName: string;
    procedure SetName(Value: string);
  published
    property Name: string read FName write SetName;
  end;

  TOptions = class(TPersistent)
  private
    FCmcoConnectionString: string;
    FNames: TStringList;
    FObjList: TObjectList;
    procedure SetCmcoConnectionString(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property CmcoConnectionString: string read FCmcoConnectionString write
        SetCmcoConnectionString;
    property Names: TStringList read FNames;
    property ObjList: TObjectList read FObjList;
  end;

implementation


constructor TOptions.Create;
begin
  inherited Create;
  FCmcoConnectionString := 'Provider Name=MySQL;User ID=dbuser;Password=dbpassword;Use Unicode=True;Data Source=MySqlServer;Database=s11;Login Prompt=False';
  FNames := TStringList.Create();
  FObjList := TObjectList.Create(True);
end;

destructor TOptions.Destroy;
begin
  FreeAndNil(FObjList);
  FreeAndNil(FNames);
  inherited Destroy;
end;

procedure TOptions.SetCmcoConnectionString(Value: string);
begin
  if FCmcoConnectionString <> Value then
  begin
    FCmcoConnectionString := Value;
  end;
end;

procedure TItem.SetName(Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
  end;
end;

initialization
  RegisterClass(TItem);

end.
