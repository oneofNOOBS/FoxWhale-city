// Tomato		//remove: /obj/item/seeds/tomato/blue
/obj/item/seeds/tomato
	name = "pack of tomato seeds"
	desc = "These seeds grow into tomato plants."
	icon_state = "seed-tomato"
	species = "tomato"
	plantname = "Tomato Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/tomato
	instability = 25
	maturation = 8
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "tomato-grow"
	icon_dead = "tomato-dead"
	genes = list(/datum/plant_gene/trait/squash, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/tomato/blood, /obj/item/seeds/tomato/aztek)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/tomato
	seed = /obj/item/seeds/tomato
	name = "tomato"
	desc = "I say to-mah-to, you say tom-mae-to."
	icon_state = "tomato"
	splat_type = /obj/effect/decal/cleanable/tomato_smudge
	filling_color = "#FF6347"
	bitesize_mod = 2
	foodtype = FRUIT
	grind_results = list(/datum/reagent/consumable/ketchup = 0)
	juice_results = list(/datum/reagent/consumable/tomatojuice = 0)
	distill_reagent = /datum/reagent/consumable/enzyme

// Blood Tomato
/obj/item/seeds/tomato/blood
	name = "pack of blood-tomato seeds"
	desc = "These seeds grow into blood-tomato plants."
	icon_state = "seed-bloodtomato"
	species = "bloodtomato"
	plantname = "Blood-Tomato Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/tomato/blood
	mutatelist = list()
	reagents_add = list(/datum/reagent/blood/tomato = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	rarity = 20

/obj/item/reagent_containers/food/snacks/grown/tomato/blood
	seed = /obj/item/seeds/tomato/blood
	name = "blood-tomato"
	desc = "So bloody...so...very...bloody....AHHHH!!!!"
	icon_state = "bloodtomato"
	splat_type = /obj/effect/gibspawner/generic
	filling_color = "#FF0000"
	foodtype = FRUIT | GROSS
	grind_results = list(/datum/reagent/consumable/ketchup = 0, /datum/reagent/blood/tomato = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/bloody_mary

//aztek-tomato by DAXYA
/obj/item/seeds/tomato/aztek
	name = "pack of aztek-tomato seeds"
	desc = "These seeds grow into aztek-tomato plants."
	icon_state = "seed-aztektomato"
	species = "aztektomato"
	plantname = "Aztek-Tomato Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/tomato/aztek
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.08, /datum/reagent/consumable/nutriment = 0.2, /datum/reagent/water = 0.04)
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/tomato/aztek
	seed = /obj/item/seeds/tomato/aztek
	name = "aztek-tomato"
	desc = "Very tasty view"
	icon_state = "aztektomato"
	splat_type = /obj/effect/decal/cleanable/yellowtomato_smudge
	filling_color = "#e9dc23"
	foodtype = FRUIT | GROSS
	grind_results = list(/datum/reagent/consumable/ketchup = 0)
	juice_results = list(/datum/reagent/consumable/tomatojuice = 0)
	distill_reagent = /datum/reagent/consumable/enzyme
