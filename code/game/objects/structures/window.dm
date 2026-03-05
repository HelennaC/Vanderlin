
/obj/structure/window
	name = "window"
	desc = "A window of simple paned glass."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "window-solid"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	pass_flags_self = PASSWINDOW|PASSSTRUCTURE
	max_integrity = 100
	integrity_failure = 0.1
	blade_dulling = DULLING_BASHCHOP
	CanAtmosPass = ATMOS_PASS_PROC
	climb_time = 20
	climb_offset = 10
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'

	var/lockdir = 0

	// See repairable component in repairable.dm for what these variables do
	var/list/repair_thresholds = list(/obj/item/natural/glass = 1)
	var/obj/item/broken_repair = /obj/item/grown/log/tree/small
	var/repair_skill = /datum/skill/craft/masonry

/obj/structure/window/Initialize()
	. = ..()
	update_appearance(UPDATE_ICON_STATE)

	if(repair_thresholds || broken_repair)
		AddComponent(/datum/component/repairable, repair_thresholds, broken_repair,  'sound/misc/wood_saw.ogg', repair_skill)

/obj/structure/window/get_explosion_resistance()
	if(!climbable)
		return max_integrity
	else
<<<<<<< HEAD
		if(anchored)
			. += "<span class='notice'>The window is <b>screwed</b> to the floor.</span>"
		else
			. += "<span class='notice'>The window is <i>unscrewed</i> from the floor, and could be deconstructed by <b>wrenching</b>.</span>"

/obj/structure/window/Initialize(mapload, direct)
	. = ..()
	if(direct)
		setDir(direct)
	if(reinf && anchored)
		state = RWINDOW_SECURE

	ini_dir = dir
	air_update_turf(1)

	if(fulltile)
		setDir()

	//windows only block while reinforced and fulltile, so we'll use the proc
	real_explosion_block = explosion_block
	explosion_block = EXPLOSION_BLOCK_PROC

/obj/structure/window/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS ,null,CALLBACK(src, PROC_REF(can_be_rotated)),CALLBACK(src,PROC_REF(after_rotation)))

/obj/structure/window/narsie_act()
	add_atom_colour(NARSIE_WINDOW_COLOUR, FIXED_COLOUR_PRIORITY)

/obj/structure/window/singularity_pull()

/obj/structure/window/setDir(direct)
	if(!fulltile)
		..()
	else
		..(FULLTILE_WINDOW_DIR)

/obj/structure/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGLASS))
		return 1
	if(dir == FULLTILE_WINDOW_DIR)
		return 0	//full tile window, you can't move into it!
	if(get_dir(loc, target) == dir)
		return !density
	if(istype(mover, /obj/structure/window))
		var/obj/structure/window/W = mover
		if(!valid_window_location(loc, W.ini_dir))
			return FALSE
	return 1

/obj/structure/window/CheckExit(atom/movable/O, turf/target)
	if(istype(O) && (O.pass_flags & PASSGLASS))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/window/attack_tk(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("<span class='notice'>Something knocks on [src].</span>")
	add_fingerprint(user)
	playsound(src, 'sound/blank.ogg', 50, TRUE)

/obj/structure/window/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)
	if(!can_be_reached(user))
		return
	. = ..()

/obj/structure/window/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!can_be_reached(user))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("<span class='notice'>[user] knocks on [src].</span>", \
		"<span class='notice'>I knock on [src].</span>")
	add_fingerprint(user)
	playsound(src, 'sound/blank.ogg', 50, TRUE)

/obj/structure/window/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/window/attack_generic(mob/user, damage_amount = 0, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)	//used by attack_alien, attack_animal, and attack_slime
	if(!can_be_reached(user))
		return
	..()

