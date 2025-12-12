BigJB = {}
BigJB.Version = "v3.0.0"

local search_paths = {
    ".",                       -- 当前目录
    "C:/N3NYOOO/LUA",          -- Nen 菜单
    "C:/INFAMOUS/GTAV/LUA"     -- Infamous 菜单
}

local function get_current_timer()
    local date = os.date("*t")
    return string.format("%d-%02d-%02d %02d:%02d:%02d", 
        date.year, date.month, date.day,
        date.hour, date.min, date.sec
    )
end

BigJB.Log = {}
-- [INFO] 普通信息
function BigJB.Log.Info(msg)
    local prefix = "\n   " .. get_current_timer() .. "  \27[47m\27[30m[BIGJB|INFO]\27[0m "
    logger.log(prefix .. tostring(msg))
end
-- [SUCCESS] 成功信息 (綠色背景)
function BigJB.Log.Success(msg)
    local prefix = "\n   " .. get_current_timer() .. "  \27[42m\27[30m[BIGJB|SUCCESS]\27[0m\27[32m "
    logger.log(prefix .. tostring(msg))
end
-- [WARNING] 警告信息 (黃色背景)
function BigJB.Log.Warn(msg)
    local prefix = "\n   " .. get_current_timer() .. "  \27[43m\27[30m[BIGJB|WARNING]\27[0m\27[33m "
    logger.log(prefix .. tostring(msg))
end
-- [ERROR] 錯誤信息 (紅色背景)
function BigJB.Log.Error(msg)
    local prefix = "\n   " .. get_current_timer() .. "  \27[41m\27[30m[BIGJB|ERROR]\27[0m\27[31m "
    logger.log(prefix .. tostring(msg))
end

local function require_file(module_name)
    local loaded_successfully = false
    
    for _, root in ipairs(search_paths) do
        local full_path = root .. "/BIGJB/" .. module_name .. ".lua"
        local status, result = pcall(dofile, full_path)
        
        if status then
            loaded_successfully = true
            return
        else
            if string.find(tostring(result), "cannot open") or string.find(tostring(result), "No such file") then
            else
                BigJB.Log.Error("Script Error in: " .. full_path .. " | " .. tostring(result))
                return 
            end
        end
    end
    
    if not loaded_successfully then
        BigJB.Log.Error("Module NOT found in any path: " .. module_name)
    end
end

gui.pushNotification("Welcome", "Loading BIGJB LUA...")

require_file("config")
require_file("core")
require_file("utils")

BigJB.UI = {}
BigJB.UI.Main = gui.createMainTab("~b~Project JB")

BigJB.UI.Self    = gui.addSub("SELF", "Self-related options.", 0, function() end)
BigJB.UI.Weapon  = gui.addSub("WEAPON", "Weapon-related options.", 1, function() end)
BigJB.UI.Vehicle = gui.addSub("VEHICLE", "Vehicle-related options.", 2, function() end)
BigJB.UI.Network = gui.addSub("NETWORK", "Network-wide options.", 3, function() end)
BigJB.UI.World   = gui.addSub("WORLD", "World-related options.", 4, function() end)
BigJB.UI.Funny   = gui.addSub("FUNNY", "Funny options.", 5, function() end)
BigJB.UI.Entity  = gui.addSub("ENTITY MANAGER", "Entity management options.", 6, function() end)

require_file("tabs/self")
require_file("tabs/weapon")
require_file("tabs/vehicle")
require_file("tabs/network")
require_file("tabs/world")
require_file("tabs/funny")
require_file("tabs/entity")

local slogan = [[
   __________. ____  __________       ____.__________ 
   \______   \|    |/   ______/      |    |\______   \
    |    |    \    /    /            |    | |    |    \
    |    |  __/   /    /   ___       |    | |    |  __/
    |    |    \   \    \  \   \  _   |    | |    |    \
    |    |    /    \    \__\   \/ \__|    | |    |    /
    |_______ /|____|\_______   /\_________| |_______ /
           \/               \_/                    \/
   _____________________________________________________
   ]]
logger.log("\n" .. slogan)
BigJB.Log.Success("BIGJB LUA " .. BigJB.Version .."|Loaded Successfully!")
gui.pushNotification("BIGJB", "Script loaded successfully!")