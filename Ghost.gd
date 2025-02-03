extends CharacterBody2D

var rg = RandomNumberGenerator.new()
var y = 0
var x1 = 1
var y1 = 10
var o1 = 26
var o2= 18

func _ready():
	visible = false

func _physics_process(delta):
	if $"../Player".pb == true:
		if $".".visible == true:
			var dir = Vector3()
			$NavigationAgent2D.target_position = $"../Player".global_position
			dir = $NavigationAgent2D.get_next_path_position() - global_position
			dir = dir.normalized()
			velocity = velocity.lerp(dir * o1 , o2 * delta)
			move_and_slide()

func _on_timer_2_timeout():
	if $"../Player".pb == true:
		visible = true
		$"../Timer2".wait_time = rg.randi_range(x1,y1)
		$"../Timer3".start()
func _on_timer_3_timeout():
	if $"../Player".pb == true:
		visible = false
		$"../Timer2".start()