/obj/structure/window/attackby(obj/item/I, mob/living/user, params)
	if(!can_be_reached(user))
		return 1 //skip the afterattack

	add_fingerprint(user)

	if(I.tool_behaviour == TOOL_WELDER && user.used_intent.type == INTENT_HELP)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, "<span class='notice'>I begin repairing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=50))
				obj_integrity = max_integrity
				update_nearby_icons()
				to_chat(user, "<span class='notice'>I repair [src].</span>")
		else
			to_chat(user, "<span class='warning'>[src] is already in good condition!</span>")
		return

	if(!(flags_1&NODECONSTRUCT_1) && !(reinf && state >= RWINDOW_FRAME_BOLTED))
		if(I.tool_behaviour == TOOL_SCREWDRIVER)
			to_chat(user, "<span class='notice'>I begin to [anchored ? "unscrew the window from":"screw the window to"] the floor...</span>")
			if(I.use_tool(src, user, decon_speed, volume = 75, extra_checks = CALLBACK(src, PROC_REF(check_anchored), anchored)))
				setAnchored(!anchored)
				to_chat(user, "<span class='notice'>I [anchored ? "fasten the window to":"unfasten the window from"] the floor.</span>")
			return
		else if(I.tool_behaviour == TOOL_WRENCH && !anchored)
			to_chat(user, "<span class='notice'>I begin to disassemble [src]...</span>")
			if(I.use_tool(src, user, decon_speed, volume = 75, extra_checks = CALLBACK(src, PROC_REF(check_state_and_anchored), state, anchored)))
				var/obj/item/stack/sheet/G = new glass_type(user.loc, glass_amount)
				G.add_fingerprint(user)
				playsound(src, 'sound/blank.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>I successfully disassemble [src].</span>")
				qdel(src)
			return
		else if(I.tool_behaviour == TOOL_CROWBAR && reinf && (state == WINDOW_OUT_OF_FRAME) && anchored)
			to_chat(user, "<span class='notice'>I begin to lever the window into the frame...</span>")
			if(I.use_tool(src, user, 100, volume = 75, extra_checks = CALLBACK(src, PROC_REF(check_state_and_anchored), state, anchored)))
				state = RWINDOW_SECURE
				to_chat(user, "<span class='notice'>I pry the window into the frame.</span>")
			return

	return ..()

/obj/structure/window/setAnchored(anchorvalue)
	..()
	air_update_turf(TRUE)
	update_nearby_icons()

/obj/structure/window/proc/check_state(checked_state)
	if(state == checked_state)
		return TRUE

/obj/structure/window/proc/check_anchored(checked_anchored)
	if(anchored == checked_anchored)
		return TRUE

/obj/structure/window/proc/check_state_and_anchored(checked_state, checked_anchored)
	return check_state(checked_state) && check_anchored(checked_anchored)

/obj/structure/window/proc/can_be_reached(mob/user)
	if(!fulltile)
		if(get_dir(user,src) & dir)
			for(var/obj/O in loc)
				if(!O.CanPass(user, user.loc, 1))
					return 0
	return 1

/obj/structure/window/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	. = ..()
	if(.) //received damage
		update_nearby_icons()

/obj/structure/window/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, hitsound, 75, TRUE)
			else
				playsound(src, 'sound/blank.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/blank.ogg', 100, TRUE)


/obj/structure/window/deconstruct(disassembled = TRUE)
	if(QDELETED(src))
		return
	if(!disassembled)
		playsound(src, breaksound, 70, TRUE)
		if(!(flags_1 & NODECONSTRUCT_1))
			for(var/obj/item/shard/debris in spawnDebris(drop_location()))
				transfer_fingerprints_to(debris) // transfer fingerprints to shards only
	qdel(src)
	update_nearby_icons()

/obj/structure/window/proc/spawnDebris(location)
	. = list()
	. += new /obj/item/shard(location)
	. += new /obj/effect/decal/cleanable/glass(location)
	if (reinf)
		. += new /obj/item/stack/rods(location, (fulltile ? 2 : 1))
	if (fulltile)
		. += new /obj/item/shard(location)

