return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Splitscreen` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Splitscreen", {
			mod_script       = "scripts/mods/Splitscreen/Splitscreen",
			mod_data         = "scripts/mods/Splitscreen/Splitscreen_data",
			mod_localization = "scripts/mods/Splitscreen/Splitscreen_localization",
		})
	end,
	packages = {
		"resource_packages/Splitscreen/Splitscreen",
	},
}
