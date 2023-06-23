extends CharacterBody2D


var stats:Dictionary

func _ready():
	get_node("AnimationPlayer").current_animation = "summon"
	get_node("AnimationPlayer").play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "summon":
		queue_free()
