/**
 * This script build a group filter for the spawn ai module.
 */
 
#include "opdagger.hpp"
 
_side = _this select 0;

_filter_array = [];

_sideStr = "";
_faction = "";
_cfgRoot = [["CfgGroups"]] call bis_fnc_loadClass;

if(_side == west) then {
    _sideStr = "West";
    _faction = "BLU_F";
};

if(_side == east) then {
    _sideStr = "East";
    _faction = "OPF_F";
};


if(_side == west || _side == east) then {
    _group_types = (_cfgRoot >> _sideStr >> _faction) call bis_fnc_getCfgSubClasses;    
    {
        _type = _x;
        diag_log (LOG_STR + _type);        
        _group = (_cfgRoot >> _sideStr >> _faction >> _type) call bis_fnc_getCfgSubClasses;
        diag_log _group;
        {
            //_group_name = configName _x;
            _group_name = _x;
            diag_log (LOG_STR + _group_name);
            _filter_array pushBack _group_name;
        } forEach _group;
    } forEach _group_types;

};

_filter_string = _filter_array joinString '","';
_filter_string = '"' + _filter_string + '"';
diag_log (LOG_STR + _filter_string);
_filter_string