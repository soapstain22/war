extends Pickup
class_name Collectable
@export var restored_health=0
@export var restored_armor=0
@export var restored_556=0
@export var restored_327=0
@export var restored_9mm=0
@export var collision:Area3D
@export var forced:bool

func _on_area_3d_body_entered(body):
	print(body)
	if (body.get_class() == "CharacterBody3D"):
		var a = body as Player
		
		if(a.ask_health(restored_health)):
			get_parent().remove_child(self)
	pass # Replace with function body.
