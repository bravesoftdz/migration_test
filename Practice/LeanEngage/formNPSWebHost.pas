unit formNPSWebHost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, OSFont, ActiveX;

const
  WM_SHOWING = WM_USER + 1;
  
type
  TfrmNPSWebHost = class(TForm)
    WebBrowser: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure WebBrowserQuit(Sender: TObject);
    procedure WebBrowserWindowClosing(ASender: TObject; IsChildWindow: WordBool;
      var Cancel: WordBool);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FUrl: String;
    FOleInPlaceActiveObject: IOleInPlaceActiveObject;

    procedure WMShowing(var Message: TMessage); message WM_SHOWING;
    procedure WMNCHitTest(var Msg: TWMNCHitTest) ; message WM_NCHitTest;
    procedure MsgHandler(var Msg: TMsg; var Handled: Boolean);
  public
    class procedure Show(Url: String; Owner: TComponent = nil); static;

    property Url: String read FUrl write FUrl;
  end;

implementation

{$R *.dfm}

{ TfrmNPSWebHost }

procedure TfrmNPSWebHost.FormCreate(Sender: TObject);
begin
  Application.OnMessage := MsgHandler;
end;

procedure TfrmNPSWebHost.FormDestroy(Sender: TObject);
begin
  FOleInPlaceActiveObject := nil;
end;

procedure TfrmNPSWebHost.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_SHOWING, 0, 0);
end;

procedure TfrmNPSWebHost.MsgHandler(var Msg: TMsg; var Handled: Boolean);
const
  StdKeys = [VK_BACK, VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT];
var IOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  if WebBrowser = nil then
  begin
    Handled := False;
    Exit;
  end;
  Handled := (IsDialogMessage(WebBrowser.Handle, Msg) = True);
  if (Handled) and (not WebBrowser.Busy) then
  begin
    if FOleInPlaceActiveObject = nil then
    begin
      Dispatch := WebBrowser.Application;
      if Dispatch <> nil then
      begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, IOIPAO);
        if IOIPAO <> nil then FOleInPlaceActiveObject := IOIPAO;
      end;
    end;
    if FOleInPlaceActiveObject <> nil then
      if ((Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP)) and
        (Msg.wParam in StdKeys) then
        //nothing  -  do not pass on Backspace, Left, Right, Up, Down arrows
      else FOleInPlaceActiveObject.TranslateAccelerator(Msg);
  end;
end;

class procedure TfrmNPSWebHost.Show(Url: String; Owner: TComponent = nil);
var
  WebForm: TfrmNPSWebHost;
begin
  WebForm := TfrmNPSWebHost.Create(Owner);

  try
    WebForm.Url := Url;

    WebForm.ShowModal;
  finally
    WebForm.Free;
  end;
end;

procedure TfrmNPSWebHost.WebBrowserQuit(Sender: TObject);
begin
  Close;
end;

procedure TfrmNPSWebHost.WebBrowserWindowClosing(ASender: TObject;
  IsChildWindow: WordBool; var Cancel: WordBool);
begin
  Cancel := True;
  
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmNPSWebHost.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;

  if Msg.Result = htClient then
  begin
    Msg.Result := htCaption;
  end;
end;

procedure TfrmNPSWebHost.WMShowing(var Message: TMessage);
begin
  if FUrl <> '' then
  begin
    WebBrowser.Navigate(FUrl);
  end;
end;

end.