/obj/structure/window/proc/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>[src] cannot be rotated while it is fastened to the floor!</span>")
		return FALSE

	var/target_dir = turn(dir, rotation_type == ROTATION_CLOCKWISE ? -90 : 90)

	if(!valid_window_location(loc, target_dir))
		to_chat(user, "<span class='warning'>[src] cannot be rotated in that direction!</span>")
		return FALSE
	return TRUE

/obj/structure/window/proc/after_rotation(mob/user,rotation_type)
	air_update_turf(1)
	ini_dir = dir
	add_fingerprint(user)

/obj/structure/window/Destroy()
	density = FALSE
	air_update_turf(1)
	update_nearby_icons()
	return ..()


/obj/structure/window/Move()
	var/turf/T = loc
	. = ..()
	setDir(ini_dir)
	move_update_air(T)
=======
		return 0
>>>>>>> upstream/main

/obj/structure/window/CanAtmosPass(turf/T)
	return climbable

/obj/structure/window/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][obj_broken ? "br" : ""]"

/obj/structure/window/attack_ghost(mob/dead/observer/user)	// lets ghosts click on windows to transport across
	density = FALSE
	. = step(user,get_dir(user,src.loc))
	density = TRUE

/obj/structure/window/solid
	desc = "A window of simple paned glass."
	icon_state = "window-solid"
	integrity_failure = 0.5

/obj/structure/window/stained
	icon_state = "stained-silver"
	max_integrity = 100
	integrity_failure = 0.75
	repair_thresholds = list(/obj/item/natural/glass = 1)
	broken_repair = /obj/item/natural/stone

/obj/structure/window/stained/silver
	desc = "A stained-glass window filigreed in silver."
	icon_state = "stained-silver"
	max_integrity = 100
	integrity_failure = 0.75

/obj/structure/window/stained/silver/alt
	icon_state = "stained-silver1"

/obj/structure/window/stained/zizo
	desc = "A stained-glass window filigreed in deep crimson."
	icon_state = "stained-zizo"

/obj/structure/window/stained/yellow
	desc = "A stained-glass window filigreed in gold."
	icon_state = "stained-yellow"

/obj/structure/window/openclose
	desc = "It opens and closes."
	icon_state = MAP_SWITCH("woodwindow", "woodwindowdir")
	max_integrity = 100
	integrity_failure = 0.5

/obj/structure/window/openclose/Initialize()
	. = ..()
	lockdir = dir
	GLOB.TodUpdate += src
	var/static/list/loc_connections = list(
		COMSIG_ATOM_MAGICALLY_UNLOCKED = PROC_REF(on_magic_unlock),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/window/openclose/Destroy()
	GLOB.TodUpdate -= src
	return ..()

/obj/structure/window/openclose/proc/on_magic_unlock(datum/source, datum/action/cooldown/spell/aoe/knock, mob/living/caster)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(open_up))

/obj/structure/window/openclose/update_tod(todd)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/openclose/update_icon_state()
	. = ..()
	var/icon
	if(GLOB.tod == "night")
		icon += "w-"
	icon += initial(icon_state)
	if(obj_broken)
		icon_state = "[icon]br"
		return
	if(climbable)
		icon_state = "[icon]op"
		return
	icon_state = "[icon]"

/obj/structure/window/openclose/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(get_dir(src, user) == lockdir)
		if(obj_broken)
			to_chat(user, "<span class='warning'>It's broken, that would be foolish.</span>")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
		if(climbable)
			close_up(user)
		else
			open_up(user)
	else
		to_chat(user, "<span class='warning'>The window doesn't close from this side.</span>")

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/window/openclose/attackby(obj/item/attacking_item, mob/user, list/modifiers)
	if(istype(attacking_item, /obj/item/weapon/knife/dagger) && !climbable && !user.cmode)
		to_chat(user, span_notice("I start trying to pry the window open..."))
		if(do_after(user, 6 SECONDS, src))
			playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
			src.force_open()
	else
		return ..()

