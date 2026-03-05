<<<<<<< HEAD
/obj/machinery/light/rogue/firebowl
=======
/obj/machinery/light/fueled/firebowl
>>>>>>> upstream/main
	name = "brazier"
	icon = 'icons/roguetown/misc/lighting.dmi'
	icon_state = "stonefire1"
	density = TRUE
<<<<<<< HEAD
//	pixel_y = 10
	base_state = "stonefire"
	climbable = TRUE
	pass_flags = LETPASSTHROW
=======
	base_state = "stonefire"
	climbable = TRUE
	pass_flags_self = LETPASSTHROW
>>>>>>> upstream/main
	cookonme = TRUE
	dir = SOUTH
	crossfire = TRUE
	fueluse = 0

<<<<<<< HEAD
/obj/machinery/light/rogue/firebowl/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	return !density

/obj/machinery/light/rogue/firebowl/attack_hand(mob/user)
=======
/obj/machinery/light/fueled/firebowl/attack_hand(mob/user)
>>>>>>> upstream/main
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
<<<<<<< HEAD
			H.visible_message(span_info("[H] warms \his hand over the fire."))

			if(do_after(H, 15, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				to_chat(H, span_warning("HOT!"))
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
=======
			H.visible_message("<span class='info'>[H] warms \his hand over the fire.</span>")

			if(do_after(H, 1.5 SECONDS, src))
				// var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				// to_chat(H, "<span class='warning'>HOT!</span>")
				// if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
				// 	H.update_damage_overlays()
				H.adjust_bodytemperature(10)
>>>>>>> upstream/main
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

	else
		if(icon_state == "[base_state]over")
			user.visible_message("<span class='notice'>[user] starts to pick up [src]...</span>", \
				"<span class='notice'>I start to pick up [src]...</span>")
<<<<<<< HEAD
			if(do_after(user, 30, target = src))
				icon_state = "[base_state]0"
			return

/obj/machinery/light/rogue/firebowl/stump
	icon_state = "stumpfire1"
	base_state = "stumpfire"

/obj/machinery/light/rogue/firebowl/church
	icon_state = "churchfire1"
	base_state = "churchfire"


/obj/machinery/light/rogue/firebowl/standing
	name = "standing fire"
	icon_state = "standing1"
	base_state = "standing"
	bulb_colour = "#ff9648"
=======
			if(do_after(user, 3 SECONDS, src))
				icon_state = "[base_state]0"
			return

/obj/machinery/light/fueled/firebowl/firebowlb
	icon_state = "stonefireb1"
	base_state = "stonefireb"
	bulb_colour = "#6cfdff"

/obj/machinery/light/fueled/firebowl/stump
	icon_state = "stumpfire1"
	base_state = "stumpfire"

/obj/machinery/light/fueled/firebowl/stumpb
	icon_state = "stumpfireb1"
	base_state = "stumpfireb"
	bulb_colour = "#6cfdff"

/obj/machinery/light/fueled/firebowl/stumpg
	icon_state = "stumpfireg1"
	base_state = "stumpfireg"
	bulb_colour = "#23b25a"

/obj/machinery/light/fueled/firebowl/blackfire
	desc = "A fire, black as death."
	icon_state = "blackfire1"
	base_state = "blackfire"
	bulb_colour = "#8468ff"

/obj/machinery/light/fueled/firebowl/church
	icon_state = "churchfire1"
	base_state = "churchfire"

/obj/machinery/light/fueled/firebowl/church/magic
	name = "magical bonfire"
	color = "#6ab2ee"
	bulb_colour = "#6ab2ee"
	max_integrity = 30

/obj/machinery/light/fueled/firebowl/church/unholyfire
	desc = "This fire burns yet it is cold..."
	icon_state = "unholyfire1"
	base_state = "unholyfire"
	bulb_colour = "#8468ff"

/obj/machinery/light/fueled/firebowl/standing
	name = "standing fire"
	icon_state = "standing1"
	base_state = "standing"
	bulb_colour = "#ff9e54"
>>>>>>> upstream/main
	cookonme = FALSE
	crossfire = FALSE


<<<<<<< HEAD
/obj/machinery/light/rogue/firebowl/standing/blue
	bulb_colour = "#b9bcff"
	icon_state = "standingb1"
	base_state = "standingb"

/obj/machinery/light/rogue/firebowl/standing/proc/knock_over() //use this later for jump impacts and shit
	icon_state = "[base_state]over"

/obj/machinery/light/rogue/firebowl/standing/fire_act(added, maxstacks)
	if(icon_state != "[base_state]over")
		..()

/obj/machinery/light/rogue/firebowl/standing/onkick(mob/user)
=======
/obj/machinery/light/fueled/firebowl/standing/blue
	bulb_colour = "#8468ff"
	icon_state = "standingb1"
	base_state = "standingb"

/obj/machinery/light/fueled/firebowl/standing/proc/knock_over() //use this later for jump impacts and shit
	icon_state = "[base_state]over"

/obj/machinery/light/fueled/firebowl/standing/fire_act(added, maxstacks)
	if(icon_state != "[base_state]over")
		..()

/obj/machinery/light/fueled/firebowl/standing/onkick(mob/user)
>>>>>>> upstream/main
	if(isliving(user))
		var/mob/living/L = user
		if(icon_state == "[base_state]over")
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")
			return
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks over [src]!</span>", \
				"<span class='warning'>I kick over [src]!</span>")
			burn_out()
			knock_over()
		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")

<<<<<<< HEAD
/obj/machinery/light/rogue/wallfire
=======
/obj/machinery/light/fueled/wallfire
>>>>>>> upstream/main
	name = "fireplace"
	icon_state = "wallfire1"
	base_state = "wallfire"
	density = FALSE
	fueluse = 0
	crossfire = FALSE
	cookonme = TRUE
<<<<<<< HEAD

/obj/machinery/light/rogue/wallfire/big_fireplace
	icon_state = "fireplace1"
	base_state = "fireplace"
	icon = 'icons/roguetown/misc/fireplace64.dmi'

/obj/machinery/light/rogue/wallfire/candle
	name = "candles"
	icon_state = "wallcandle1"
	base_state = "wallcandle"
	crossfire = FALSE
	cookonme = FALSE
	pixel_y = 32
	soundloop = null

/obj/machinery/light/rogue/wallfire/candle/OnCrafted(dirin)
	pixel_x = 0
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32
	. = ..()

/obj/machinery/light/rogue/wallfire/candle/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
=======
	temperature_change = 30

/obj/machinery/light/fueled/wallfire/candle
	name = "candles"
	icon_state = "wallcandle1"
	base_state = "wallcandle"
	bulb_colour = "#ffa35c"
	crossfire = FALSE
	cookonme = FALSE
	SET_BASE_PIXEL(0, 32)
	soundloop = null
	temperature_change = 0

/obj/machinery/light/fueled/wallfire/candle/OnCrafted(dirin, mob/user)
	pixel_x = base_pixel_x
	pixel_y = base_pixel_y
	switch(dirin)
		if(NORTH)
			pixel_y += 32
		if(SOUTH)
			pixel_y -= 32
		if(EAST)
			pixel_x += 32
		if(WEST)
			pixel_x -= 32
	return ..()

/obj/machinery/light/fueled/wallfire/candle/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message("<span class='warning'>[user] snuffs [src].</span>")
>>>>>>> upstream/main
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()

<<<<<<< HEAD
/obj/machinery/light/rogue/wallfire/candle/r
	pixel_y = 0
	pixel_x = 32
/obj/machinery/light/rogue/wallfire/candle/l
	pixel_y = 0
	pixel_x = -32

/obj/machinery/light/rogue/wallfire/candle/blue
	bulb_colour = "#b9bcff"
	icon_state = "wallcandleb1"
	base_state = "wallcandleb"

/obj/machinery/light/rogue/wallfire/candle/blue/r
	pixel_y = 0
	pixel_x = 32
/obj/machinery/light/rogue/wallfire/candle/blue/l
	pixel_y = 0
	pixel_x = -32

/obj/machinery/light/rogue/wallfire/candle/weak
	light_power = 0.9
	light_outer_range =  6
/obj/machinery/light/rogue/wallfire/candle/weak/l
	pixel_x = -32
	pixel_y = 0
/obj/machinery/light/rogue/wallfire/candle/weak/r
	pixel_x = 32
	pixel_y = 0

/obj/machinery/light/rogue/wallfire/candle/lamp
	name = "candle lamp"
	icon_state = "candle"
	base_state = "candle"
	icon = 'icons/roguetown/misc/decoration.dmi'
=======
/obj/machinery/light/fueled/wallfire/candle/r
	SET_BASE_PIXEL(32, 0)

/obj/machinery/light/fueled/wallfire/candle/l
	SET_BASE_PIXEL(-32, 0)

/obj/machinery/light/fueled/wallfire/candle/blue
	bulb_colour = "#8d73ff"
	icon_state = "wallcandleb1"
	base_state = "wallcandleb"

/obj/machinery/light/fueled/wallfire/candle/blue/extinguish()
	return FALSE

/obj/machinery/light/fueled/wallfire/candle/blue/burn_out()
	return FALSE

/obj/machinery/light/fueled/wallfire/candle/blue/r
	SET_BASE_PIXEL(32, 0)

/obj/machinery/light/fueled/wallfire/candle/blue/l
	SET_BASE_PIXEL(-32, 0)

/obj/machinery/light/fueled/wallfire/candle/skull
	bulb_colour = "#8d73ff"
	icon_state = "skullwallcandle1"
	base_state = "skullwallcandle"

/obj/machinery/light/fueled/wallfire/candle/skull/extinguish()
	return FALSE

/obj/machinery/light/fueled/wallfire/candle/skull/burn_out()
	return FALSE

/obj/machinery/light/fueled/wallfire/candle/skull/r
	SET_BASE_PIXEL(32, 0)

/obj/machinery/light/fueled/wallfire/candle/skull/l
	SET_BASE_PIXEL(-32, 0)

/obj/machinery/light/fueled/wallfire/candle/weak
	light_power = 0.9
	light_outer_range =  6

/obj/machinery/light/fueled/wallfire/candle/weak/l
	SET_BASE_PIXEL(-32, 0)

/obj/machinery/light/fueled/wallfire/candle/weak/r
	SET_BASE_PIXEL(32, 0)

/*	.............   Candle lamp   ................ */
/obj/machinery/light/fueled/wallfire/candle/lamp // cant get them to start unlit but they work as is
	name = "candle lamp"
	icon_state = "candle"
	base_state = "candle"
>>>>>>> upstream/main
	layer = WALL_OBJ_LAYER+0.1
	light_power = 0.9
	light_outer_range =  6

<<<<<<< HEAD
/obj/machinery/light/rogue/torchholder
=======
/obj/machinery/light/fueled/torchholder
>>>>>>> upstream/main
	name = "sconce"
	icon_state = "torchwall1"
	base_state = "torchwall"
	brightness = 5
	density = FALSE
<<<<<<< HEAD
	var/obj/item/flashlight/flare/torch/torchy
=======
	var/obj/item/flashlight/flare/torch/torchy = /obj/item/flashlight/flare/torch
>>>>>>> upstream/main
	fueluse = FALSE //we use the torch's fuel
	soundloop = null
	crossfire = FALSE
	plane = GAME_PLANE_UPPER
	cookonme = FALSE
<<<<<<< HEAD
	var/lacks_torch

/obj/machinery/light/rogue/torchholder/c
	pixel_y = 32

/obj/machinery/light/rogue/torchholder/r
	dir = WEST

/obj/machinery/light/rogue/torchholder/l
	dir = EAST

/obj/machinery/light/rogue/torchholder/fire_act(added, maxstacks)
=======
	temperature_change = 0
	fog_parter_effect = null
	var/shows_empty = TRUE

/obj/machinery/light/fueled/torchholder/c
	SET_BASE_PIXEL(0, 32)

/obj/machinery/light/fueled/torchholder/r
	dir = WEST

/obj/machinery/light/fueled/torchholder/l
	dir = EAST

/obj/machinery/light/fueled/torchholder/update_icon_state()
	. = ..()
	if(!shows_empty)
		return
	if(torchy)
		return
	icon_state = base_state

/obj/machinery/light/fueled/torchholder/seton(s)
	. = ..()
	if(!torchy || torchy.fuel <= 0)
		on = FALSE
		set_light_on(on)

/obj/machinery/light/fueled/torchholder/fire_act(added, maxstacks)
>>>>>>> upstream/main
	if(torchy)
		if(!on)
			if(torchy.fuel > 0)
				torchy.spark_act()
<<<<<<< HEAD
				playsound(src.loc, 'sound/items/firelight.ogg', 100)
				on = TRUE
				update()
				update_icon()
				if(soundloop)
					soundloop.start()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
				return TRUE

/obj/machinery/light/rogue/torchholder/Initialize()
	if(!lacks_torch)
		torchy = new /obj/item/flashlight/flare/torch(src)
		torchy.spark_act()
	. = ..()

/obj/machinery/light/rogue/torchholder/OnCrafted(dirin, user)
	dir = turn(dirin, 180)
	if(dir == SOUTH)
		pixel_y = 32
	QDEL_NULL(torchy)
	. = ..()

/obj/machinery/light/rogue/torchholder/process()
=======
				playsound(src, 'sound/items/firelight.ogg', 100)
				on = TRUE
				update()
				update_appearance(UPDATE_ICON_STATE)
				if(soundloop)
					soundloop.start()
				return TRUE

/obj/machinery/light/fueled/torchholder/Initialize()
	if(torchy)
		torchy = new torchy(src)
		torchy.spark_act()
	. = ..()

/obj/machinery/light/fueled/torchholder/Destroy()
	if(torchy)
		QDEL_NULL(torchy)
	return ..()

/obj/machinery/light/fueled/torchholder/OnCrafted(dirin, user)
	if(dir == SOUTH)
		pixel_y = base_pixel_y + 32
	QDEL_NULL(torchy)
	. = ..()

/obj/machinery/light/fueled/torchholder/process()
>>>>>>> upstream/main
	if(on)
		if(torchy)
			if(torchy.fuel <= 0)
				burn_out()
			if(!torchy.on)
				burn_out()
		else
			return PROCESS_KILL

<<<<<<< HEAD
/obj/machinery/light/rogue/torchholder/attack_hand(mob/user)
=======
/obj/machinery/light/fueled/torchholder/attack_hand(mob/user)
>>>>>>> upstream/main
	. = ..()
	if(.)
		return
	if(torchy)
		if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(torchy))
			torchy.forceMove(loc)
		torchy = null
		on = FALSE
<<<<<<< HEAD
		set_light(0)
		update_icon()
		playsound(src.loc, 'sound/foley/torchfixturetake.ogg', 70)

/obj/machinery/light/rogue/torchholder/update_icon()
	if(torchy)
		if(on)
			icon_state = "[base_state]1"
		else
			icon_state = "[base_state]0"
	else
		icon_state = "torchwall"

/obj/machinery/light/rogue/torchholder/burn_out()
=======
		update()
		update_appearance(UPDATE_ICON_STATE)
		playsound(src, 'sound/foley/torchfixturetake.ogg', 70)

/obj/machinery/light/fueled/torchholder/burn_out()
>>>>>>> upstream/main
	if(torchy && torchy.on)
		torchy.turn_off()
	..()

<<<<<<< HEAD
/obj/machinery/light/rogue/torchholder/attackby(obj/item/W, mob/living/user, params)
=======
/obj/machinery/light/fueled/torchholder/attackby(obj/item/W, mob/living/user, list/modifiers)
>>>>>>> upstream/main
	if(istype(W, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = W
		if(torchy)
			if(LR.on && !on)
				if(torchy.fuel <= 0)
<<<<<<< HEAD
					to_chat(user, span_warning("The mounted torch is burned out."))
					return
				else
					torchy.spark_act()
					user.visible_message(span_info("[user] lights [src]."))
					playsound(src.loc, 'sound/items/firelight.ogg', 100)
					on = TRUE
					update()
					update_icon()
					addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
=======
					to_chat(user, "<span class='warning'>The mounted torch is burned out.</span>")
					return
				else
					torchy.spark_act()
					user.visible_message("<span class='info'>[user] lights [src].</span>")
					playsound(src, 'sound/items/firelight.ogg', 100)
					on = TRUE
					update()
					update_appearance(UPDATE_ICON_STATE)
>>>>>>> upstream/main
					return
			if(!LR.on && on)
				if(LR.fuel > 0)
					LR.spark_act()
<<<<<<< HEAD
					user.visible_message(span_info("[user] lights [LR] in [src]."))
=======
					user.visible_message("<span class='info'>[user] lights [LR] in [src].</span>")
>>>>>>> upstream/main
					user.update_inv_hands()
		else
			if(LR.on)
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
				on = TRUE
				update()
<<<<<<< HEAD
				update_icon()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
=======
				update_appearance(UPDATE_ICON_STATE)
>>>>>>> upstream/main
			else
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
<<<<<<< HEAD
				update_icon()
			playsound(src.loc, 'sound/foley/torchfixtureput.ogg', 70)
		return
	. = ..()

/obj/machinery/light/rogue/torchholder/cold
	lacks_torch = TRUE
	pixel_y = 32


/obj/machinery/light/rogue/chand
=======
				update_appearance(UPDATE_ICON_STATE)
			playsound(src, 'sound/foley/torchfixtureput.ogg', 70)
		return
	. = ..()

/obj/machinery/light/fueled/torchholder/metal_torch
	torchy = /obj/item/flashlight/flare/torch/metal

/obj/machinery/light/fueled/torchholder/metal_torch/west
	dir = WEST

/obj/machinery/light/fueled/torchholder/metal_torch/east
	dir = EAST

/obj/machinery/light/fueled/torchholder/metal_torch/north
	dir = NORTH

/obj/machinery/light/fueled/chand
>>>>>>> upstream/main
	name = "chandelier"
	icon_state = "chand1"
	base_state = "chand"
	icon = 'icons/roguetown/misc/tallwide.dmi'
	density = FALSE
	brightness = 10
<<<<<<< HEAD
	pixel_x = -10
	pixel_y = -10
=======
	SET_BASE_PIXEL(-10, -10)
>>>>>>> upstream/main
	layer = 2.0
	fueluse = 0
	soundloop = null
	crossfire = FALSE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
<<<<<<< HEAD

/obj/machinery/light/rogue/chand/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
=======
	temperature_change = 5

/obj/machinery/light/fueled/chand/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message("<span class='warning'>[user] snuffs [src].</span>")
>>>>>>> upstream/main
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()


<<<<<<< HEAD
/obj/machinery/light/rogue/hearth
=======
/obj/machinery/light/fueled/hearth
>>>>>>> upstream/main
	name = "hearth"
	icon_state = "hearth1"
	base_state = "hearth"
	density = TRUE
	anchored = TRUE
	climbable = TRUE
	climb_time = 3 SECONDS
	layer = TABLE_LAYER
	climb_offset = 14
	on = FALSE
	cookonme = TRUE
<<<<<<< HEAD
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	var/datum/looping_sound/boilloop/boilloop
	var/rawegg = FALSE

/obj/machinery/light/rogue/hearth/Initialize()
	boilloop = new(src, FALSE)
	. = ..()

/obj/machinery/light/rogue/hearth/attackby(obj/item/W, mob/living/user, params)
	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/bucket/pot))
			playsound(get_turf(user), 'sound/foley/dropsound/shovel_drop.ogg', 40, TRUE, -1)
			attachment = W
			W.forceMove(src)
			update_icon()
			return
	else
		if(istype(W, /obj/item/reagent_containers/glass/bowl))
			to_chat(user, span_notice("Remove the pot from the hearth first."))
			return
		if(istype(attachment, /obj/item/cooking/pan))
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(istype(W, /obj/item/reagent_containers/food/snacks/egg)) // added
					playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, 0)
					sleep(25) // to get egg crack before frying hiss
					W.icon_state = "rawegg" // added
					rawegg = TRUE
				if(!food)
					S.forceMove(src)
					food = S
					update_icon()
					if(on)
						playsound(src.loc, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 5)
					return
