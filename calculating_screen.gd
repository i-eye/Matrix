extends Node2D

var matrix = main.matrix
var size = main.size
var D = main.D
var Dx = main.Dx
var Dy = main.Dy
var Dz = main.Dz
var x = main.x
var y = main.y
var z = main.z

func _ready():
	for r in range(size):
		$Matrix.text += "\n"
		for c in range(size+1):
			if c == size:
				$Matrix.text += str(matrix[r][c])
			else:
				$Matrix.text += str(matrix[r][c]) + ", "
			

	$D.text = "D = " + str(D)
	$Dx.text = "Dx = " + str(Dx)
	$Dy.text = "Dy = " + str(Dy)
	$Dz.text = "Dz = " + str(Dz)
	if size == 2:
		$Answer.text = "Answer: (" + str(x) + ", " + str(y) + ")"
	else:
		$Answer.text = "Answer: (" + str(x) + ", " + str(y) + ", " + str(z) + ")"
