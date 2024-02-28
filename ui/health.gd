extends Node2D

# Same as game.gd
var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func decrease():
	health -= 1
	self.get_child(health / 2).frame += 1