// New concept = boil at least 33 water, add item, it turns into food reagent volume 33 of the appropriate type
		else if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/reagent_containers/glass/bucket/pot/pot = attachment
			if(!pot.reagents.has_reagent(/datum/reagent/water, 33))
				to_chat(user, span_notice("Not enough water."))
				return TRUE
			if(pot.reagents.chem_temp < 374)
				to_chat(user, span_warning("[pot] isn't boiling!"))
				return
			pot.attempt_pot_recipes(W, user)
	. = ..()

//////////////////////////////////

/obj/machinery/light/rogue/hearth/fire_act(added, maxstacks)
	. = ..()
	if(food)
		playsound(src.loc, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 2)

/obj/machinery/light/rogue/hearth/update_icon()
	cut_overlays()
	icon_state = "[base_state][on]"
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/I = attachment
			I.pixel_x = 0
			I.pixel_y = 0
			add_overlay(new /mutable_appearance(I))
			if(food)
				I = food
				I.pixel_x = 0
				I.pixel_y = 0
				add_overlay(new /mutable_appearance(I))

/obj/machinery/light/rogue/hearth/attack_hand(mob/user)
=======
	soundloop = /datum/looping_sound/fireloop
	// temperature_change = 40
	var/heat_time = 100
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	var/rawegg = FALSE

