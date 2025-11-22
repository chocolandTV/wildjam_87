extends Node2D

func _ready() -> void:
    EventManager.set_asteroid_mother(self)