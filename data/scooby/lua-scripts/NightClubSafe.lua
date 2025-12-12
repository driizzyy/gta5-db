ncs = stats.set_int -- NightClubSafe! >:c not NoCopyrightSounds
script.run_in_callback(function()
	while true do
		ncs("mpx_club_popularity", 1000)
		ncs("mpx_club_pay_time_left", -1)
		script.yield(7000)
	end
end)