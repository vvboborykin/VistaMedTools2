program VistaMedTools2;

uses
  Forms,
  BaseFormUnit in 'BaseFormUnit.pas' {BaseForm},
  BaseLayoutFormUnit in 'BaseLayoutFormUnit.pas' {BaseLayoutForm},
  DevExpressDataUnit in 'DevExpressDataUnit.pas' {DevExpressData: TDataModule},
  BaseOkCancelFormUnit in 'BaseOkCancelFormUnit.pas' {BaseOkCancelForm},
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm},
  VersionInfoUnit in 'VersionInfoUnit.pas',
  CryptoServiceUnit in 'CryptoServiceUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  BaseChildFormUnit in 'BaseChildFormUnit.pas' {BaseChildForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Инструменты ВистаМед';
  Application.CreateForm(TDevExpressData, DevExpressData);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
