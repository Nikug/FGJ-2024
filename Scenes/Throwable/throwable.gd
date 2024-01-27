extends CharacterBody3D

signal slapped

@export var movement_velocity = Vector3.ZERO
@export var speed = 750
@export var slapMax = 10
@export var slapMin = 1
var hela = 1

var assets = [
	{
		texture=preload("res://assets/Slappables/GLASS.png"),
		h = 1,
		w = 1,
		a = false,
		hela = 1
		},
	{
		h = 1.5,
		w = 1,
		a = true,
		an = "fisu",
		hela = 1
		},
	{
		h = 2,
		w = 1,
		a = true,
		an = "lavalambbu",
		hela = 4
		},
	{
		h = 1,
		w = 1,
		a = true,
		an = "limu",
		hela = 1
		},
	{
		h = 0.5,
		w = 0.5,
		a = true,
		an = "kaukkari",
		hela = 1
		}]

func _ready():

	var selectedAsset =  assets[randi() % assets.size()]
	hela = selectedAsset.hela
	if selectedAsset.a:
		$Animation.animation = selectedAsset.an
		$Animation.play()
	else:
		$Animation.queue_free()
		$Sprite.texture  = selectedAsset.texture

	var box = BoxShape3D.new()
	box.extents.x = selectedAsset.w
	box.extents.y = selectedAsset.h
	box.extents.z = 1
	$CollisionShape3D.shape = box


func _physics_process(_delta):
	velocity = movement_velocity
	move_and_slide()

func get_slapped():
	slapped.emit()
	hela -= 1
	if hela == 0:
		movement_velocity = Vector3(randi_range(slapMin, slapMax), randi_range(slapMin, slapMax), randi_range(slapMin, slapMax))


