extends Node2D

# New signals that will be recieved by the 'card manager' node, which we named "MoleculeBank"
signal hovered
signal hovered_off


# ----------------------------------
# ----------------------------------
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Debugging prints:
	print("Card ready: ", self.name) # Check if the node is initializing
	print("Area2D node exists: ", has_node("Area2D"))  # Check if Area2D exists
	print("Area2D path: ", $Area2D.get_path() if has_node("Area2D") else "not found")
	
	# All cards must be a child of MoleculeBank node, or this will cause a fatal error at runtime
	get_parent().connect_card_signals(self) # the connect_card_signals function lives in molecule_bank.gd script 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# ----------------------------------
# ----------------------------------

# Signals for mouse hover over card
func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self) # 'self' is the card node


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off" , self)
