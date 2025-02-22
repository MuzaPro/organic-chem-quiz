# ====================================
# SCRIPT: States/release_reagent_state.gd
# ATTACH TO: Release state node (child of ReagentCardStateMachine)
# ====================================
extends ReagentCardState

func _enter():
	print("RELEASE state entered")
	var drop_zones = card.drop_zone_detector.get_overlapping_areas()
	print("Found drop zones: ", drop_zones)
	
	if drop_zones.is_empty():
		print("No drop zones found")
		_return_to_starting_position()
	else:
		print("Attempting to use drop zone: ", drop_zones[0])
		var drop_zone = drop_zones[0]
		if drop_zone.can_accept_card():
			drop_zone.accept_card(card)
			card.current_drop_zone = drop_zone
		else:
			_return_to_starting_position()
	
	transitioned.emit("idle")

func _return_to_starting_position():
	card.position = card.starting_position
	if card.current_drop_zone:
		card.current_drop_zone.remove_card()
		card.current_drop_zone = null
