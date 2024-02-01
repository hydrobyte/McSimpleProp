unit FoMainLz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, McSimpleProp;

type

  { TFormMain }

  TFormMain = class(TForm)
    BtClose: TButton;
    GbxProp1: TGroupBox;
    GbxProp2: TGroupBox;
    GbxProp3: TGroupBox;
    ImgLogo: TImage;
    LbHeader: TLabel;
    LbNone: TLabel;
    LbTM: TLabel;
    LbVersion: TLabel;
    PageControl: TPageControl;
    PanelFooter: TPanel;
    PanelHeader: TPanel;
    PanelProp: TPanel;
    Splitter: TSplitter;
    Tab1: TTabSheet;
    Tab2: TTabSheet;
    Tab3: TTabSheet;
    TabNone: TTabSheet;
    TreeView: TTreeView;
    procedure BtCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    fMcSimpleProp: TMcSimpleProp;
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
var
  node: TTreeNode;
begin
  // version
  LbVersion.Caption := 'Test McSimpleProp 0.0.1 - Lazarus 2.3.0';
  // McSimpleProp setup
  fMcSimpleProp := TMcSimpleProp.Create(TreeView, PageControl);
  // ... add nodes
  node := fMcSimpleProp.AddNode('Group 1'   , nil , false);
  node := fMcSimpleProp.AddNode('Sub Group' , node, true );
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

