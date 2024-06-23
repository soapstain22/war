extends Weapon
class_name Melee
@export var damage = 5
@export var hitbox = Area3D
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentAim = lerp(defaultAim,aimdownPos,cooldown/delay)
	var a = hitbox as Area3D
	#a.get_overlapping_bodies()
func stopAimDown():
	pass
func fire():
	print("a")
	if (cooldown <= 0):
		print("b")
		return shoot()

func reload():
	if ammo != maxammo:
		attemptingReload = true
func shoot():
	cooldown = delay
	#$"..".add_child(newbullet)
	print("this part")

