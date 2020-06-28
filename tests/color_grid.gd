extends BoundingContainer


onready var ColorBlock = preload("color_block.tscn")


func _ready():
	for i in range($GridContainer.columns * $GridContainer.columns):
		$GridContainer.add_child(ColorBlock.instance())
