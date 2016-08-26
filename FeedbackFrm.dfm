object FeedbackForm: TFeedbackForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #21453#39304#22788#29702#20154
  ClientHeight = 457
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TGSPDBGrid
    Left = 0
    Top = 27
    Width = 480
    Height = 430
    Align = alClient
    OnQueryEditHide = GridQueryEditHide
    OnQueryCellValue = GridQueryCellValue
    DataSource = GSPDBDataSource1
    PersistentStyle = psFromDFM
    PersistentValue = 
      '<?xml version="1.0" encoding="utf-8"?>'#13#10'<o:GridSetting xmlns:a="' +
      'attribute" xmlns:c="collection" xmlns:o="object" Version="2.2.5"' +
      '>'#13#10'    <a:FixedCols>1</a:FixedCols>'#13#10'    <a:LeftMargin>2</a:Left' +
      'Margin>'#13#10'    <a:RightMargin>2</a:RightMargin>'#13#10'    <a:TopMargin>' +
      '2</a:TopMargin>'#13#10'    <a:BottomMargin>2</a:BottomMargin>'#13#10'    <a:' +
      'InvalidValueLabel>!'#38750#27861#20540'</a:InvalidValueLabel>'#13#10'    <a:GridLineWid' +
      'th>1</a:GridLineWidth>'#13#10'    <a:GridLineColor>12632256</a:GridLin' +
      'eColor>'#13#10'    <a:GridColor>-16777211</a:GridColor>'#13#10'    <a:ShowAs' +
      'Tree>True</a:ShowAsTree>'#13#10'    <c:ColSettings>'#13#10'        <o:ColSet' +
      'ting DisplayWidth="25" AutoWrapType="cstSuitColWidth"/>'#13#10'       ' +
      ' <o:ColSetting DisplayWidth="80"/>'#13#10'        <o:ColSetting Displa' +
      'yWidth="80" Identity="'#26085#26399'"/>'#13#10'    </c:ColSettings>'#13#10'    <c:TitleR' +
      'ows>'#13#10'        <o:TitleRow>'#13#10'            <a:RowHeight>20</a:RowHe' +
      'ight>'#13#10'            <c:TitleCells>'#13#10'                <o:TitleCell ' +
      'Index="1" Caption="'#22995#21517'"/>'#13#10'                <o:TitleCell Index="2"' +
      ' Caption="'#26085#26399'"/>'#13#10'            </c:TitleCells>'#13#10'        </o:TitleR' +
      'ow>'#13#10'    </c:TitleRows>'#13#10'    <c:TableSettings>'#13#10'        <o:Table' +
      'Setting>'#13#10'            <a:IsTree>True</a:IsTree>'#13#10'            <a:' +
      'IsTreeWithMasterView>True</a:IsTreeWithMasterView>'#13#10'            ' +
      '<a:DefRowHeight>18</a:DefRowHeight>'#13#10'            <c:FieldSetting' +
      's>'#13#10'                <o:FieldSetting Index="0" DisplayExpr="=@Row' +
      'No"/>'#13#10'                <o:FieldSetting Index="1" EditFieldName="' +
      '#PersonID"/>'#13#10'                <o:FieldSetting Index="2" EditFiel' +
      'dName="Date"/>'#13#10'            </c:FieldSettings>'#13#10'        </o:Tabl' +
      'eSetting>'#13#10'    </c:TableSettings>'#13#10'</o:GridSetting>'#13#10
  end
  object tdGrid: TTBXDock
    Left = 0
    Top = 0
    Width = 480
    Height = 27
    AllowDrag = False
    object tbGrid: TTBXToolbar
      Left = 0
      Top = 0
      Caption = #24037#20855#26465
      DockPos = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object TBItem1: TTBItem
        Action = acAdd
      end
      object TBItem2: TTBItem
        Action = acDel
      end
    end
  end
  object GSPDBDataSource1: TGSPDBDataSource
    Left = 272
    Top = 152
    object GSPViewProviderItem1: TGSPViewProviderItem
      View = tblFeedback
    end
  end
  object tblFeedback: TGSPTableProxy
    Left = 232
    Top = 152
  end
  object ActionList1: TActionList
    Left = 304
    Top = 152
    object acAdd: TAction
      Caption = #28155#21152
      OnExecute = acAddExecute
    end
    object acDel: TAction
      Caption = #21024#38500
      OnExecute = acDelExecute
    end
  end
end
