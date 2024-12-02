class_name Personaje
extends CharacterBody2D

signal player_hit()

@export var character: CharacterBody2D
@export var gravity = 100
@export var jump_speed = 100
@export var speed = 100
@export var main_animation: AnimatedSprite2D
@onready var sprite_2d = $Sprite2D

var _movements = {
	IDLE = "idle",
	RUN_RIGHT = "run",
	RUN_LEFT = "run_left"
}

var _current_movement = _movements.IDLE

func _ready():
	main_animation.play(_current_movement)
	
	#if not character:
		#set_physics_process(false)

func _physics_process(delta):
	# Horizontal
	var direction = Input.get_axis("izquierda", "derecha")
	velocity.x = speed * direction

	# Determina el estado del movimiento basado en la dirección
	if direction > 0:
		_current_movement = _movements.RUN_RIGHT
		sprite_2d.scale.x = direction  # Ajusta la dirección de la escala
	elif direction < 0:
		_current_movement = _movements.RUN_LEFT
		sprite_2d.scale.x = direction  # Ajusta la dirección de la escala
	else:
		_current_movement = _movements.IDLE

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Saltar
	var jump_pressed = Input.is_action_just_pressed("saltar")
	if jump_pressed and is_on_floor():
		velocity.y -= jump_speed

	move_and_slide()

	# Actualiza la animación
	_set_animation()


func _on_area_2d_body_entered(body):
	print("Un cuerpo ha entrado en el área: ", body.name)
	print("aqui podriamos reproducir una animación de alegria")
	
func damage_received():
	print("daño recibido")
	player_hit.emit()
	
func _set_animation():
	
	if _current_movement == _movements.RUN_RIGHT:
		main_animation.play(_movements.RUN_RIGHT)
		main_animation.flip_h = false
	elif _current_movement == _movements.RUN_LEFT:
		main_animation.play(_movements.RUN_RIGHT)
		main_animation.flip_h = true
	else:
		main_animation.play(_movements.IDLE)
