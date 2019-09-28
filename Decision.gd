extends Panel

var man1_image = preload("res://images/man1.png")
var man2_image = preload("res://images/man2.png")
var woman1_image = preload("res://images/woman1.png")

var imageArray = [man1_image, man2_image, woman1_image]

func _ready():
	randomize()
	set_portrait()
	
func set_portrait():
	$PortraitPanel/portrait_background/portrait.set_texture(imageArray[randi()%imageArray.size()])