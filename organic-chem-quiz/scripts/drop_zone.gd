# drop zone script

extends Node2D

signal card_dropped(card)
var is_occupied = false
var occupied_by = null

func _ready():
	# Set up a different collision mask than the cards
	$Area2D.collision_mask = 1  # same as cards
	$Area2D.collision_layer = 2  # different layer for drops
	

func can_accept_card():
	return not is_occupied

func accept_card(card):
	is_occupied = true
	occupied_by = card
	# Position the card in the center of the drop zone
	card.position = global_position

func remove_card():
	is_occupied = false
	occupied_by = null


func _on_area_2d_area_entered(area: Area2D) -> void:
	# Tell the molecule bank this is a valid drop zone
	get_node("../MoleculeBank").current_drop_zone = self

func _on_area_2d_area_exited(area: Area2D) -> void:
	# Clear the current drop zone if it's this one
	var molecule_bank = get_node("../MoleculeBank")
	if molecule_bank.current_drop_zone == self:
		molecule_bank.current_drop_zone = null
