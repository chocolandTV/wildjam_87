extends StaticBody2D
class_name Moon


# Object to rotate
@export var center : Node2D

# Object radius
@export var radius : float = 3844.0
# Radiant per seconds
@export var angular_speed : float  = 3.9 

# privates 
var angle : float = 0.0

func _process(_delta):
    if center != null:
        _circulate(_delta)


func _circulate(delta : float ) ->void:

    #add delta and speed to angle
    angle += angular_speed * delta

    # calculate vector2 position
    var _step_position : Vector2 = Vector2(radius * cos(angle), radius * sin(angle))
    
    # new position of the distanced circle
    position = center.position + _step_position