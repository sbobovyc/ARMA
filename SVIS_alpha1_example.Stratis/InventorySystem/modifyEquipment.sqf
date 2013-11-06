/**
 * @file modifyEquipment.sqf
 * @author sbobovyc
 * TODO: fix error that happens when no row is selected and user presses + or -.
 * TODO: commands like removeItemToVest don't work, so I have to use a custom function that puts items where ever. 
 * TODO: move gui code to setNListGUI.sqf or setGUI.sqf.
 */
 
 #include "InventoryDialogDefs.hpp"
 
 // compile functions
 getItemMap = compile preprocessFileLineNumbers "InventorySystem\getItemMap.sqf";
 removeFromInventory = compile preprocessFileLineNumbers "InventorySystem\removeFromInventory.sqf";
 
disableSerialization;
_control = _this select 0; 
_type = _this select 1;
_j = lnbCurSelRow  _control;

switch(_type) do
{
	case "ADD":
	{				
		switch(SVIS_SELECTED_BUTTON) do {		
			case "Uniform":
			{
				_rtn = [UniformItems player] call getItemMap;
				diag_log _j;
				_item = ((_rtn select 0) select _j);
				if(!isnil ("_item")) then {
					diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Uniform", _item];			
					player addItemToUniform _item; // This does not work for some reason, so I use my custom function
					["Uniform"] execVM "InventorySystem\setNListGUI.sqf";				
				};
			};			
			case "Vest":
			{
				_rtn = [VestItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Vest", _item];			
				player addItemToVest _item; // This does not work for some reason, so I use my custom function
				["Vest"] execVM "InventorySystem\setNListGUI.sqf";				
			};		
			case "Backpack":
			{
				_rtn = [BackpackItems player] call getItemMap;
				if( count (_rtn select 0) != 0) then { // if there is nothing in the item map, do nothing
					_item = ((_rtn select 0) select _j);
					diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Backpack", _item];			
					player addItemToBackpack _item;				
				};
				["Backpack"] execVM "InventorySystem\setNListGUI.sqf";
			};				
		};
	};
	case "SUB":
	{
		switch(SVIS_SELECTED_BUTTON) do {		
			case "Uniform":
			{
				_rtn = [UniformItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				if(!isnil ("_item")) then {
					diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Uniform", _item];			
					//player removeItemFromUniform _item; // This does not work for some reason, so I use my custom function
					[[_item]] call removeFromInventory;
					["Uniform"] execVM "InventorySystem\setNListGUI.sqf";				
				};
			};		
			case "Vest":
			{
				_rtn = [VestItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);					
				//player removeItemToVest _item; // This does not work for some reason, so I use my custom function
				if(!isnil ("_item")) then {
					diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Vest", _item];						
					[[_item]] call removeFromInventory;
					["Vest"] execVM "InventorySystem\setNListGUI.sqf";
				};
			};
			case "Backpack":
			{
				_rtn = [BackpackItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				if(!isnil ("_item")) then {
					diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Backpack", _item];			
					[[_item]] call removeFromInventory;
					["Backpack"] execVM "InventorySystem\setNListGUI.sqf";
				};
			};			
			case "Weapon": 
			{
				_rtn = primaryWeaponItems player;
				_item_list = [];
				{
					if (_x != "") then {
						_item_list = _item_list + [_x];
					};
				} forEach _rtn;
				_item = (_item_list select _j);
				if(!isnil ("_item")) then {
					diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Weapon", _item];			
					player removePrimaryWeaponItem  _item;
					["Weapon"] execVM "InventorySystem\setNListGUI.sqf";
				};
			};
		};
	};	
	default
	{
		diag_log "SVIS: Error in modifyEquipment";	
		hint "SVIS: Error in modifyEquipment";	
	};
};

((findDisplay -1) displayCtrl UNIFORM_LOAD) progressSetPosition loadUniform player;
((findDisplay -1) displayCtrl VEST_LOAD) progressSetPosition loadVest player;
((findDisplay -1) displayCtrl BACKPACK_LOAD) progressSetPosition loadBackpack player;
((findDisplay -1) displayCtrl TOTAL_LOAD) progressSetPosition load player;