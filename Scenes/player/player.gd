extends Area2D

@export var speed = 400
var screen_size
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_released("slap"):
		slap()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		_animated_sprite.play("walk")
	else:
		if _animated_sprite.animation != "slap":
			_animated_sprite.play("idle")
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func slap():
	_animated_sprite.play("slap")
