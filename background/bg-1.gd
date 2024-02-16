extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ParallaxLayer/Water1").play("Idle")
	get_node("ParallaxLayer/Water2").play("Idle")
	get_node("ParallaxLayer/Water3").play("Idle")
	get_node("ParallaxLayer/Water4").play("Idle")
