function PlayerInventory:get_jammer_time()
	if PECME.settings.duration_edit then
		return PECME.settings.ECM_duration
	
		else
		
			return 6
		
	end
	
end