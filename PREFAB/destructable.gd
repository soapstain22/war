extends Node3D
class_name Destructable
@export var gibs:Array
@export var sound:AudioStreamWAV
func destroy():
	var a = gibs.pick_random() as PackedScene
	a.instantiate().reparent(self)
	a.instantiate().reparent(self)
	a.instantiate().reparent(self)
	a.instantiate().reparent(self)
