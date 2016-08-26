unit HYService;

interface

uses
  GSPInterface;

type
  THYService = class
  private
    FProjModel: IGSPModel;
    function  GetProjModel: IGSPModel;
  public
    property  ProjModel: IGSPModel read GetProjModel;
    procedure Save;
  end;

implementation

uses
  HYUtils;

const
  CHYModelFile            = 'HY.GSP';

{ THYService }

function THYService.GetProjModel: IGSPModel;
begin
  if not Assigned(FProjModel) then
    FProjModel := LoadGSPModel(CHYModelFile);
  Result := FProjModel;
end;

procedure THYService.Save;
begin
  if Assigned(FProjModel) then
    SaveModelToFile(FProjModel, CHYModelFile);
end;

end.
