class_name ColorBlock
extends TextureRect


export(int) var size = 100


func _ready():
	self.texture = createImageTexture()


func randomColor() -> Color:
	randomize()
	return Color(rand_range(0,1), rand_range(0,1), rand_range(0,1))


func createImage() -> Image:
	var color := randomColor()
	var image := Image.new()
	image.create(size, size, false, Image.FORMAT_RGB8)
	image.lock()
	for x in range(size):
		for y in range(size):
			image.set_pixel(x, y, color)
	image.unlock()
	return image


func createImageTexture() -> ImageTexture:
	var imageTexture := ImageTexture.new()
	imageTexture.set_storage(ImageTexture.STORAGE_COMPRESS_LOSSY)
	imageTexture.create_from_image(createImage())
	return imageTexture
