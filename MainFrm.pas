unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, Menus, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Mask, HYService, GSPInterface;

const
  WM_NID = WM_User + 1000; //声明一个常量
  
type
  TMianForm = class(TForm)
    btnTest: TButton;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    miShow: TMenuItem;
    miClose1: TMenuItem;
    IdHTTP1: TIdHTTP;
    medtMeeting: TMaskEdit;
    mmMeetingMsg: TMemo;
    medtWeather: TMaskEdit;
    btnFeedback: TButton;
    mmFeedbackMsg: TMemo;
    cbWeather: TCheckBox;
    cbMeeting: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnFeedbackClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure miShowClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miClose1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FOptionTbl: IGSPPropTable;
    FHYService: THYService;
    function  IdHTTPGet(const AURL: string; var AWeb: string): Boolean;
    function  IsWorkDay(const ADateTime: TDateTime): Boolean;
    procedure SendMsg(const AMsg: string; const AFeedbackRec: IGSPRecord = nil);
    procedure PressEnter(AHandle: THandle);
    function  GetWeather: string;
    function  GetFeedbackRec(const ADate: TDate): IGSPRecord;
    procedure UpdateToNextDate(const AFeedbackRec: IGSPRecord);
    function  CanOpenHYOurHome(var AHandle: THandle): Boolean;
    procedure LoadConfig;
    procedure SaveConfig;
  public
    procedure SysCommand(var ASysMsg: TMessage); message WM_SYSCOMMAND;
    procedure WMNID(var AMsg:TMessage); message WM_NID;
  end;

var
  MianForm: TMianForm;
  NotifyIcon: TNotifyIconData; // 全局变量
  
const
  CWednesday               = 4;
  CWeekStep                = 7;
  CDayStep                 = 1;
  CHTTPSuccess             = 200;

implementation

uses
  Clipbrd, DateUtils, superobject, FeedbackFrm, HYConsts;

{$R *.dfm}

procedure TMianForm.FormCreate(Sender: TObject);
begin
  FHYService := THYService.Create;
  FOptionTbl := FHYService.ProjModel.FindTable(dbnDB, ptnOption) as IGSPPropTable;
  LoadConfig;
end;

procedure TMianForm.btnFeedbackClick(Sender: TObject);
begin
  TFeedbackForm.Execute(FHYService);
  FHYService.Save;
end;

procedure TMianForm.btnTestClick(Sender: TObject);
var
  iFeedbackRec: IGSPRecord;
begin
 // btnTest.Caption := IntToStr(SysUtils.DayOfWeek(Now));

  iFeedbackRec := GetFeedbackRec(Date);
  if iFeedbackRec <> nil then
  begin
    SendMsg(GetWeather, iFeedbackRec);
    //UpdateToNextDate(iFeedbackRec);
  end;
end;

procedure TMianForm.miShowClick(Sender: TObject);
begin
  Self.Visible := true; // 显示窗体    
end;  

procedure TMianForm.PressEnter(AHandle: THandle);
begin
  SendMessage(AHandle, WM_KEYDOWN, VK_RETURN, 0);
  SendMessage(AHandle, WM_KEYUP, VK_RETURN, 0);
end;

function TMianForm.IsWorkDay(const ADateTime: TDateTime): Boolean;
var
  s, sDate: string;
  rFormat: TFormatSettings;
  n, nBegin: Integer;
begin
  s := '-1';
  rFormat.ShortDateFormat:='yyyymmdd';
  sDate := DateToStr(ADateTime, rFormat);
  try
    IdHTTPGet('http://www.easybots.cn/api/holiday.php?d=' + sDate , s);
  except
  end;
  //工作日对应结果为 0, 休息日对应结果为 1, 节假日对应的结果为 2
  //参考：http://apistore.baidu.com/apiworks/servicedetail/1116.html
  //http://www.easybots.cn/holiday_api.net
  nBegin := Pos(':', s);
  s := Copy(s, nBegin + 2, 1);
  n := StrToIntDef(s, -1);
  Result := n = 0;
end;

