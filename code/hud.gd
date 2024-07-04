extends Control
var ammo:Label
var weap:TextureRect
var ammoCount =0 
var ammoTop= 0 
func _ready():
	ammo = $mainBox/Label as Label
	weap = $mainBox/weaponBox/weapon as TextureRect
func updateSlot():
	pass
	
func setMaxAmmo(count):
	ammoTop = count
	ammo.text = str(ammoCount)+"/"+str(ammoTop)
func setAmmo(count):
	ammoCount = count
	ammo.text = str(ammoCount)+"/"+str(ammoTop)
func ammoBlink():
	pass
func setIcon(icon):
	var a = $mainBox/weaponBox/weapon as TextureRect
	a.texture = icon
