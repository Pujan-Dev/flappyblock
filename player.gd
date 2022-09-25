extends KinematicBody2D


var walls = preload("res://walls.tscn")
const up = Vector2(0,-1)

var motion = Vector2()

const flap = 250

var gravity = 20
var maxgravity = 200
var score = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	motion.y += gravity
	if motion.y >maxgravity:
		motion.y = maxgravity

	if Input.is_action_just_pressed("Jump"):
		motion.y = -flap
	motion = move_and_slide(motion,up)
	get_parent().get_node("CanvasLayer/RichTextLabel").text =  str(score)
func wallresetter() :
	var wall_init = walls.instance()
	wall_init.position = Vector2(480,rand_range(-60,60))
	get_parent().call_deferred("add_child",wall_init)


func _on_resetter_body_entered(body):
	if body.name == "walls":
		body.queue_free()
		wallresetter()


func _on_Area2D_body_entered(body):
	if body.name == "walls":
		get_tree().reload_current_scene()


func _on_Area2D_area_entered(area):
	if area.name == "point":
		score = score+ 1
