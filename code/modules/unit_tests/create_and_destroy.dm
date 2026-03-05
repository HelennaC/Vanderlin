///Delete one of every type, sleep a while, then check to see if anything has gone fucky
/datum/unit_test/create_and_destroy
	//You absolutely must run after (almost) everything else
	priority = TEST_CREATE_AND_DESTROY

GLOBAL_VAR_INIT(running_create_and_destroy, FALSE)
/datum/unit_test/create_and_destroy/Run()
	if(SSmapping?.config?.map_name == "Voyage")
		return

	//We'll spawn everything here
<<<<<<< HEAD
	var/turf/spawn_at = run_loc_bottom_left
	var/list/ignore = list(
		//Never meant to be created, errors out the ass for mobcode reasons
		/mob/living/carbon,
		//Needs a seed passed, but subtypes set one by default
		/obj/item/grown,
		/obj/item/reagent_containers/food/snacks/grown,
		//And another
		/obj/item/slimecross/recurring,
		//This should be obvious
		/obj/machinery/doomsday_device,
		//Template type
		/obj/effect/mob_spawn,
		//Singleton
		/mob/dview,
		//Template type
		/obj/item/bodypart,
		//briefcase launchpads erroring
		/obj/item/storage/briefcase/launchpad,
		/obj/machinery/launchpad/briefcase,
		/obj/item/storage/box/syndicate/bundle_A, // can contain a launchpad briefcase
		//template types
		/obj/item/gun/magic,
		/obj/item/gun/magic/staff,
		//template type again
		/obj/item/storage/fancy,
		//needs a mob passed to view it
		/atom/movable/screen/credit,
		//invalid without mob/living passed
		/obj/shapeshift_holder,
		//abstract type, should not be spawned but subtypes are okay
		/mob/living/silicon/robot/modules,
		//explodes when deleted
		/obj/structure/checkoutmachine,
		//spawns a bunch of swarmers that wander off and damage stuff that gets spawned
		/mob/living/simple_animal/hostile/megafauna/swarmer_swarm_beacon,
		// requires a pod passed
		/obj/effect/DPfall,
		/obj/effect/DPtarget,
		// prompts loc for input
		/obj/item/clothing/suit/roguetown/shirt/grenzelhoft,
		// maploading
		/obj/item/hilbertshotel,
	)
	//these are VERY situational and need info passed
	ignore += typesof(/obj/effect/abstract)
	//needs a lich passed
	ignore += typesof(/obj/item/phylactery)
	//cba to fix hitscans erroring in Destroy, so just ignore all projectiles
	ignore += typesof(/obj/projectile)
	//needs an owner to work
	ignore += typesof(/obj/item/paper/contract)
	//needs a spell to work
	ignore += typesof(/obj/item/melee/blood_magic)
	//Doesn't work on our map setup
	ignore += typesof(/obj/item/disk/nuclear)
	//Say it with me now, type template
	ignore += typesof(/obj/effect/mapping_helpers)
	//This turf existing is an error in and of itself
	ignore += typesof(/turf/baseturf_skipover)
	ignore += typesof(/turf/baseturf_bottom)
	//This one demands a computer, so we'll let it off easy
	ignore += typesof(/obj/item/modular_computer/processor)
	//Very finiky, blacklisting to make things easier
	ignore += typesof(/obj/item/poster/wanted)
	//Needs a client / mob / hallucination to observe it to exist.
	ignore += typesof(/obj/effect/hallucination)
	ignore += typesof(/obj/projectile/hallucination)
	//Can't pass in a thing to glow
	ignore += typesof(/obj/effect/abstract/eye_lighting)
	//We have a baseturf limit of 10, adding more than 10 baseturf helpers will kill CI, so here's a future edge case to fix.
	ignore += typesof(/obj/effect/baseturf_helper)
	//No trauma to pass in
	ignore += typesof(/mob/camera/imaginary_friend)
	//No linked console
	ignore += typesof(/mob/camera/aiEye/remote/base_construction)
	//See above
	ignore += typesof(/mob/camera/aiEye/remote/shuttle_docker)
	//No one to be friends with :(
	ignore += typesof(/obj/effect/mob_spawn/human/demonic_friend)
	//Hangs a ref post invoke async, which we don't support. Could put a qdeleted check but it feels hacky
	ignore += typesof(/obj/effect/anomaly/grav/high)
	//See above
	ignore += typesof(/obj/effect/timestop)
	//this boi spawns turf changing stuff, and it stacks and causes pain. Let's just not
	ignore += typesof(/obj/effect/sliding_puzzle)
	//Our system doesn't support it without warning spam from unregister calls on things that never registered
	ignore += typesof(/obj/docking_port)
	//Asks for a shuttle that may not exist, let's leave it alone
	ignore += typesof(/obj/item/pinpointer/shuttle)
	//Expects a mob to holderize, we have nothing to give
	ignore += typesof(/obj/item/clothing/head/mob_holder)
	//Needs cards passed into the initilazation args
	ignore += typesof(/obj/item/toy/cards/cardhand)
	//Needs a holodeck area linked to it which is not guarenteed to exist and technically is supposed to have a 1:1 relationship with computer anyway.
	ignore += typesof(/obj/machinery/computer/holodeck)
	//invalid without start and end
	ignore += typesof(/obj/effect/immovablerod)
	//invoke async + explosion in init + all sorts of nastiness on subtypes
	ignore += typesof(/obj/effect/temp_visual/hierophant)
	//these explode when Destroy()ed
	ignore += typesof(/obj/machinery/vending/custom)
	ignore += typesof(/obj/vehicle/sealed)
	ignore += typesof(/obj/mecha)
	//these also like to explode if anything else is on their turf or nearby
	ignore += typesof(/obj/effect/meteor)
	//ENDS THE FUCKING WORLD.
	ignore += typesof(/obj/singularity/narsie)
	//needs multiple atoms passed
	ignore += typesof(/obj/effect/buildmode_line)
	//needs a fried item passed
	ignore += typesof(/obj/item/reagent_containers/food/snacks/deepfryholder)
	// requires other parts
	ignore += typesof(/obj/machinery/gravity_generator)
	// requires a generator
	ignore += typesof(/obj/structure/projected_forcefield)
	// genuinely just too lazy to get this one working
	ignore += typesof(/obj/structure/bodycontainer)
