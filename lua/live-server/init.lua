local path = require("live-server.path")
local default_response = require("live-server.default_response")

local M = {}

M.app = {}

function M.setup(opts)
	local uv = vim.loop

	local function create_server(host, port, on_request)
		local server = uv.new_tcp()
		server:bind(host, port)

		server:listen(128, function(err)
			assert(not err, err)
			local client = uv.new_tcp()
			server:accept(client)
			on_request(client)
		end)

		return server
	end

	local function handle_request(sock)
		sock:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				sock:write(
					"HTTP/1.1 200 OK\r\n"
						.. "Content-Length: "
						.. #chunk
						.. "\r\n"
						.. "Content-Type: text/html; charset=UTF-8\r\n"
						.. "\r\n"
						.. "<h1>Bueno, funciona</h1>\r\n",
					function()
						sock:close() -- Cerrar la conexión con el cliente después de responder
					end
				)
			else
				sock:close()
			end
		end)
	end

	local server = create_server("127.0.0.1", 4000, handle_request)

	vim.notify("tcp echo-server listening on port: 4000")
end

return M