/obj/structure/window/openclose/reinforced
	desc = "A glass window. This one looks reinforced with a metal mesh."
	icon_state = MAP_SWITCH("reinforcedwindow", "reinforcedwindowdir")
	max_integrity = 800
	integrity_failure = 0.1
	metalizer_result = null
	smeltresult = /obj/item/ingot/iron

/obj/structure/window/proc/open_up(mob/user)
	if(user)
		visible_message("<span class='info'>[user] opens [src].</span>")
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	update_appearance(UPDATE_ICON_STATE)
	air_update_turf(TRUE)

/obj/structure/window/proc/close_up(mob/user)
	if(user)
		visible_message("<span class='info'>[user] closes [src].</span>")
	playsound(src, 'sound/foley/doors/windowdown.ogg', 100, FALSE)
	climbable = FALSE
	update_appearance(UPDATE_ICON_STATE)
	air_update_turf(TRUE)

/obj/structure/window/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(mover.throwing && !climbable)
		if(isliving(mover))
			if(iscarbon(mover))
				var/mob/living/carbon/dude = mover
				take_damage(20 * (dude.STASTR / 10))
			else
				take_damage(10)
		else if(isitem(mover) && mover.throwforce > 10)
			take_damage(mover.throwforce)

	if(climbable && (mover.throwing || mover.movement_type & (FLYING|FLOATING)))
		if(ishuman(mover))
			var/mob/living/carbon/human/dude = mover
			if(prob(100 - clamp((dude.get_skill_level(/datum/skill/misc/athletics, TRUE) + dude.get_skill_level(/datum/skill/misc/climbing, TRUE)) * 10 - (!dude.IsOffBalanced() * 30), 10, 100)))
				var/obj/item/bodypart/head/head = dude.get_bodypart(BODY_ZONE_HEAD)
				if(head)
					head.receive_damage(20)
				dude.Stun(5 SECONDS)
				dude.Knockdown(5 SECONDS)
				dude.add_stress(/datum/stress_event/hithead)
				dude.visible_message(
					span_warning("[dude] hits their head as they fly through the window!"),
					span_danger("I hit my head on the window frame!"),
				)

		return TRUE

/obj/structure/window/proc/force_open()
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	opacity = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/attackby(obj/item/W, mob/user, list/modifiers)
	return ..()

/obj/structure/window/attack_paw(mob/living/user)
	attack_hand(user)

<<<<<<< HEAD
/obj/structure/window/reinforced/examine(mob/user)
	. = ..()
	switch(state)
		if(RWINDOW_SECURE)
			. += "<span class='notice'>It's been screwed in with one way screws, you'd need to <b>heat them</b> to have any chance of backing them out.</span>"
		if(RWINDOW_BOLTS_HEATED)
			. += "<span class='notice'>The screws are glowing white hot, and you'll likely be able to <b>unscrew them</b> now.</span>"
		if(RWINDOW_BOLTS_OUT)
			. += "<span class='notice'>The screws have been removed, revealing a small gap you could fit a <b>prying tool</b> in.</span>"
		if(RWINDOW_POPPED)
			. += "<span class='notice'>The main plate of the window has popped out of the frame, exposing some bars that look like they can be <b>cut</b>.</span>"
		if(RWINDOW_BARS_CUT)
			. += "<span class='notice'>The main pane can be easily moved out of the way to reveal some <b>bolts</b> holding the frame in.</span>"

/obj/structure/window/reinforced/spawner/east
	dir = EAST

/obj/structure/window/reinforced/spawner/west
	dir = WEST

/obj/structure/window/reinforced/spawner/north
	dir = NORTH

/obj/structure/window/reinforced/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME

/obj/structure/window/plasma
	name = "plasma window"
	desc = ""
	icon_state = "plasmawindow"
	reinf = FALSE
	heat_resistance = 25000
	armor = list("melee" = 80, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 45, "bio" = 100, "rad" = 100, "fire" = 99, "acid" = 100)
	max_integrity = 200
	explosion_block = 1
	glass_type = /obj/item/stack/sheet/plasmaglass
	rad_insulation = RAD_NO_INSULATION

