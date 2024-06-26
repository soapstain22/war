extends Weapon
class_name Melee
@export var damage = 5
@export var hitbox = Area3D
@export var delay = 1
var currentDelay = 0
@export var swingTarget:Transform3D
@export var swingStart:Transform3D
@export var root:Transform3D
var swinging:bool = false
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ((currentDelay - delta) >0):
		currentDelay -= delta
	else:
		currentDelay = delay
func fire():
	
	pass
