/obj/machinery/recharger
	name = "recharger"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger"
	base_icon_state = "recharger"
	desc = "A charging dock for energy based weaponry."
	use_power = IDLE_POWER_USE
	idle_power_usage = 4
	active_power_usage = 250
	circuit = /obj/item/circuitboard/machine/recharger
	pass_flags = PASSTABLE
	var/obj/item/charging = null
	var/recharge_coeff = 1
	var/using_power = FALSE //Did we put power into "charging" last process()?
	///Did we finish recharging the currently inserted item?
	var/finished_recharging = FALSE

	var/static/list/allowed_devices = typecacheof(list(
		/obj/item/gun/energy,
		/obj/item/melee/baton,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/modular_computer,
		/obj/item/ammo_casing/mws_batt,
		/obj/item/ammo_box/magazine/mws_mag,
		/obj/item/electrostaff))

/obj/machinery/recharger/RefreshParts()
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_coeff = C.rating

/obj/machinery/recharger/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
		. += "<span class='warning'>You're too far away to examine [src]'s contents and display!</span>"
		return

	if(charging)
		. += {"<span class='notice'>\The [src] contains:</span>
		<span class='notice'>- \A [charging].</span>"}

	if(!(machine_stat & (NOPOWER|BROKEN)))
		. += "<span class='notice'>The status display reads:</span>"
		. += "<span class='notice'>- Recharging <b>[recharge_coeff*10]%</b> cell charge per cycle.</span>"
		if(charging)
			var/obj/item/stock_parts/cell/C = charging.get_cell()
			. += "<span class='notice'>- \The [charging]'s cell is at <b>[C.percent()]%</b>.</span>"

/obj/machinery/recharger/proc/setCharging(new_charging)
	charging = new_charging
	if (new_charging)
		START_PROCESSING(SSmachines, src)
		finished_recharging = FALSE
		use_power = ACTIVE_POWER_USE
		using_power = TRUE
		update_appearance()
	else
		use_power = IDLE_POWER_USE
		using_power = FALSE
		update_appearance()

/obj/machinery/recharger/Exited(atom/movable/M, atom/newloc)
	. = ..()
	if(charging == M)
		setCharging()

/obj/machinery/recharger/attackby(obj/item/G, mob/user, params)
	if(G.tool_behaviour == TOOL_WRENCH)
		if(charging)
			to_chat(user, "<span class='notice'>Remove the charging item first!</span>")
			return
		setAnchored(!anchored)
		power_change()
		to_chat(user, "<span class='notice'>You [anchored ? "attached" : "detached"] [src].</span>")
		G.play_tool_sound(src)
		return

	var/allowed = is_type_in_typecache(G, allowed_devices)

	if(allowed)
		if(anchored)
			if(charging || panel_open)
				return TRUE

			//Checks to make sure he's not in space doing it, and that the area got proper power.
			var/area/a = get_area(src)
			if(!a || !a.powered(EQUIP))
				to_chat(user, "<span class='notice'>[src] blinks red as you try to insert [G].</span>")
				return TRUE

			if (istype(G, /obj/item/gun/energy))
				var/obj/item/gun/energy/E = G
				if(!E.can_charge)
					to_chat(user, "<span class='notice'>Your gun has no external power connector.</span>")
					return TRUE

			if(!user.transferItemToLoc(G, src))
				return TRUE
			setCharging(G)

		else
			to_chat(user, "<span class='notice'>[src] isn't connected to anything!</span>")
		return TRUE

	if(anchored && !charging)
		if(default_deconstruction_screwdriver(user, "recharger", "recharger", G))
			update_appearance()
			return

		if(panel_open && G.tool_behaviour == TOOL_CROWBAR)
			default_deconstruction_crowbar(G)
			return

	return ..()

/obj/machinery/recharger/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)

	add_fingerprint(user)
	if(charging)
		charging.update_icon()
		user.put_in_hands(charging)

/obj/machinery/recharger/attack_tk(mob/user)
	if(charging)
		charging.update_icon()
		charging.forceMove(drop_location())

/obj/machinery/recharger/process()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		return PROCESS_KILL

	using_power = FALSE
	if(charging)
		var/obj/item/stock_parts/cell/C = charging.get_cell()
		if(C)
			if(C.charge < C.maxcharge)
				C.give(C.chargerate * recharge_coeff)
				use_power(250 * recharge_coeff)
				using_power = TRUE
			update_appearance()

		if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			var/obj/item/ammo_box/magazine/recharge/R = charging
			if(R.stored_ammo.len < R.max_ammo)
				R.stored_ammo += new R.ammo_type(R)
				use_power(200 * recharge_coeff)
				using_power = TRUE
			update_appearance()
			return

		if(istype(charging, /obj/item/ammo_casing/mws_batt))
			var/obj/item/ammo_casing/mws_batt/R = charging
			if(R.cell.charge < R.cell.maxcharge)
				R.cell.give(R.cell.chargerate * recharge_coeff)
				use_power(250 * recharge_coeff)
				using_power = 1
			if(R.BB == null)
				R.chargeshot()
			update_appearance()

		if(istype(charging, /obj/item/ammo_box/magazine/mws_mag))
			var/obj/item/ammo_box/magazine/mws_mag/R = charging
			for(var/B in R.stored_ammo)
				var/obj/item/ammo_casing/mws_batt/batt = B
				if(batt.cell.charge < batt.cell.maxcharge)
					batt.cell.give(batt.cell.chargerate * recharge_coeff)
					use_power(250 * recharge_coeff)
					using_power = 1
				if(batt.BB == null)
					batt.chargeshot()
			update_appearance()

		if(!using_power && !finished_recharging) //Inserted thing is at max charge/ammo, notify those around us
			finished_recharging = TRUE
			playsound(src, 'sound/machines/ping.ogg', 30, TRUE)
			say("[charging] has finished recharging!")

	else
		return PROCESS_KILL

/obj/machinery/recharger/power_change()
	..()
	update_appearance()

/obj/machinery/recharger/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_CONTENTS)
		return
	if(!(machine_stat & (NOPOWER|BROKEN)) && anchored)
		if(istype(charging,  /obj/item/gun/energy))
			var/obj/item/gun/energy/E = charging
			if(E.cell)
				E.cell.emp_act(severity)

		else if(istype(charging, /obj/item/melee/baton))
			var/obj/item/melee/baton/B = charging
			if(B.cell)
				B.cell.charge = 0

/obj/machinery/recharger/update_appearance(updates)
	. = ..()
	if((machine_stat & (NOPOWER|BROKEN)) || panel_open || !anchored)
		luminosity = 0
		return
	luminosity = 1

/obj/machinery/recharger/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		return
	if(panel_open)
		. += mutable_appearance(icon, "[base_icon_state]-open", alpha = src.alpha)
		return

	if(!charging)
		. += mutable_appearance(icon, "[base_icon_state]-empty", alpha = src.alpha)
		. += emissive_appearance(icon, "[base_icon_state]-empty", alpha = src.alpha)
		return
	if(using_power)
		. += mutable_appearance(icon, "[base_icon_state]-charging", alpha = src.alpha)
		. += emissive_appearance(icon, "[base_icon_state]-charging", alpha = src.alpha)
		return

	. += mutable_appearance(icon, "[base_icon_state]-full", alpha = src.alpha)
	. += emissive_appearance(icon, "[base_icon_state]-full", alpha = src.alpha)
