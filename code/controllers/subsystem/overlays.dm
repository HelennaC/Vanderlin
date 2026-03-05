SUBSYSTEM_DEF(overlays)
	name = "Overlay"
	flags = SS_NO_FIRE|SS_NO_INIT
	var/list/stats
	var/list/overlay_icon_state_caches
	var/list/overlay_icon_cache

/datum/controller/subsystem/overlays/PreInit()
<<<<<<< HEAD
	overlay_icon_state_caches = list()
	overlay_icon_cache = list()
=======
>>>>>>> upstream/main
	stats = list()

/datum/controller/subsystem/overlays/Shutdown()
	text2file(render_stats(stats), "[GLOB.log_directory]/overlay.log")

<<<<<<< HEAD

/datum/controller/subsystem/overlays/Recover()
	overlay_icon_state_caches = SSoverlays.overlay_icon_state_caches
	overlay_icon_cache = SSoverlays.overlay_icon_cache

=======
>>>>>>> upstream/main
/// Converts an overlay list into text for debug printing
/// Of note: overlays aren't actually mutable appearances, they're just appearances
/// Don't have access to that type tho, so this is the best you're gonna get
/proc/overlays2text(list/overlays)
	var/list/unique_overlays = list()
	// As anything because we're basically doing type coercion, rather then actually filtering for mutable appearances
	for(var/mutable_appearance/overlay as anything in overlays)
		var/key = "[overlay.icon]-[overlay.icon_state]-[overlay.dir]"
		unique_overlays[key] += 1
	var/list/output_text = list()
	for(var/key in unique_overlays)
		output_text += "([key]) = [unique_overlays[key]]"
	return output_text.Join("\n")

/proc/iconstate2appearance(icon, iconstate)
	var/static/image/stringbro = new()
	stringbro.icon = icon
	stringbro.icon_state = iconstate
	return stringbro.appearance

/proc/icon2appearance(icon)
	var/static/image/iconbro = new()
	iconbro.icon = icon
	return iconbro.appearance

/atom/proc/build_appearance_list(build_overlays)
<<<<<<< HEAD
	if (!islist(build_overlays))
		build_overlays = list(build_overlays)
	for (var/overlay in build_overlays)
		if(!overlay)
			build_overlays -= overlay
			continue
		if (istext(overlay))
=======
	if(!islist(build_overlays))
		build_overlays = list(build_overlays)

	for(var/overlay in build_overlays)
		if(!overlay)
			build_overlays -= overlay
			continue
		if(istext(overlay))
			// This is too expensive to run normally but running it during CI is a good test
			// if(PERFORM_ALL_TESTS(focus_only/invalid_overlays))
			// 	if(!icon_exists(icon, overlay))
			// 		var/icon_file = "[icon]" || "Unknown Generated Icon"
			// 		stack_trace("Invalid overlay: Icon object '[icon_file]' [REF(icon)] used in '[src]' [type] is missing icon state [overlay].")
			// 		continue
>>>>>>> upstream/main
			build_overlays -= overlay
			build_overlays += iconstate2appearance(icon, overlay)
		else if(isicon(overlay))
			build_overlays -= overlay
			build_overlays += icon2appearance(overlay)
<<<<<<< HEAD
	return build_overlays

#define NOT_QUEUED_ALREADY (!(flags_1 & OVERLAY_QUEUED_1))
#define QUEUE_FOR_COMPILE flags_1 |= OVERLAY_QUEUED_1; SSoverlays.queue += src;
/atom/proc/cut_overlays()
	STAT_START_STOPWATCH
	overlays = null
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

=======

	return build_overlays

/atom/proc/cut_overlays()
	STAT_START_STOPWATCH
	overlays = null
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

>>>>>>> upstream/main
/atom/proc/cut_overlay(list/remove_overlays)
	if(!overlays)
		return
	STAT_START_STOPWATCH
	overlays -= build_appearance_list(remove_overlays)
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

/atom/proc/add_overlay(list/add_overlays)
	if(!overlays)
		return
	STAT_START_STOPWATCH
	overlays += build_appearance_list(add_overlays)
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

/atom/proc/copy_overlays(atom/other, cut_old) //copys our_overlays from another atom
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	STAT_START_STOPWATCH
	var/list/cached_other = other.overlays.Copy()
	if(cut_old)
		if(cached_other)
			overlays = cached_other
		else
			overlays = null
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)
	else if(cached_other)
		overlays += cached_other
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)
<<<<<<< HEAD



#undef NOT_QUEUED_ALREADY
#undef QUEUE_FOR_COMPILE
=======
>>>>>>> upstream/main

//TODO: Better solution for these?
/image/proc/add_overlay(x)
	overlays |= x

/image/proc/cut_overlay(x)
	overlays -= x

/image/proc/cut_overlays(x)
	overlays.Cut()

/image/proc/copy_overlays(atom/other, cut_old)
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	var/list/cached_other = other.overlays.Copy()
	if(cached_other)
		if(cut_old || !overlays.len)
			overlays = cached_other
		else
			overlays |= cached_other
	else if(cut_old)
		cut_overlays()
