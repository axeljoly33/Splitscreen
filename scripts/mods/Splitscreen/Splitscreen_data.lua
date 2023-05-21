local mod = get_mod("Splitscreen")

return {
	name = "Splitscreen",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id      = "toggle_SC_id",
				type            = "keybind",
				default_value   = {},
				keybind_trigger = "pressed",
				keybind_type    = "function_call",
				function_name   = "toggle_SC"
			}
		}
	}
}
