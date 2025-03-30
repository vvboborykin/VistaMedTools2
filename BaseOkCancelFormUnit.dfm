inherited BaseOkCancelForm: TBaseOkCancelForm
  Caption = 'BaseOkCancelForm'
  PixelsPerInch = 96
  TextHeight = 19
  inherited lacMain: TdxLayoutControl
    object btnCancel: TcxButton [0]
      Left = 457
      Top = 320
      Width = 100
      Height = 43
      Action = actCancel
      Cancel = True
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton [1]
      Left = 329
      Top = 320
      Width = 120
      Height = 43
      Action = actOk
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    inherited lagRoot: TdxLayoutGroup
      Index = -1
    end
    object lagButtons: TdxLayoutGroup
      Parent = lagRoot
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object layCancel: TdxLayoutItem
      Parent = lagButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layOk: TdxLayoutItem
      Parent = lagButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnOk
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object sepButtons: TdxLayoutSeparatorItem
      Parent = lagRoot
      AlignVert = avBottom
      CaptionOptions.Text = 'Separator'
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      Index = 0
    end
  end
  inherited aclMain: TActionList
    object actOk: TAction
      Caption = 'OK'
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1072
      OnExecute = actCancelExecute
    end
  end
end
