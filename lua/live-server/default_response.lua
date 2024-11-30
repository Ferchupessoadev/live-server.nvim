local M = {}

function M.get()
	return [[
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<title>Live Server</title>
			</head>
			<body>
				<h1>Live Server</h1>
				<p>Live Server not found at <code>]] .. vim.fn.getcwd() .. [[</code></p>
			</body>
		</html>
	]]
end

return M
