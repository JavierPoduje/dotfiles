-- Define the camelToKebab function
local function camelToKebab(str)
	-- Replace all occurrences of an uppercase letter followed by a lowercase letter or digit
	-- with a hyphen followed by the lowercase version of the uppercase letter.
	local kebab = str:gsub("(%u)(%l)", function(upper, lower)
		return "-" .. upper:lower() .. lower
	end)

	-- Replace all occurrences of a digit followed by an uppercase letter
	-- with the digit followed by a hyphen and the lowercase version of the uppercase letter.
	kebab = kebab:gsub("(%d)(%u)", function(digit, upper)
		return digit .. "-" .. upper:lower()
	end)

	-- Replace any remaining uppercase letters with a hyphen followed by the lowercase version of the letter
	kebab = kebab:gsub("(%u)", function(upper)
		return "-" .. upper:lower()
	end)

	-- Remove any leading hyphen if present
	kebab = kebab:gsub("^-", "")

	return kebab
end

-- Define the kebabToCamel function
local function kebabToCamel(str)
	-- Convert kebab case to camel case
	local camel = str:gsub("(%-)(%l)", function(_, letter)
		return letter:upper()
	end)
	return camel
end

-- Create a command to convert the selected text to kebab case
vim.api.nvim_create_user_command("Kc", function()
	-- Get the current visual selection
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local lines = vim.fn.getline(s_start[2], s_end[2])

	-- Convert the selection to a single string if it's multiline
	if #lines > 1 then
		for i = 2, #lines do
			lines[1] = lines[1] .. "\n" .. lines[i]
		end
	end
	local selection = lines[1]:sub(s_start[3], s_end[3])

	-- Convert the selection to kebab case
	local kebab = camelToKebab(selection)

	-- Replace the visual selection with the kebab case text
	vim.fn.setreg("v", kebab)
	vim.cmd('normal! gv"vp')
end, { range = true })

-- Create a command to convert the selected text from kebab case to camel case
vim.api.nvim_create_user_command("Cc", function()
	-- Get the current visual selection
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local lines = vim.fn.getline(s_start[2], s_end[2])

	-- Convert the selection to a single string if it's multiline
	if #lines > 1 then
		for i = 2, #lines do
			lines[1] = lines[1] .. "\n" .. lines[i]
		end
	end
	local selection = lines[1]:sub(s_start[3], s_end[3])

	-- Convert the selection to camel case
	local camel = kebabToCamel(selection)

	-- Replace the visual selection with the camel case text
	vim.fn.setreg("v", camel)
	vim.cmd('normal! gv"vp')
end, { range = true })
