extends TextureButton

onready var buttons: Control = get_node("Buttons")
onready var tween: Tween = get_node("Tween")

var can_show_menu: bool = true

func on_button_pressed() -> void:
	if can_show_menu:
		buttons.show()
		show_menu()
		can_show_menu = false
		
		
func show_menu() -> void:
	var interaction: int = 0
	for button in buttons.get_children():
		interaction += 1
		var _interpolate_to = tween.interpolate_property(button, "position", button.position, button.position + Vector2(-21 * interaction, 0), .5, Tween.TRANS_BACK, Tween.EASE_OUT)
		var _interpolate_from = tween.interpolate_property(button, "position", button.position + Vector2(-21 * interaction, 0), Vector2.ZERO, .5, Tween.TRANS_BACK, Tween.EASE_OUT, 2.0)
	
	var _start_tween = tween.start()
	
	
func on_tween_completed() -> void:
	buttons.hide()
	can_show_menu = true
