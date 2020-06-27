# godot-bounding-container
Godot's built in container classes grow with the contents. This works well for a lot of cases but not when you want to be able to limit the size the of the container (e.g. when you want to keep the entire contents on the screen).

This is simply a `BoundingContainer` node that extends the native `MarginContainer`. This allows you to set a margin and a max size. If no max size is provided, it will use the `viewport` size. 
