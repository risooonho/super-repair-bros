extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2(1, 0)
var next_direction = 1
var cur_direction = 1
# r,l,d,u == 1,2,3,4

func _ready():
	$AnimationPlayer.play("idle")

func get_input():
	if Input.is_action_pressed('right') && cur_direction != 2:
		next_direction = 1
	if Input.is_action_pressed('left') && cur_direction != 1:
		next_direction = 2
	if Input.is_action_pressed('down') && cur_direction != 4:
		next_direction = 3
	if Input.is_action_pressed('up') && cur_direction != 3:
		next_direction = 4

func change_direction():
	if next_direction != cur_direction && not is_on_wall():
		if next_direction == 1:
			velocity.x = 1
			velocity.y = 0
			cur_direction = next_direction;
		if next_direction == 2:
			velocity.x = -1
			velocity.y = 0
			cur_direction = next_direction;
		if next_direction == 3:
			velocity.x = 0
			velocity.y = 1
			cur_direction = next_direction;
		if next_direction == 4:
			velocity.x = 0
			velocity.y = -1
			cur_direction = next_direction;

	velocity = velocity.normalized() * speed

func world_is_endless():
	if position.x > get_viewport_rect().size.x:
		position.x = 0
	if position.y > get_viewport_rect().size.y:
		position.y = 0
	if position.x < 0:
		position.x = get_viewport_rect().size.x
	if position.y < 0:
		position.y = get_viewport_rect().size.y


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide (velocity, Vector2( 0, 0 ), false, 1)
	change_direction()
	world_is_endless()
