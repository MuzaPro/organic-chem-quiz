# ====================================
# SCRIPT: reagent_bank.gd
# ATTACH TO: ReagentBank (HBoxContainer) node
# ====================================
extends HBoxContainer

func _ready():
	# Add to group so cards can find their way back
	add_to_group("reagent_bank")

func return_card_starting_position(card: ReagentCard):
	print("Bank: Returning card to position")
	card.reparent(self)


#func return_card_starting_position(card: ReagentCard):
	#card.reparent(self)  # Return card to bank
	## Ensure card can still receive input
	#card.mouse_filter = Control.MOUSE_FILTER_STOP
	#card.focus_mode = Control.FOCUS_ALL


func set_new_card(card: ReagentCard):
	card.reparent(self)
	card.current_drop_zone = null
