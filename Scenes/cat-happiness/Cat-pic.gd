extends TextureRect

var grumpyCat = load("res://assets/cat_faces/UNHAPPY.png")
var coolCat = load("res://assets/cat_faces/NEUTRAL.png")
var manicCat= load("res://assets/cat_faces/HAPPY.png")

var grumpyCatAlt = load("res://assets/cat_faces/pekka.png")
var coolCatAlt = load("res://assets/cat_faces/alex.png")
var manicCatAlt = load("res://assets/cat_faces/jussi.png")


# Cat type = "grumpy" | "cool" | "manic"
func changeCat(catType: String):
	var animationPlayer: AnimationPlayer = $AnimationPlayer
	var funModifier = $"/root/Gamestate".funModifier
	match catType:
		"grumpy":
			animationPlayer.stop()
			set_texture(grumpyCat if !funModifier else grumpyCatAlt)
		"cool":
			animationPlayer.stop()
			set_texture(coolCat if !funModifier else coolCatAlt)
		"manic":
			animationPlayer.play("pulse")
			set_texture(manicCat if !funModifier else manicCatAlt)

