extends GridContainer
class_name MatrixController

var currentSize: int = 2
var prevSize: int = 2

func sizeChange(val):
	currentSize = val
	
	# when matrix size is changed, add/remove children of LineEdit as needed
	columns = currentSize + 1
	if currentSize > prevSize:
		# if new size is bigger, add children.
		# since this is adding to an already exisiting matrix, e.g. 1x1
		# only add needed children
		for i in range(currentSize*(currentSize+1) - prevSize*(prevSize+1)):
			addFromMatrix()
	elif currentSize < prevSize:
		# opposite of adding
		for i in range(prevSize*(prevSize+1) - currentSize*(currentSize+1)):
			removeFromMatrix()
	prevSize = currentSize
	return currentSize


	# add children to matrix
func addFromMatrix():
	var newLineEdit = LineEdit.new()
	add_child(newLineEdit)

	# kill children from matrix
func removeFromMatrix():
	get_children().back().free()
