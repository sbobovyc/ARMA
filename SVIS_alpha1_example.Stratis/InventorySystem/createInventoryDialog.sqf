/**
  * @file createInventoryDialog.sqf
  * @author sbobovyc
  * @details
  * This must be called like this:
  * nul = [] execVM "createInventoryDialog.sqf";
  * Global variable "IIS_CAM", "IIS_MUTEX" is used.
  */
#include "InventoryItems.hpp"  
#include "InventoryDialogDefs.hpp"


// put player in a specific stance
//player switchMove "aidlpercmstpsraswrfldnon_idlesteady02n";
//player switchMove	"AidlPercMstpSnonWnonDnon_Player"; // good for uniform, vest, headgear
//player switchMove "AidlPercMstpSnonWnonDnon_Player_0S";
//player switchMove "AidlPercMstpSrasWrflDnon_G01_player"; // good for showing off rifle
player switchMove "AidlPercMstpSlowWrflDnon_G01"; //TODO normal idle standing, but is wrong when player does not have a rifle
_pos = getPos player;
SVIS_MUTEX = false; //TODO move mutex creation to pointCamera
nul = [] execVM "InventorySystem\pointCamera.sqf";

// an easy way to solve the problem of the player not facing the camera
player setDir 0;

_ok = createDialog "InventoryDialog"; 
if !(_ok) then {hint "Dialog couldn't be opened!"};

// set slider ranges
getItemArray = compile preprocessFileLineNumbers "InventorySystem\getItemArray.sqf";	
getBackpackArray = compile preprocessFileLineNumbers "InventorySystem\getBackpackArray.sqf";	
getWeaponArray = compile preprocessFileLineNumbers "InventorySystem\getWeaponArray.sqf";
IIS_HEADGEAR_ARRAY = [HEADGEAR] call getItemArray;
IIS_UNIFORM_ARRAY = [UNIFORM] call getItemArray;
IIS_VEST_ARRAY = [VEST] call getItemArray;
IIS_BACKPACK_ARRAY = call getBackpackArray;
IIS_WEAPON_ARRAY = call getWeaponArray;

sliderSetRange [HEADGEAR_SLIDER, 0, (count IIS_HEADGEAR_ARRAY) - 1]; 
sliderSetSpeed [HEADGEAR_SLIDER, 1.0, 1.0];
sliderSetPosition [HEADGEAR_SLIDER, 0];

sliderSetRange [UNIFORM_SLIDER, 0, (count IIS_UNIFORM_ARRAY) - 1]; 
sliderSetSpeed [UNIFORM_SLIDER, 1.0, 1.0];
sliderSetPosition [UNIFORM_SLIDER, 0];

sliderSetRange [VEST_SLIDER, 0, (count IIS_VEST_ARRAY) - 1]; 
sliderSetSpeed [VEST_SLIDER, 1.0, 1.0];
sliderSetPosition [VEST_SLIDER, 0];	

sliderSetRange [BACKPACK_SLIDER, 0, (count IIS_BACKPACK_ARRAY) - 1]; 
sliderSetSpeed [BACKPACK_SLIDER, 1.0, 1.0];
sliderSetPosition [BACKPACK_SLIDER, 0];	

sliderSetRange [WEAPON_SLIDER, 0, (count IIS_WEAPON_ARRAY) - 1]; 
sliderSetSpeed [WEAPON_SLIDER, 1.0, 1.0];
sliderSetPosition [WEAPON_SLIDER, 0];	
		
waitUntil { !dialog }; // hit ESC to close it 


// garbage collect
IIS_HEADGEAR_ARRAY = nil;
IIS_BACKPACK_ARRAY = nil;
IIS_WEAPON_ARRAY = nil;

//TODO fixes camera not being destroyed when player presses ESC. Better solution is to add a keydown event handler
if !(isNull IIS_CAM) then {
	nul = ["Destroy"] execVM "InventorySystem\pointCamera.sqf";		
};

// save inventory
[] execVM "InventorySystem\saveInventory.sqf";