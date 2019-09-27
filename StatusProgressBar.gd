extends Panel

const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")

func _ready():
	$influence.visible = false
	
func set_influence(amount):
	if amount == INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE:
		$influence.visible = true
		$influence.scale = Vector2(0.1, 0.1)
		$influence.modulate = Color(0, 1, 0)
	if amount == INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE:
		$influence.visible = true
		$influence.scale = Vector2(0.15, 0.15)
		$influence.modulate = Color(0, 1, 0)
	if amount == INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE:
		$influence.visible = true
		$influence.scale = Vector2(0.1, 0.1)
		$influence.modulate = Color(1, 0, 0)
	if amount == INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE:
		$influence.visible = true
		$influence.scale = Vector2(0.15, 0.15)
		$influence.modulate = Color(1, 0, 0)
		
func reset_influence():
		$influence.visible = false