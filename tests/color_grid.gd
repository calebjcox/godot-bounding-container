extends GridContainer


export(int, 1, 20) var Columns = 10
export(int, 1, 20) var Rows = 10
export(int, 10, 1000, 10) var Block_Size = 100
onready var ColorBlock = preload("color_block.tscn")


func _ready():
	var block: ColorBlock
	self.columns = Columns
	for i in range(Columns * Rows):
		block = ColorBlock.instance()
		block.size = Block_Size
		self.add_child(block)
