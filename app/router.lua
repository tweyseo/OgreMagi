-- function reference
local type = type
local pcall = pcall
-- include
local log = require("log.index")
local ec = require("define.errorCode")
local handler = require("handler.index")

local router = {}

local function resolveMessage(data)
    local id = data.id
    local body = data.body
    if not id then
        log.warn("invalid message!")
        return nil, nil, ec.INVALID_MESSAGE
    end

    return id, body, ec.OK
end

function router.router(req)
    local resp = {}
    local id , body, errCode = resolveMessage(req)
    if not id then
        resp["code"] = errCode
        return resp, true
    end

    local f = handler[id]
    if type(f) == "function" then
        local state, ret = pcall(f, body)
        if not state then
            log.warn("process message[", id, "] err: ", ret)
            resp["code"] = ec.INTERNAL_ERROR
        else
            resp = ret
        end
    else
        log.warn("unprocess message: ", id)
        resp["code"] = ec.UNPROCESS_MESSAGE
    end

    return resp, true
end

function router.errHandler(data, err)
    log.warn("handle data: ", data, ", err: ", err)
    if err == "timeout"
        or err == "derialize failed"
        or err == "serialize failed" then
        return true
    else
        return false
    end
end

return router