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
	print("Setting up quiz question")
	
	# Clear existing reagents if any
	for child in reagent_bank.get_children():
		child.queue_free()
	
	# Configure the reagent bank
	reagent_bank.custom_minimum_size = Vector2(400, 150)
	reagent_bank.mouse_filter = Control.MOUSE_FILTER_PASS
	reagent_bank.alignment = BoxContainer.ALIGNMENT_CENTER
	reagent_bank.add_theme_constant_override("separation", 20)
	
	# Create new reagent cards
	for molecule in molecule_data:
		var reagent = preload("res://Card/reagent_card.tscn").instantiate()
		reagent_bank.add_child(reagent)
		reagent.custom_minimum_size = Vector2(100, 100)
		reagent.configure(molecule)
