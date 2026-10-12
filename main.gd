extends Node2D

@export var enemy_scene: PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/GameOverLabel.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$CanvasLayer/StartButton.hide()
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = Vector2(575, 150)
	enemy.enemy_shoot.connect(_on_enemy_shoot)
	
func _on_enemy_shoot(bullet_scene, bullet_transform):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet .global_transform = bullet_transform
