inherited BaseChildForm: TBaseChildForm
  Left = 405
  Width = 555
  Caption = 'BaseChildForm'
  FormStyle = fsMDIChild
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  inherited lacMain: TdxLayoutControl
    Width = 539
    inherited lagRoot: TdxLayoutGroup
      Index = -1
    end
  end
end
