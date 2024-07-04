extends Weapon
class_name Gun
# Called when the node enters the scene tree for the first time.
@export var needsAimDown = 0
@export var canAimDown = 0
@export var aimdownTime = 1
var curAimdownTime = 0.2
@export var aimdownPos:Vector3
var currentAim:Vector3
@export var defaultAim:Vector3
@export var ammo = 40
@export var maxammo = 40
@export var reloadTimer = 2
@export var bullet :PackedScene
@export var clip = 7

@export var clipsize = 7
var attemptingReload = false
var aimdown = false
@export var firesound : AudioStreamWAV
var cooldown = 0
@export var delay = 1
func _process(delta):
	if cooldown > 0:
		#print(cooldown)
		cooldown = cooldown - delta
	if reloadTimer > 0 && attemptingReload:
		reloadTimer -= delta
	if aimdown:
		if (curAimdownTime+delta < aimdownTime):
			curAimdownTime += delta
	else:
		if (curAimdownTime-delta > 0):
			curAimdownTime -= delta
	currentAim = lerp(defaultAim,aimdownPos,curAimdownTime/aimdownTime)
func reload():
	if ammo != maxammo:
		attemptingReload = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func stopAimDown():
	pass
func attack():
	print("a")
	if (cooldown <= 0):
		var newbullet = bullet.instantiate() as RigidBody3D
		newbullet.linear_velocity+=Vector3.FORWARD*10
		get_tree().root.get_child(0).add_child(newbullet)
		cooldown = delay
		newbullet as RigidBody3D
		#$"..".add_child(newbullet)
		
		return newbullet
