
# Scene: ReagentCard.tscn
# ReagentCard (Control)
#   ├── Sprite (TextureRect)
#   ├── ReagentCardStateMachine
#   │   ├── Idle (ReagentCardState)
#   │   ├── Hover (ReagentCardState)
#   │   ├── Drag (ReagentCardState)
#   │   └── Release (ReagentCardState)
#   ├── DropZoneDetector (Area2D)
#   │   └── CollisionShape2D
#   └── CardsDetector (Area2D)
#       └── CollisionShape2D


# ====================================
# SCRIPT: reagent_card.gd
# ATTACH TO: ReagentCard (Control) node
# ====================================
class_name ReagentCard
extends Control

@onready var sprite: TextureRect = $Sprite
@onready var state_machine: ReagentCardStateMachine = $ReagentCardStateMachine
@onready var drop_zone_detector: Area2D = $DropZoneDetector
@onready var starting_position: Vector2




var molecule_data: Dictionary = {}
var current_drop_zone = null


func _ready():
	# Store initial position for returning when drag is cancelled
	starting_position = position
	print("Card _ready called with data: ", molecule_data, " for card named: ", name, " with parent: ", get_parent().name if get_parent() else "no parent")
	## signals connection
	#gui_input.connect(_on_gui_input)
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)
	
	# Load molecule sprite if provided
	if molecule_data.has("sprite_path"):
		var texture = load(molecule_data.sprite_path)
		if texture:
			sprite.texture = texture
			# Scale sprite to fit card size while maintaining aspect ratio
			sprite.custom_minimum_size = Vector2(100, 100) # Adjust size as needed

func configure(data: Dictionary):
	molecule_data = data
	if is_inside_tree():
		_ready()

func _input(event):
	state_machine.on_input(event)

func _on_gui_input(event):
	# print("Card received gui_input: ", event)
	state_machine.on_gui_input(event)

func _on_mouse_entered():
	print("Card mouse entered")
	state_machine.on_mouse_entered()

func _on_mouse_exited():
	print("Card mouse exited")
	state_machine.on_mouse_exited()
