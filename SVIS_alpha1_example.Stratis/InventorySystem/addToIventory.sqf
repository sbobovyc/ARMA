/**
  * @file addToInventory.sqf
  * @author sbobovyc
  * @details
  * 
  */

_items = _this select 0;
{
	diag_log format["SVIS: addToInventory: %1", _x];
	if(isClass(configFile/"CfgMagazines"/_x)) then
	{
		player addMagazine _x;
	} 
	else 
	{
		player addItem _x;
	};	
} forEach _items;	