/obj/machinery/light/fueled/hearth/Initialize()
	. = ..()

/obj/machinery/light/fueled/hearth/Destroy()
	. = ..()

/obj/machinery/light/fueled/hearth/attackby(obj/item/W, mob/living/user, list/modifiers)
	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/bucket/pot) || istype(W, /obj/item/reagent_containers/glass/carafe/teapot))
			playsound(user, 'sound/foley/dropsound/shovel_drop.ogg', 40, TRUE, -1)

			if(user.transferItemToLoc(W, src, silent = TRUE))
				attachment = W
				update_appearance(UPDATE_ICON_STATE | UPDATE_OVERLAYS)
			return

	else
		. = attachment.attackby(W, user, modifiers)
		if(.)
			return
	. = ..()

/obj/machinery/light/fueled/hearth/MouseDrop(mob/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!istype(over))
		return

	if(attachment && over == usr && over.CanReach(src))
		SEND_SIGNAL(attachment, COMSIG_TRY_STORAGE_SHOW, over, TRUE)

//////////////////////////////////

/obj/machinery/light/fueled/hearth/fire_act(added, maxstacks)
	. = ..()
	if(food)
		playsound(src, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 2)

/obj/machinery/light/fueled/hearth/update_overlays()
	. = ..()
	if(!attachment)
		return
	if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/bucket/pot) || istype(attachment, /obj/item/reagent_containers/glass/carafe/teapot))
		var/obj/item/I = attachment
		I.pixel_x = I.base_pixel_x
		I.pixel_y = I.base_pixel_y
		. += new /mutable_appearance(I)
		if(!food)
			return
		I = food
		I.pixel_x = I.pixel_x
		I.pixel_y = I.pixel_y
		. += new /mutable_appearance(I)

