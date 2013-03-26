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
setGUI = compile preprocessFileLineNumbers "InventorySystem\setGUI.sqf";

// initialize global data arrays
SVIS_HEADGEAR_ARRAY = [HEADGEAR] call getItemArray;
SVIS_UNIFORM_ARRAY = [UNIFORM] call getItemArray;
SVIS_VEST_ARRAY = [VEST] call getItemArray;
SVIS_BACKPACK_ARRAY = call getBackpackArray;
SVIS_WEAPON_ARRAY = call getWeaponArray;


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

_pos = getPos player;
SVIS_MUTEX = false; //TODO move mutex creation to pointCamera
nul = [] execVM "InventorySystem\pointCamera.sqf";

// an easy way to solve the problem of the player not facing the camera
player setDir 0;

SVIS_EQP_MUTEX = false;

_ok = createDialog "InventoryDialog"; 
if !(_ok) then {hint "Dialog couldn't be opened!"};

// initialize dialog gui
["Init"] call setGUI;
["SetHeadgear", true] call setGUI;
["SetUniform", true] call setGUI;
["SetVest", true] call setGUI;
["SetBackpack", true] call setGUI;
["SetPrimaryWeapon", true] call setGUI;

waitUntil { !dialog }; //BUG if user is switching gear and presses ESC, there is a change gear will be removed but not added


// garbage collect
SVIS_HEADGEAR_ARRAY = nil;
SVIS_UNIFORM_ARRAY = nil;
SVIS_VEST_ARRAY = nil;
SVIS_BACKPACK_ARRAY = nil;
SVIS_WEAPON_ARRAY = nil;
SVIS_EQP_MUTEX = nil;

//TODO Better solution is to add a keydown event handler
if !(isNull SVIS_CAM) then {
	nul = ["Destroy"] execVM "InventorySystem\pointCamera.sqf";		
};

// save inventory
[] execVM "InventorySystem\saveInventory.sqf";
