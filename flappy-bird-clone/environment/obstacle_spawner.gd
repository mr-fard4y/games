extends Node2D


onready var timer = $Timer
var obstacleCls = preload("res://environment/obstacle.tscn")


func _ready():
	randomize()


func _on_Timer_timeout():
	spawn_obstacle()


func spawn_obstacle():
	var obstacle = obstacleCls.instance()
	add_child(obstacle)
	obstacle.position.y = randi()%400 + 150


func start():
	timer.start()


func stop():
	timer.stop()
