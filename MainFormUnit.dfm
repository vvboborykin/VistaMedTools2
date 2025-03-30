inherited MainForm: TMainForm
  Width = 884
  Height = 633
  Caption = #1043#1083#1072#1074#1085#1072#1103' '#1092#1086#1088#1084#1072
  Color = clAppWorkSpace
  FormStyle = fsMDIForm
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object ribMain: TdxRibbon [0]
    Left = 0
    Top = 0
    Width = 868
    Height = 122
    BarManager = bamMain
    ColorSchemeName = 'Office2013DarkGray'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object tabMainTabWork: TdxRibbonTab
      Active = True
      Caption = #1056#1072#1073#1086#1090#1072
      Groups = <
        item
          ToolbarName = 'dxbrHelp'
        end
        item
          ToolbarName = 'dxbrWindows'
        end>
      Index = 0
    end
  end
  inherited aclMain: TActionList
    Images = iml32
    object actAbout: TAction
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 0
      OnExecute = actAboutExecute
    end
    object WindowClose1: TWindowClose
      Category = 'Window'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Enabled = False
      Hint = 'Close'
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = #1050#1072#1089#1082#1072#1076
      Enabled = False
      Hint = 'Cascade'
      ImageIndex = 17
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = #1055#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080
      Enabled = False
      Hint = 'Tile Horizontal'
      ImageIndex = 15
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = #1055#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
      Enabled = False
      Hint = 'Tile Vertical'
      ImageIndex = 16
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Enabled = False
      Hint = 'Minimize All'
    end
    object WindowArrange1: TWindowArrange
      Category = 'Window'
      Caption = #1042#1099#1089#1090#1088#1086#1080#1090#1100
      Enabled = False
    end
  end
  object bamMain: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = iml32
    ImageOptions.LargeImages = iml32
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 304
    Top = 136
    DockControlHeights = (
      0
      0
      0
      0)
    object dxbrHelp: TdxBar
      Caption = #1057#1087#1088#1072#1074#1082#1072
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 323
      FloatTop = 117
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnAbout'
        end>
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxbrWindows: TdxBar
      Caption = #1054#1082#1085#1072
      CaptionButtons = <>
      DockedLeft = 86
      DockedTop = 0
      FloatLeft = 323
      FloatTop = 117
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btn1'
        end
        item
          Visible = True
          ItemName = 'btn2'
        end
        item
          Visible = True
          ItemName = 'btn3'
        end
        item
          Visible = True
          ItemName = 'btn4'
        end
        item
          Visible = True
          ItemName = 'btn5'
        end
        item
          Visible = True
          ItemName = 'btn6'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnAbout: TdxBarLargeButton
      Action = actAbout
      Category = 0
    end
    object btn1: TdxBarButton
      Action = WindowArrange1
      Category = 0
    end
    object btn2: TdxBarButton
      Action = WindowCascade1
      Category = 0
    end
    object btn3: TdxBarButton
      Action = WindowClose1
      Category = 0
    end
    object btn4: TdxBarButton
      Action = WindowMinimizeAll1
      Category = 0
    end
    object btn5: TdxBarButton
      Action = WindowTileHorizontal1
      Category = 0
    end
    object btn6: TdxBarButton
      Action = WindowTileVertical1
      Category = 0
    end
  end
  object iml32: TcxImageList
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 7340464
    ImageInfo = <
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000023180E305C41267F5C41267F2318
          0E30000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000045311D60B8824DFFB8824DFFB8824DFFB882
          4DFF5C41267F0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000017100A20B8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFF17100A2000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002E211340B8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFF2E21134000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000C080510AC7A48EFB8824DFFB8824DFFB8824DFFB882
          4DFFAC7A48EF0C08051000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000002E211340AC7A48EFB8824DFFB8824DFFAC7A
          48EF3A2918500000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000002E2113402E2113400000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000067492B8F8A613ABF8A613ABF8A613ABF6749
          2B8F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AC7A48EFB8824DFFB8824DFFB8824DFF5C41
          267F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFF6749
          2B8F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AC7A48EFB8824DFFB8824DFFB8824DFFA172
          43DF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000007351309FB8824DFFB8824DFFB8824DFFB882
          4DFF7351309F0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000023180E30B8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFF7351309F0C080510000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000045311D60B8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFF956A3FCF0C0805100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000045311D60B8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFF956A3FCF0C08051000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000045311D60B882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFF7E5935AF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005139
          2270B8824DFFB8824DFFB8824DFFB8824DFFB8824DFF23180E30000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000AC7A48EFB8824DFFB8824DFFB8824DFFB8824DFF5C41267F000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000C08
          0510000000000000000000000000000000000000000000000000000000000000
          00008A613ABFB8824DFFB8824DFFB8824DFFB8824DFF8A613ABF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002E21
          13407351309F0C08051000000000000000000000000000000000000000000000
          0000A17243DFB8824DFFB8824DFFB8824DFFB8824DFF8A613ABF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002E21
          1340B8824DFFA17243DF45311D600C0805100000000000000000000000006749
          2B8FB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF7E5935AF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002E21
          1340B8824DFFB8824DFFB8824DFFB8824DFF956A3FCF8A613ABFA17243DFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF51392270000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002E21
          1340B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFAC7A48EF0C080510000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002E21
          1340B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFF45311D6000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000C08
          05105C41267FAC7A48EFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFA17243DF2E2113400000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000003A2918505C41267F7E5935AF8A613ABF8A613ABF7E59
          35AF5C41267F2E21134000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object apeMain: TApplicationEvents
    Left = 368
    Top = 224
  end
end
