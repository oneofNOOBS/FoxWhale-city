//////////
//DILDOS//
//////////
/obj/item/dildo
	name 				= "dildo"
	desc 				= "Floppy!"
	icon 				= 'icons/obj/genitals/dildo.dmi'
	force 				= 0
	hitsound			= 'sound/weapons/tap.ogg'
	throwforce			= 0
	icon_state 			= "dildo_knotted_2"
	alpha 				= 192//transparent
	var/can_customize	= FALSE
	var/dildo_shape 	= "human"
	var/dildo_size		= 2
	var/dildo_type		= "dildo"//pretty much just used for the icon state
	var/random_color 	= TRUE
	var/random_size 	= FALSE
	var/random_shape 	= FALSE
	var/is_knotted		= FALSE
	//Lists moved to _cit_helpers.dm as globals so they're not instanced individually

/obj/item/dildo/update_appearance()
	icon_state = "[dildo_type]_[dildo_shape]_[dildo_size]"

/obj/item/dildo/Initialize(mapload)
	. = ..()
	if(random_color == TRUE)
		var/randcolor = pick(GLOB.dildo_colors)
		color = GLOB.dildo_colors[randcolor]
	if(random_shape == TRUE)
		var/randshape = pick(GLOB.dildo_shapes)
		dildo_shape = GLOB.dildo_shapes[randshape]
	if(random_size == TRUE)
		var/randsize = pick(GLOB.dildo_sizes)
		dildo_size = GLOB.dildo_sizes[randsize]
	update_appearance()
	alpha		= rand(192, 255)
	pixel_y 	= rand(-7,7)
	pixel_x 	= rand(-7,7)

/obj/item/dildo/random//totally random
	name 				= "random dildo"//this name will show up in vendors and shit so you know what you're vending(or don't, i guess :^))
	random_color 		= TRUE
	random_shape 		= TRUE
	random_size 		= TRUE

/obj/item/dildo/knotted
	dildo_shape 		= "knotted"
	name 				= "knotted dildo"
	attack_verb 		= list("penetrated", "knotted", "slapped", "inseminated")

/obj/item/dildo/human
	dildo_shape 		= "human"
	name 				= "human dildo"
	attack_verb = list("penetrated", "slapped", "inseminated")

/obj/item/dildo/plain
	dildo_shape 		= "plain"
	name 				= "plain dildo"
	attack_verb 		= list("penetrated", "slapped", "inseminated")

/obj/item/dildo/flared
	dildo_shape 		= "flared"
	name 				= "flared dildo"
	attack_verb 		= list("penetrated", "slapped", "neighed", "gaped", "prolapsed", "inseminated")

/obj/item/dildo/flared/huge
	name 				= "literal horse cock"
	desc 				= "THIS THING IS HUGE!"
	dildo_size 			= 4
	hitsound = 'sound/weapons/klonk.ogg'

///////////////////
//FOXWHALE DILDOS//
//////////////////

/obj/item/dildo/flared/gigantic
	name 				= "Big horse cock"
	desc 				= "Огромный лошадиный член. Выглядит устрашающе!"
	dildo_size 			= 5