/obj/structure/window/plasma/spawnDebris(location)
	. = list()
	. += new /obj/item/shard/plasma(location)
	. += new /obj/effect/decal/cleanable/glass/plasma(location)
	if (reinf)
		. += new /obj/item/stack/rods(location, (fulltile ? 2 : 1))
	if (fulltile)
		. += new /obj/item/shard/plasma(location)

/obj/structure/window/plasma/spawner/east
	dir = EAST

/obj/structure/window/plasma/spawner/west
	dir = WEST

/obj/structure/window/plasma/spawner/north
	dir = NORTH

/obj/structure/window/plasma/unanchored
	anchored = FALSE

/obj/structure/window/plasma/reinforced
	name = "reinforced plasma window"
	desc = ""
	icon_state = "plasmarwindow"
	reinf = TRUE
	heat_resistance = 50000
	armor = list("melee" = 80, "bullet" = 20, "laser" = 0, "energy" = 0, "bomb" = 60, "bio" = 100, "rad" = 100, "fire" = 99, "acid" = 100)
	max_integrity = 500
	damage_deflection = 21
	explosion_block = 2
	glass_type = /obj/item/stack/sheet/plasmarglass

//entirely copypasted code
//take this out when construction is made a component or otherwise modularized in some way
/obj/structure/window/plasma/reinforced/attackby(obj/item/I, mob/living/user, params)
	switch(state)
		if(RWINDOW_SECURE)
			if(I.tool_behaviour == TOOL_WELDER && user.used_intent.type == INTENT_HARM)
				user.visible_message("<span class='notice'>[user] holds \the [I] to the security screws on \the [src]...</span>",
										"<span class='notice'>I begin heating the security screws on \the [src]...</span>")
				if(I.use_tool(src, user, 180, volume = 100))
					to_chat(user, "<span class='notice'>The security screws are glowing white hot and look ready to be removed.</span>")
					state = RWINDOW_BOLTS_HEATED
					addtimer(CALLBACK(src, PROC_REF(cool_bolts)), 300)
				return
		if(RWINDOW_BOLTS_HEATED)
			if(I.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message("<span class='notice'>[user] digs into the heated security screws and starts removing them...</span>",
										"<span class='notice'>I dig into the heated screws hard and they start turning...</span>")
				if(I.use_tool(src, user, 80, volume = 50))
					state = RWINDOW_BOLTS_OUT
					to_chat(user, "<span class='notice'>The screws come out, and a gap forms around the edge of the pane.</span>")
				return
		if(RWINDOW_BOLTS_OUT)
			if(I.tool_behaviour == TOOL_CROWBAR)
				user.visible_message("<span class='notice'>[user] wedges \the [I] into the gap in the frame and starts prying...</span>",
										"<span class='notice'>I wedge \the [I] into the gap in the frame and start prying...</span>")
				if(I.use_tool(src, user, 50, volume = 50))
					state = RWINDOW_POPPED
					to_chat(user, "<span class='notice'>The panel pops out of the frame, exposing some thin metal bars that looks like they can be cut.</span>")
				return
		if(RWINDOW_POPPED)
			if(I.tool_behaviour == TOOL_WIRECUTTER)
				user.visible_message("<span class='notice'>[user] starts cutting the exposed bars on \the [src]...</span>",
										"<span class='notice'>I start cutting the exposed bars on \the [src]</span>")
				if(I.use_tool(src, user, 30, volume = 50))
					state = RWINDOW_BARS_CUT
					to_chat(user, "<span class='notice'>The panels falls out of the way exposing the frame bolts.</span>")
				return
		if(RWINDOW_BARS_CUT)
			if(I.tool_behaviour == TOOL_WRENCH)
				user.visible_message("<span class='notice'>[user] starts unfastening \the [src] from the frame...</span>",
					"<span class='notice'>I start unfastening the bolts from the frame...</span>")
				if(I.use_tool(src, user, 50, volume = 50))
					to_chat(user, "<span class='notice'>I unfasten the bolts from the frame and the window pops loose.</span>")
					state = WINDOW_OUT_OF_FRAME
					setAnchored(FALSE)
				return
	return ..()

/obj/structure/window/plasma/reinforced/examine(mob/user)
	. = ..()
	switch(state)
		if(RWINDOW_SECURE)
			. += "<span class='notice'>It's been screwed in with one way screws, you'd need to <b>heat them</b> to have any chance of backing them out.</span>"
		if(RWINDOW_BOLTS_HEATED)
			. += "<span class='notice'>The screws are glowing white hot, and you'll likely be able to <b>unscrew them</b> now.</span>"
		if(RWINDOW_BOLTS_OUT)
			. += "<span class='notice'>The screws have been removed, revealing a small gap you could fit a <b>prying tool</b> in.</span>"
		if(RWINDOW_POPPED)
			. += "<span class='notice'>The main plate of the window has popped out of the frame, exposing some bars that look like they can be <b>cut</b>.</span>"
		if(RWINDOW_BARS_CUT)
			. += "<span class='notice'>The main pane can be easily moved out of the way to reveal some <b>bolts</b> holding the frame in.</span>"

/obj/structure/window/plasma/reinforced/spawner/east
	dir = EAST

/obj/structure/window/plasma/reinforced/spawner/west
	dir = WEST

/obj/structure/window/plasma/reinforced/spawner/north
	dir = NORTH

/obj/structure/window/plasma/reinforced/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME

/obj/structure/window/reinforced/tinted
	name = "tinted window"
	icon_state = "twindow"
	opacity = 1
/obj/structure/window/reinforced/tinted/frosted
	name = "frosted window"
	icon_state = "fwindow"

/* Full Tile Windows (more obj_integrity) */

/obj/structure/window/fulltile
	icon = 'icons/obj/smooth_structures/window.dmi'
	icon_state = "window"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 50
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile)
	glass_amount = 2

