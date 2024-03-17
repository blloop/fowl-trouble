extends Node

# Dynamic game values
var max_hp = 10
var player_hp = 10
var gold = 0
var visited = false
var paused = false
var recap = false
var w1_unlocked = [1, 0, 0]

# Static values
var splashes = [
	"Looks like trouble!", 
	"What a foul move!", 
	"You're a bad egg!"
]