=======
	var/turf/spawn_at = run_loc_floor_bottom_left
>>>>>>> upstream/main

	var/list/cached_contents = spawn_at.contents.Copy()
	var/original_turf_type = spawn_at.type
	var/original_baseturfs = islist(spawn_at.baseturfs) ? spawn_at.baseturfs.Copy() : spawn_at.baseturfs
	var/original_baseturf_count = length(original_baseturfs)

	GLOB.running_create_and_destroy = TRUE
	for(var/type_path in typesof(/atom/movable, /turf) - uncreatables) //No areas please
		if(ispath(type_path, /turf))
			spawn_at.ChangeTurf(type_path)
			//We change it back to prevent baseturfs stacking and hitting the limit
			spawn_at.ChangeTurf(original_turf_type, original_baseturfs)
			if(original_baseturf_count != length(spawn_at.baseturfs))
				TEST_FAIL("[type_path] changed the amount of baseturfs from [original_baseturf_count] to [length(spawn_at.baseturfs)]; [english_list(original_baseturfs)] to [islist(spawn_at.baseturfs) ? english_list(spawn_at.baseturfs) : spawn_at.baseturfs]")
				//Warn if it changes again
				original_baseturfs = islist(spawn_at.baseturfs) ? spawn_at.baseturfs.Copy() : spawn_at.baseturfs
				original_baseturf_count = length(original_baseturfs)
		else
			var/atom/creation = new type_path(spawn_at)
			if(QDELETED(creation))
				continue
			//Go all in
			qdel(creation, force = TRUE)
			//This will hold a ref to the last thing we process unless we set it to null
			//Yes byond is fucking sinful
			creation = null

		//There's a lot of stuff that either spawns stuff in on create, or removes stuff on destroy. Let's cut it all out so things are easier to deal with
		var/list/to_del = spawn_at.contents - cached_contents
		if(length(to_del))
			for(var/atom/to_kill in to_del)
				qdel(to_kill)

	GLOB.running_create_and_destroy = FALSE

	// Drastically lower the amount of time it takes to GC, since we don't have clients that can hold it up.
	SSgarbage.collection_timeout[GC_QUEUE_CHECK] = 10 SECONDS
	//Clear it, just in case
	cached_contents.Cut()

	var/list/queues_we_care_about = list()
	// All of em, I want hard deletes too, since we rely on the debug info from them
	for(var/i in 1 to GC_QUEUE_HARDDELETE)
		queues_we_care_about += i

	//Now that we've qdel'd everything, let's sleep until the gc has processed all the shit we care about
	// + 2 seconds to ensure that everything gets in the queue.
	var/time_needed = 2 SECONDS
	for(var/index in queues_we_care_about)
		time_needed += SSgarbage.collection_timeout[index]

	var/start_time = world.time
	var/real_start_time = REALTIMEOFDAY
	var/garbage_queue_processed = FALSE

	sleep(time_needed)

	while(!garbage_queue_processed)
		var/oldest_packet_creation = INFINITY
		for(var/index in queues_we_care_about)
			var/list/queue_to_check = SSgarbage.queues[index]
			if(!length(queue_to_check))
				continue

			var/list/oldest_packet = queue_to_check[1]
			//Pull out the time we inserted at
			var/qdeld_at = oldest_packet[GC_QUEUE_ITEM_GCD_DESTROYED]

			oldest_packet_creation = min(qdeld_at, oldest_packet_creation)

		//If we've found a packet that got del'd later then we finished, then all our shit has been processed
		//That said, if there are any pending hard deletes you may NOT sleep, we gotta handle that shit
		if(oldest_packet_creation > start_time && !length(SSgarbage.queues[GC_QUEUE_HARDDELETE]))
			garbage_queue_processed = TRUE
			break

		if(REALTIMEOFDAY > real_start_time + time_needed + 50 MINUTES) //If this gets us gitbanned I'm going to laugh so hard
			TEST_FAIL("Something has gone horribly wrong, the garbage queue has been processing for well over 50 minutes. What the hell did you do")
			break

		//Immediately fire the gc right after
		SSgarbage.next_fire = 1
		//Unless you've seriously fucked up, queue processing shouldn't take "that" long. Let her run for a bit, see if anything's changed
		sleep(20 SECONDS)

	//Alright, time to see if anything messed up
	var/list/cache_for_sonic_speed = SSgarbage.items
	for(var/path in cache_for_sonic_speed)
		var/datum/qdel_item/item = cache_for_sonic_speed[path]
		if(item.failures)
			TEST_FAIL("[item.name] hard deleted [item.failures] times out of a total del count of [item.qdels]")
		if(item.no_respect_force)
			TEST_FAIL("[item.name] failed to respect force deletion [item.no_respect_force] times out of a total del count of [item.qdels]")
		if(item.no_hint)
			TEST_FAIL("[item.name] failed to return a qdel hint [item.no_hint] times out of a total del count of [item.qdels]")
		if(LAZYLEN(item.extra_details))
			var/details = item.extra_details.Join("\n")
			TEST_FAIL("[item.name] failed with extra info: \n[details]")

	cache_for_sonic_speed = SSatoms.BadInitializeCalls
	for(var/path in cache_for_sonic_speed)
		var/fails = cache_for_sonic_speed[path]
		if(fails & BAD_INIT_NO_HINT)
			TEST_FAIL("[path] didn't return an Initialize hint")
		if(fails & BAD_INIT_QDEL_BEFORE)
			TEST_FAIL("[path] qdel'd before we could call Initialize()")
		if(fails & BAD_INIT_SLEPT)
			TEST_FAIL("[path] slept during Initialize()")

	//This shouldn't be needed, but let's be polite
	SSgarbage.collection_timeout[GC_QUEUE_CHECK] = GC_CHECK_QUEUE
