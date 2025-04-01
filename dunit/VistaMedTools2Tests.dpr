// Uncomment the following directive to create a console application
// or leave commented to create a GUI application... 
// {$APPTYPE CONSOLE}

program VistaMedTools2Tests;

uses
  TestFramework {$IFDEF LINUX},
  QForms,
  QGUITestRunner {$ELSE},
  Forms,
  GUITestRunner {$ENDIF},
  TextTestRunner,
  JsonObjectSerilizerUnitTests in 'JsonObjectSerilizerUnitTests.pas',
  JsonObjectSerilizerUnit in '..\JsonObjectSerilizerUnit.pas',
  DJson in '..\DJSON-main\src\DJson.pas',
  TestObjectUnit in 'TestObjectUnit.pas',
  CryptoServiceUnit in '..\CryptoServiceUnit.pas';

{$R *.RES}

begin
  Application.Initialize;

{$IFDEF LINUX}
  QGUITestRunner.RunRegisteredTests;
{$ELSE}
  if System.IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
{$ENDIF}

end.

 