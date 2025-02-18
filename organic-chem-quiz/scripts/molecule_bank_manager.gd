# molecule_bank_manager

# Gives Card functionality to molecules in the answer bank


extends Node2D
var card_being_dragged
var screen_size
const COLLISION_MASK_CARD = 1
var is_hovering_on_card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x,0,screen_size.x), 
		clamp(mouse_pos.y,0,screen_size.y))




func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = _raycast_check_for_card()
			if card:
				card_being_dragged = card
		else :
			card_being_dragged = null

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	highlight_card(card,true)

func on_hovered_off_card(card):
	highlight_card(card, false)



func highlight_card(card, hovered):   # hovered is a boolean 
	if hovered:
		card.scale = Vector2(1.05,1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1.00,1.00)
		card.z_index = 1




func _raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() >0 : 
		return result[0].collider.get_parent()
	return null
	
