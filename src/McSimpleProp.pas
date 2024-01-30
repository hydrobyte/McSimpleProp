(*******************************************************************************

  The MIT License (MIT)

  Copyright (c) 2021 - 2024,  HydroByte Software

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*******************************************************************************)
unit McSimpleProp;

interface

uses
  Classes, SysUtils, ComCtrls;

type
  TMcSimpleProp = class
  private
    fTreeView   : TTreeView;
    fPageControl: TPageControl;

    procedure fSetAllTabVisible(aValue: Boolean);

  public
    constructor Create(aTreeView: TTreeView; aPageControl: TPageControl); overload; virtual;

    procedure Prepare;
    function  AddNode(const aText: string; aNode: TTreeNode; isParent: Boolean): TTreeNode;
    procedure SelectTabByText(const aText: string);
    procedure SelectNodeByText(const aText: string);
    function  FindTabByText(const aText: string): TTabSheet;
    function  FindNodeByText(const aText: string): TTreeNode;
    function  GetNodePath(aNode: TTreeNode): string;
  end;

implementation

const C_McSimpleProp_VERSION = '0.0.1';

{ ---------------------------------------------------------------------------- }
{ TMcSimpleProp }
{ ---------------------------------------------------------------------------- }

procedure TMcSimpleProp.fSetAllTabVisible(aValue: Boolean);
var
  k: Integer;
begin
  if ( Assigned(fPageControl) ) then
  begin
    for k := 0 to (fPageControl.PageCount - 1) do
      fPageControl.Pages[k].TabVisible := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TMcSimpleProp - Public methods }
{ ---------------------------------------------------------------------------- }

constructor TMcSimpleProp.Create(aTreeView: TTreeView; aPageControl: TPageControl);
begin
  fTreeView    := aTreeView;
  fPageControl := aPageControl;
end;

procedure TMcSimpleProp.Prepare;
begin
  if ( Assigned(fTreeView) ) then
  begin
    fTreeView.ReadOnly := true;
    fTreeView.FullExpand;
  end;
  if ( Assigned(fPageControl) ) then
  begin
    fSetAllTabVisible(false);
    //SetWindowLong(fPageControl.Handle, GWL_EXSTYLE, WS_EX_TRANSPARENT);
  end;
end;

procedure TMcSimpleProp.SelectTabByText(const aText: string);
var
  selTab: TTabSheet;
begin
  // find tab
  selTab := FindTabByText(aText);
  if ( Assigned(selTab) )
    then fPageControl.ActivePage      := selTab
    else fPageControl.ActivePageIndex := 0; // TabNone
end;

procedure TMcSimpleProp.SelectNodeByText(const aText: string);
var
  selNode: TTreeNode;
begin
  // find tab
  selNode := FindNodeByText(aText);
  if ( Assigned(selNode) ) then
    selNode.Selected := true; // will fire OnChange
end;

function TMcSimpleProp.AddNode(const aText: string; aNode: TTreeNode;
  isParent: Boolean): TTreeNode;
begin
  Result := nil;
  // preconditions
  if ( not Assigned(fTreeView) ) then
    exit;
  // add
  if (isParent)
    then Result := fTreeView.Items.AddChild(aNode, aText)
    else Result := fTreeView.Items.Add(aNode, aText);
end;

function TMcSimpleProp.FindTabByText(const aText: string): TTabSheet;
var
  found: Boolean;
  k: Integer;
begin
  Result := nil;
  // preconditions
  if ( not Assigned(fPageControl) ) then
    exit;
  // search for tab
  found := false;
  k := 0;
  while ( (not found) and (k < fPageControl.PageCount) ) do
  begin
    if ( fPageControl.Pages[k].Caption = aText ) then
    begin
      Result := fPageControl.Pages[k];
      found  := true;
    end
    else
      Inc(k);
  end;
end;

function TMcSimpleProp.FindNodeByText(const aText: string): TTreeNode;
var
  found: Boolean;
begin
  Result := nil;
  // preconditions
  if ( not Assigned(fTreeView) ) then
    exit;
  // start/first node
  Result := fTreeView.Items.GetFirstNode;
  // search for tab
  found := false;
  while ( (not found) and (Result <> nil) ) do
  begin
    if ( Result.Text = aText )
      then found  := true
      else Result := Result.GetNext;
  end;
end;

function TMcSimpleProp.GetNodePath(aNode: TTreeNode): string;
var
  Sep: string;
begin
  Result := '';
  Sep    := ' > ';
  // backward nodes trace
  while ( aNode <> nil ) do
  begin
    if (Result <> '')
      then Result := aNode.Text + Sep + Result
      else Result := aNode.Text +       Result;
    aNode := aNode.Parent;
  end;
end;

end.
