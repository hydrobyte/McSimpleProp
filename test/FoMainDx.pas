unit FoMainDx;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls,

  McSimpleProp;

type
  TFormMain = class(TForm)
    TreeView: TTreeView;
    Splitter: TSplitter;
    PanelFooter: TPanel;
    PanelProp: TPanel;
    PanelHeader: TPanel;
    LbHeader: TLabel;
    PageControl: TPageControl;
    TabNone: TTabSheet;
    LbNone: TLabel;
    Tab1: TTabSheet;
    GbxProp1: TGroupBox;
    Tab2: TTabSheet;
    GbxProp2: TGroupBox;
    Tab3: TTabSheet;
    GbxProp3: TGroupBox;
    BtClose: TButton;
    ImgLogo: TImage;
    LbVersion: TLabel;
    LbTM: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure BtCloseClick(Sender: TObject);
  private
    fMcSimpleProp: TMcSimpleProp;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
var
  node: TTreeNode;
begin
  // version
  LbVersion.Caption := 'Test McSimpleProp 0.0.1 - Delphi 10.4 Sydney (CE)';
  // McSimpleProp setup
  fMcSimpleProp := TMcSimpleProp.Create(TreeView, PageControl);
  // ... add nodes
  node := fMcSimpleProp.AddNode('Group 1'   , nil , false);
  node := fMcSimpleProp.AddNode(Tab1.Caption, node, true );
  node := fMcSimpleProp.AddNode('Group 2'   , nil , false);
  node := fMcSimpleProp.AddNode(Tab2.Caption, node, true );
  node := fMcSimpleProp.AddNode(Tab3.Caption, nil , false);
  // ... prepare controls
  fMcSimpleProp.Prepare;
  // ... select node related to Tab1 by default
  fMcSimpleProp.SelectNodeByText(Tab1.Caption);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  fMcSimpleProp.Free;
end;

procedure TFormMain.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  fMcSimpleProp.SelectTabByText(Node.Text);
  LbHeader.Caption := fMcSimpleProp.GetNodePath(Node);
end;

procedure TFormMain.BtCloseClick(Sender: TObject);
begin
  Close;
end;

end.
