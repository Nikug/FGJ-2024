extends TextureRect

var grumpyCat = load("res://assets/cat_faces/UNHAPPY.png")
var coolCat = load("res://assets/cat_faces/NEUTRAL.png")
var manicCat= load("res://assets/cat_faces/manic-cat.jpg")


# Cat type = "grumpy" | "cool" | "manic"
func changeCat(catType: String):
	match catType:
		"grumpy":
			set_texture(grumpyCat)
		"cool":
			set_texture(coolCat)
		"manic":
			set_texture(manicCat)
