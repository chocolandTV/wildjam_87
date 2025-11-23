extends RigidBody2D
class_name Asteroid_Base
const ASTEROID_DESPAWN_DISTANCE :float = 10000

@export var mining_component : Mining_Resources_Component
@export var timer : Timer
@export var burn_duration : float = 0.8
@export var burn_color : Color = Color(1, 0.2, 0.2, 1.0)
@export var final_shrink : Vector2 = Vector2(0.15, 0.15)

func _ready() -> void:
    timer.timeout.connect(_on_timer_timeout)

func initialize_asteroid(_size : Vector2, _resource: Dictionary, _lifetime : float)->void:
    scale = _size
    mining_component.total_resources = _resource

    visible = true
    # ensure default look when spawned
    modulate = Color(1,1,1,1)
    set_sleeping(false)
    timer.start()

func _on_timer_timeout() -> void:
   
    _play_burn_and_reset()


func _play_burn_and_reset() -> void:
    # stop physics so it doesn't move while burning
    set_sleeping(true)
    # create tween: modulate to red + shrink
    var tw : Tween = create_tween()
    tw.tween_property(self, "modulate", burn_color, burn_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
    tw.set_parallel()
    tw.tween_property(self, "scale", final_shrink, burn_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
    tw.connect("finished", Callable(self, "_on_burn_finished"))

func _on_burn_finished() -> void:
    # hand back to manager (will hide/reset/repool the asteroid)
    AsteroidManager.reset_asteroid(self)
    