object DevExpressData: TDevExpressData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 373
  Top = 124
  Height = 150
  Width = 215
  object lalLf: TdxLayoutLookAndFeelList
    Left = 56
    Top = 32
    object dxLayoutSkinLookAndFeel1: TdxLayoutSkinLookAndFeel
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.SkinName = 'Office2013DarkGray'
    end
    object dxLayoutStandardLookAndFeel1: TdxLayoutStandardLookAndFeel
    end
  end
  object locRus: TcxLocalizer
    Active = True
    StorageType = lstResource
    Left = 112
    Top = 32
  end
end
