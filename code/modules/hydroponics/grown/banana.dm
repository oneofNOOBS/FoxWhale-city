// Banana
/obj/item/seeds/banana
	name = "pack of banana seeds"
	desc = "They're seeds that grow into banana trees. When grown, keep away from clown."
	icon_state = "seed-banana"
	species = "banana"
	plantname = "Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana
	lifespan = 50
	endurance = 30
	instability = 10
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "banana-dead"
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/banana/black, /obj/item/seeds/banana/exotic_banana)
	reagents_add = list(/datum/reagent/consumable/banana = 0.1, /datum/reagent/potassium = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.02)

/obj/item/reagent_containers/food/snacks/grown/banana
	seed = /obj/item/seeds/banana
	name = "banana"
	desc = "It's an excellent prop for a clown."
	icon_state = "banana"
	item_state = "banana"
	trash = /obj/item/grown/bananapeel
	filling_color = "#FFFF00"
	bitesize = 5
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/banana = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/bananahonk

/obj/item/reagent_containers/food/snacks/grown/banana/generate_trash(atom/location)
	. = ..()
	var/obj/item/grown/bananapeel/peel = .
	if(istype(peel))
		peel.grind_results = list(/datum/reagent/consumable/banana_peel = seed.potency * 0.2)

/obj/item/reagent_containers/food/snacks/grown/banana/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is aiming [src] at [user.p_them()]self! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/items/bikehorn.ogg', 50, 1, -1)
	sleep(25)
	if(!user)
		return (OXYLOSS)
	user.say("BANG!", forced = "banana")
	sleep(25)
	if(!user)
		return (OXYLOSS)
	user.visible_message("<B>[user]</B> laughs so hard they begin to suffocate!")
	return (OXYLOSS)

//Banana Peel
/obj/item/grown/bananapeel
	seed = /obj/item/seeds/banana
	name = "banana peel"
	desc = "A peel from a banana."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	icon_state = "banana_peel"
	item_state = "banana_peel"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/grown/bananapeel/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is deliberately slipping on [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/misc/slip.ogg', 50, 1, -1)
	return (BRUTELOSS)

//Banana Spider.
/obj/item/seeds/banana/exotic_banana
	name = "pack of exotic banana seeds"
	desc = "They're seeds that grow into banana trees. However, those bananas might be alive."
	icon_state = "seed_exoticbanana"
	species = "exoticbanana"
	icon_grow = "banana-grow"
	plantname = "Exotic Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	seed = /obj/item/seeds/banana/exotic_banana
	name = "banana spider"
	desc = "You do not know what it is, but you can bet the clown would love it."
	icon_state = "exoticbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GROSS | MEAT | RAW | FRUIT
	grind_results = list(/datum/reagent/blood = 20, /datum/reagent/liquidgibs = 5)
	var/awakening = 0

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, "<span class='notice'>You decide to wake up the banana spider...</span>")
	awakening = 1

	spawn(30)
		if(!QDELETED(src))
			var/mob/living/simple_animal/banana_spider/S = new /mob/living/simple_animal/banana_spider(get_turf(src.loc))
			S.speed += round(10 / max(seed.potency, 1), 1)
			S.visible_message("<span class='notice'>The banana spider chitters as it stretches its legs.</span>")
			qdel(src)

//black banana
/obj/item/seeds/banana/black
	name = "pack of black banana seeds"
	desc = "They're seeds that grow into black banana trees."
	icon_state = "seed-banana-black"
	species = "blackbanana"
	icon_grow = "banana-grow"
	plantname = "Black Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana/black
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/maxchem, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/banana = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/iron = 0.01)
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/banana/black
	seed = /obj/item/seeds/banana/black
	name = "black banana"
	icon_state = "banana_black"
	item_state = "black_peel"
	trash = /obj/item/grown/bananapeel/black
	filling_color = "#070f01"
	tastes = list("banana" = 1)
	wine_power = 60
	wine_flavor = "Ваш язык орошает привычный банановый вкус. Ничего необычного. Послевкусие кажется слегка металлическим."

/obj/item/grown/bananapeel/black
	seed = /obj/item/seeds/banana/black
	name = "black banana peel"
	desc = "A peel from a black banana."
	icon_state = "banana_peel_black"

// Other
/obj/item/grown/bananapeel/specialpeel     //used by /obj/item/clothing/shoes/clown_shoes/banana_shoes
	name = "synthesized banana peel"
	desc = "A synthetic banana peel."

/obj/item/grown/bananapeel/specialpeel/Initialize(mapload, AM)
	. = ..()
	AddComponent(/datum/component/slippery, 40)
