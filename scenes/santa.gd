extends KinematicBody2D
export (float) var gravedad #valor de la gravedad
export (float) var vel_despl #establecemos una velocidad a la que se movera
export (float) var vel_salto #establecemos una velocidad a la que saltara
var saltando = false
var velocidad = Vector2() #x e y guardamos en velocidad

func _ready():
	get_node("AnimatedSprite").play("parado")

func _physics_process(delta):
	velocidad.y += gravedad * delta # generamos una gravedad constante
	#hacer caminar al santa y que se quede parado
	if(Input.is_action_just_pressed("tecla_d")):
		get_node("AnimatedSprite").flip_h = false
		velocidad.x = vel_despl
		if(!saltando):
			get_node("AnimatedSprite").play("caminando")
	if(Input.is_action_just_pressed("tecla_a")):
		get_node("AnimatedSprite").flip_h = true
		velocidad.x = -vel_despl
		if(!saltando):
			get_node("AnimatedSprite").play("caminando")
	if(Input.is_action_just_released("tecla_d")):
		get_node("AnimatedSprite").play("parado")
		velocidad.x = 0
	if(Input.is_action_just_released("tecla_a")):
		get_node("AnimatedSprite").play("parado")
		velocidad.x = 0
	if(Input.is_action_pressed("tecla_w") && !saltando):
		get_node("AnimatedSprite").play("saltando")
		velocidad.y = -vel_salto
		saltando = true
	
	if(get_slide_collision(get_slide_count()-1 > 0)): #detectar lo que el santa ha tocado
		var obj_colisionado = get_slide_collision(get_slide_count()-1).collider #obtenemos el collider de lo que santa tocó
		if(obj_colisionado.is_in_group("suelo")):
			saltando = false
			if(velocidad.x == 0):
				get_node("AnimatedSprite").play("parado")
			if(velocidad.x != 0):
				get_node("AnimatedSprite").play("caminando")
				
	
		
		
	var movimiento = velocidad
	move_and_slide(movimiento)