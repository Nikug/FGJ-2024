extends CharacterBody3D

signal slapped

@export var movement_velocity = Vector3.ZERO
@export var speed = 750
@export var slapMax = 10
@export var slapMin = 1
var hela = 1

var GLass = {
	texture=
	preload("res://assets/Slappables/GLASS.png"),
	h = 1,
	w = 1,
	a = false,
	hela = 1
	}
var reMOte = {
	texture=
	preload("res://assets/Slappables/Remote.png"),
	h = 0.5,
	w = 0.5,
	a = false,
	hela = 1
	}
var fISHbOwl ={
	texture=
	preload("res://assets/Slappables/FISHBOWL-5.png"),
	h = 1.5,
	w = 1,
	a = true,
	an = "fisu",
	hela = 1
	}
var lavaLamBbu ={
	texture=
	preload("res://assets/Slappables/FISHBOWL-5.png"),
	h = 2,
	w = 1,
	a = true,
	an = "lavalambbu",
	hela = 4
	}
var limu ={
	texture=
	preload("res://assets/Slappables/FISHBOWL-5.png"),
	h = 1,
	w = 1,
	a = true,
	an = "limu",
	hela = 1
	}
var kaukkari ={
	texture=
	preload("res://assets/Slappables/FISHBOWL-5.png"),
	h = 0.5,
	w = 0.5,
	a = true,
	an = "kaukkari",
	hela = 1
	}

func _ready():
	var assets = [GLass, fISHbOwl, lavaLamBbu, kaukkari, limu]

	var name =  assets[randi() % assets.size()]
	hela = name.hela
	if name.a:
		$Animation.animation = name.an
		$Animation.play()
		var current_animation : String = $Animation.animation
		var sprite_texture : Texture = $Animation.sprite_frames.get_frame_texture(current_animation, 0)
		var size  = sprite_texture.get_size()

		var box = BoxShape3D.new()
		box.extents.x = name.w
		box.extents.y = name.h
		box.extents.z = 1
		$CollisionShape3D.shape = box
	else:
		var box = BoxShape3D.new()

		$Animation.queue_free()
		$Sprite.texture  = name.texture
		$Sprite.hframes  = name.h
		$Sprite.vframes  = name.w
		var size  = name.texture.get_size()

		box.extents.x = name.w
		box.extents.y = name.h
		box.extents.z = 1
		$CollisionShape3D.shape = box


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully.ssss..xsdxcccsssxxd.awd
	velocity = movement_velocity
	move_and_slide()

func get_slapped():
	slapped.emit()
	hela -= 1
	if hela == 0:
		movement_velocity = Vector3(randi_range(slapMin, slapMax), randi_range(slapMin, slapMax), randi_range(slapMin, slapMax))


# we can use format strings to pad it to a length of 2 with zeros, e.g. 01:20:12
