extends Node2D

# Same as game.gd
var health = Game.max_hp

func decrease():
	health -= 1
	self.get_child(health / 2).frame += 1
