unit HYUtils;

interface

uses
  GSPInterface, SysUtils, Windows;


  function LoadGSPModel(const AFileName: string; AReadOnly: Boolean = False;
    ANeedRuntime: Boolean = False; ALogCommand: Boolean = False): IGSPModel;
  procedure SaveModelToFile(const AModel: IGSPModel; const AFileName: string);
  
implementation

uses
  GSPEngineUtils, Classes;

procedure SaveModelToFile(const AModel: IGSPModel; const AFileName: string);
var
  oStream: TMemoryStream;
  sBakFileName: string;
begin
  sBakFileName := AFileName + '.bak';
  // ���ݹ����ļ�
  if FileExists(AFileName) then
    CopyFile(PChar(AFileName), PChar(sBakFileName), False);

  // ����
  try
    FileSetReadOnly(AFileName, False);
    GSPEngine.CreateModelXMLWriter.Write(AFileName, AModel);
  except
    on E: Exception do
    begin
      // �ָ������ļ�
      if FileExists(sBakFileName) then
        CopyFile(PChar(sBakFileName), PChar(AFileName), False);
      raise;
    end;
  end;

  // ɾ�������ļ�
  if FileExists(sBakFileName) then
    DeleteFile(PChar(sBakFileName));
end;

function LoadGSPModel(const AFileName: string; AReadOnly: Boolean = False;
    ANeedRuntime: Boolean = False; ALogCommand: Boolean = False): IGSPModel;
begin
  Assert(FileExists(AFileName), Format('�ļ�[%s]������', [AFileName]));
  Result := GSPEngine.CreateModel(ALogCommand, GSPEngine.DefaultGEPEngine);
  GSPEngine.CreateModelXMLReader.Read(AFileName, Result, AReadOnly);
  
  if ANeedRuntime and (Result.Mode <> gmRuntime) then
    Result.Mode := gmRuntime;
end;

end.
