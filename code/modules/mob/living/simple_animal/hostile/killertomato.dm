/mob/living/simple_animal/hostile/killertomato
	name = "Killer Tomato"
	desc = "It's a horrifyingly enormous beef tomato, and it's packing extra beef!"
	icon_state = "tomato"
	icon_living = "tomato"
	icon_dead = "tomato_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 80
	health = 80
	see_in_dark = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/meatwheat = 10)
	response_help_continuous  = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	melee_damage_lower = 12
	melee_damage_upper = 20
	attack_verb_continuous = "slams"
	attack_verb_simple = "slam"
	attack_sound = 'sound/weapons/punch1.ogg'
	faction = list("plants")

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 500
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/killertomato/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ventcrawling, given_tier = VENTCRAWLER_ALWAYS)
