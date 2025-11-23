extends Sprite2D

@export var _target : Node2D
@export var duration : float = 0.8
@export var shrink_ease = Tween.EASE_IN
@export var move_ease = Tween.EASE_IN
@export var trans_type = Tween.TRANS_EXPO
var _start_scale : Vector2
func _ready() ->void:
    if _target:
        _animate_to_target()
        _start_scale = scale

func _animate_to_target() -> void:
    
    var tw = create_tween()
    tw.tween_property(self, "global_position", _target.global_position, duration).set_trans(trans_type).set_ease(move_ease)
    tw.tween_property(self, "scale", Vector2.ZERO, duration).set_trans(trans_type).set_ease(shrink_ease)
    tw.connect("finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished() -> void:
    visible = false
    # optional: queue_free() or emit a signal here