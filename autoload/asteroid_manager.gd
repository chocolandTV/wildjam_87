extends Node
### Asteroid spawner with object pooling, timed spawn and fly-in tweens

@export var asteroid_scene : PackedScene
@export var asteroid_spawning_rate : float = 10.0

# how many asteroids to keep in pool (initial)
@export var pool_size : int = 32

# how many asteroids to spawn each cycle: use min/max (min_max_spawning_asteroids.x .. .y)
@export var min_max_spawning_asteroids : Vector2i = Vector2i(1, 4)

# random size range for spawned asteroids
@export var min_max_spawning_size : Vector2 = Vector2(0.3, 1.2)

# spawn distance from player (very far)
@export var asteroid_spawn_distance : float = 10000.0

# target radius around player where asteroids fly into
@export var fly_in_min_radius : float = 300.0
@export var fly_in_max_radius : float = 1500.0

# fly-in tween duration range
@export var fly_in_duration_min : float = 0.6
@export var fly_in_duration_max : float = 2.0

# random linear speed applied after fly-in
@export var post_fly_speed_min : float = 20.0
@export var post_fly_speed_max : float = 300.0

# internal
var _player : Node2D = null
var _mother : Node2D = null
var _pool : Array = []
var _active : Array = []

var _timer : Timer

func _ready() -> void:
    # subscribe to event when mother node is provided by scene
    EventManager.asteroid_mother_setted.connect(_on_mother_is_set)
    # ensure timer exists
    _timer = Timer.new()
    _timer.one_shot = false
    _timer.wait_time = asteroid_spawning_rate
    _timer.connect("timeout", Callable(self, "_on_timer_timeout"))
    add_child(_timer)

func _on_mother_is_set() -> void:
    _player = EventManager.player_node
    _mother = EventManager.asteroids_mother

    # build pool (add children under mother for scene cleanliness)
    if not _mother:
        push_error("AsteroidManager: mother node is null on _on_mother_is_set")
        return

    _pool.clear()
    _active.clear()

    for i in pool_size:
        var inst : RigidBody2D = asteroid_scene.instantiate()
        _mother.add_child(inst)
        inst.visible = false
        # ensure default state if Asteroid_Base provides init call
        if inst.has_method("initialize_asteroid"):
            # initialize minimal defaults; real init happens on spawn
            # avoid starting any internal timer yet
            pass
        _pool.append(inst)

    _timer.start()

func _on_timer_timeout() -> void:
    _handle_asteroids()

func _handle_asteroids() -> void:
    if _pool.is_empty():
        # nothing available
        return

    var rng := RandomNumberGenerator.new()
    rng.randomize()

    # determine safe spawn count (1..max) but not more than pool size
    var min_count = max(1, min_max_spawning_asteroids.x)
    var max_count = max(min_count, min_max_spawning_asteroids.y)
    var max_possible = min(max_count, _pool.size())
    if max_possible <= 0:
        return
    var spawn_count := rng.randi_range(min_count, max_possible)

    for i in range(spawn_count):
        # pick random element from pool and remove it
        var idx = rng.randi_range(0, _pool.size() - 1)
        var ast = _pool.pop_at(idx)
        _active.append(ast)

        # random size/resources/lifetime (customize per your Mining_Resources_Component)
        var size := Vector2.ONE * rng.randf_range(min_max_spawning_size.x, min_max_spawning_size.y)
        var resource := {
            "Minerals": rng.randi_range(0, 10),
            "Gas": rng.randi_range(0, 10),
            "Crystals": rng.randi_range(0, 10),
            "Artifact": rng.randi_range(0, 1)
        }
        var lifetime := rng.randf_range(8.0, 40.0)

        # spawn far away at random angle
        var angle := rng.randf_range(0.0, TAU)
        var spawn_pos := _player.global_position + Vector2.RIGHT.rotated(angle) * asteroid_spawn_distance

        # choose a random target point near the player
        var dir_angle := rng.randf_range(0.0, TAU)
        var dist_to_player := rng.randf_range(fly_in_min_radius, fly_in_max_radius)
        var target_pos := _player.global_position + Vector2.RIGHT.rotated(dir_angle) * dist_to_player

        _spawn_asteroid(ast, spawn_pos, size, resource, lifetime, target_pos)

func _spawn_asteroid(ast: RigidBody2D, position: Vector2, size: Vector2, resource: Dictionary, lifetime: float, fly_target: Vector2) -> void:
    # prepare asteroid
    ast.global_position = position
    ast.visible = true
    # reset physics state
    if ast.has_method("set_sleeping"):
        ast.set_sleeping(false)

    # initialize asteroid (size/resource/lifetime)
    if ast.has_method("initialize_asteroid"):
        ast.initialize_asteroid(size, resource, lifetime)
    else:
        ast.scale = size
        # if it has a mining_component property, set resources if available
        if "mining_component" in ast and ast.mining_component:
            ast.mining_component.total_resources = resource

    # create fly-in tween
    var rng := RandomNumberGenerator.new()
    rng.randomize()
    var duration := rng.randf_range(fly_in_duration_min, fly_in_duration_max)

    # use asteroid's create_tween so it's tied to node lifecycle
    var tw := ast.create_tween()
    tw.tween_property(ast, "global_position", fly_target, duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    tw.connect("finished", Callable(self, "_on_asteroid_flyin_finished").bind(ast))

func _on_asteroid_flyin_finished(ast: RigidBody2D) -> void:
    # after arriving, give asteroid a random linear velocity so it continues moving
    if not ast:
        return
    var rng := RandomNumberGenerator.new()
    rng.randomize()
    var angle := rng.randf_range(0.0, TAU)
    var speed := rng.randf_range(post_fly_speed_min, post_fly_speed_max)
    var vel := Vector2.RIGHT.rotated(angle) * speed

    # if RigidBody2D, set linear_velocity
    if "linear_velocity" in ast:
        ast.linear_velocity = vel
    # optionally enable other behavior

    # keep asteroid active; it should call reset_asteroid(self) when it dies or timer times out

func reset_asteroid(ast: RigidBody2D) -> void:
    # called by asteroid when it's ready to be returned to pool
    if not ast:
        return
    # stop tweens on asteroid
    if ast.get_tree_tween():
        ast.get_tree_tween().kill()
    # stop physics and hide
    if "linear_velocity" in ast:
        ast.linear_velocity = Vector2.ZERO
    if ast.has_method("set_sleeping"):
        ast.set_sleeping(true)
    ast.visible = false
    # reset appearance
    ast.scale = Vector2.ONE
    ast.modulate = Color(1,1,1,1)
    # remove from active list if present
    var i := _active.find(ast)
    if i >= 0:
        _active.remove_at(i)
    # return to pool
    _pool.append(ast)

func _on_tree_exiting() -> void:
    _timer.stop()