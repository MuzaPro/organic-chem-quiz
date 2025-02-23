# ====================================
# SCRIPT: States/release_reagent_state.gd
# ATTACH TO: Release state node
# ====================================

extends ReagentCardState

func _enter():
	print("RELEASE state entered")
	var drop_zones = card.drop_zone_detector.get_overlapping_areas()
	print("Found drop zones: ", drop_zones)
	
	if drop_zones.is_empty():
		_return_to_bank()
	else:
		var valid_zones = drop_zones.filter(func(zone): return zone.has_method("can_accept_card"))
		if valid_zones.is_empty():
			_return_to_bank()
		else:
			var drop_zone = valid_zones[0]
			if drop_zone.can_accept_card():
				drop_zone.accept_card(card)
				card.current_drop_zone = drop_zone
			else:
				_return_to_bank()
	
	transitioned.emit("idle")

func _return_to_bank():
	# Get reference to ReagentBank
	var reagent_bank = get_tree().get_first_node_in_group("reagent_bank")
	if reagent_bank:
		reagent_bank.return_card_starting_position(card)
	
	if card.current_drop_zone:
		card.current_drop_zone.remove_card()
		card.current_drop_zone = null
