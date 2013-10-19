/**
 * @file getItemMap.sqf
 * @author sbobovyc
 * Example: [UniformItems player] call getItemMap;
 */
 
  _item_list = [];
//_item_list resize 10; // for performance
_item_count = [];
//_item_count resize 10;
_counter = 0;

_source_array = _this select 0;
{
	if(_x in _item_list) then {
		_i = _item_list find _x;
		_item_count set [_i, (_item_count select _i) + 1];
	} else {
		_item_list set [_counter, _x];
		_item_count set [_counter, 1];
		_counter = _counter + 1;
	};
} forEach _source_array;

[_item_list, _item_count];