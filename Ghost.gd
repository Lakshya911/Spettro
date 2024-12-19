extends CharacterBody2D

var rg = RandomNumberGenerator.new()
var y = 0
var x1 = 10
var y1 = 10
var o1 = 24
var o2= 16

func _ready():
	visible = false

func _physics_process(delta):
	if $".".visible == true:
		var dir = Vector3()
		$NavigationAgent2D.target_position = $"../Player".global_position
		dir = $NavigationAgent2D.get_next_path_position() - global_position
		dir = dir.normalized()
		velocity = velocity.lerp(dir * o1 , o2 * delta)
		move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("delete"):
		visible = false
	elif Input.is_action_just_pressed("restore"):
		visible = true

func _on_timer_2_timeout():
	visible = true
	$"../Timer2".wait_time = rg.randi_range(x1,y1)
	$"../Timer3".start()
func _on_timer_3_timeout():
	visible = false
	$"../Timer2".start()
