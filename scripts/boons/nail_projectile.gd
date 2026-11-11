extends Area2D
class_name NailProjectile

@export var speed: float = 600.0
@export var damage: float = 5.0
@export var nail_lifetime_seconds: float = 1.5


var _direction: Vector2 = Vector2.DOWN
var source: Node2D

func set_direction(direction: Vector2) -> void:
	_direction = direction

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.call("take_damage", damage)
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void: 
	nail_lifetime_seconds -= delta
	if nail_lifetime_seconds < 0.0:
		free()
		return
	rotation = _direction.angle() - (PI /2)
	global_position += delta * speed * _direction
