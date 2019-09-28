extends Panel

const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")

func _ready():
	$influence.visible = false
	
func show_influence(amount):
	if amount == INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE:
		$influence.scale = Vector2(0.75, 0.75)
		$influence.play("arrowUp")
		$influence.visible = true
	if amount == INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE:
		$influence.scale = Vector2(1, 1)
		$influence.play("arrowUp")
		$influence.visible = true
	if amount == INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE:
		$influence.scale = Vector2(0.75, 0.75)
		$influence.play("arrowDown")
		$influence.visible = true
	if amount == INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE:
		$influence.scale = Vector2(1, 1)
		$influence.play("arrowDown")
		$influence.visible = true
		
		
func set_influence(amount):
	var value = amount;
	if amount == INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE:
		value = 1;
	if amount == INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE:
		value = 2;
	if amount == INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE:
		value = -1;
	if amount == INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE:
		value = -2;
	$ProgressBar.set_value($ProgressBar.value + value)
	
func reset_influence():
		$influence.visible = false