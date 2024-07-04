extends RigidBody3D
class_name Destructable
@export var hitsound:Array
@export var smashsound:Array
@export var scrapesound:Array
@export var contains: PackedScene
@export var gibs: Array
@export var hp = 10

func attacked(dmg):
	var v = $AudioStreamPlayer as AudioStreamPlayer
	if (dmg>hp):
		print("attacked")

		v.stream = hitsound.pick_random() as AudioStreamWAV

	else:
		v.stream = smashsound.pick_random() as AudioStreamWAV
	v.play()
