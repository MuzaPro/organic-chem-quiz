# ====================================
# SCRIPT: reagent_card_state_machine.gd
# ATTACH TO: ReagentCardStateMachine node (child of ReagentCard)
# ====================================
class_name ReagentCardStateMachine
extends Node

@export var initial_state: ReagentCardState

var current_state: ReagentCardState
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is ReagentCardState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.call_deferred("_enter")
		current_state = initial_state

func on_input(event: InputEvent):
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent):
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered():
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited():
	if current_state:
		current_state.on_mouse_exited()

func on_child_transition(new_state_name: String):
	print("Attempting transition to state: ", new_state_name)
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("Failed to find state: ", new_state_name)
		return
	print("Found state: ", new_state.name)
	if current_state:
		current_state._exit()
	
	new_state._enter()
	current_state = new_state
