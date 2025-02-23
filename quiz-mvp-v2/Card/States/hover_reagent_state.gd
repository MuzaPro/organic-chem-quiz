# ====================================
# SCRIPT: States/hover_reagent_state.gd
# ATTACH TO: Hover state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	print("Entering HOVER state")
	card.modulate = Color(1.2, 1.2, 1.2) # Slight highlight

var transitioning_to_drag = false # Will change in the on_gui_input function

func on_gui_input(event: InputEvent):
	print("HOVER state received input: ", event)
	if event.is_action_pressed("mouse_left"):
		print("Left mouse pressed in HOVER state, transitioning to DRAG")
		transitioning_to_drag = true # will reset on _exit function
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
		transitioned.emit("drag")

func _exit():
	print("Exiting HOVER state")
	transitioning_to_drag = false
	
func on_mouse_entered():
	print("HOVER state received mouse entered")

func on_mouse_exited():
	print("HOVER state mouse exit")
	transitioned.emit("idle")
