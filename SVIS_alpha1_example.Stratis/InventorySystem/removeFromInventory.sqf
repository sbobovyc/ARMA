/**
  * @file removeFromInventory.sqf
  * @author sbobovyc
  * @details
  * 
  */

_items = _this select 0;
{
	diag_log format["SVIS: removeFromInventory: %1", _x];
	if(isClass(configFile/"CfgMagazines"/_x)) then
	{
		player removeMagazine _x;
	} 
	else 
	{
		player removeItem _x;
	};	
} forEach _items;	
