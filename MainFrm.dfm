object MianForm: TMianForm
  Left = 0
  Top = 0
  Caption = 'QQ'#24037#20316#21161#25163
  ClientHeight = 174
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnTest: TButton
    Left = 296
    Top = 142
    Width = 75
    Height = 25
    Caption = #27979#35797
    TabOrder = 0
    OnClick = btnTestClick
  end
  object medtMeeting: TMaskEdit
    Left = 105
    Top = 9
    Width = 50
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 1
    Text = '  :  '
  end
  object mmMeetingMsg: TMemo
    Left = 18
    Top = 35
    Width = 185
    Height = 89
    Lines.Strings = (
      #24320#22805#20250#12290)
    TabOrder = 2
  end
  object medtWeather: TMaskEdit
    Left = 315
    Top = 9
    Width = 50
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
  end
  object btnFeedback: TButton
    Left = 414
    Top = 142
    Width = 75
    Height = 25
    Caption = #21453#39304#22788#29702#20154
    TabOrder = 4
    OnClick = btnFeedbackClick
  end
  object mmFeedbackMsg: TMemo
    Left = 234
    Top = 35
    Width = 255
    Height = 89
    Lines.Strings = (
      #12298#34892#19994#35745#20215#20132#27969#30452#36890#36710#12299#20170#22825'name'#22788#29702#21453#39304#12290
      '/rose/rose/rose/rose/rose/rose/rose/rose')
    TabOrder = 5
  end
  object cbWeather: TCheckBox
    Left = 234
    Top = 12
    Width = 81
    Height = 17
    Caption = #22825#27668#26102#38388#65306
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbMeeting: TCheckBox
    Left = 18
    Top = 12
    Width = 81
    Height = 17
    Caption = #24320#20250#26102#38388#65306
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 8
    Top = 160
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 128
    object miShow: TMenuItem
      Caption = #26174#31034
      OnClick = miShowClick
    end
    object miClose1: TMenuItem
      Caption = #36864#20986
      OnClick = miClose1Click
    end
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
    Top = 152
  end
end
