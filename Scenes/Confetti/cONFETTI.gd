extends GPUParticles3D

var t = 0.0


func _ready():
	restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if t > lifetime:
		queue_free()
	t += _delta