/obj/structure/window/fulltile/unanchored
	anchored = FALSE

/obj/structure/window/plasma/fulltile
	icon = 'icons/obj/smooth_structures/plasma_window.dmi'
	icon_state = "plasmawindow"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 300
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile)
	glass_amount = 2

/obj/structure/window/plasma/fulltile/unanchored
	anchored = FALSE

/obj/structure/window/plasma/reinforced/fulltile
	icon = 'icons/obj/smooth_structures/rplasma_window.dmi'
	icon_state = "rplasmawindow"
	dir = FULLTILE_WINDOW_DIR
	state = RWINDOW_SECURE
	max_integrity = 1000
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	glass_amount = 2

/obj/structure/window/plasma/reinforced/fulltile/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME

/obj/structure/window/reinforced/fulltile
	icon = 'icons/obj/smooth_structures/reinforced_window.dmi'
	icon_state = "r_window"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 150
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	state = RWINDOW_SECURE
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile)
	level = 3
	glass_amount = 2

/obj/structure/window/reinforced/fulltile/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'icons/obj/smooth_structures/tinted_window.dmi'
	icon_state = "tinted_window"
	dir = FULLTILE_WINDOW_DIR
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile)
	level = 3
	glass_amount = 2

/obj/structure/window/reinforced/fulltile/ice
	icon = 'icons/obj/smooth_structures/rice_window.dmi'
	icon_state = "ice_window"
	max_integrity = 150
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile)
	level = 3
	glass_amount = 2

/obj/structure/window/shuttle
	name = "shuttle window"
	desc = ""
	icon = 'icons/obj/smooth_structures/shuttle_window.dmi'
	icon_state = "shuttle_window"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 150
	wtype = "shuttle"
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	reinf = TRUE
	heat_resistance = 1600
	armor = list("melee" = 90, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 100)
	smooth = SMOOTH_TRUE
	canSmoothWith = null
	explosion_block = 3
	level = 3
	glass_type = /obj/item/stack/sheet/titaniumglass
	glass_amount = 2

