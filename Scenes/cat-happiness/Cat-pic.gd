extends TextureRect

var grumpyCat = load("res://assets/cat_faces/UNHAPPY.png")
var coolCat = load("res://assets/cat_faces/NEUTRAL.png")
var manicCat= load("res://assets/cat_faces/HAPPY.png")



# Cat type = "grumpy" | "cool" | "manic"
func changeCat(catType: String):
	var animationPlayer: AnimationPlayer = $AnimationPlayer
	match catType:
		"grumpy":
			animationPlayer.stop()
			set_texture(grumpyCat)
		"cool":
			animationPlayer.stop()
			set_texture(coolCat)
		"manic":
			animationPlayer.play("pulse")
			set_texture(manicCat)
			
			
