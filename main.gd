extends Node2D

# Stores the previous size of the Matrix (side length)
var prevSize: int = 2
static var size: int = 2

static var matrix = []

static var D
static var Dx
static var Dy
static var Dz
static var x: float
static var y: float
static var z: float

func _on_matrix_size_value_changed(val):
	# change the text of the matrix size to fit with new value
	size = val
	print(size)
	$MatrixSizeText.text = "Matrix size: " + str(size) + "x" + str(size+1)
	
	# when matrix size is changed, add/remove children of LineEdit as needed
	$Matrix.columns = size + 1
	if size > prevSize:
		# if new size is bigger, add children.
		# since this is adding to an already exisiting matrix, e.g. 1x1
		# only add needed children
		for i in range(size*(size+1) - prevSize*(prevSize+1)):
			addFromMatrix()
		# adjust position of matrix to be centered
		# this loop is done to prevent problems when skipping to e.g 1 --> 5
		for i in range(size - prevSize):
			$Matrix.position.x = $Matrix.position.x - 32
	elif size < prevSize:
		# opposite of adding
		for i in range(prevSize*(prevSize+1) - size*(size+1)):
			removeFromMatrix()
		# adjust position of matrix to be centered
		for i in range(prevSize - size): 
			$Matrix.position.x = $Matrix.position.x + 32
	prevSize = size
	
	# add children to matrix
func addFromMatrix():
	var newLineEdit = LineEdit.new()
	$Matrix.add_child(newLineEdit)

	# kill children from matrix
func removeFromMatrix():
	$Matrix.get_children().back().free()

func _on_start_pressed():
	var matrixLine: Array[int]
	for i in $Matrix.get_children():
		matrixLine.append(int(i.text))
	for r in range(size):
		matrix.append([])
		for c in range(size+1):
			matrix[r].append(matrixLine.front())
			matrixLine.pop_front()
			
	print(matrix)
	print(matrix[1][1])
	if size == 2:
		solveFor2x3()
	if size == 3:
		solveFor3x4()
	print("D: " + str(D))
	print("Dx: " + str(Dx))
	print("Dy: " + str(Dy))
	print("Dz: " + str(Dz))
	print("x: " + str(x))
	print("y: " + str(y))
	print("z: " + str(z))
	goToCalculatingScreen()
	
func goToCalculatingScreen():
	get_tree().change_scene_to_file("res://calculating_screen.tscn")

func solveFor2x3():
	D = calculateD2x2()
	Dx = calculateDx2x2()
	Dy = calculateDy2x2()
	if D == 0:
		print("D is zero.")
	else:
		x = Dx/D
		y = Dy/D
		
# not done
func solveFor3x4():
	var solveDDxorDy = 1
	var matrix1 = solve1st2x2(solveDDxorDy)
	var matrix2 = solve2nd2x2(solveDDxorDy)
	var matrix3 = solve3rd2x2(solveDDxorDy)
	D = matrix[0][0] * matrix1 - matrix[0][1] * matrix2 + matrix[0][2] * matrix3
	print("Matrix1 D: " + str(matrix1))
	print("Matrix2 D: " + str(matrix2))
	print("Matrix3 D: " + str(matrix3))
	
	solveDDxorDy = 2
	matrix1 = solve1st2x2(solveDDxorDy)
	matrix2 = solve2nd2x2(solveDDxorDy)
	matrix3 = solve3rd2x2(solveDDxorDy)
	Dx = matrix[0][3] * matrix1 - matrix[0][1] * matrix2 + matrix[0][2] * matrix3
	print("Matrix1 Dx: " + str(matrix1))
	print("Matrix2 Dx: " + str(matrix2))
	print("Matrix3 Dx: " + str(matrix3))
	
	solveDDxorDy = 3
	matrix1 = solve1st2x2(solveDDxorDy)
	matrix2 = solve2nd2x2(solveDDxorDy)
	matrix3 = solve3rd2x2(solveDDxorDy)
	Dy = matrix[0][0] * matrix1 - matrix[0][3] * matrix2 + matrix[0][2] * matrix3
	print("Matrix1 Dy: " + str(matrix1))
	print("Matrix2 Dy: " + str(matrix2))
	print("Matrix3 Dy: " + str(matrix3))
	
	solveDDxorDy = 4
	matrix1 = solve1st2x2(solveDDxorDy)
	matrix2 = solve2nd2x2(solveDDxorDy)
	matrix3 = solve3rd2x2(solveDDxorDy)
	Dz = matrix[0][0] * matrix1 - matrix[0][1] * matrix2 + matrix[0][3] * matrix3
	print("Matrix1 Dz: " + str(matrix1))
	print("Matrix2 Dz: " + str(matrix2))
	print("Matrix3 Dz: " + str(matrix3))
	
	if D == 0:
		print("D is zero. aaa")
	else:
		x = float(Dx)/D
		y = float(Dy)/D
		z = float(Dz)/D

func solve1st2x2(solveDDxorDy):
	if solveDDxorDy == 1:
		return matrix[1][1]*matrix[2][2] - matrix[1][2]*matrix[2][1]
	elif solveDDxorDy == 2:
		return matrix[1][1]*matrix[2][2] - matrix[1][2]*matrix[2][1]
	elif solveDDxorDy == 3:
		return matrix[1][3]*matrix[2][2] - matrix[1][2]*matrix[2][3]
	elif solveDDxorDy == 4:
		return matrix[1][1]*matrix[2][3] - matrix[1][3]*matrix[2][1]
func solve2nd2x2(solveDDxorDy):
	if solveDDxorDy == 1:
		return matrix[1][0]*matrix[2][2] - matrix[1][2]*matrix[2][0]
	elif solveDDxorDy == 2:
		return matrix[1][3]*matrix[2][2] - matrix[1][2]*matrix[2][3]
	elif solveDDxorDy == 3:
		return matrix[1][0]*matrix[2][2] - matrix[1][2]*matrix[2][0]
	elif solveDDxorDy == 4:
		return matrix[1][0]*matrix[2][3] - matrix[1][3]*matrix[2][0]
func solve3rd2x2(solveDDxorDy):
	if solveDDxorDy == 1:
		return matrix[1][0]*matrix[2][1] - matrix[1][1]*matrix[2][0]
	elif solveDDxorDy == 2:
		return matrix[1][3]*matrix[2][1] - matrix[1][1]*matrix[2][3]
	elif solveDDxorDy == 3:
		return matrix[1][0]*matrix[2][3] - matrix[1][3]*matrix[2][0]
	elif solveDDxorDy == 4:
		return matrix[1][0]*matrix[2][1] - matrix[1][1]*matrix[2][0]

# currently done
func calculateD2x2():
	return matrix[0][0]*matrix[1][1] - matrix[0][1]*matrix[1][0]
func calculateDx2x2():
	return matrix[0][2]*matrix[1][1] - matrix[0][1]*matrix[1][2]
func calculateDy2x2():
	return matrix[0][0]*matrix[1][2] - matrix[0][2]*matrix[1][0]
