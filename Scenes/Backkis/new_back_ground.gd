extends Node3D

@export var speed = -1.0

var bg1
var bg2
var velocity_vector = Vector3(speed, 0, 0)
var images = []
var generated_images = []
var image_width = 20.48


# Called when the node enters the scene tree for the first time.
func _ready():
	bg1 = $Body1
	bg2 = $Body2
	images = [bg1, bg2]

	for image in images:
		image.velocity = velocity_vector


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.x - images[0].position.x > image_width:
		var image = images.pop_front()
		image.position.x += image_width * 2
		images.push_back(image)

	for image in images:
		image.move_and_slide()
