extends Node

# Signals
signal camera_player_entered_planet_zone(_radius : float)
signal camera_player_exited_planet_zone()

##################################################################################### CALL FUNCTIONS #################


func on_player_entered_planet_zone(_radius :float) ->void:
    camera_player_entered_planet_zone.emit(_radius)

func on_player_exited_planet_zone() ->void:
    camera_player_exited_planet_zone.emit()