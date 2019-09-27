extends Panel

export var id = 1

onready var text = $ViewportContainer/Panel/Label

var active_decision
const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")
enum {LEFT, NEUTRAL, RIGHT}
var choice = NEUTRAL
const TEST_DECISION_ARRAY = preload("res://TestDecisionArrays.gd")

func _ready():	
	randomize()
	var decision_array_class = load("res://TestDecisionArrays.gd")
	var decision_array = decision_array_class.new()
	active_decision = decision_array.get_random_decision();
	text.text = active_decision.text

func get_input():		
	if Input.is_action_just_pressed("accept_p%s" %id):
		if choice == NEUTRAL:
			set_right_influences(active_decision)
			text.text = 'Right option chosen'
			choice = RIGHT
		elif choice == RIGHT:
			text.text = 'Right option confirmed'
			choice = NEUTRAL
			reset_influences()
		else:
			text.text = 'Left option revoked'
			choice = NEUTRAL	
			reset_influences()
	if Input.is_action_just_pressed("reject_p%s" %id):
		if choice == NEUTRAL:
			set_left_influences(active_decision)
			text.text = 'Left option chosen'
			choice = LEFT
		elif choice == LEFT:
			text.text = 'Left option confirmed'
			choice = NEUTRAL
			reset_influences()
		else:
			text.text = 'Right option revoked'
			choice = NEUTRAL	
			reset_influences()
			
func _process(delta):
	get_input()
	
func set_left_influences(option):
	if option.left_influence_status1 != null:
			$Status.set_influence(option.left_influence_status1)
	if option.left_influence_status2 != null:
			$Status2.set_influence(option.left_influence_status2)
	if option.left_influence_status3 != null:
			$Status3.set_influence(option.left_influence_status3)
	if option.left_influence_status4 != null:
			$Status4.set_influence(option.left_influence_status4)
	if option.left_influence_status5 != null:
			$Status5.set_influence(option.left_influence_status5)

func set_right_influences(option):
	if option.right_influence_status1 != null:
			$Status.set_influence(option.right_influence_status1)
	if option.right_influence_status2 != null:
			$Status2.set_influence(option.right_influence_status2)
	if option.right_influence_status3 != null:
			$Status3.set_influence(option.right_influence_status3)
	if option.right_influence_status4 != null:
			$Status4.set_influence(option.right_influence_status4)
	if option.right_influence_status5 != null:
			$Status5.set_influence(option.right_influence_status5)

func reset_influences():
	$Status.reset_influence()
	$Status2.reset_influence()
	$Status3.reset_influence()
	$Status4.reset_influence()
	$Status5.reset_influence()
