unit OptionsUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils;

type
  TOptions = class
  private
    FCmcoConnectionString: string;
    procedure SetCmcoConnectionString(Value: string);
  public
    constructor Create;
  published
    property CmcoConnectionString: string read FCmcoConnectionString write
        SetCmcoConnectionString;
  end;

implementation


constructor TOptions.Create;
begin
  inherited Create;
  FCmcoConnectionString := 'Provider Name=MySQL;User ID=dbuser;Password=dbpassword;Use Unicode=True;Data Source=MySqlServer;Database=s11;Login Prompt=False';
end;

procedure TOptions.SetCmcoConnectionString(Value: string);
begin
  if FCmcoConnectionString <> Value then
  begin
    FCmcoConnectionString := Value;
  end;
end;

end.
