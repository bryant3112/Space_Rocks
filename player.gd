extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = INIT

var thrust = 500.0
var rotation_speed = 3.0
var max_speed = 400.0

func _ready():
	$Shield.hide()
	change_state(ALIVE)
	
func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
			
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
			$Shield.hide()
			
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
			$Shield.show()
			
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
			$Shield.hide()
			
	state = new_state
	
func _physics_process(delta):
	if state != DEAD:

	
		if Input.is_action_pressed("ui_left"):
			rotation -= rotation_speed * delta
			
		if Input.is_action_pressed("ui_right"):
			rotation += rotation_speed * delta
			
		if Input.is_action_pressed("ui_up"):
			apply_central_force(Vector2.UP.rotated(rotation) * thrust)
			
		if linear_velocity.length() > max_speed:
			linear_velocity = linear_velocity.normalized() * max_speed
			
func hit():
	if state == ALIVE:
		change_state(INVULNERABLE)
		$Timer.start()
		
func _on_timer_timeout() -> void:
	change_state(ALIVE)
