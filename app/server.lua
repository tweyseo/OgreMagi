-- function reference
-- include
local server = require("net.index").TCP_SERVER_LITE
local router = require("router")

local tcpServer = {}

function tcpServer.run()
    server(nil, router.router, router.errHandler)
end

return tcpServer