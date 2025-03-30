program VistaMedTools2;

uses
  Forms,
  BaseFormUnit in 'BaseFormUnit.pas' {BaseForm},
  DevExpressDataUnit in 'DevExpressDataUnit.pas' {DevExpressData: TDataModule},
  BaseLayoutFormUnit in 'BaseLayoutFormUnit.pas' {BaseLayoutForm},
  BaseOkCancelFormUnit in 'BaseOkCancelFormUnit.pas' {BaseOkCancelForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Инструменты ВистаМед 2';
  Application.CreateForm(TDevExpressData, DevExpressData);
  Application.Run;
end.
