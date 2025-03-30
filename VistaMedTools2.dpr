program VistaMedTools2;

uses
  Forms,
  BaseFormUnit in 'BaseFormUnit.pas' {BaseForm},
  DevExpressDataUnit in 'DevExpressDataUnit.pas' {DevExpressData: TDataModule},
  BaseLayoutFormUnit in 'BaseLayoutFormUnit.pas' {BaseLayoutForm},
  BaseOkCancelFormUnit in 'BaseOkCancelFormUnit.pas' {BaseOkCancelForm},
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm},
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  VersionInfoUnit in 'VersionInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Инструменты ВистаМед 2';
  Application.CreateForm(TDevExpressData, DevExpressData);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
