local num_by_char = {
	m = 1,
	[","] = 2,
	["."] = 3,
	j = 4,
	k = 5,
	l = 6,
	u = 7,
	i = 8,
	o = 9,
}

local left_num_by_char = {
	v = 1,
	c = 2,
	x = 3,
	f = 4,
	d = 5,
	s = 6,
	r = 7,
	e = 8,
	w = 9,
}

local repeat_str = function(str, times)
	local result = ""
	for _ = 1, times do
		result = result .. str
	end
	return result
end

return {
	num_by_char = num_by_char,
	left_num_by_char = left_num_by_char,
	repeat_str = repeat_str,
}
