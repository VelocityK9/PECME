if PECME then return end

_G.PECME = _G.PECME or {}
PECME._mod_path = ModPath
PECME._save_path = SavePath .. 'PECME.json'
PECME.settings = {
	duration_edit = true,
	ECM_duration = 6,
}

function PECME:load()
	local file = io.open(self._save_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all')) or {}) do
			self.settings[k] = v
		end
		file:close()
	end
end

PECME:load()

function PECME:save()
	local file = io.open(self._save_path, 'w')
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

Hooks:Add('LocalizationManagerPostInit', 'LocalizationManagerPostInit_PECME', function(loc)
	loc:load_localization_file(PECME._mod_path .. 'loc/english.json')
end)

Hooks:Add('MenuManagerInitialize', 'MenuManageInitialize_PECME', function(menu_manager)
	MenuCallbackHandler.PECMESave = function(this, item)
		PECME:save()
	end
	MenuCallbackHandler.PECMEToggleOption = function(this, item)
		PECME.settings[item:name()] = (item:value() == 'on')
	end
	MenuCallbackHandler.PECMEGenericOption = function(this, item)
		PECME.settings[item:name()] = item:value()
	end
	MenuHelper:LoadFromJsonFile(PECME._mod_path .. 'options.json', PECME, PECME.settings)
end)