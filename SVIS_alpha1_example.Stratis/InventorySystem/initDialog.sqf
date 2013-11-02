/**
  * @file initDialog.sqf
  * @author sbobovyc
  * @details  
  */
  
#include "InventoryDialogDefs.hpp"
disableSerialization;

// compile functions
setGUI = compile preprocessFileLineNumbers "InventorySystem\setGUI.sqf";
  
_display = _this select 0;

diag_log _display;
diag_log (typeName _display);
// initialize dialog gui
//TODO move all gui init to gui's onLoad
[_display,"Init"] call setGUI;
[_display,"SetHeadgear", true] call setGUI;
[_display,"SetUniform", true] call setGUI;
[_display,"SetVest", true] call setGUI;
[_display,"SetBackpack", true] call setGUI;
[_display,"SetPrimaryWeapon", true] call setGUI;
[_display,"SetSecondaryWeapon", true] call setGUI;
// add instructions to list box
/*
lbAdd [MULTIPURPOSE_LISTBOX, "1. Click buttons to get context sensitive"];
lbAdd [MULTIPURPOSE_LISTBOX, "list of items."];
lbAdd [MULTIPURPOSE_LISTBOX, "2. Use sliders to change gear."];
lbAdd [MULTIPURPOSE_LISTBOX, "3. Select items in list box and click"];
lbAdd [MULTIPURPOSE_LISTBOX, "the + and - to add or remove items."];
*/
// disable the + and - button so user can't click them before selecting an inventory item
ctrlEnable [ADD_ITEM_BUTTON, false];
ctrlEnable [REMOVE_ITEM_BUTTON, false];

