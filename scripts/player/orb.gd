extends Node2D


@onready var autoattack = preload("res://scenes/player/autoattack.tscn")

var player
var focus = false
var wander_amount = 5
var hover_timer = 0
var base_pos = Vector2(-24,-11)
var focus_pos = Vector2(-21,-41)
var last_frame_pos = base_pos
var target_pos = base_pos
var offset_y = 0

var CD:Dictionary = {
	"autoattack":0,
	"spell 1":0,
	"spell 2":0
}

var spells = [
	{
		#spell0
		"type":"none",
		"number":0,
		"base cd":0,
		"base damage":0,
		
		"damages":0, # % facteur des base dmg
		"CDR":0, # % facteur du base cd
		"enhancement":0, # % facteur du bonus à l'aa
		
		"bonus":[] #jusqu'à 5 bonus de stats, selon la rareté
	},
	{
		#spell1
		"type":"none",
		"number":0,
		"base cd":0,
		"base damage":0,
		
		"damages":0, 
		"CDR":0,
		"enhancement":0, 
		
		"bonus":[]
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("..")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for k in CD.keys():
		if CD[k] > 0:
			CD[k] -= delta
	if focus:
		target_pos = Vector2(focus_pos[0],focus_pos[1])
	else:
		if hover_timer < 0:
			hover_timer = 2*PI
		hover_timer -= delta*(randf()+0.5)
		offset_y = sin(hover_timer)*wander_amount
		target_pos = Vector2(base_pos[0],base_pos[1] + offset_y) #need work, enlever child mystique ?
	position = last_frame_pos+(target_pos-last_frame_pos)*0.75   #but : lag derrière la mystique
	last_frame_pos = position

func auto_attack(target):
	if CD["autoattack"] > 0:
		#anim spell fail ?
		print("on cd")
		return
	CD["autoattack"] = player.stats["attack speed"]
	var new_aa = autoattack.instantiate()
	new_aa.global_position = global_position
	new_aa.target = target
	get_node("../..").add_child(new_aa) #ça l'ajoute dans game for now	

func cast_spell(spell,target):
	if CD["spell "+str(spell)] > 0:
		#anim spell fail ?
		print("on cd")
		return
	var new_spell = (load("res://scenes/player/spells/"+str(spells[spell]["type"]+str(spells[spell]["number"]))+".tscn")).instantiate()
	new_spell.global_position = global_position
	new_spell.target = target
	get_node("../..").add_child(new_spell)
	#structure : chaque spell a une scene localisée à /spells/<type>/<number>.tscn, why not trade number for name.

func switch_spell(spell, new_spell):
	pass
	#TODO, switch le spell <spell> avec <new_spell>
