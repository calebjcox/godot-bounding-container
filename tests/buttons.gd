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
	if mode > BoundingContainer.BoundingMode.NONE:
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
	bounding.max_height += 10


func _on_Horizontal_pressed():
	_nextHorizontalMode()
	bounding.max_width += 10