procedure TMianForm.LoadConfig;
begin
  medtMeeting.Text := FOptionTbl.AsString[pfnMeetingTime];
  mmMeetingMsg.Text := FOptionTbl.AsString[pfnMeetingMsg];
  mmFeedbackMsg.Text := FOptionTbl.AsString[pfnFeedbackMsg];
  medtWeather.Text := FOptionTbl.AsString[pfnWeatherTime];
end;

procedure TMianForm.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NotifyIcon); // 删除托盘图标
  SaveConfig;
  FHYService.Save;
  FHYService.Free;  
end;

procedure TMianForm.FormShow(Sender: TObject);
begin
  SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW); // 隐藏任务栏显示
  with NotifyIcon do
  begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd := Handle;
    uID := 1;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallBackMessage := WM_NID;
    hIcon := Application.Icon.Handle;
    szTip := '托盘程序';
  end;
  Shell_NotifyIcon(NIM_ADD, @NotifyIcon); // 在托盘区显示图标
end;

function TMianForm.GetFeedbackRec(const ADate: TDate): IGSPRecord;

  function GetFeedbackTableName: string;
  begin
    if SysUtils.DayOfWeek(ADate) = CWednesday then
      Result := ptnFeedbackWeek
    else
      Result := ptnFeedback;
  end;

var
  iFeedbackTbl: IGSPTable;
begin
  iFeedbackTbl := FHYService.ProjModel.FindTable(dbnDB, GetFeedbackTableName);
  Result := iFeedbackTbl.Locate(pfnDate, ADate);
end;

function TMianForm.CanOpenHYOurHome(var AHandle: THandle): Boolean;
var
  dwTickCount: DWORD;
  sUrl: string;
  oStrs: TStrings;
begin
  Result := False;
  oStrs := TStringList.Create;
  try
    oStrs.LoadFromFile('QQ.txt');
    sUrl := Trim(oStrs.Text);
  finally
    oStrs.Free;
  end;
  dwTickCount := GetTickCount;
  // 有时系统反应慢，窗口显示需要一点时间。
  // 30秒内找不到<行业，Our home!>窗口就退出
  repeat
    WinExec(PChar(sUrl), SW_SHOWMINIMIZED);
    Sleep(200);
    Application.ProcessMessages;
    AHandle := FindWindow(nil, '行业，Our home!');
    if AHandle <> 0 then
    begin
      Result := True;
      Break;
    end;
  until (GetTickCount - dwTickCount > 30 * 1000);  
end;

function TMianForm.GetWeather: string;

  function DecodeJSStr(const value: Widestring): Widestring;
  var
    P: PWideChar;
    v: WideChar;
    tmp: Widestring;
  begin
    Result := '';
    P := PWideChar(value);
    while P^ <> #0 do
    begin
      v := #0;
      case P^ of
      '\':
      begin
        inc(P);
        case P^ of
          '"', '\', '/':
            v := P^;
          'b':
            v := #$08;
          'f':
            v := #$0C;
          'n':
          v := #$0A;
          'r':
          v := #$0D;
            't':
          v := #$09;
            'u':
          begin
            tmp := Copy(P, 2, 4);
            v := WideChar(StrToInt('$' + tmp));
            inc(P, 4);
          end;
        end;
      end;
      else
        v := P^;
      end;
      Result := Result + v;
      inc(P);
    end;
  end;
  
var
  s: string;
  vJson: ISuperObject;
