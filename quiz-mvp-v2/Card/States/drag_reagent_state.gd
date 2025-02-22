# ====================================
# SCRIPT: States/drag_reagent_state.gd
# ATTACH TO: Drag state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	card.modulate = Color(0.8, 0.8, 1.2) # Blue tint while dragging
	
	var quiz_screen = get_tree().get_first_node_in_group("quiz_screen")
	if quiz_screen:
		card.reparent(quiz_screen)

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	
	if event.is_action_released("mouse_left"):
		get_viewport().set_input_as_handled()
		transitioned.emit("release")
