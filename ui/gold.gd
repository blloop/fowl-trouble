extends Node2D

func _ready():
	$AnimatedSprite2D.play("Idle")

func _process(_delta):
	$Label.text = str(Game.gold)
