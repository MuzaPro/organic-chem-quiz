# ====================================
# SCRIPT: reagent_card_state.gd
# ATTACH TO: Base state script, not directly attached to any node
# Used as parent class for all state scripts
# ====================================
class_name ReagentCardState
extends Node

signal transitioned

@export var card: ReagentCard

func _enter():
	pass

func _exit():
	pass

func on_input(_event: InputEvent):
	pass

func on_gui_input(_event: InputEvent):
	pass

func on_mouse_entered():
	pass

func on_mouse_exited():
	pass
