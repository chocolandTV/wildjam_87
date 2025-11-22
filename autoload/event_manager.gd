extends Node

# Signals
signal camera_player_entered_planet_zone(_radius : float)
signal camera_player_exited_planet_zone()

## Public Variable
var collectable_mother : Node2D = null
var asteroids_mother : Node2D = null
var player_node : Node2D = null
##################################################################################### CALL FUNCTIONS #################


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

func set_asteroid_mother(_node) ->void:
    if _node:
        asteroids_mother = _node