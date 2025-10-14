extends Control

# Goes directly to the game world, feel free to change
@export var startGamePath: String = "res://game_world.tscn"

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(startGamePath)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	get_node("CanvasLayer/Settings").visible = true
