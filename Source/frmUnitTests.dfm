inherited UnitTestWindow: TUnitTestWindow
  HelpContext = 467
  Caption = 'Unit Tests'
  ClientHeight = 451
  ClientWidth = 262
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    0000000000060D00004E3C1603802A1104740000002C00000000000000000000
    0000000000000000001E250F036C3D1904830F00005B0000000E000000000000
    000048120083FF6F1EE9FF8E3FEAFFAF6AEBB47A57CD00000028000000250000
    002400000015A7714DBDFFB471EBFF9143EAFF7521EA5519009B000000050000
    0028F16E24E1F97122E2ED7A35DBEE9A5EDCFFC896E2344040B4001626EB0011
    23DF2A2B2B96FFCA9AE2EE9E64DCED7F39DBF77123DFFB7528EA020000420600
    003CFF9144ECE66A22E4EA7A36DCED985CDAFFB78DDB72B8C0F600DBFFFF00CA
    FFFF64AABCF4FFBD90DBED9C61DBEA7F3BDCE36921E2FF9448F20F0000560000
    000BB36635C1FFAE6AFDDF7936E0F1975AD9EAB790E09CA59CFD000B11FF0009
    11FF909E9AFBF2BD96DDEE9C5FD9DC7E3BE1FFA962F8C07541D3000000190000
    00000000001EAE724CBEFFC590FED49A67E7D8AE8AE7B8A798FF1A2C2AFF0F21
    1FFFB4A296FEDEB596E5D09C6AE8FFC18BFBB37A58CC0000002C000000000000
    00000000000000000010966243B0FED4AAFCB5B39CF8CDDFD8FF62F5F7FF53E9
    F5FFC5DBDBFFB8B4A0F5FFD3A2F6A07152C10000001B00000000000000000000
    000000000000000000000000000EAE7855B7E9E6D4FFB4D5DBFF94EAFBFF7EDE
    F7FFACD5DEFFEDE3CAFABD8864C7000000190000000000000000000000000000
    000C0000002D00000A560000003D00020967B7B8B8FAE5FEF2FF33C5EEFF25C0
    EEFFDEFEF7FFC8C5C0FB00060E780000044700000D5C000000310000000C0000
    002600000035000000240000093E00000B500009197CC0D0D5FD77E3F9FF6EDF
    FEFFCDD8DBFE000B167E00000647000000330000001E00000B310000001E0000
    0000000000000000000000000000000000120005318102305CB73DB7FFFF41C0
    FFFF063C6EC9000023820000000F000000000000000000000000000000000000
    0000000000000000002E0000116000052A7D0000003600174AAB00B5FFFF00A7
    FFFF00113CA90000023B0004267300000D590000002F00000000000000000000
    00000000001900000E53000000180000000900000005021135CA2478B3FF236F
    AAFF000924B700000002000000090000001600000E5400000017000000000000
    000000000430000000180000000000000000000000000000001C0000167C0000
    117B000000190000000000000000000000000000001B0000002C000000000000
    0000000000040000000100000000000000000000000000000030000000230000
    0026000000310000000000000000000000000000000100000004000000000000
    0000000000000000000000000000000000000000051400000021000000000000
    000000000022000000150000000000000000000000000000000000000000C3C1
    00008001000000000000000000000000000080010000C0030000E00700000000
    000000000000F00F0000C00300008C3100009C390000FC3F0000F99F0000}
  ExplicitWidth = 278
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 13
  inherited BGPanel: TPanel
    Width = 262
    Height = 451
    ExplicitWidth = 262
    ExplicitHeight = 451
    inherited FGPanel: TPanel
      Width = 258
      Height = 447
      ExplicitWidth = 258
      ExplicitHeight = 447
      object ExplorerDock: TSpTBXDock
        Left = 0
        Top = 0
        Width = 258
        Height = 26
        AllowDrag = False
        DoubleBuffered = True
        object ExplorerToolbar: TSpTBXToolbar
          Left = 0
          Top = 0
          Align = alTop
          AutoResize = False
          DockMode = dmCannotFloat
          FullSize = True
          Images = vilImages
          TabOrder = 0
          Caption = 'ExplorerToolbar'
          Customizable = False
          object tbiRefresh: TSpTBXItem
            Action = actRefresh
          end
          object tbiClearAll: TSpTBXItem
            Action = actClearAll
          end
          object TBXSeparatorItem2: TSpTBXSeparatorItem
          end
          object tbiRun: TSpTBXItem
            Action = actRun
          end
          object tbiStop: TSpTBXItem
            Action = actStop
          end
          object TBXSeparatorItem1: TSpTBXSeparatorItem
          end
          object tbiSelectAll: TSpTBXItem
            Action = actSelectAll
          end
          object tbiDeselectAll: TSpTBXItem
            Action = actDeselectAll
          end
          object tbiSelectFailed: TSpTBXItem
            Action = actSelectFailed
          end
          object TBXSeparatorItem7: TSpTBXSeparatorItem
          end
          object tbiCollapseAll: TSpTBXItem
            Action = actCollapseAll
          end
          object tbiExpandAll: TSpTBXItem
            Action = actExpandAll
          end
        end
      end
      object SpTBXSplitter1: TSpTBXSplitter
        Left = 0
        Top = 269
        Width = 258
        Height = 5
        Cursor = crSizeNS
        Align = alBottom
        ParentColor = False
        MinSize = 1
      end
      object Panel1: TPanel
        Left = 0
        Top = 26
        Width = 258
        Height = 243
        Align = alClient
        TabOrder = 1
        object UnitTests: TVirtualStringTree
          Left = 1
          Top = 1
          Width = 256
          Height = 241
          Align = alClient
          BorderStyle = bsNone
          Header.AutoSizeIndex = -1
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          HintMode = hmHint
          Images = vilRunImages
          IncrementalSearch = isAll
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toInitOnSave, toWheelPanning]
          TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnChange = UnitTestsChange
          OnChecked = UnitTestsChecked
          OnDblClick = UnitTestsDblClick
          OnGetText = UnitTestsGetText
          OnGetImageIndex = UnitTestsGetImageIndex
          OnGetHint = UnitTestsGetHint
          OnInitChildren = UnitTestsInitChildren
          OnInitNode = UnitTestsInitNode
          ExplicitLeft = 2
          Columns = <>
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 274
        Width = 258
        Height = 173
        Align = alBottom
        TabOrder = 2
        DesignSize = (
          258
          173)
        object Bevel1: TBevel
          Left = 8
          Top = 58
          Width = 242
          Height = 5
          Anchors = [akLeft, akTop, akRight]
          Shape = bsTopLine
        end
        object Label2: TLabel
          Left = 7
          Top = 62
          Width = 73
          Height = 13
          Caption = 'Error Message:'
          Color = clNone
          ParentColor = False
          Transparent = True
        end
        object ModuleName: TLabel
          Left = 7
          Top = 1
          Width = 88
          Height = 13
          Caption = 'No Module Loaded'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbFoundTests: TLabel
          Left = 172
          Top = 1
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Found 0 tests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lblRunTests: TLabel
          Left = 7
          Top = 19
          Width = 55
          Height = 13
          Caption = 'Run 0 tests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lblFailures: TLabel
          Left = 7
          Top = 37
          Width = 96
          Height = 13
          Caption = 'Failures/Errors : 0/0'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object SpTBXPanel1: TPanel
          Left = 1
          Top = 85
          Width = 256
          Height = 87
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'SpTBXPanel1'
          TabOrder = 0
          object ErrorText: TRichEdit
            Left = 1
            Top = 1
            Width = 254
            Height = 85
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Shell Dlg 2'
            Font.Style = []
            Constraints.MinHeight = 10
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            Zoom = 100
          end
        end
      end
    end
  end
  inherited DockClient: TJvDockClient
    TopDock = False
    BottomDock = False
    Top = 48
  end
  object DialogActions: TActionList
    Images = vilImages
    Left = 152
    Top = 48
    object actRefresh: TAction
      Category = 'Commands'
      Caption = '&Refresh'
      Hint = 'Refresh tests|Extract tests from active module'
      ImageIndex = 3
      OnExecute = actRefreshExecute
    end
    object actRun: TAction
      Category = 'Commands'
      Caption = '&Run'
      Hint = 'Run selected tests'
      ImageIndex = 5
      OnExecute = actRunExecute
    end
    object actStop: TAction
      Category = 'Commands'
      Caption = '&Stop'
      Hint = 'Stop Testing'
      ImageIndex = 4
      OnExecute = actStopExecute
    end
    object actSelectAll: TAction
      Category = 'TestTree'
      Caption = 'Select &All'
      Hint = 'Select all tests'
      ImageIndex = 6
      OnExecute = actSelectAllExecute
    end
    object actDeselectAll: TAction
      Category = 'TestTree'
      Caption = '&Deselect All'
      Hint = 'Deselect all tests'
      ImageIndex = 7
      OnExecute = actDeselectAllExecute
    end
    object actSelectFailed: TAction
      Category = 'TestTree'
      Caption = 'Select Fai&led'
      Hint = 'Select all failed tests'
      ImageIndex = 8
      OnExecute = actSelectFailedExecute
    end
    object actExpandAll: TAction
      Category = 'TestTree'
      Caption = 'Ex&pand All'
      Hint = 'Expand all test nodes'
      ImageIndex = 1
      OnExecute = actExpandAllExecute
    end
    object actCollapseAll: TAction
      Category = 'TestTree'
      Caption = '&Collapse All'
      Hint = 'Collapse all test nodes'
      ImageIndex = 2
      OnExecute = actCollapseAllExecute
    end
    object actClearAll: TAction
      Category = 'Commands'
      Caption = '&Clear All'
      Hint = 'Clear all tests'
      ImageIndex = 0
      OnExecute = actClearAllExecute
    end
  end
  object icRunImages: TImageCollection
    Images = <
      item
        Name = 'UnitTests\Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000524944415478DA63FCFFFF3F032580717019F0E8D1A398AB57AF3AE0
              D3A0ADADBD5F4E4E6E295603B66FDF3EC7C6C626199F01478E1C99EBE9E99932
              6AC0F035009890A28109C9119F017813123960E00D00006F7B7FE192F60CCF00
              00000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F80000005F4944415478DA63FCFFFF3F032D01E3A80583D382FEFEFE1D5FBE7C
              1127C5202121A1A7D9D9D93E4459D0DCDC7CBEA0A0C080140B264C9870A1B6B6
              D670D482510B462D18B5805A164C9D3A75CBBB77EFA449B180A4C28E9A60D482
              81B700007AF8B7D1B079C78D0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F4000000974944415478DA63FCFFFF3FC34002C651078C3A60D03A0028CEFCE7
              CF1F794A2D606262FAC9CCCCFC946407FCFDFB57CAD4D4F4B69696D6374A1C70
              EDDA35AE3367CE28021DF28A64076464649CEBEBEB13A7C4014545452F67CC98
              61040C8567A30E1875C0A803461D30EA8051078C3A606839E0DFBF7F62262626
              F707AC41020D0569A043D8297100D94D327A8151078C3A60C01D0000790A47D0
              A3691BD70000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnitTests\Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000534944415478DA63FCFFFF3F032580717019F0FCF9AB98FBF73F38E0
              D3A0A424B85F4242742956038E1DBB35C7DA5A2D199F01478FDE9A6B65A59632
              6AC0F035E0C58BD7D1F7EEBD77C46700DE84440E18780300BA3F7FE197CD8EC5
              0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F80000005E4944415478DA63FCFFFF3F032D01E3A80583D38233676EEDF8F081
              4D9C148304047E3D353151F321CA823D7B1E9C7775553020C582DDBB1F5C7071
              51301CB560D482510B462DA09605C0C26E0BB0B09326C502920A3B6A82510B06
              DE02001DFFB7D127B34C0F0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F4000000964944415478DA63FCFFFF3FC34002C651078C3A60D03A0028CEFCF7
              EF5F798A2D6064FCC9CCCCFC946407002D977AFFFEE7ED5BB77E7CA3C4016A6A
              1C5C42421C8A4C4C4CAF4876C09123EFCF3938888853E2800307DEBCB4B11134
              0286C2B351078C3A60D401A30E1875C0A803461D30B41CF0EFDF3FB177EF7EDC
              1FB006093414A481F2EC943880EC2619BDC0A803461D30E00E000014D247D02F
              AC847B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnitTests\Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000534944415478DA63FCFFFF3F032580717019F0FCD5F398FB1FEE3BE0
              D3A024A8B45F4254622956038EDD3A36C75ACD3A199F01476F1D9D6BA5669532
              6AC0F035E0C5EB17D1F7DEDF73C46700DE84440E18780300BA3F7FE1F94D2B7C
              0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F80000005E4944415478DA63FCFFFF3F032D01E3A80583D38233B7CEECF8C0F6
              419C1483047E093C355133F121CA823D0FF69C7755703520C582DD0F765F7051
              70311CB560D482510B462DA09605C0C26E0BB0B09326C502920A3B6A82510B06
              DE02001DFFB7D1A0CE8D2D0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F4000000964944415478DA63FCFFFF3FC34002C651078C3A60D03A0028CEFCF7
              EF5F798A2D6064FCC9CCCCFC946407002D977AFFF3FDED5B3F6E7DA3C4016A1C
              6A5C421C428A4C4C4CAF4876C091F747CE3988388853E280036F0EBCB411B431
              0286C2B351078C3A60D401A30E1875C0A803461D30B41CF0EFDF3FB1773FDEDD
              1FB006093414A481F2EC943880EC2619BDC0A803461D30E00E000014D247D0E2
              F430C30000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnitTests\Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000001DE4944415478DA63FCFFFF3F032580119F01AB572F9A77E3C645B59A
              9A1E174646C61F2419B07EFDB259BF7F5747686A3EE7DEB021F3444D4D1FC890
              EF441900D31C16F68017C4BF7C99FD1F2E43300C00399B89A93E243818A21906
              2E5CE0FCBB654BE6F19A9A5E5B9C06C0340705423503A560D21B36CA7EFDFDA7
              694D787842025603D6AF5B36EBC7FBEA086F674CCDDBF60135B3566D8A8BCF88
              C21906BB776FEBB975BC2839C0E1A600035423486AF729D9AFD72FB9DDE3F8C6
              C350B3A22B848D8DED164E2FECDFB7ABE3CCD6FC745F831B0220E1C3D765BFDE
              7DE47E4F60B7B412DF6B51EE8F7E4FAF16AFAA0F656767BF8E331041869CDE98
              9FCECFFE95F5C24FF7FBEC071825532FE50B33323032FC03C2A3013BAE24AECC
              0B86B9046B34EEDABEA56FF39E6D4E6BE233543EB1B07196452CFA507BB94588
              898109E8BBFF0C0B4AA7EC49ECCA75C569C09EE3C75BA379780A5EE9EA7281F8
              725BB67E2D9A7AE169CE8E72B5E51173CE472C4E096061617984D580EB376F65
              04DD7BDEFB56439F8B11282572EBEAD7E982ACBD36A6265397B7CC9E1B5E959C
              09D4FC04671800F9ECBD7316AE5B2164ECC5FDFED9F77A75EE894EB636950C38
              00562F00C538DBA6CEDE6867AC7FDCD6D2BC9E010FC0999980E24CC074FF8F81
              000000FFA106F0F77649CE0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000003164944415478DA63FCFFFF3F032D01232916FCFCF953F3CD9B375AD2
              D2D26BA96EC18F1F3FB43D3DED0FFDFDFB9163E6CC75259A9A5AD3A96601D0E5
              1A5E5EF6472A2A2E0A1918FC608C8BD3F9DCD9B9A4564F4F7F22C516201BEEEA
              FA831124F6FA350303B196E0B5009BE13040AC25382DC06738299660B50018A1
              3A1E1EB687EAEB2F0B383AFEC46A380CAC59C3F9BFBF5FE7C391232785191919
              FF13B400E6F2F2D28B42CE8E482EFF0F465002421F3AC2FEBFA955F7C38E9D87
              ED3938382E13F401D8704FFB23451917851C6C7E30FE47320CC51220387A82FD
              7FFB64DD0F3B77E1361CC382AACAD2C3FF3ECFB12A49FBC0043309C58350F6B1
              73ECFF7B66AB7F0A700E3C51D4521F000C9A1F4459F0E7CF1F593F1FD793FE96
              67C5BC6C3E33630B9A9397D9FF4F5CA9FE499747ED35CB417E25890CA1A35593
              3BDD81967C272A92C19678BB9EF4D43B2BE66E8C6AC9999BECFFA76F53FFA4CF
              ABF15A729F960A3B0317C347D6D77F39D3188EE1B2046B2A0259E20BB4C45DED
              AC98AB01C492B377D8FFCFD8ABFE59F3AFDC179F73F1521C0CDC404B21F035EB
              D3BFAF331F1D2999D0EC811E5C38F301B225423CBF98661ED0FC24666AFBFAC3
              915BD2797762998C3FDBB2FF6740C047ACF7FE9E4E3B70AC7872138A4FF0E664
              A02572404B4E7CFCF4814B1C68F886A62615063E3E065713BFEF8DB70A992DBF
              3AB321ABBFC37AF5EFAED2CD7BB25A2B3C88B20004BE7EFD6A1C5D51B162636B
              2BD87030F8F78FC1CDCCFF5BCDAD5C66DBCF6EEC602120ECB6A87894B1BD3A96
              5F80FF105116FCFDFB5722AEBE7ECFB2B2326DB8E150A0B568D1BBC0BDE71F7A
              6CF552B77AEBCC85CD70BC16FCFBF74F34A1BA76DF96A41C9DFFDCBC0C8CD0A4
              042A0C9436AF7ED76FA835D1DADCBC79F984392BAE2C3B6555B1A7278A8F9FFF
              3051A9086A8150664DFD9EBD4E91864CBC02F0B42A7160D3BB3607C389361616
              4DE014FCFF3F23D0A7B22C2C2C8FB099833788809608E654D6EE3DA3EE6DC8C2
              27C8C07B61F7BB3A6FB389D69610C389010423196889484E45EDAE9B7FB8149B
              429DFB49319C280B6096DCB97B37404D55750E2986136D012500008713D4E0EA
              1F74C00000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000042B4944415478DA63FCFFFF3FC34002C621EB00A03EC6952B57CE5CB0
              608EF7E6CDDB6D595959EFD1CD0120CB972F5F36BBB5B5264E5DFD17E3972FAA
              6FB66EDD6D4D8E23487600C8F2B56BD74CABAF2F4B5EB2E409AB8ECE1F86E464
              A9DFCF9E29BFDBBE7D2FC8117769E60074CB0D0DFF80C57FFF6620DB11443B00
              97E53040AE2388720021CB2971044107106B39B98EC0EB00586A6F69A98A5FBA
              F4190B21CB61E0E74F0686A828A93F5FBF6ABEDABE7DB71C2323E35F921D809C
              D588F13932B8708199212646F6776565F3E2E8E8986492430039D817CE7DC26A
              A00FB5FC3FB21A744D10EACA556686F814D9DF25A50DCB6263E39280BEFF4792
              03E096D79525CF99FC84555FFB0FC2FCFF9816223BE6EA0D66869402D9DFA544
              5A8ED501DBB76FEB292ACCCA9FD9F9944557E30F8685B81C72E526334366B5EC
              EFA4B8F49D45E5E5FEC4588ED501E7CF9F2F0A0AF2EFEA287EC9EC60F68B389F
              DF6166C86F97FDED6EE97AF1F2F6FDEAA5D37AE7B805F81591E500103873E64C
              696868507B53C64B667BA35F787D7FF3213343D144D9DF1ED6EE179EEDBBA5AC
              72CF5AE891ECF98F011D31CB03A22232C97200DC112141ED75312F996DF47F61
              F5FDAD27CC0C157321963FDF775B59EB9EA310D048B0FC1DD9E31FFD897004DE
              7200E688CAA097CCD6DABF50E46E3F6366A85906B4DCC6E3C2BB7D0F959DEF45
              0931323041DD09812764B77C74E908043A223C932C07E07204CC720B6BC7EB57
              176FD2EEF8B59A998D8103C572187BBDDCEC0FEE1343E6BB05F81691E5007447
              8809FE055BEEE4EA7BE1F0FFFFCAEF0424F82C7AB732747F5FC6C2CAC08E6239
              0C2E90EDF9A8DF61BDDC2F2A2C932C0780C0F1E3C7ABA322C31BD9D998FEBB7B
              F99F3BF4F79FCA85FE7E2106161606B9EAC6BF36FDFBFECFFBBE83859D8113AB
              FE76B9A20FD6B3BCA7DBB93B5791E500982396AF5CE17718C9721890A969FC6B
              DBB7FBFFFCEFBB311CF197E10F438542E2FBE4CD15351A3ADAD3C876C0E973E7
              CA52972C29BFD8DD2DC4C0CC8C212F5755FFC766D2C1FFF3BE6E678539E21FD0
              FA2AA5E47751ABF25BF58C0DFBC88E8233E7CE95A6012D3FDFD52D0CB1FC3F22
              5B82E83FBF19F48B0ADF5759DBAE3DD0B83CA0F7D632117660C2C46739D10EB8
              70E95241EAF499B5376BDB85185998E11633C24AA6BF7F19D45A6BDE4D4F4D6A
              373634EC79FAF871589747D164B66FECAC491B2BEA34F574A6E0329B980609B3
              BDBBE7B37BC5CD624C320A48964353FB9F3F0CD2939BDECD2ACA69D0D5D1990C
              D3F7ECC99390AF5FBE0AAA6AA8CFC6673E5121F0E7CF1F79FF98D843F77D32E4
              98A5E5A13E075A0EF4B9C092EE77130AD2C13E272A2EC97100CC110191B1875E
              DA27C8B189CB31FCFFF797816DF3A477BDC599645B4E9203A08E50003AE2E04B
              DB5839EE531B28B69C640780C0AF5FBF549C3DBC8F4D9BD4DF8C1CE774730008
              00F570031B1C5F29B59C6C07501300002818B7DF4184F1050000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'UnitTests\Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000534944415478DA63FCFFFF3F032580717019F0EAF9F3980FF7EF3BE0
              D320A8A4B45F5442622956036E1D3B3647CDDA3A199F01B78E1E9DAB66659532
              6AC0F035E0F58B17D1EFEFDD73C46700DE84440E18780300BA3F7FE121D6554A
              0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F80000005E4944415478DA63FCFFFF3F032D01E3A80583D3825B67CEEC60FBF0
              419C14837E09083C553331F121CA82077BF69C5770753520C58207BB775F5070
              71311CB560D482510B462DA09605C0C26E0BB0B09326C502920A3B6A82510B06
              DE02001DFFB7D1D1D578620000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F4000000964944415478DA63FCFFFF3FC34002C651078C3A60D03A0028CEFCF7
              EF5F798A2D6064FCC9CCCCFC946407002D97FAF9FEFDED1FB76E7DA3C4011C6A
              6A5C1C42428A4C4C4CAF4876C0FB2347CE8938388853E28037070EBC14B4B131
              0286C2B351078C3A60D401A30E1875C0A803461D30B41CF0EFDF3FB11FEFDEDD
              1FB006093414A481F2EC943880EC2619BDC0A803461D30E00E000014D247D065
              45168F0000000049454E44AE426082}
          end>
      end
      item
        Name = 'UnitTests\Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000002494944415478DA63FCFFFF3F030C00D92CAF5EDC8B1297545EC44024
              60841900D27CFB4CFB1A19A93ED7A76F272F54D58BCC22DA002066BE7DB6638D
              9246A30F0BCF4F96EFAF05BF3F793A6189AA415C1A4103FEFDFB07B4B9659DB2
              76B31733D76F6698C49B2BBA2FF8D44E3BB1B1B15F07F1EF5F3953F2E1D47A0F
              83C4163F4646C66F70036E1C6FDA2425D6ECC5C00AD40CF20D107F7AADFD9249
              624D8DA48CC61C88E6D3A55C5B4BAB45D9BFF15FE2B43DA29FD6E30934E40BD8
              809BE7564D667F9399C4F0FF2D1748F3BFBFC2DFCFBF8ABDF4E09DEC176565E5
              3B9CAFAF29E9BDDB6D2AC1F14D00A4E1EF9F3F0CD734F3E7E87AC6A6C2C3E0D6
              B93593FEDEC848666213FCFE4DB271CB7F4E8DA7A74F9FB63692E57BA870AA27
              4894E5330FC869FFFEFE67B8241DB24F3FB9DD17E60D782CDCBEB0BE9F5744EB
              8A848CFADC4F9F3E39ECD9B327C6D7D7B7FD566FF47AED675B74FFFD6360B8A4
              9E74443F6732DCF928062003980141414129BF7EFD52BBDD1DBEF6B790D22BFD
              8C1E5FE40024CA0010FFCF9F3FB2CCCCCC9F569E38D1166E61510134E4334906
              00D5B0D6EDD9B3B1D5D2D223E3D8B1A3535D5DBD81867CC267807D6161E14C3B
              3BBBAB7FFFFF679AFFEF9FD9D1A828C9FF1C1C8C0C7FFF3214EDDEBDAFD7C3C3
              19A701A064FDFEFD7BF7BF7FFFB2B59E38593AC7D4D682818D8D9111A854EECE
              F577ABC485AAB5151466E03400C920B6E6AD3B372CE553F764666461107CF7E0
              DD6C3D996A2D45C51978C300CD108ED64DDBD7EDFBC86231C556B50A59335106
              C00C79FDEEBD9398B0D03674390050B939F0F945A1020000000049454E44AE42
              6082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000003794944415478DA63FCFFFF3F0336F0E7CF1F79161696870C1402466C
              16BC7BF33488F196C3AC375CCD2B550D22B2A96AC1FBB7CFFDFFDE7799256274
              4DECE36DB90FAFBE35AF56358C4BA38A05C886333041C43EDEA4CC12B805A060
              F9F7C07D9A88F15571064654451F6FCA7E7CFDB36F918A5E481EBA01EF5FBFF4
              E1171239CDC4CCFC12A705F80C07819FCF797F3EBA9F7158D5AACB1559FCE9BD
              9B295FE725B67D65177DA75FB5CE1E9B258CEFDE3CF3FF73DB65168FE235B1FF
              20C3612106A4419EFBF389F7E7AB37E94754ACBA3C1919197FC3343EBB7F2BE9
              CBBCE47635D1DF627F7EFF66B8FC45EA965ECD06076666E6E728163CDB67F688
              5DE094EC5F06888130C3C1D44FDE9F1FFFA51E55B5EEF1C065384C0C6CC93799
              9B7A55EB1C912D61FCFDFBB7FCB3832EFB187E1C54FAF30F61382B23D3FFB75F
              15BF2F3EE5F5EEF59B0F82121212CF40E2F23FEE72BBF13DE35415FB2F881E1C
              F75FFDFBC09EBCA4584A516D1E4A1C8032D5D37D2EFB7E3E3FA8F4FB0F03033B
              37F7AF3F022E8FFEC9B5CE7BF6ECB9FEBE7DFB5C626363BBDEDD38692A76B4C7
              4355E43F0F240C19E05E7EF88DF7DD2FBFAEC9AAA60E0D585311D08B4ACF0E38
              EFF9FFF19CF40FD1B4A36A76BDEEA06079FAF4695C474747EDE4C99355CF4C2D
              38A07D7FA52D27CB7F26B80940FD0FFE8BBDFB133665A28A897D13CE640AB3E4
              EE8525D56A260919B03047B600A896FDECF4E2ED9A9766DA7133FD6606BB9C5D
              E1DDAFA85940973B363060018CB8CA22785244B200E2E0FFECE7A615EED0383F
              CDF60D97ECC75FB173701A4E9605504B38CF4ECEDD296015BA075BB0506C0132
              B8F3F87142E6DEBD55DB63625C80A5EF23AA5A70F7C993B8E04B973A2EBABA4A
              BAAC5B777B5B5090072B2BEB3DAA580037DCCB4B122C00CC68D82C2168C1F3E7
              CFA32C2C2CE67B7878BC8589DDE3E1E13CE6E0C0FBCDD7971945F1CF9F0C9E2B
              56DCD8161FAF49B40540798E870F1FC6FEFDFB9705C43F75FF8179F5E72F814F
              DCBDF818FF831540CAC77FFF19F4F6EE78BAD9CE26435C58780BD1162083BFFF
              FE899BCE5B74E1859D9F04DCE0FF2043FE31C85F38F474BD9B439A98B0F03692
              E2001D9CBF75AB20F7D4B5CA4F9206628C20D3812E177A7AFAE90A1F970C7111
              84CBC9B6006CC9CD5B0585872F57FEE6D314E3FC78F1E9D24037AC86936D0108
              9CBB79AB3067F7C1920D9141A9E8C142150B4000A8570058667DC0A706003D10
              15EF63EDF90E0000000049454E44AE426082}
          end
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000047D4944415478DAC5956D4C1B651CC0EFB8BE494B5B5A4B670F2896A1
              31050965C29C9B0B2306B761C56C98980D5C115C4C5C48FC32BF6830247E32F1
              8B43A60667C822224B3663DC5871C39641A92201716313182DD71747D96869AF
              F4E5AEDE95DEB8762D655B8BFFE4E9DD3D2FFDFD9EE7FFDC3D60281402FECF00
              930910ED421CC77810C440B65C00C771B16DE8150307B00AF83B27763359AC5B
              5B2640CEDCA2DF6F9016EA140CDE2AE3DE44D112AF72722F8BCDBE9E76013A9C
              097B99E13A27184A87C40302F1E0F7DBD220112540E6DCAAAF19916EBF56100B
              A74BDC9D7CD6C1AF4CBC27508FBB92EC9AC9E519372D406D3812CE90F9180947
              E000E01E93BA9D39DA0F6179C9A9D866B7CBB97BB6ADEA1C08E0A0A2EDB7433C
              BE409F54805C7644B7DF20C9D729A09CC8CCA98509ADDF9270EFCD3CA723B3F3
              7461F1819389E0C5B91939E4F37524B828FFE8CA5BFC6CD1AF0905300CCBB6EA
              6A46F94F5E2B0078D1F0104D822CF8BFB0EBAEE0ABCE647088B1B68058309854
              02F4FB7CCF78868B46B127CCC22018038EC0C96AA60F76DD136F1E4E45328970
              0A56BD68997BA454EBF3CD88FD58F4D293703E93850FDF7EC179F59F0A97DD6E
              DF46849DC160F8C96ED9FE3B9C8381A16CA542C88398F1B70E62F7A04B2F7EF0
              43E96B9AA6B802648425864BB54EFB8C78D51769248A44CA0BDC40EB671C50ED
              A4C3E178BAB7B7B7A2BEBEDE2891486E630EB3A4E8F7CF7695140A391004452F
              5BE4625BC6508BE20D7DF93BEDB5200806130A44495867C4BE00008865794E77
              EEFA86B3582C1AB95CDE6532993452A97470AA55F94789D02B8658113846DFBD
              447F0FCB632F3E32A83AF6F1EB041C03E2C4031F22AFD7B3031D79BE1F087858
              CB7057073DE77401994CD63DF65DFBF9A7C6BBAA60E60A37FA750901B6200FB5
              288F0E95B77C7A30DECC130A50120EDBCD3D790AD5E7F47ABA000CC36788B1D0
              D81942C2D85105030EEE9A00010745A8A5AC39293CA140A2881508E32809C317
              5530BEC8B54162D4A26AD9143C250294C49FDF7E72813FD2B9D7B5F3B84ED5D4
              A64E94F3B408501276D36CC336796137095FB0DBDFCC954A2F12F72B5B22408F
              81F1F1F6A6E9E9133BFC7EF3B9C6C697369248B9C0D58989B666B3F9C45C6DAD
              083299F03A9D6EEAC786863D84842BED02743800AE7DD7A1F9F90D251E5A203F
              3FBFABAFAFEF172E976BA5B7FDBCB050FEBD48F49CA3AE8E43C1A980E6E670B5
              5EFF77BC743C94008AA215ADADAD171004C9A4D7CF1614B0E7F6ED6361870F83
              B1F070ACAC00653D3D56A346B38B38434C8F2C4006D13F93286CEA593B3E7EF2
              7DD3C2BB96AA9A6C120ED28E7090F809A128A0BC741ED11D3D7280C3E1FCF558
              29888D6597EBE5B2B33D3FAD561F1280E1A32B74FFF826AF98D703E48FF65B74
              C71A5E25E053F1FEE3B10488B1E097DA81EE537750355EA0CA5A9F7D08C002AB
              80F8D6207245D31877E62911A0243A2F6BBBBF36AFA8D922651639FB40D007B0
              170DC840F3DB1BC253224097F866DEA58604DBB3588BA3C8404B7278CA042889
              8EFECB674FDF98AE36BE77BC3A51CED32640491045949191B1B4D93129157894
              F80F322AF0DFEC0C0ADE0000000049454E44AE426082}
          end>
      end>
    Left = 16
    Top = 112
  end
  object vilRunImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'UnitTests\Item1'
        Disabled = False
        Name = 'Item1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'UnitTests\Item2'
        Disabled = False
        Name = 'Item2'
      end
      item
        CollectionIndex = 2
        CollectionName = 'UnitTests\Item3'
        Disabled = False
        Name = 'Item3'
      end
      item
        CollectionIndex = 3
        CollectionName = 'UnitTests\Item4'
        Disabled = False
        Name = 'Item4'
      end
      item
        CollectionIndex = 4
        CollectionName = 'UnitTests\Item5'
        Disabled = False
        Name = 'Item5'
      end
      item
        CollectionIndex = 5
        CollectionName = 'UnitTests\Item6'
        Disabled = False
        Name = 'Item6'
      end>
    ImageCollection = icRunImages
    Left = 88
    Top = 112
  end
  object vilImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 14
        CollectionName = 'Item15'
        Disabled = False
        Name = 'Item15'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Item29'
        Disabled = False
        Name = 'Item29'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Item30'
        Disabled = False
        Name = 'Item30'
      end
      item
        CollectionIndex = 39
        CollectionName = 'Item40'
        Disabled = False
        Name = 'Item40'
      end
      item
        CollectionIndex = 40
        CollectionName = 'Item41'
        Disabled = False
        Name = 'Item41'
      end
      item
        CollectionIndex = 51
        CollectionName = 'Item52'
        Disabled = False
        Name = 'Item52'
      end
      item
        CollectionIndex = 104
        CollectionName = 'Item105'
        Disabled = False
        Name = 'Item105'
      end
      item
        CollectionIndex = 105
        CollectionName = 'Item106'
        Disabled = False
        Name = 'Item106'
      end
      item
        CollectionIndex = 106
        CollectionName = 'Item107'
        Disabled = False
        Name = 'Item107'
      end>
    ImageCollection = CommandsDataModule.icImages
    Left = 152
    Top = 112
  end
end
