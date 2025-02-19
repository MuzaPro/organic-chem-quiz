# draggable molecule script
extends Node2D

# New signals that will be recieved by the 'card manager' node, which we named "MoleculeBank"
signal hovered
signal hovered_off



# Properties to identify the molecule
@export var molecule_name: String = ""
@export var sprite_path: String = ""

# Node references
@onready var card_image: Sprite2D = $CardImage
@onready var area_2d: Area2D = $Area2D

# Original card position for returning when not dropped in zone
var original_position: Vector2 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# All cards must be a child of MoleculeBank node, or this will cause a fatal error at runtime
	get_parent().connect_card_signals(self) # the connect_card_signals function lives in molecule_bank.gd script 
	original_position = position
	
	#Load sprite if path is set
	if sprite_path != "":
		set_molecule_sprite(sprite_path)

# Configure the molecule with all necessary data
func configure(config: Dictionary) -> void:
	if config.has("name"):
		molecule_name = config.name
	if config.has("sprite_path"):
		set_molecule_sprite(config.sprite_path)


# Set the molecule's sprite
func set_molecule_sprite(path: String) -> void:
	sprite_path = path
	var texture = load(path)
	if texture:
		card_image.texture = texture
	else:
		print("Failed to load texture from path: ", path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Signals for mouse hover over card
func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self) # 'self' is the card node

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off" , self)

func get_original_position() -> Vector2:
	return original_position

# Reset position when not dropped in a valid zone
func reset_position() -> void:
	position = original_position

# Method to get molecule data
func get_molecule_data() -> Dictionary:
	return {
		"name": molecule_name,
		"sprite_path": sprite_path
	}
