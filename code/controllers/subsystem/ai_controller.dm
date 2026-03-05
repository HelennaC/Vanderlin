/// The subsystem used to tick [/datum/ai_controllers] instances. Handling the re-checking of plans.
SUBSYSTEM_DEF(ai_controllers)
	name = "AI Controller Ticker"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	init_order = INIT_ORDER_AI_CONTROLLERS
	wait = 0.5 SECONDS //Plan every half second if required, not great not terrible.
<<<<<<< HEAD
	///List of all ai_subtree singletons, key is the typepath while assigned value is a newly created instance of the typepath. See setup_subtrees()
	var/list/ai_subtrees = list()
	///List of all ai controllers currently running
	var/list/active_ai_controllers = list()
=======
	///type of status we are interested in running
	var/planning_status = AI_STATUS_ON
	/// The tick cost of all active AI, calculated on fire.
	var/our_cost

#define AI_STATUS_OFF_MAX_TIME 5 SECONDS
>>>>>>> upstream/main

/datum/controller/subsystem/ai_controllers/Initialize(timeofday)
	setup_subtrees()
	return ..()

/datum/controller/subsystem/ai_controllers/proc/setup_subtrees()
<<<<<<< HEAD
	ai_subtrees = list()
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		ai_subtrees[subtree_type] = subtree

/datum/controller/subsystem/ai_controllers/fire(resumed)
	for(var/datum/ai_controller/ai_controller as anything in active_ai_controllers)
		if(!COOLDOWN_FINISHED(ai_controller, failed_planning_cooldown))
			continue
=======
	if(length(GLOB.ai_subtrees))
		return
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		GLOB.ai_subtrees[subtree_type] = subtree

///Called when the max Z level was changed, updating our coverage.
/datum/controller/subsystem/ai_controllers/proc/on_max_z_changed()
	if(!length(GLOB.ai_controllers_by_zlevel))
		GLOB.ai_controllers_by_zlevel = new /list(world.maxz,0)
	while (GLOB.ai_controllers_by_zlevel.len < world.maxz)
		GLOB.ai_controllers_by_zlevel.len++
		GLOB.ai_controllers_by_zlevel[GLOB.ai_controllers_by_zlevel.len] = list()

/datum/controller/subsystem/ai_controllers/fire(resumed)
	var/timer = TICK_USAGE_REAL
	for(var/datum/ai_controller/ai_controller as anything in GLOB.ai_controllers_by_status[planning_status])
		if(!COOLDOWN_FINISHED(ai_controller, failed_planning_cooldown))
			continue

>>>>>>> upstream/main
		if(!ai_controller.able_to_plan())
			continue
		ai_controller.SelectBehaviors(wait * 0.1)
		if(!LAZYLEN(ai_controller.current_behaviors)) //Still no plan
			COOLDOWN_START(ai_controller, failed_planning_cooldown, AI_FAILED_PLANNING_COOLDOWN)
<<<<<<< HEAD
=======

	our_cost = MC_AVERAGE(our_cost, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))

#undef AI_STATUS_OFF_MAX_TIME
>>>>>>> upstream/main
