#macro TS 16

//get tiles in room

var _w = ceil(room_width / TS);
var _h = ceil(room_height / TS);

//create motion plan
global.mp_grid = mp_grid_create(0,0, _w, _h, TS, TS);

//add solid instance to walls



