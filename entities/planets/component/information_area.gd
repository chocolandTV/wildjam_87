extends Area2D
class_name Information_Area

var is_allready_scanned :bool = false

func on_player_entered_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    var _planet = get_parent() as Node
    _game_ui.setup_interactive_box(_planet.planet_info, self)
    # Event to camera zoom out if enabled
    if PersistentData.game_settings["camera_auto_zoom"] == 1:
        EventManager.on_player_entered_planet_zone(_planet.planet_radius)

func on_player_exited_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    _game_ui.hide_interactive_box()
    # Event to camera zoom in if enabled
    if PersistentData.game_settings["camera_auto_zoom"] == 1:
        EventManager.on_player_exited_planet_zone()