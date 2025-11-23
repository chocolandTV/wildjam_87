extends Node

# Signals
signal camera_player_entered_planet_zone(_radius : float)
signal camera_player_exited_planet_zone()
signal camera_player_changed()

signal asteroid_mother_setted()

signal scanned_planet_updated()

signal camera_zoom_changed( _zoom : Vector2)

signal collectable_done(_pos : Vector2)
signal asteroid_done(_pos : Vector2)
## Public Variable
var collectable_mother : Node2D = null
var asteroids_mother : Node2D = null
var player_node : Node2D = null
##################################################################################### CALL FUNCTIONS #################
func on_asteroid_done(_pos :Vector2) ->void:
    asteroid_done.emit(_pos)
    
func on_collectable_done(_pos :Vector2) ->void:
    collectable_done.emit(_pos)
#new method for background image zooming
func on_camera_zoom_changed(_zoom :Vector2) ->void:
    print("Signal Camera Changed")
    camera_zoom_changed.emit(_zoom)

func on_scanned_planet_updated() ->void:
    scanned_planet_updated.emit()
    
func on_player_changed_zoom(_current_zoom: Vector2)->void:
    camera_player_changed.emit(_current_zoom)

func on_player_entered_planet_zone(_radius :float) ->void:
    camera_player_entered_planet_zone.emit(_radius)

func on_player_exited_planet_zone() ->void:
    camera_player_exited_planet_zone.emit()

func set_collectable_mother(_node : Node2D) ->void:
    if _node:
        collectable_mother = _node

func set_player_node(_node) ->void:
    if _node:
        player_node = _node
        if asteroids_mother != null:
            asteroid_mother_setted.emit()

func set_asteroid_mother(_node) ->void:
    if _node:
        asteroids_mother = _node
        if player_node != null:
            asteroid_mother_setted.emit()