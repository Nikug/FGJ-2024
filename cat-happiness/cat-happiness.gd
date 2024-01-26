extends Control

var happyScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	happyScore += 20
	
	await get_tree().create_timer(1).timeout
	happyScore += 20
	
	await get_tree().create_timer(1).timeout
	happyScore += 20
	
	await get_tree().create_timer(1).timeout
	happyScore += 20
	
	await get_tree().create_timer(1).timeout
	happyScore += 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (happyScore <= 10):
		$"Cat-pic".changeCat("grumpy")
	elif (10 < happyScore && happyScore <= 50):
		$"Cat-pic".changeCat("cool")
	elif (50 < happyScore && happyScore <= 100):
		$"Cat-pic".changeCat("manic")
		
	$"HappinessBar".value = happyScore
		
	
