extends Control

var happyScore = 0
var player_id = 0

func _ready():
	
	while(true):
		if (happyScore >= 100):
			$"/root/Gamestate".increment_happiness(player_id, -100)
		await get_tree().create_timer(0.5).timeout
		$"/root/Gamestate".increment_happiness(player_id)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	happyScore = $"/root/Gamestate".get_happiness_score(player_id)
	
	if (happyScore <= 10):
		$"Cat-pic".changeCat("grumpy")
	elif (10 < happyScore && happyScore <= 50):
		$"Cat-pic".changeCat("cool")
	elif (50 < happyScore && happyScore <= 100):
		$"Cat-pic".changeCat("manic")
		
	$"HappinessBar".value = happyScore
	
	
	
	
	
