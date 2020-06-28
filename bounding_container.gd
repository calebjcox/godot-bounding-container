class_name BoundingContainer
extends MarginContainer
# A `Container` that will scale the contents once it hits a max size
#
# Godot's built in container classes grow with the contents. This works well for
# a lot of cases but not when you want to be able to limit the size the of the
# container (e.g. when you want to keep the entire contents on the screen).
#
# This is simply a `BoundingContainer` node that extends the native 
# `MarginContainer`. This allows you to set a margin and a max size. If no max 
# size is provided, it will use the `viewport` size. 
#
# https://github.com/cjc89/godot-bounding-container


enum BoundingMode {
	SCREEN,
	SPECIFIED,
	SCREEN_AND_SPECIFIED,
	NONE,
}

export(BoundingMode) var width_bounding_mode = BoundingMode.SCREEN_AND_SPECIFIED
export(BoundingMode) var height_bounding_mode = BoundingMode.SCREEN_AND_SPECIFIED
export(int) var max_width = 0
export(int) var max_height = 0


func _ready():
	connect("sort_children", self, "scale")
	connect("resized", self, "scale")
	get_viewport().connect("size_changed", self, "scale")


func scale() -> void:
	var width: int
	var height: int
	var scaleX: float = 1
	var scaleY: float = 1
	var scale: float
	
	width = max_width if max_width > 0 else get_viewport().size.x
	height = max_height if max_height > 0 else get_viewport().size.y
	
	scaleX = getScaleX()
	scaleY = getScaleY()
	
	scale = min(scaleX, scaleY)
	rect_scale = Vector2(scale, scale)


func getScaleX() -> float:
	return _scaleFactor(width_bounding_mode, get_rect().size.x, max_width, get_viewport().size.x)


func getScaleY() -> float:
	return _scaleFactor(height_bounding_mode, get_rect().size.y, max_height, get_viewport().size.y)


func _scaleFactor(mode: int, size, max_size, screen_size) -> float:
	var scale: float = 1
	
	match mode:
		BoundingMode.SCREEN:
			if screen_size > 0:
				scale = screen_size / size
			
		BoundingMode.SPECIFIED:
			if max_size > 0:
				scale = max_size / size
			
		BoundingMode.SCREEN_AND_SPECIFIED:
			scale = _scaleFactor(BoundingMode.SCREEN, size, max_size, screen_size)
			scale = min(scale, _scaleFactor(BoundingMode.SPECIFIED, size, max_size, screen_size))
			
	return min(scale, float(1))