/obj/machinery/light/fueled/hearth/attack_hand(mob/user)
>>>>>>> upstream/main
	. = ..()
	if(.)
		return

	if(attachment)
<<<<<<< HEAD
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				if(rawegg)
					to_chat(user, span_notice("Throws away the raw egg."))
					rawegg = FALSE
					qdel(food)
					update_icon()
				if(!user.put_in_active_hand(food))
					food.forceMove(user.loc)
				food = null
				update_icon()
			else
				if(!user.put_in_active_hand(attachment))
					attachment.forceMove(user.loc)
				attachment = null
				update_icon()
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			if(!user.put_in_active_hand(attachment))
				attachment.forceMove(user.loc)
			attachment = null
			update_icon()
			boilloop.stop()
=======
		if(!user.put_in_active_hand(attachment))
			attachment.forceMove(user.loc)
		attachment = null
		update_appearance(UPDATE_ICON_STATE | UPDATE_OVERLAYS)
>>>>>>> upstream/main
	else
		if(on)
			var/mob/living/carbon/human/H = user
			if(istype(H))
<<<<<<< HEAD
				H.visible_message(span_info("[H] warms \his hand over the embers."))
				if(do_after(H, 50, target = src))
					var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
					to_chat(H, span_warning("HOT!"))
					if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
						H.update_damage_overlays()
			return TRUE


