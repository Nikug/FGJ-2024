extends TextureRect

var grumpyCat = load("res://Scenes/cat-happiness/UNHAPPY.png")
var coolCat = load("res://Scenes/cat-happiness/NEUTRAL.png")
var manicCat= load("res://Scenes/cat-happiness/manic-cat.jpg")


# Cat type = "grumpy" | "cool" | "manic"
func changeCat(catType: String):
	match catType:
		"grumpy":
			set_texture(grumpyCat)
		"cool":
			set_texture(coolCat)
		"manic":
			set_texture(manicCat)
