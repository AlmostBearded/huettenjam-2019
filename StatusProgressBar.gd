extends Panel

const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")
const MAX_SCALE = 1.5
const MIN_SCALE = 0.75

func _ready():
	$influence.visible = false
	
func show_influence(amount):
	var scale = MIN_SCALE * (1 - abs(amount)) + MAX_SCALE * abs(amount)
	if amount > 0:
		$influence.scale = Vector2(scale, scale)
		$influence.play("arrowUp")
		$influence.visible = true
	elif amount < 0:
		$influence.scale = Vector2(scale, scale)
		$influence.play("arrowDown")
		$influence.visible = true
		
#TODO: don't calculate the value here, just update it, when the data is updated
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