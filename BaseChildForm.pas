unit BaseChildForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseLayoutFormUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013DarkGray,
  dxSkinscxPCPainter, ActnList, dxLayoutContainer, dxLayoutControl;

type
  TChildForm = class(TBaseLayoutForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChildForm: TChildForm;

implementation

{$R *.dfm}

end.
