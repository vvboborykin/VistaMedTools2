inherited BaseChildForm: TBaseChildForm
  Caption = 'BaseChildForm'
  FormStyle = fsMDIChild
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  inherited lacMain: TdxLayoutControl
    inherited lagRoot: TdxLayoutGroup
      Index = -1
    end
  end
end
