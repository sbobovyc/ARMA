/**
 * @file modifyEquipment.sqf
 * @author sbobovyc
 * TODO: commands like addItemToVest don't work, so I have to use a custom function that puts items where ever.
 * TODO: commands like removeItemToVest don't work, so I have to use a custom function that puts items where ever. 
 * TODO: move gui code to setListGUI.sqf or setGUI.sqf.
 */
 
 #include "InventoryDialogDefs.hpp"
 
 // compile functions
 getItemMap = compile preprocessFileLineNumbers "InventorySystem\getItemMap.sqf";
 addToInventory = compile preprocessFileLineNumbers "InventorySystem\addToInventory.sqf";
 removeFromInventory = compile preprocessFileLineNumbers "InventorySystem\removeFromInventory.sqf";
 
disableSerialization;
 _control = _this select 0; 
_type = _this select 1;
_j = 0;
if( count (lbSelection _control) != 0) then {
	_j = (lbSelection _control) select 0;
};	

 switch(_type) do
{
	case "ADD":
	{				
		diag_log format["Selected %1", SVIS_SELECTED_BUTTON];
		switch(SVIS_SELECTED_BUTTON) do {		
			case "Uniform":
			{
				_rtn = [UniformItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log (_rtn select 0);
				diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Uniform", _item];			
				//player addItemToVest _item; // This does not work for some reason, so I use my custom function
				[[_item]] call addToInventory;
				["Uniform"] execVM "InventorySystem\setListGUI.sqf";
				((findDisplay -1) displayCtrl UNIFORM_LOAD) progressSetPosition loadUniform player;
			};			
			case "Vest":
			{
				_rtn = [VestItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Vest", _item];			
				//player addItemToVest _item; // This does not work for some reason, so I use my custom function
				[[_item]] call addToInventory;
				["Vest"] execVM "InventorySystem\setListGUI.sqf";
				((findDisplay -1) displayCtrl VEST_LOAD) progressSetPosition loadVest player;
			};		
			case "Backpack":
			{
				_rtn = [BackpackItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log format["SVIS: modifyEquipment.sqf: adding %1 to Backpack", _item];			
				[[_item]] call addToInventory;
				["Backpack"] execVM "InventorySystem\setListGUI.sqf";
				((findDisplay -1) displayCtrl BACKPACK_LOAD) progressSetPosition loadBackpack player;
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
				diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Uniform", _item];			
				//player removeItemToVest _item; // This does not work for some reason, so I use my custom function
				[[_item]] call removeFromInventory;
				["Uniform"] execVM "InventorySystem\setListGUI.sqf";				
				((findDisplay -1) displayCtrl UNIFORM_LOAD) progressSetPosition loadUniform player;
			};		
			case "Vest":
			{
				_rtn = [VestItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Vest", _item];			
				//player removeItemToVest _item; // This does not work for some reason, so I use my custom function
				[[_item]] call removeFromInventory;
				["Vest"] execVM "InventorySystem\setListGUI.sqf";
				((findDisplay -1) displayCtrl VEST_LOAD) progressSetPosition loadVest player;
			};
			case "Backpack":
			{
				_rtn = [BackpackItems player] call getItemMap;
				_item = ((_rtn select 0) select _j);
				diag_log format["SVIS: modifyEquipment.sqf: removing %1 from Backpack", _item];			
				[[_item]] call removeFromInventory;
				["Backpack"] execVM "InventorySystem\setListGUI.sqf";
				((findDisplay -1) displayCtrl BACKPACK_LOAD) progressSetPosition loadBackpack player;
			};			
		};
	};	
	default
	{
		diag_log "SVIS: Error in modifyEquipment";	
		hint "SVIS: Error in modifyEquipment";	
	};
};

((findDisplay -1) displayCtrl TOTAL_LOAD) progressSetPosition load player;