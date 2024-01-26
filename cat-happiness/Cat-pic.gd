extends TextureRect

var grumpyCat = load("res://cat-happiness/grumpy-cat.webp")
var coolCat = load("res://cat-happiness/ok-cat.jpg")
var manicCat= load("res://cat-happiness/manic-cat.jpg")


# Cat type = "grumpy" | "cool" | "manic"
func changeCat(catType: String):
	match catType:
		"grumpy":
			set_texture(grumpyCat)
		"cool":
			set_texture(coolCat)
		"manic":
			set_texture(manicCat)
