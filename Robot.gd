extends Area2D

onready var ground_ray = $Sprite/ray_floor
onready var wall_ray = $Sprite/ray_wall

var max_fall_speed = 128
var current_fall_speed = 0
var move_speed_fall = 1
export var move_speed = 24 

enum state { running=0, idle=1, direction=2, falling=3, zapping=4, toofar=5, cycle=6, check=7, nothing=8} 


var robotCheckName = "Robotx"


enum primary_mode { 
			idle,
			patrol, #// just back and forth
			check, #// back and forth but check over shoulder
			patrolzapping, #// just back and forth whilst pausing to zap
			idlezap
			} 

enum detect_mode { 
		nothing,
		zap,  #// if found (on same level) -> zap 
		follow,  #// if found -> move towards 
		chase  #// if found (on same level) -> chase (fast)
}

export (primary_mode) var moveMode = primary_mode.idle
export (detect_mode) var detectMode = detect_mode.nothing

var last_moveMode = -1

enum direction { left=-1, right=1 }

var on_ground : bool = false
var changed_dir : bool = false
var timer_count : int = 0
var this_state = -1 

var  timer : float

var last_state = -1

# Called when the node enters the scene tree for the first time.
func _ready():

#// decide on a state based on

	randomize()
	
	enter_state(state.idle) 
	
	#if ( !ground_ray.is_colliding() ):
	enter_state(state.falling)
	
func _process(delta):
	#print('_physics_process')
	
	if Global.gameProcessing == false:
		return
	
	process_states(delta)
	

func enter_state(pass_state): 

	
	if ( this_state != pass_state ):
		leave_state(this_state)
		this_state = pass_state 

	if ( this_state != last_state and self.name == robotCheckName):
		print("state change from ", last_state, " to ", this_state)
		last_state = this_state
		
		
	if ( pass_state == state.running ):
		$Sprite/AniSprite.play("running")
		timer = rand_range(0.5,2.5)
		#$Timer.start(rand_range(0.5,2.5))
		#scale.x = direction.values()[ randi()%direction.size() ]
		
		
	if ( pass_state == state.idle ):
		$Sprite/AniSprite.play("idle")
		timer = rand_range(0.5,1.5)
		#$Timer.start(rand_range(0.5,1.5))
	#	if(rand_range(0,2) > 1):
	#		$AnimatedSprite.play("idleclean")
	#	else:
	#		$AnimatedSprite.play("idlestand")
	
	if ( pass_state == state.cycle ):
		$Sprite/AniSprite.play("idle")
		timer = 0
		checkseq = 0
	
	if ( pass_state == state.zapping ):
		$Sprite/Electricity.visible = true
		$Sprite/Electricity/CollisionShape2D.disabled = false

	
	if ( pass_state == state.falling ):
		$Sprite/AniSprite.play("idle")
		current_fall_speed = 0 		

	if ( pass_state == state.check ):
		$Sprite/AniSprite.play("check")

	if ( pass_state == state.direction ):
		#scale.x = direction.values()[ randi()%direction.size() ]
		#scale.x *= -1	
		#global_position.x += move_speed * scale.x * 2 	

		timer=50

		#print("changing direction current:", scale.x, " playing animation ",aniSet)

		$Sprite/AniSprite.play("R2L")
		

	if ( pass_state == state.toofar ):	

		enter_state(state.direction)
	
		pass


		
func changed_direction():
	
	#timer = 5	
	pass
	
	
func leave_state(pass_state):
	if ( pass_state == state.falling):
		#position = Vector2(position.x, position.y-1)
		pass
	#if ( pass_state == state.running):
		#print("leaving state running" )
		#if ( not ground_ray.is_colliding() ) :
			#print(" off platform" )
			#global_position.x += ((scale.x*-1))
		#// check 
		#pass
	#if ( )
	if ( pass_state == state.zapping):
		$Sprite/Electricity.visible = false
		$Sprite/Electricity/CollisionShape2D.disabled = true

		etimer = 0
		#position = Vector2(position.x, position.y-1)
		pass
		
func process_states(_delta):
	if ( this_state == state.falling):
		process_falling(_delta)
	elif ( this_state == state.running):
		process_running(_delta) 
	elif ( this_state == state.idle):
		process_idle(_delta) 
	elif ( this_state == state.zapping):
		process_zapping(_delta) 
	elif ( this_state == state.direction):
		process_direction(_delta)
		
	timer -= _delta
	#if ( self.name == robotCheckName and last_pos != -1 ):
	#	print(int(abs(last_pos-global_position.x)))
	if timer < 0 or ( last_pos != -1 and int(abs(last_pos-global_position.x)) >= limit_pos)  :
		#process_next()
		sequence_next()
	#if (self.name == "@Person@23"):	
	#	print(timer)
	




func process_falling(_delta): 
	if ( on_ground == false ):
		current_fall_speed = lerp(current_fall_speed,max_fall_speed,0.04)
		#global_position.x += move_speed_fall * scale.x
		global_position.y += current_fall_speed * _delta
		#$CPUParticles2D.speed_scale = current_fall_speed /1
		#if current_fall_speed >= max_fall_speed/1.75:
		#	$CPUParticles2D.emitting = true 
		if ( ground_ray.is_colliding() ):
			#print(ground_ray.get_collision_point())
			global_position = ground_ray.get_collision_point()
			global_position.y -= 0.5 * _delta
			enter_state(state.idle)
			on_ground = true
	else:
		# we should be on ground but ray collider says we are not
		if ( !ground_ray.is_colliding() ):
			#print( "falling -> under cell gone " )
			#scale.x *= -1
			enter_state(state.direction)






