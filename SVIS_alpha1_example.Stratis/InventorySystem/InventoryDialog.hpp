/**
 * @file InventoryDialog.hpp
 * @author sbobovyc
 *
 */

#include "gui.hpp"
#include "InventoryDialogDefs.hpp"
#define X_POS 1.0
#define Y_POS -0.2

//TODO
// Add checkboxes for items like NVG

class InventoryDialog{
	idd = -1;                      // set to -1, because we don't require a unique ID
	movingEnable = true;           // the dialog can be moved with the mouse (see "moving"; below)
	enableSimulation = true;      // don't freeze the game
	controlsBackground[] = { Background };    
	objects[] = { };               // no objects needed
	controls[] = { TitleLabel, 
			HeadgearButton, 
			HeadgearSlider, 
			UniformButton, 
			UniformSlider, 
			VestButton,
			VestSlider,
			BackpackButton,
			BackpackSlider,			
			WeaponButton,
			WeaponSlider,		
			SecondaryWeaponButton,
			SecondaryWeaponSlider,
			CloseButton};  // controls

	class Common {
		x = X_POS + 0.05;
		w = 0.2;
		h = 0.05;
	};

	class TitleLabel : Common {
		idc = -1;              // set to -1, unneeded
		moving = 1;            // left click (and hold) this control to move the dialog
		// (requires "movingEnabled"; to be 1, see above)
		type = CT_STATIC;      // constant
		style = ST_CENTER;       // constant
		text = TITLE;
		font = FONT_GAME;
		sizeEx = 0.035;

		colorBackground[] = COLOR_TRANSPARENT_DARK_GREEN;
		colorText[] = COLOR_BLUE;

		x = X_POS;
		y = Y_POS+0.1;
		w = 0.3;
	};

	class Background {
		idc = -1;
		moving = 0;	// disabled moving by clicking on the background of dialog
		type = CT_STATIC;
		style = ST_LEFT;
		text = "";
		font = FONT_GAME;
		sizeEx = 0.0;
		colorBackground[] = COLOR_TRANSPARENT_LGRAY;
		colorText[] = COLOR_TRANSPARENT;
		x = X_POS;
		y = Y_POS+0.1;
		w = 0.3;
		h = 1.4;	
	};

	class Button : Common {
		idc = -1;              // set to -1, unneeded
		moving = 1;            // left click (and hold) this control to move the dialog
		// (requires "movingEnabled"; to be 1, see above)
		type = CT_BUTTON;      // constant
		style = ST_LEFT;       // constant
		font = FONT_GAME;
		sizeEx = 0.03;

		colorText[] = COLOR_WHITE;
		colorFocused[] = {0,0,0,0};
		colorDisabled[] = {1, 1, 1, 0.2};
		colorBackground[] = COLOR_TRANSPARENT_DARK_GREEN;
		colorBackgroundDisabled[] = COLOR_TRANSPARENT_DARK_GREEN;
		colorBackgroundActive[] = {0.5, 1, 0, 0.7};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0, 0, 0, 0};
		colorBorder[] = {0, 0, 0, 0};
		borderSize = 0;
		soundEnter[] = {"", 0, 1 };
		soundPush[] = {"", 0, 1 };
		soundClick[] = {"", 0, 1 };
		soundEscape[] = {"", 0, 1 };

	};

	class HorizSlider : Common {
		idc = -1; 
		type = CT_SLIDER; 
		style = SL_HORZ; 
		color[] = COLOR_TRANSPARENT_DARK_GREEN;
		coloractive[] = { 1, 0, 0, 0.5 };
		// This is an ctrlEventHandler to show you some response if you move the sliderpointer.
		onSliderPosChanged = "hint format[""%1"",_this];";

	};

	class HeadgearButton : Button {
		idc = HEADGEAR_BUTTON;
		text = "Headgear Name";
		action = "[""Headgear""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+0.2;
	};

	class HeadgearSlider : HorizSlider {
		idc = HEADGEAR_SLIDER;
		onSliderPosChanged = "nul = [""Headgear"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+0.3;
	};

	class UniformButton : Button {
		idc = UNIFORM_BUTTON;
		text = "Uniform Name";
		action = "[""Uniform""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+0.4;
	};

	class UniformSlider : HorizSlider {
		idc = UNIFORM_SLIDER;
		onSliderPosChanged = "nul = [""Uniform"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+0.5;
	};

	class VestButton : Button {
		idc = VEST_BUTTON;
		text = "Vest Name";
		action = "[""Vest""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+0.6;
	};

	class VestSlider : HorizSlider {
		idc = VEST_SLIDER;
		onSliderPosChanged = "nul = [""Vest"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+0.7;
	};

	class BackpackButton : Button {
		idc = BACKPACK_BUTTON;
		text = "Backpack Name";
		action = "[""Backpack""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+0.8;
	};

	class BackpackSlider : HorizSlider {
		idc = BACKPACK_SLIDER;
		onSliderPosChanged = "nul = [""Backpack"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+0.9;
	};

	class WeaponButton : Button {
		idc = WEAPON_BUTTON;
		text = "Primary Weapon Name";
		action = "[""Weapon""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+1.0;
	};

	class WeaponSlider : HorizSlider {
		idc = WEAPON_SLIDER;
		onSliderPosChanged = "nul = [""Weapon"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+1.1;
	};

	class SecondaryWeaponButton : Button {
		idc = SECONDARY_WEAPON_BUTTON;
		text = "Secondary Weapon Name";
		action = "[""Backpack""] execVM ""InventorySystem\pointCamera.sqf"";";
		y = Y_POS+1.2;
	};
	
	class SecondaryWeaponSlider : HorizSlider {
		idc = SECONDARY_WEAPON_SLIDER;
		onSliderPosChanged = "nul = [""SecondaryWeapon"", _this select 1] execVM ""InventorySystem\switchEquipment.sqf"";";
		y = Y_POS+1.3;
	};
	
	class CloseButton : Button {
		text = "Save & Close";
		action = "[""Destroy""] execVM ""InventorySystem\pointCamera.sqf""; closeDialog 0";
		y = Y_POS+1.4;
	};
};

