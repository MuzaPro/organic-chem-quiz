# ====================================
# SCRIPT: drop_zone.gd
# ATTACH TO: Both DropZoneLeft and DropZoneRight Area2D nodes
# ====================================
extends Area2D

var current_card: ReagentCard = null
@onready var texture_rect: TextureRect = $TextureRect

func _ready():
	## Set the texture rect size to match collision shape
	#var shape: CollisionShape2D = $CollisionShape2D
	#var rect_shape: RectangleShape2D = shape.shape
	#texture_rect.size = rect_shape.size
	pass

func can_accept_card() -> bool:
	print("Checking if can accept card")
	return current_card == null


func accept_card(card) -> void:
	print("Accepting card: ", card.name)
	current_card = card
	
	# Center the card in the drop zone
	var collision_shape = $CollisionShape2D
	var shape_size = (collision_shape.shape as RectangleShape2D).size
	card.global_position = global_position + (shape_size / 2) - (card.size / 2)
	
	
	card.get_parent().remove_child(card)
	add_child(card)
	card.position = Vector2(shape_size.x/2 - card.size.x/2, shape_size.y/2 - card.size.y/2)
	
	
	# Ensure proper input handling
	card.mouse_filter = Control.MOUSE_FILTER_STOP
	card.focus_mode = Control.FOCUS_ALL
	

func remove_card() -> void:
	print("Removing card from drop zone")
	current_card = null
