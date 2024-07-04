extends CharacterBody3D
class_name Player
@export var SPEED : float = 5.0
@export var JUMP_VELOCITY : float = 4.5
@export var MOUSE_SENSITIVITY : float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
var playerClass : CasteSystem
var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var _mouse_rotation : Vector3
var _player_rotation : Vector3
var _camera_rotation : Vector3
var weapons : Array
var weaponIndex = 0
var HUD
var hand: Node3D
var headlag= 1
var crouch = 1
@export var maxhealth= 100
@export var health = 100 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event: InputEvent) -> void:
	
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
	if event.is_action_pressed("fire"):
		attack()
	if event.is_action_pressed("switch_weap_up"):
		changeweapon(1)
	if event.is_action_pressed("switch_weap_down"):
		changeweapon(-1)
	if event.is_action_pressed("action"):
		var a = weapons[weaponIndex] as Weapon
	else:
		var a = weapons[weaponIndex] as Weapon

	if event.is_action_pressed("run"):
		SPEED = 9
	if event.is_action_released("run"):
		SPEED = 5
func _input(event):
	#if event.is_action_pressed("exit"):
	#	get_tree().quit()
	pass
func _update_camera(delta):

	# Rotates camera using euler rotation
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)

	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	CAMERA_CONTROLLER.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0
	#hand.global_position = CAMERA_CONTROLLER.global_position
	#hand.global_rotation = CAMERA_CONTROLLER.global_rotation

func _ready():
	hand = $Camera3D/hand
	
	give_instance(preload("res://scenes/prefabs/weapons/WP_Gun.tscn"))
	# Get mouse input
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	CAMERA_CONTROLLER = $Camera3D
	HUD = $Control
func ask_health(ct):
	if maxhealth <= health:
		print("health full")
		return false
	health= clamp(ct + health,0,maxhealth)

	return true
func _physics_process(delta):

	# Update camera movement based on mouse movement
	_update_camera(delta)

	# Add the gravity.i
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("goleft", "goright", "goforward", "gobackward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			CAMERA_CONTROLLER.position = Vector3.UP*abs(sin(headlag*SPEED))/3+Vector3.UP*1.5
			var spd = global_position.distance_to(global_position+direction)
			headlag+=delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if not is_on_floor():
			CAMERA_CONTROLLER.position = Vector3.UP*lerpf(CAMERA_CONTROLLER.position.y,1.5,delta*5)
	var a = weapons[weaponIndex]
	#a.global_position = hand.global_position + CAMERA_CONTROLLER.basis*a.currentAim
	move_and_slide()
	# THIS WAS BLATANTLY STOLEN FROM https://github.com/StayAtHomeDev-Git/FPS-Godot-Basic-Setup/blob/main/controllers/scripts/fps_controller.gd
func attack():
	#var a = $".."
	#a.add_child(weapons[weaponIndex])
	#var hi = weapons[weaponIndex].fire() as RigidBody3D
	var a = weapons[weaponIndex] as Weapon
	var b = a.attack() as RigidBody3D
	if b != null:
		b.global_position = hand.global_position
		b.global_rotation = hand.global_rotation
		b.linear_velocity = CAMERA_CONTROLLER.global_basis*b.linear_velocity
		#b.linear_velocity = CAMERA_CONTROLLER.global_basis*b.linear_velocity
		print("hi")
	#HUD.setMaxAmmo(a.maxammo)
	#HUD.setAmmo(a.ammo)
	pass
	#hi.global_position = global_position
func changeweapon(dir):
	print("changing")
	weapons[weaponIndex].visible = false
	if(dir==1):
		weaponIndex = (weaponIndex+1)%len(weapons)
	if(dir==-1):
		weaponIndex = (weaponIndex-1)%len(weapons)
	weapons[weaponIndex].visible = true
	HUD.setIcon(weapons[weaponIndex].image)
	
func give_instance(weap):
	var a = weap.instantiate()
	weapons.push_front(a)
	hand.add_child(a)

func set_equipped(weapo):
	pass
func add_health(toadd):
	health += toadd
