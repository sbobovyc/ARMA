/**
  * @file addToInventory.sqf
  * @author sbobovyc
  * @details
  * 
  */

_entity = _this select 0;
_items = _this select 1;
{
	diag_log format["SVIS: addToInventory: %1", _x];
	if(isClass(configFile/"CfgMagazines"/_x)) then
	{
		_entity addMagazine _x;
	} 
	else 
	{
		_entity addItem _x;
	};	
} forEach _items;	
