//---------------------------------------------------------------------------
#ifndef FoMainCxH
#define FoMainCxH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>

#include "McSimpleProp.hpp"
//---------------------------------------------------------------------------
class TFormMain : public TForm
{
__published:
  TSplitter *Splitter;
  TTreeView *TreeView;
  TPanel *PanelFooter;
  TImage *ImgLogo;
  TLabel *LbVersion;
  TLabel *LbTM;
  TButton *BtClose;
  TPanel *PanelProp;
  TPanel *PanelHeader;
  TLabel *LbHeader;
  TPageControl *PageControl;
  TTabSheet *TabNone;
  TLabel *LbNone;
  TTabSheet *Tab1;
  TGroupBox *GbxProp1;
  TTabSheet *Tab2;
  TGroupBox *GbxProp2;
  TTabSheet *Tab3;
  TGroupBox *GbxProp3;
  TTabSheet *Tab4;
  TGroupBox *GbxProp4;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall TreeViewChange(TObject *Sender, TTreeNode *Node);
  void __fastcall BtCloseClick(TObject *Sender);
public:
  __fastcall TFormMain(TComponent* Owner);

private:
  TMcSimpleProp* FMcSimpleProp;
};
//---------------------------------------------------------------------------
extern PACKAGE TFormMain *FormMain;
//---------------------------------------------------------------------------
#endif
