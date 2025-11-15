extends Area2D
class_name Information_Area

func on_player_entered_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    var _planet = get_parent() as Planet_Class
    _game_ui.setup_interactive_box(_planet.planet_info)

func on_player_exited_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    _game_ui.hide_interactive_box()