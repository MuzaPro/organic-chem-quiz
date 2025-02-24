# ====================================
# SCRIPT: States/idle_reagent_state.gd
# ATTACH TO: Idle state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	print("Entering IDLE state")
	card.modulate = Color.WHITE
	card.pivot_offset = Vector2.ZERO
	var mouse_pos = card.get_global_mouse_position()
	if card.get_global_rect().has_point(mouse_pos):
		print("Mouse already over card in IDLE state")
		call_deferred("on_mouse_entered")

func _exit():
	print("Exiting IDLE state")

func on_mouse_entered():
	print("IDLE state MOUSE ENTER - parent:", card.get_parent().name)
	transitioned.emit("hover")