/obj/machinery/light/rogue/hearth/process()
=======
				H.visible_message("<span class='info'>[H] warms \his hand over the embers.</span>")
				if(do_after(H, 5 SECONDS, src))
					H.adjust_bodytemperature(10)
			return TRUE


/obj/machinery/light/fueled/hearth/process()
>>>>>>> upstream/main
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()
	if(on)
		if(initial(fueluse) > 0)
			if(fueluse > 0)
				fueluse = max(fueluse - 10, 0)
			if(fueluse == 0)
				burn_out()
<<<<<<< HEAD
		if(attachment)
			if(istype(attachment, /obj/item/cooking/pan))
				if(food)
					var/obj/item/C = food.cooking(20, src)
					if(C)
						if(rawegg)
							rawegg = FALSE
						qdel(food)
						food = C
			if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
				if(attachment.reagents)
					attachment.reagents.expose_temperature(400, 0.033)
					if(attachment.reagents.chem_temp > 374)
						boilloop.start()
					else
						boilloop.stop()
		update_icon()


/obj/machinery/light/rogue/hearth/onkick(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/hearth/Destroy()
	QDEL_NULL(boilloop)
	. = ..()

/obj/machinery/light/rogue/campfire
=======
		if(attachment?.reagents)
			attachment.reagents.expose_temperature(400, 0.04)
		update_appearance(UPDATE_OVERLAYS)

/obj/machinery/light/fueled/hearth/onkick(mob/user)
	if(isliving(user) && on)
		user.visible_message("<span class='warning'>[user] snuffs [src].</span>")
		burn_out()

/obj/machinery/light/fueled/campfire
>>>>>>> upstream/main
	name = "campfire"
	icon_state = "badfire1"
	base_state = "badfire"
	density = FALSE
	layer = 2.8
	brightness = 5
	on = FALSE
	fueluse = 15 MINUTES
	bulb_colour = "#da5e21"
	cookonme = TRUE
	max_integrity = 30
<<<<<<< HEAD
	light_outer_range = 5
	light_power = 3

/obj/machinery/light/rogue/campfire/process()
=======
	soundloop = /datum/looping_sound/fireloop

	temperature_change = 25

/obj/machinery/light/fueled/campfire/process()
>>>>>>> upstream/main
	..()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()

<<<<<<< HEAD
/obj/machinery/light/rogue/campfire/onkick(mob/user)
	if(isliving(user) && on)
		var/mob/living/L = user
		L.visible_message(span_info("[L] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/campfire/attack_hand(mob/user)
=======
/obj/machinery/light/fueled/campfire/onkick(mob/user)
	if(isliving(user) && on)
		var/mob/living/L = user
		L.visible_message("<span class='info'>[L] snuffs [src].</span>")
		burn_out()

/obj/machinery/light/fueled/campfire/attack_hand(mob/user)
>>>>>>> upstream/main
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
<<<<<<< HEAD
			H.visible_message(span_info("[H] warms \his hand near the fire."))

			if(do_after(H, 100, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				to_chat(H, span_warning("HOT!"))
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

/obj/machinery/light/rogue/campfire/densefire
=======
			H.visible_message("<span class='info'>[H] warms \his hand near the fire.</span>")

			if(do_after(H, 10 SECONDS, src))
				// var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				// to_chat(H, "<span class='warning'>HOT!</span>")
				// if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
				// 	H.update_damage_overlays()
				H.adjust_bodytemperature(10)
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

/obj/machinery/light/fueled/campfire/densefire
>>>>>>> upstream/main
	icon_state = "densefire1"
	base_state = "densefire"
	density = TRUE
	layer = 2.8
	brightness = 5
	climbable = TRUE
	on = FALSE
	fueluse = 30 MINUTES
<<<<<<< HEAD
	pass_flags = LETPASSTHROW
	bulb_colour = "#eea96a"
	max_integrity = 60

/obj/machinery/light/rogue/campfire/densefire/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	if(locate(/obj/machinery/light/rogue/firebowl) in get_turf(mover))
		return 1
	return !density


/obj/machinery/light/rogue/campfire/pyre
=======
	pass_flags_self = LETPASSTHROW
	bulb_colour = "#eea96a"
	max_integrity = 60

/obj/machinery/light/fueled/campfire/pyre
>>>>>>> upstream/main
	name = "pyre"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "pyre1"
	base_state = "pyre"
	brightness = 10
	fueluse = 30 MINUTES
	layer = BELOW_MOB_LAYER
	buckleverb = "crucifie"
	can_buckle = 1
	buckle_lying = 0
	dir = NORTH
	buckle_requires_restraints = 1
	buckle_prevents_pull = 1


<<<<<<< HEAD
/obj/machinery/light/rogue/campfire/pyre/post_buckle_mob(mob/living/M)
=======
/obj/machinery/light/fueled/campfire/pyre/post_buckle_mob(mob/living/M)
>>>>>>> upstream/main
	..()
	M.set_mob_offsets("bed_buckle", _x = 0, _y = 10)
	M.setDir(SOUTH)

<<<<<<< HEAD
/obj/machinery/light/rogue/campfire/pyre/post_unbuckle_mob(mob/living/M)
	..()
	M.reset_offsets("bed_buckle")

/obj/machinery/light/rogue/campfire/longlived
=======
/obj/machinery/light/fueled/campfire/pyre/post_unbuckle_mob(mob/living/M)
	..()
	M.reset_offsets("bed_buckle")

/obj/machinery/light/fueled/campfire/longlived
>>>>>>> upstream/main
	fueluse = 180 MINUTES
