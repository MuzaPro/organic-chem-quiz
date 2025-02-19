extends Node2D

const DraggableMolecule = preload("res://scenes//quiz/DraggableMolecule.tscn")

@onready var molecule_bank = $MoleculeBank

# Example molecule data - later this will come from a question database
var molecule_data = [
	{
		"name": "Methanol",
		"sprite_path": "res://assets/molecules/methanol.svg"
	},
	{
		"name": "Ethanol",
		"sprite_path": "res://assets/molecules/ethanol.svg"
	}
]

func _ready():
	setup_current_question()

func setup_current_question():
	# Clear existing molecules if any
	for child in molecule_bank.get_children():
		child.queue_free()
	
	# Create new molecule cards
	var spacing = 250  # Adjust based on your card size
	var start_x = 250 # Starting x position
	
	for i in range(molecule_data.size()):
		var molecule = DraggableMolecule.instantiate()
		molecule_bank.add_child(molecule)
		
		# Position the molecule in the bank
		molecule.position = Vector2(start_x + (i * spacing), 100)
		
		# Configure the molecule with its data
		molecule.configure(molecule_data[i])

# Function to add when implementing question switching
func load_next_question():
	# This will be implemented later when we add question management
	pass
