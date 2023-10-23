extends Node2D
class_name mainClass

# Stores the previous size of the Matrix (side length)
var prevSize: int = 2
var size: int = 2
@onready var matrixNode: MatrixController = $Matrix as MatrixController

var matrix = []

var D: float
var Dx: float
var Dy: float
var Dz: float
var x: float
var y: float
var z: float

func _on_matrix_size_value_changed(val):
	# change the text of the matrix size to fit with new value
	var size = matrixNode.sizeChange(val)
	$MatrixSizeText.text = "Matrix size: " + str(size) + "x" + str(size+1)
	

func _on_start_pressed():
	var matrixLine: Array[float]
	for i in $Matrix.get_children():
		matrixLine.append(float(i.text))
	for r in range(size):
		matrix.append([])
		for c in range(size+1):
			matrix[r].append(matrixLine.front())
			matrixLine.pop_front()


