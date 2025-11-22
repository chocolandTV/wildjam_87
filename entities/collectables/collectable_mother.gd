extends Node2D

func _ready() -> void:
    # Initial Collectable_holder
    EventManager.set_collectable_mother(self)