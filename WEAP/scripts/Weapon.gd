extends Node
class_name Weapon

@export var model : MeshInstance3D
@export var bullet :PackedScene
@export var clip = 7
@export var clipsize = 7
@export var ammo = 40
@export var maxammo = 40
@export var ammotimerOnreset = 2
@export var ammotimer = 2
@export var cooldown = 2
@export var delay = 1
@export var needsAimDown = 0
@export var canAimDown = 0
@export var aimdownTime = 1
var curAimdownTime = 0.2
@export var aimdownPos:Vector3
var currentAim:Vector3
@export var defaultAim:Vector3
var attemptingReload = false
var aimdown = false
@export var firesound : AudioStreamWAV
@export var image: CompressedTexture2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		#print(cooldown)
		cooldown = cooldown - delta
	if ammotimer > 0 && attemptingReload:
		ammotimer -= delta
	print(curAimdownTime)
	if aimdown:
		if (curAimdownTime+delta < aimdownTime):
			print("p")
			curAimdownTime += delta
	else:
		if (curAimdownTime-delta > 0):
			curAimdownTime -= delta
	currentAim = lerp(defaultAim,aimdownPos,curAimdownTime/aimdownTime)
	
func stopAimDown():
	pass
func fire():
	print("a")
	if (cooldown <= 0):
		print("b")
		return shoot()
		#firesound.instantiate_playback()
		#var newbullet:RigidBody3D = bullet.instantiate() as RigidBody3D
		#newbullet.apply_central_force(Vector3.FORWARD*6)
		#$"..".add_child(newbullet)
		#print("this part")
		#return newbullet
	
func reload():
	if ammo != maxammo:
		attemptingReload = true
func shoot():
		#firesound.instantiate_playback()
		var newbullet = bullet.instantiate() as RigidBody3D
		cooldown = delay
		#$"..".add_child(newbullet)
		print("this part")

		return newbullet
