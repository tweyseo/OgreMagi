-- function reference
-- include
local messageDefine = require("define.messageDefine")
local ping = require("handler.testHandler.ping")

return {
    [messageDefine.MESSAGE_PING] = ping,
}