unit FeedbackFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GSPCustomGrid, GSPGrid, GSPDB, ExtCtrls, GrandGrid, GrandViewGrid,
  GSPDBGrid, HYService, StdCtrls, TB2Item, TB2Dock, TB2Toolbar,
  TBX, ActnList, GSPInterface, GrandCompGrid;

type
  TFeedbackForm = class(TForm)
    Grid: TGSPDBGrid;
    GSPDBDataSource1: TGSPDBDataSource;
    GSPViewProviderItem1: TGSPViewProviderItem;
    tblFeedback: TGSPTableProxy;
    tdGrid: TTBXDock;
    tbGrid: TTBXToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    ActionList1: TActionList;
    acAdd: TAction;
    acDel: TAction;
    procedure acAddExecute(Sender: TObject);
    procedure acDelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridQueryCellValue(Sender: TObject; ACol, ARow: Integer; const
        AField: IGSPField; const ARecord: IGSPRecord; var AValue: string; var
        AHandled: Boolean);
    procedure GridQueryEditHide(Sender: TObject; ACol, ARow: Integer; const AField:
        IGSPField; const ARecord: IGSPRecord; var AEditText: string; var ACanHide,
        AHandled: Boolean);
  private
    FHYService: THYService;
  public
    constructor Create(AHYService: THYService);
    class function Execute(AHYService: THYService): Boolean;
  end;

implementation

uses
  HYConsts;

{$R *.dfm}

constructor TFeedbackForm.Create(AHYService: THYService);
begin
  inherited Create(nil);
  FHYService := AHYService;
end;

procedure TFeedbackForm.acAddExecute(Sender: TObject);
var
  iFeedbackRec: IGSPRecord;
begin
  iFeedbackRec := tblFeedback.NewRecord;
  tblFeedback.Append(iFeedbackRec);
end;

procedure TFeedbackForm.acDelExecute(Sender: TObject);
var
  iFeedbackRec: IGSPRecord;
begin
  iFeedbackRec := Grid.GetCurRecord;
  if iFeedbackRec <> nil then
    tblFeedback.Remove(iFeedbackRec);
end;

class function TFeedbackForm.Execute(AHYService: THYService): Boolean;
begin
  with Self.Create(AHYService) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TFeedbackForm.FormShow(Sender: TObject);
begin
  tblFeedback.TableIntf := FHYService.ProjModel.FindTable(dbnDB, ptnFeedback);
  Grid.Active := True;
end;

procedure TFeedbackForm.GridQueryCellValue(Sender: TObject; ACol, ARow:
    Integer; const AField: IGSPField; const ARecord: IGSPRecord; var AValue:
    string; var AHandled: Boolean);
begin
  if (AField <> nil) and (ARecord <> nil) and SameText(AField.FieldName, pfnDate)
    and (AValue <> '') then
     AValue := DateToStr(StrToFloat(AValue));
end;

procedure TFeedbackForm.GridQueryEditHide(Sender: TObject; ACol, ARow: Integer;
    const AField: IGSPField; const ARecord: IGSPRecord; var AEditText: string;
    var ACanHide, AHandled: Boolean);
var
  rFormat: TFormatSettings;
begin
  if (AField <> nil) and (ARecord <> nil) and SameText(AField.FieldName, pfnDate) then
  begin
    GetLocaleFormatSettings(GetUserDefaultLCID, rFormat);
    rFormat.DateSeparator := '-';
    rFormat.TimeSeparator := ':';
    rFormat.ShortDateFormat := 'yyyy-mm-dd';
    rFormat.ShortTimeFormat := 'hh:nn:ss';
    AField.Value := FloatToStr(StrToDateDef(AEditText, Date, rFormat));
    AHandled := True;
  end;
end;

end.
