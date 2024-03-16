extends Node2D

# Same as game.gd
var health = 10

func decrease():
	health -= 1
	self.get_child(health / 2).frame += 1
