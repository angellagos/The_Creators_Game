class_name Boss
extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer  # Nodo para reproducir el audio
const ESCENA_BARRIL = preload("res://enemigos/barril.tscn")

func _ready():
	# Conecta el temporizador para el lanzamiento de barriles
	$Timer.connect("timeout", _on_timer_timeout)
	
	# Configuración inicial del audio
	audio_player.stream = preload("res://8.Boss.wav")  
	audio_player.play()  # Reproduce el audio al inicio
	_start_audio_loop()  # Inicia el bucle del audio cada x segundos

func launch_barrel():
	var instancia_barril = ESCENA_BARRIL.instantiate()
	instancia_barril.position = $CharacterSquareRed/CharacterHandRed.position
	add_child(instancia_barril)
	animation_player.play("reposo")

func _on_timer_timeout():
	animation_player.play("lanzar")
	$Timer.wait_time = randf_range(2, 5)

func _start_audio_loop():
	# Bbucle de audio
	$TimerAudio.start(10)  # audio Boss cada x segundos

func _on_timer_audio_timeout():
	audio_player.play()  # bucle audio
