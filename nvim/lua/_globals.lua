-- Print inspected version of something
P = function(x)
	print(vim.inspect(x))
	return x
end

-- Convert json to php array
JsonToPhp = function()
	vim.api.nvim_command([[ :%s/\%V":\s*\"/" => "/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*{/" => [/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*\[/" => [/ge ]])
	vim.api.nvim_command([[ :%s/\%V{/[/ge ]])
	vim.api.nvim_command([[ :%s/\%V}/]/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*/" => /ge ]])
end

vim = vim
v = vim.api
