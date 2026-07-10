class_name BaseProyectile
extends Node2D


func _ready() -> void:
	reset_values()

func _process(_delta: float) -> void:
	pass

func reset_values() -> void:
	pass

func terminate() -> void:
	PoolManager.add_queue("proyectile_1", self)
	visible = false
