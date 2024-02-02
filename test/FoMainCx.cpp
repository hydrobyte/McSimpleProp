//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "FoMainCx.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormMain *FormMain;
//---------------------------------------------------------------------------
__fastcall TFormMain::TFormMain(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall
TFormMain::FormCreate(TObject *Sender)
{
  // version
  LbVersion->Caption = "Test McSimpleProp 0.9.0 - C++Builder 10.2";
  // McSimpleProp setup
  FMcSimpleProp = new TMcSimpleProp(TreeView, PageControl);
  // ... add nodes
  TTreeNode* Node;
  Node = FMcSimpleProp->AddNode("Group 1"    , NULL, false);
  Node = FMcSimpleProp->AddNode("Sub Group"  , Node, true );
  Node = FMcSimpleProp->AddNode(Tab1->Caption, Node, true );
  Node = FMcSimpleProp->AddNode(Tab2->Caption, Node, false);
  Node = FMcSimpleProp->AddNode("Group 2"    , NULL, false);
  Node = FMcSimpleProp->AddNode(Tab3->Caption, Node, true );
  Node = FMcSimpleProp->AddNode(Tab4->Caption, NULL, false);
  // ... prepare controls
  FMcSimpleProp->Prepare();
  // ... select node related to Tab1 by default
  FMcSimpleProp->SelectNodeByText(Tab1->Caption);
}
//---------------------------------------------------------------------------
void __fastcall
TFormMain::FormDestroy(TObject *Sender)
{
  if (FMcSimpleProp) delete (FMcSimpleProp);
}
//---------------------------------------------------------------------------
void __fastcall
TFormMain::TreeViewChange(TObject *Sender, TTreeNode *Node)
{
  FMcSimpleProp->SelectTabByText(Node->Text);
  LbHeader->Caption = FMcSimpleProp->GetNodePath(Node);
}
//---------------------------------------------------------------------------
void __fastcall
TFormMain::BtCloseClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
