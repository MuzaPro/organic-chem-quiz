# ====================================
# SCRIPT: quiz_screen.gd
# ATTACH TO: QuizScreen (Control) node
# ====================================
extends Control

@onready var reagent_bank: HBoxContainer = $ReagentBank
@onready var reaction_area: Control = $ReactionArea

# Example molecule data - later this will come from a question database
var molecule_data = [
	{
		"name": "Methanol",
		"sprite_path": "res://Assets/molecules/methanol.svg"
	},
	{
		"name": "Ethanol",
		"sprite_path": "res://Assets/molecules/ethanol.svg"
	},
	{
		"name": "Acetone",
		"sprite_path": "res://Assets/molecules/acetone.svg"
	},
	{
		"name": "sodium_methoxide_ionic",
		"sprite_path": "res://Assets/molecules/sodium_methoxide_ionic.svg"
	}
]

func _ready():
	setup_current_question()
	# Add to group for card reparenting during drag
	add_to_group("quiz_screen")

func setup_current_question():
	# Clear existing reagents if any
	for child in reagent_bank.get_children():
		child.queue_free()
	
	# Create new reagent cards
	var spacing = 120  # Adjust based on your card size
	var start_x = 100  # Starting x position
	
	for i in range(molecule_data.size()):
		var reagent = preload("res://Card/reagent_card.tscn").instantiate()
		reagent_bank.add_child(reagent)
		reagent.configure(molecule_data[i])