/obj/structure/window/shuttle/narsie_act()
	add_atom_colour("#3C3434", FIXED_COLOUR_PRIORITY)

/obj/structure/window/shuttle/tinted
	opacity = TRUE

/obj/structure/window/shuttle/unanchored
	anchored = FALSE

/obj/structure/window/plasma/reinforced/plastitanium
	name = "plastitanium window"
	desc = ""
	icon = 'icons/obj/smooth_structures/plastitanium_window.dmi'
	icon_state = "plastitanium_window"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 200
	wtype = "shuttle"
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	heat_resistance = 1600
	armor = list("melee" = 95, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 100)
	smooth = SMOOTH_TRUE
	canSmoothWith = null
	explosion_block = 3
	damage_deflection = 11 //The same as normal reinforced windows.
	level = 3
	glass_type = /obj/item/stack/sheet/plastitaniumglass
	glass_amount = 2
	rad_insulation = RAD_HEAVY_INSULATION

/obj/structure/window/plasma/reinforced/plastitanium/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME

/obj/structure/window/paperframe
	name = "paper frame"
	desc = ""
	icon = 'icons/obj/smooth_structures/paperframes.dmi'
	icon_state = "frame"
	dir = FULLTILE_WINDOW_DIR
	opacity = TRUE
	max_integrity = 15
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/window/paperframe)
	glass_amount = 2
	glass_type = /obj/item/stack/sheet/paperframes
	heat_resistance = 233
	decon_speed = 10
	CanAtmosPass = ATMOS_PASS_YES
	resistance_flags = FLAMMABLE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	breaksound = 'sound/blank.ogg'
	hitsound = 'sound/blank.ogg'
	var/static/mutable_appearance/torn = mutable_appearance('icons/obj/smooth_structures/paperframes.dmi',icon_state = "torn", layer = ABOVE_OBJ_LAYER - 0.1)
	var/static/mutable_appearance/paper = mutable_appearance('icons/obj/smooth_structures/paperframes.dmi',icon_state = "paper", layer = ABOVE_OBJ_LAYER - 0.1)

/obj/structure/window/paperframe/Initialize()
	. = ..()
	update_icon()

/obj/structure/window/paperframe/examine(mob/user)
	. = ..()
	if(obj_integrity < max_integrity)
		. += "<span class='info'>It looks a bit damaged, you may be able to fix it with some <b>paper</b>.</span>"

/obj/structure/window/paperframe/spawnDebris(location)
	. = list(new /obj/item/stack/sheet/mineral/wood(location))
	for (var/i in 1 to rand(1,4))
		. += new /obj/item/paper/natural(location)

/obj/structure/window/paperframe/attack_hand(mob/user)
=======
/obj/structure/window/attack_hand(mob/living/user)
>>>>>>> upstream/main
	. = ..()
	if(.)
		return
	if(obj_broken)
		return
	if( user.used_intent.type == /datum/intent/unarmed/claw )
		to_chat(user, "<span class='warning'>[user] smashes the window!!</span>")
		atom_break()
		return
	user.changeNext_move(CLICK_CD_MELEE)
	src.visible_message("<span class='info'>[user] knocks on [src].</span>")
	add_fingerprint(user)
	playsound(src, 'sound/misc/glassknock.ogg', 100)

/obj/structure/window/atom_break(damage_flag, silent)
	if(!obj_broken)
		attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
		new /obj/item/natural/glass/shard (get_turf(src))
		climbable = TRUE
	..()
	update_appearance(UPDATE_ICON_STATE)
	air_update_turf(TRUE)

/obj/structure/window/atom_fix()
	. = ..()
	climbable = initial(climbable)
	update_appearance(UPDATE_ICON_STATE)
	air_update_turf(TRUE)
