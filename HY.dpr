program HY;

uses
  FastMM4,
  Forms,
  MainFrm in 'MainFrm.pas' {MianForm},
  superobject in 'superobject.pas',
  FeedbackFrm in 'FeedbackFrm.pas' {FeedbackForm},
  HYUtils in 'HYUtils.pas',
  HYService in 'HYService.pas',
  HYConsts in 'HYConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMianForm, MianForm);
  Application.Run;
end.
