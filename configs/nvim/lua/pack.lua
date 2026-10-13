local function gh(repo)
	return "https://github.com/" .. repo
end

------------------------------
--- =====[Pack setup]===== ---
------------------------------
local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			run_build(name, { "make" }, ev.data.path)
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

-------------------------------------------
--- =====[Plugins install & setup]===== ---
-------------------------------------------

-- Get all plugin
local wd = vim.fn.stdpath("config")
local cwDir = wd .. "/lua/plugins"
local cwdContent = vim.split(vim.fn.glob(cwDir .. "/*"), "\n", { trimempty = true })

-- Install all plugins
for _, cwdItem in pairs(cwdContent) do
	local plugin = dofile(cwdItem)
	if plugin.install == nil then
		error("Missing essential install function for " .. cwdItem)
	end
	plugin.install(gh)
end

-- Setup all plugins
for _, cwdItem in pairs(cwdContent) do
	local plugin = dofile(cwdItem)
	if plugin.setup ~= nil then
		plugin.setup()
	end
end
