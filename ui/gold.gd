extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("Label").text = str(Game.gold)
