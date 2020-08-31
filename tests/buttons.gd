extends Node


var bounding: BoundingContainer


func _ready():
	bounding = self.find_parent("BoundingContainer")
	_setHorizontalText()
	_setVerticalText()


func _setVerticalText():
	$Vertical.text = "Vertical: " + str(bounding.height_bounding_mode)


func _setHorizontalText():
	$Horizontal.text = "Horizontal: " + str(bounding.width_bounding_mode)
	
	
func _nextMode(mode):
	mode += 1
	if mode > BoundingContainer.BoundingMode.SCREEN_AND_SPECIFIED:
		mode = 0
	return mode


func _nextVerticalMode():
	bounding.height_bounding_mode = _nextMode(bounding.height_bounding_mode)
	_setVerticalText()


func _nextHorizontalMode():
	bounding.width_bounding_mode = _nextMode(bounding.width_bounding_mode)
	_setHorizontalText()

func _on_Vertical_pressed():
	_nextVerticalMode()


func _on_Horizontal_pressed():
	_nextHorizontalMode()


func _on_Bigger_pressed():
	bounding.max_height += 50
	bounding.max_width += 50


func _on_Smaller_pressed():
	bounding.max_height -= 50
	bounding.max_width -= 50
