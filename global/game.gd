extends Node

# Menu variables
var menu_num = -1
var w1_unlocked = [1, 1, 0]

# Dynamic game values
var max_hp = 10
var player_hp = 10
var gold = 0
var gem = 0
var time_goal = 0
var this_scene = ""
var paused = false
var recap = false

# Static values
var bad_splashes = [
	"Looks like trouble!", 
	"What a foul move!", 
	"You're a bad egg!"
]

var good_splashes = [
	"Poultry in motion!",
	"You're flying high!",
	"Not half bad!"
]
