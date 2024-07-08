return {
	"jiangmiao/auto-pairs",
	config = function()
		vim.g.AutoPairs = {
			["("] = ")//s",
			["["] = "]//s",
			["{"] = "}//s",
			["'"] = "'",
			['"'] = '"',
			['"""'] = '"""',
			["'''"] = "'''",
		}
	end,
}
