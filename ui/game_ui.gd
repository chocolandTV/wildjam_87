extends CanvasLayer

# Exported Variables
@export var interactive_box : Interactive_Box

# private variables
var _is_interacting :bool = false

# Public Methods
func setup_interactive_box(planet_info : Canvas_Info) -> void:
	interactive_box.setup_planet_info(planet_info)
    show_interactive_box()
    _is_interacting = true

func hide_interactive_box() -> void:
    interactive_box.visible = false
    _is_interacting = false

func show_interactive_box() -> void:
	interactive_box.visible = true
