extends CharacterBody3D

signal slapped

@export var movement_velocity = Vector3.ZERO
@export var speed = 750
@export var slapMax = 10
@export var slapMin = 1

var GLass = {
	texture=
	preload("res://assets/Slappables/GLASS.png"),
	h = 1,
	w = 1,
	a = false
	}
var reMOte = {
	texture=
	preload("res://assets/Slappables/Remote.png"),
	h = 1,
	w = 1,
	a = false
	}
var fISHbOwl ={
	texture=
	preload("res://assets/Slappables/FISHBOWL-5.png"),
	h = 3,
	w = 2,
	a = true
	}

func _ready():
	var assets = [GLass, reMOte, fISHbOwl]
	var name =  assets[randi() % assets.size()]
	if name.a:
		$Animation.play()
	else:
		$Animation.queue_free()
		$Sprite.texture  = name.texture
		$Sprite.hframes  = name.h
		$Sprite.vframes  = name.w


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully.ssss..xsdxcccsssxxd.awd
	velocity = movement_velocity
	move_and_slide()

func get_slapped():
	slapped.emit()
	movement_velocity = Vector3(randi_range(slapMin, slapMax), randi_range(slapMin, slapMax), randi_range(slapMin, slapMax))


# we can use format strings to pad it to a length of 2 with zeros, e.g. 01:20:12
