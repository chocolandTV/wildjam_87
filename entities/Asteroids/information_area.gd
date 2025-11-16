extends Area2D

func _ready() -> void:
    body_entered.connect(on_player_entered_area)
    body_exited.connect(on_player_exited_area)

func on_player_entered_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    var _structure = get_parent() as Asteroid_Base
    _game_ui.setup_interactive_box(_structure.asteroid_info, self)

func on_player_exited_area(_player : Node) -> void:
    var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
    _game_ui.hide_interactive_box()