-- playing around with tcp sockets...
--local server = vim.uv.new_tcp()
--server:bind("127.0.0.1", "12345")
--server:listen(128, function(err)
--    assert(not err, err) -- Check for errors.
--    local sock = vim.uv.new_tcp()
--    server:accept(sock) -- Accept client connection.
--    sock:read_start(function(err, chunk)
--        assert(not err, err) -- Check for errors.
--        if chunk then
--            print("reading")
--            sock:write(chunk) -- Echo received messages to the channel.
--        else -- EOF (stream closed).
--            print("closing")
--            sock:close() -- Always close handles to avoid leaks.
--        end
--    end)
--end)

M = {
	num_by_char = {
		m = 1,
		[","] = 2,
		["."] = 3,
		j = 4,
		k = 5,
		l = 6,
		u = 7,
		i = 8,
		o = 9,
	},
	left_num_by_char = {
		v = 1,
		c = 2,
		x = 3,
		f = 4,
		d = 5,
		s = 6,
		r = 7,
		e = 8,
		w = 9,
	},
}

return M
