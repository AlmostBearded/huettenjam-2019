class_name Pool

var dict 
var size

func _init():
	dict = {}
	size = 0
	
func insert(card):
	if not dict.has(card.id):
		dict[card.id] = card
	size = size + 1

func pull(id):
	if(size < 1):
		return null
	var card = dict[id]
	dict.erase(id)
	return card

func select_succ(succ_list):
	randomize()
	#if no successors get one of the general ones at random
	if succ_list.empty():
		var random = randi() % 100
		var possible_succ = []
		for key in dict.keys():
			if dict.is_general:
				possible_succ.add(key)
		return possible_succ[randi() % possible_succ.size()]
	#just one successors
	elif succ_list.size() == 1:
		return succ_list.keys()[0]
	#mor than one successors
	else: 
		var random = randi() % 100
		var range_start = 0
		for key in succ_list.keys():
			var range_end = succ_list[key]
			if random >= range_start and random <= range_end:
				return key
			else:
				range_start = range_end
		

	


