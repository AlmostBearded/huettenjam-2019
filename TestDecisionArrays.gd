var test_decisions = []

const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")

func _init():
	var decision_class = load("res://TestDecision.gd")
	var test_decision1 = decision_class.new("Test1", INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, null, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, null, INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE, null, INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE, null)
	var test_decision2 = decision_class.new("Test2", null, INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE, null, null, null, null)
	var test_decision3 = decision_class.new("Test3", INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE)
	var test_decision4 = decision_class.new("Test4", null, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, null, null, null, null, null)
	var test_decision5 = decision_class.new("Test5", null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, null, null)
	var test_decision6 = decision_class.new("Test6", null, null, null, INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE, INFLUENCE_ENUM.SMALL_NEGATIVE_INFLUENCE, null, null, null, INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE, INFLUENCE_ENUM.SMALL_POSITIVE_INFLUENCE)
	var test_decision7 = decision_class.new("Test7", null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, null, null, null, INFLUENCE_ENUM.BIG_POSITIVE_INFLUENCE, null, null, null)
	
	test_decisions = [test_decision1, test_decision2, test_decision3, test_decision4, test_decision5, test_decision6, test_decision7]
	randomize()
	
func get_random_decision():
	return test_decisions[randi()%test_decisions.size()]