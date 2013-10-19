/**
  * @file createInventoryDialog.sqf
  * @author sbobovyc
  * @details
  * This must be called like this:
  * nul = [] execVM "createInventoryDialog.sqf";
  * Global variable "SVIS_CAM", "SVIS_MUTEX" is used.
  */
#include "InventoryItems.hpp"  
#include "InventoryDialogDefs.hpp"

// compile functions
getItemArray = compile preprocessFileLineNumbers "InventorySystem\getItemArray.sqf";	
getBackpackArray = compile preprocessFileLineNumbers "InventorySystem\getBackpackArray.sqf";	
getWeaponArray = compile preprocessFileLineNumbers "InventorySystem\getWeaponArray.sqf";
getSecondaryWeaponArray = compile preprocessFileLineNumbers "InventorySystem\getSecondaryWeaponArray.sqf";
setGUI = compile preprocessFileLineNumbers "InventorySystem\setGUI.sqf";


// initialize global data arrays
SVIS_HEADGEAR_ARRAY = [HEADGEAR] call getItemArray;
SVIS_UNIFORM_ARRAY = [UNIFORM] call getItemArray;
SVIS_VEST_ARRAY = [VEST] call getItemArray;
SVIS_BACKPACK_ARRAY = call getBackpackArray;
SVIS_WEAPON_ARRAY = call getWeaponArray;
SVIS_SECONDARY_WEAPON_ARRAY = call getSecondaryWeaponArray;

// put player in a specific stance
//player switchMove "aidlpercmstpsraswrfldnon_idlesteady02n";
//player switchMove	"AidlPercMstpSnonWnonDnon_Player"; // good for uniform, vest, headgear
//player switchMove "AidlPercMstpSnonWnonDnon_Player_0S";
//player switchMove "AidlPercMstpSrasWrflDnon_G01_player"; // good for showing off rifle
if( (primaryWeapon player) != "" ) then {
	player switchMove "AidlPercMstpSlowWrflDnon_G01"; //TODO normal idle standing, but is wrong when player does not have a rifle
} else {

	if( (handgunWeapon player) != "") then {
		player switchMove "AidlPercMstpSlowWpstDnon_G01"; // good for uniform, vest, headgear
	};

	if( (secondaryWeapon player) != "") then {

	};

};

// turn the player away from the inventory crate
_dir = getDir player;
player setDir 180+_dir;
//player setDir 0;
nul = [] execVM "InventorySystem\pointCamera.sqf";

SVIS_EQP_MUTEX = false;

_ok = createDialog "InventoryDialog"; 
if !(_ok) then {hint "Dialog couldn't be opened!"};

// initialize dialog gui
//TODO move all gui init to gui's onLoad
[0,"Init"] call setGUI;
[0,"SetHeadgear", true] call setGUI;
[0,"SetUniform", true] call setGUI;
[0,"SetVest", true] call setGUI;
[0,"SetBackpack", true] call setGUI;
[0,"SetPrimaryWeapon", true] call setGUI;
[0,"SetSecondaryWeapon", true] call setGUI;



waitUntil { !dialog }; //BUG if user is switching gear and presses ESC, there is a change gear will be removed but not added


// garbage collect
SVIS_HEADGEAR_ARRAY = nil;
SVIS_UNIFORM_ARRAY = nil;
SVIS_VEST_ARRAY = nil;
SVIS_BACKPACK_ARRAY = nil;
SVIS_WEAPON_ARRAY = nil;
SVIS_SECONDARY_WEAPON_Array = nil;

//TODO Better solution is to add a keydown event handler
//if !(isNull SVIS_CAM) then {
//	nul = ["Destroy"] execVM "InventorySystem\pointCamera.sqf";		
//};

if !(isnil("SVIS_CAM")) then {
	nul = ["Destroy"] execVM "InventorySystem\pointCamera.sqf";		
};

// save inventory
[] execVM "InventorySystem\saveInventory.sqf";