begin
{
http://apistore.baidu.com/apiworks/servicedetail/112.html
  JSON返回示例 :
errNum: 0,
errMsg: "success",
retData: {
   city: "北京", //城市
   pinyin: "beijing", //城市拼音
   citycode: "101010100",  //城市编码	
   date: "15-02-11", //日期
   time: "11:00", //发布时间
   postCode: "100000", //邮编
   longitude: 116.391, //经度
   latitude: 39.904, //维度
   altitude: "33", //海拔	
   weather: "晴",  //天气情况
   temp: "10", //气温
   l_tmp: "-4", //最低气温
   h_tmp: "10", //最高气温
   WD: "无持续风向",	 //风向
   WS: "微风(<10m/h)", //风力
   sunrise: "07:12", //日出时间
   sunset: "17:44" //日落时间
  }

  //https://api.heweather.com/x3/weather?cityid=CN101010100&key=5b4c3a5c0e8447f0bd34c54f66e59fb3
  //http://www.heweather.com/documents/api
  try
    IdHTTPGet('http://apis.baidu.com/apistore/weatherservice/weather?citypinyin=beijing', s);
    vJson := SO(DecodeJSStr(s));
    Result := Format('发布时间：%s', [vJson.O['retData'].S['time']]);
    Result := Result + #13#10 + Format('天气：%s', [vJson.O['retData'].S['weather']]);
    //Result := Result + #13#10 + Format('气温：%s', [vJson.O['retData'].S['temp']]);
    Result := Result + #13#10 + Format('最低气温：%s', [vJson.O['retData'].S['l_tmp']]);
    Result := Result + #13#10 + Format('最高气温：%s', [vJson.O['retData'].S['h_tmp']]);
    Result := Result + #13#10 + Format('风向：%s', [vJson.O['retData'].S['WD']]);
    Result := Result + #13#10 + Format('风力：%s', [vJson.O['retData'].S['WS']]);
  except
    Result := '天气获取失败！';
  end;                                
end;

function TMianForm.IdHTTPGet(const AURL: string; var AWeb: string): Boolean;
var
  IdHTTP: TIdHTTP;
  oResponse: TStringStream; // 提交后返回的数据
begin
  Result := False;
  if AURL = '' then Exit;
  AWeb := '';
  IdHTTP := TIdHTTP.Create(nil);
  try
    try
      with IdHTTP do
      begin
        // IdHTTP 设置
        HTTPOptions := HTTPOptions + [hoKeepOrigProtocol];   //保持 并使用PV1_1
        ProtocolVersion := pv1_1;
        HTTPOptions := HTTPOptions - [hoForceEncodeParams];  //去掉自动编码
        AllowCookies := True;
        HandleRedirects := True;
        ConnectTimeout := 30000;
        ReadTimeout := 30000;
        // IdHTTP 提交信息的设置
        Request.Accept := 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5;apikey=74c27c8c6c623cfbe0bc80aa0940038f';
        Request.AcceptCharSet := 'GBK,utf-8;q=0.7,*;q=0.3';
        Request.AcceptEncoding := '';     //'gzip,deflate,sdch';
        Request.AcceptLanguage := 'zh-CN,zh;q=0.8';
        Request.Connection :='Keep-Alive';
        Request.ContentType := 'application/x-www-form-urlencoded';
        //从百度申请的apikey目前免费100次每秒2016/06/22
        Request.CustomHeaders.Values['apikey'] := 'ccf4245b4c070d9b7d57ce86097e6bcf';
        Request.UserAgent := 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.133 Safari/534.16';
        Request.Referer := AURL;

        oResponse := TStringStream.Create(''); //或者TEncoding.UTF8
        try
          Get(AURL, oResponse);
          if ResponseCode <> CHTTPSuccess then Exit;
          //if oResponse.Size <= 1 then Exit;
          AWeb := oResponse.DataString;
          Result := True;
        finally
          FreeAndNil(oResponse);
        end;
      end;
    except
      on E: Exception do
        Result := False;
    end;
  finally
    IdHTTP.Disconnect;
    FreeAndNil(IdHTTP);
  end;
end;

procedure TMianForm.miClose1Click(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NotifyIcon);
  Self.Close;
end;

procedure TMianForm.SaveConfig;
begin
  FOptionTbl.AsString[pfnMeetingTime] := medtMeeting.Text;
  FOptionTbl.AsString[pfnMeetingMsg] := mmMeetingMsg.Text;
  FOptionTbl.AsString[pfnFeedbackMsg] := mmFeedbackMsg.Text;
  FOptionTbl.AsString[pfnWeatherTime] := medtWeather.Text;
  FHYService.Save;
end;

procedure TMianForm.SendMsg(const AMsg: string; const AFeedbackRec: IGSPRecord = nil);
var  
  h: THandle;
  iPersonRec: IGSPRecord;
begin
  if not CanOpenHYOurHome(h) then
    Exit;

  ClipBoard.AsText := AMsg;  // 复制

  SendMessage(h, WM_PASTE, 0, 0); // 粘贴
  if (AFeedbackRec <> nil) then
  begin
    iPersonRec := AFeedbackRec.FindField(pfnPersonID).MasterRecord;
    ClipBoard.AsText := #13#10 + StringReplace(mmFeedbackMsg.Text, pfnName, iPersonRec.AsString[pfnName], [rfIgnoreCase]);
    SendMessage(h, WM_PASTE, 0, 0); // 粘贴
    if (iPersonRec.AsString[pfnQQ] <> '') then
    begin
      ClipBoard.AsText := #13#10 + '@' + AFeedbackRec.FindField(pfnPersonID).MasterRecord.AsString[pfnQQ];
      SendMessage(h, WM_PASTE, 0, 0);
      Sleep(200); // 休息一下等QQ的@提示弹出。
      PressEnter(h); // 回车 发送  
    end;
  end;

  PressEnter(h);  // 回车 发送

  SendMessage(h, WM_CLOSE, 0, 0); // 关闭窗口
end;

procedure TMianForm.SysCommand(var ASysMsg: TMessage);
begin
  case ASysMsg.WParam of
    SC_MINIMIZE, SC_CLOSE: // 当最小化时
    begin
      Hide; // 在任务栏隐藏程序 
    end;
  else
    inherited;
  end;
end;

procedure TMianForm.Timer1Timer(Sender: TObject);
var
  nDiff: Int64;
  iFeedbackRec: IGSPRecord;
begin
  try
    nDiff := SecondsBetween(Time, StrToTime(medtWeather.Text));
  except
    nDiff := -1;
  end;
  if (nDiff = 0) and cbWeather.Checked and IsWorkDay(Now) then
  begin
    iFeedbackRec := GetFeedbackRec(Date);
    if iFeedbackRec <> nil then
    begin
      SendMsg(GetWeather, iFeedbackRec);
      UpdateToNextDate(iFeedbackRec);
    end;
    Sleep(2000);
  end;

  try
    nDiff := SecondsBetween(Time, StrToTime(medtMeeting.Text));
  except
    nDiff := -1;
  end;
  if (nDiff = 0) and cbMeeting.Checked and IsWorkDay(Now) then
  begin
    SendMsg(mmMeetingMsg.Text);
    Sleep(2000);
  end;
end;

// 更新至下一个法定工作日。
procedure TMianForm.UpdateToNextDate(const AFeedbackRec: IGSPRecord);
var
  iFeedbackTbl: IGSPTable;
  iFeedbackRec: IGSPRecord;
  dDate: TDate;
  I, nStep: Integer;
begin
  if AFeedbackRec = nil then
    Exit;
  
  iFeedbackTbl := AFeedbackRec.Table;
  iFeedbackTbl.Sort(pfnDate);
  iFeedbackRec := iFeedbackTbl.Records[AFeedbackRec.Table.RecordCount - 1];
  dDate := iFeedbackRec.AsFloat[pfnDate];

  if iFeedbackTbl.Name = ptnFeedbackWeek then
    nStep := CWeekStep  // 
  else
    nStep := CDayStep;
  I := 0;
  repeat
    Inc(I);
    dDate := dDate + nStep;
    if (SameText(iFeedbackTbl.Name, ptnFeedbackWeek) or (SysUtils.DayOfWeek(dDate) <> CWednesday))
      and IsWorkDay(dDate) then
      Break;
  until (I > 16);   // 国家最长假期不会超过16天
  if I < 16 then
  begin  
    AFeedbackRec.AsFloat[pfnDate] := dDate;
    FHYService.Save;
  end;
end;

procedure TMianForm.WMNID(var AMsg:TMessage);
var
  rMousePos: TPoint;
begin
  GetCursorPos(rMousePos); //获取鼠标位置
  case AMsg.LParam of
    WM_LBUTTONUP: // 在托盘区点击左键后
      Self.Visible := not Self.Visible; // 显示主窗体与否  
    WM_RBUTTONUP: // 在托盘区点右键后
      PopupMenu1.Popup(rMousePos.X, rMousePos.Y); // 弹出菜单
  end;
end;

end.
