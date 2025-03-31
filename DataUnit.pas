unit DataUnit;

interface

uses
  SysUtils, Classes, UniProvider, MySQLUniProvider, DB, DBAccess, Uni;

type
  TData = class(TDataModule)
    conCmco: TUniConnection;
    MySql: TMySQLUniProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data: TData;

implementation

{$R *.dfm}

end.
