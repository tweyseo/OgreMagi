-- function reference
local now = ngx.now
-- include
local log = require("log.index")
local utils = require("toolkit.utils")

return function(body)
    log.warn("recv: ", utils.json_encode(body))
    return { code = 0, content = { serverTime = now() } }
end