func process_running(delta): 
	if ( this_state != last_state and self.name == robotCheckName):
		print("groundray:", !ground_ray.is_colliding())
	if ( !ground_ray.is_colliding() ) :
		if ( on_ground == false ):
			enter_state(state.falling)
		else:
			#changed_direction()
			#scale.x *= -1		
			#print("running scale:", scale.x)			
			#global_position.x += move_speed * scale.x * 2 * delta
			
			enter_state(state.toofar)
			
			
			#enter_state(state.direction)
			

	else:
		
		if (wall_ray.is_colliding()):
			enter_state(state.toofar)
	#	scale.x *= -1
	
		global_position.x += move_speed * scale.x * delta
		
		
	
func process_idle(_delta): 
	
	pass


	
var elecdone = false
var etimer = 0
var c = 0
func process_zapping(_delta):
	etimer += _delta
	if ( self.name == robotCheckName ):
		print ( "elecdone:", elecdone, "e:", etimer, ":", (int(etimer*200) % 4) )
	if ( (int(etimer*200) % 4) == 0 ):

		#//
		#// alternate electric and blank frame
		#//
		
		if ( self.elecdone == false ):	

			#//
			#// swap from blue to white and white to blue every second showing
			#//
			c += 1
			c = c % 2	

			var d = int(rand_range(0,4))	#// pick 1 of 4 frames

			$Sprite/Electricity/Sprite.frame = d + (c*4)
			$Sprite/Electricity/Sprite.visible = true
			$Sprite/Electricity/CollisionShape2D.disabled = false

			if ( self.name == robotCheckName ):
				print(etimer, " d:", d + (c*4))

			self.elecdone = true

		else:
			$Sprite/Electricity/Sprite.visible = false
			$Sprite/Electricity/CollisionShape2D.disabled = true

			#// just show an empty frame for this cycle

			#$Sprite/Electricity/Sprite.frame = 8

			if ( self.name == robotCheckName ):			
				print(etimer, " d:", 8)

			self.elecdone = false

	pass


func process_direction(_delta):
	#print("process_direction", scale.x)
	pass
	
	#enter_state(state.idle)



var checkseq = 0
var last_pos = -1
var limit_pos = 16
func sequence_next():
	
	if ( self.name == robotCheckName ):
		print(" sequence ", moveMode, ":", detectMode," cs:", checkseq )
		
	if ( moveMode == primary_mode.idle ):
		enter_state(state.idle)
		pass
	elif ( moveMode == primary_mode.patrol ):

		if (this_state != state.running):
			enter_state(state.running)
		
		pass
		
		
	elif ( moveMode == primary_mode.check ):
		
		if ( checkseq == 0 ):
			enter_state(state.running)
			last_pos = global_position.x
			timer = 10
			limit_pos = 16
			checkseq = 1
					
		elif ( checkseq == 1 ):
			enter_state(state.check)
			last_pos = -1
			timer = 99
			checkseq = 0

			
	elif ( moveMode == primary_mode.patrolzapping ):
		if ( self.name == robotCheckName ):
			print("patrolzapping C:", checkseq, " T:", timer, " LP:", last_pos)
		if ( checkseq == 0 ):
			enter_state(state.running)
			last_pos = global_position.x
			timer = 10
			limit_pos = 16
			checkseq = 1
			
		elif ( checkseq == 1 ):
			global_position.x = last_pos + (limit_pos * scale.x)
			enter_state(state.zapping)
			last_pos = -1
			elecdone = false
			etimer = 0
			timer = 2
			checkseq = 0
			
		pass
		
		
	elif ( moveMode == primary_mode.idlezap ):
		
		if ( checkseq == 0 ):
			
			enter_state(state.nothing)
			timer = 2			
			checkseq = 1
			
		elif ( checkseq == 1 ):

			enter_state(state.zapping)
			timer = 2			
			checkseq = 0

			

	
	
	#if ( allowedmodes.find(descision) >= 0 ):
	#		
	#	pass
	#pass
	
func process_next(): 
	
	if ( !ground_ray.is_colliding() ):
		return
	
	if ( false ):
		
		var descision:int = state.values()[ randi()%(state.size()-1) ]		
	
		enter_state(descision)
		
	else:
		
		enter_state(state.running)
	
	#if (self.name == "@Person@23"):
	#	print("descision ", descision, ' d:', scale.x, ' v:', state.values(), " #:", state.size(), ' - ', ground_ray.is_colliding() )
	#	$sprite.modulate = Color("FF00FF")
	




func _on_AniSprite_animation_finished():
	#if ( self.name == robotCheckName ):
	#	print ("animation_finished dir:",scale.x, "s:", this_state)
	if ( this_state == state.direction ):
		scale.x *= -1
		
		timer=1
		enter_state(state.cycle)
		#process_next()

	if ( this_state == state.check ):
		timer=0
		pass
	


func _on_AniSprite_frame_changed():
	#print("ani changed ani:", $Sprite/AniSprite.animation, " frame:", $Sprite/AniSprite.frame, " t:", timer, " gr:", ground_ray.is_colliding())
	pass # Replace with function body.


func _on_Robot_area_entered(area):
	print("Robot => ", area.name, " collided with ", name)
	#// if area == player: kill player 
	if ( area.name == "Player"):
		area.emit_signal("player_die")
		$Sprite/Electricity/Sprite.visible = true
	pass # Replace with function body.


func _on_Electricity_area_entered(area):
	print("Electricity => ", area.name, " collided with ", name)
	#// if area == player: kill player 
	if ( area.name == "Player"):
		area.emit_signal("player_die")
		$Sprite/Electricity/Sprite.visible = true
	pass # Replace with function body.
