# ====================================
# SCRIPT: States/hover_reagent_state.gd
# ATTACH TO: Hover state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	# print("Entering HOVER state")
	card.modulate = Color(1.2, 1.2, 1.2) # Slight highlight

func on_gui_input(event: InputEvent):
	# print("HOVER state received input: ", event)
	if event.is_action_pressed("mouse_left"):
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
		transitioned.emit("drag")

func on_mouse_exited():
	# print("HOVER state mouse exit")
	transitioned.emit("idle")
