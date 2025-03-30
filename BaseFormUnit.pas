{*******************************************************
* Project: VistaMedTools2
* Unit: BaseFormUnit.pas
* Description: Базовая форма приложения
* 
* Created: 30.03.2025 7:12:01
* Copyright (C) 2025 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit BaseFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList;

type
  TBaseForm = class(TForm)
    aclMain: TActionList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
