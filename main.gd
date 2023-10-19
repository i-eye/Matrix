extends Node2D

	
func _on_matrix_size_value_changed(size):
	size = $MatrixSize.value
	$MatrixSizeText.text = "Matrix size: " + str(size) + "x" + str(size)


func _on_start_pressed():
	get_tree().change_scene_to_file("res://calculating_screen.tscn")

# TODO: Make matrix usable by adding text editor things idk
