# ====================================
# SCRIPT: States/idle_reagent_state.gd
# ATTACH TO: Idle state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	print("Entering IDLE state")
	card.modulate = Color.WHITE
	card.pivot_offset = Vector2.ZERO

func _exit():
	print("Exiting IDLE state")

func on_mouse_entered():
	print("IDLE state received mouse enter")
	transitioned.emit("hover")
