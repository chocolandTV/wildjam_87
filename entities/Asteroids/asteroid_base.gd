extends RigidBody2D
class_name Asteroid_Base

@export var mining_component : Mining_Resources_Component
@export var timer : Timer


func _ready() -> void:
    timer.timeout.connect(_on_timer_timeout_reset)


func initialize_asteroid(_size : Vector2, _resource: Dictionary, _lifetime : float)->void:
    scale = _size
    mining_component.total_resources = _resource
    timer.wait_time = _lifetime
    visible = true

func _on_timer_timeout_reset() ->void:
    AsteroidManager.reset_asteroid(self)
