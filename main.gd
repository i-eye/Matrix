# TODO: 1. make it so either all text from matrix is removed when changing size
# or make it so LineEdit stay in their current positions when adding more children
# 2. center matrix
extends Node2D

# Stores the previous size of the Matrix (side length)
var prevSize: int = 1

func _on_matrix_size_value_changed(size):
	# change the text of the matrix size to fit with new value
	size = $MatrixSize.value
	$MatrixSizeText.text = "Matrix size: " + str(size) + "x" + str(size)
	
	# when matrix size is changed, add/remove children of LineEdit as needed
	$Matrix.columns = size
	if size > prevSize:
		# if new size is bigger, add children.
		# since this is adding to an already exisiting matrix, e.g. 1x1
		# only add needed children
		for i in range(size*size - prevSize*prevSize):
			addFromMatrix()
		# opposite of adding
	elif size < prevSize:
		for i in range(prevSize*prevSize - size*size):
			removeFromMatrix()
	prevSize = size
	
	# add children to matrix
func addFromMatrix():
	var newLineEdit = LineEdit.new()
	$Matrix.add_child(newLineEdit)

	# kill children from matrix
func removeFromMatrix():
	$Matrix.get_children().back().free()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://calculating_screen.tscn")



	
