extends Weapon
class_name RocketLauncher
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet = preload("res://rocket.tscn")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
