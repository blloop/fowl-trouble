extends Node2D

func _ready():
	$Coin.play("Idle")
	$Gem.hide()

func _process(_delta):
	$Label.text = str(Game.gold)

func show_gem():
	$Gem.show()
	$Gem.play("Idle")
