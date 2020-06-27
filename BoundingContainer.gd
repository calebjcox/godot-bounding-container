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



export(int) var max_width = 0
export(int) var max_height = 0


func _ready():
	connect("sort_children", self, "scale")
	connect("resized", self, "scale")
	get_viewport().connect("size_changed", self, "scale")


func scale():
	var width: int
	var height: int
	var scaleX: float = 1
	var scaleY: float = 1
	var scale: float
	
	width = max_width if max_width > 0 else get_viewport().size.x
	height = max_height if max_height > 0 else get_viewport().size.y
	
	if get_rect().size.x > width:
		scaleX = width / get_rect().size.x
	if get_rect().size.y > height:
		scaleY = height / get_rect().size.y
	
	scale = min(scaleX, scaleY)
	print("Scale: " + str(scale))
	rect_scale = Vector2(scale, scale)
