extends Node2D

func _ready():
	$Coin.play("Idle")
	$Gem.hide()
	$Digit2.hide()

func set_gold(num):
	if num < 10:
		$Digit1.frame = num
	elif num == 10:
		$Digit2.show()
		$Digit1.frame = 1
	else:
		$Digit1.frame = num / 10
		$Digit2.frame = num % 10

func show_gem():
	$Gem.show()
	$Gem.play("Idle")
