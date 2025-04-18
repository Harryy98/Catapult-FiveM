local selectedCatapult = "~r~ Hey, you didn't set a catapult!"

function Noti(text, type)
    lib.notify({
        title = 'Catapult Notification',
        description = text,
        position = "center-right",
        type = type or 'inform'
    })
end

function SetCatapult(ped, veh, x, y, z, heading, catapultNum)
    SetVehicleForwardSpeed(veh, 0.0)
    SetEntityHeading(ped, heading)
    SetPedCoordsKeepVehicle(ped, x, y, z)
    selectedCatapult = tostring(catapultNum)
    Noti("~g~Set aircraft on catapult " .. selectedCatapult, 'success')
end

RegisterCommand("catapultset", function(source, args)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local pedCoords = GetEntityCoords(ped)
    local catapultCoords = {
        {x = 3028.57, y = -4597.24, z = 15.86, heading = 18.15, catapultNum = 1},
        {x = 3041.68, y = -4593.65, z = 15.86, heading = 18.15, catapultNum = 2}
    }
    local nearestCatapult = nil
    local nearestDistance = math.huge

    for _, coords in ipairs(catapultCoords) do
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pedCoords.x, pedCoords.y, pedCoords.z, true)
        if distance < nearestDistance then
            nearestDistance = distance
            nearestCatapult = coords
        end
    end

    if nearestDistance <= 30.0 and nearestCatapult then
        SetCatapult(ped, veh, nearestCatapult.x, nearestCatapult.y, nearestCatapult.z, nearestCatapult.heading, nearestCatapult.catapultNum)
    else
        Noti("~r~No catapult nearby!", 'error')
    end
end, false)

RegisterCommand("catapultlaunch", function(source, args)
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local catapultCoords = {
        {x = 3028.57, y = -4597.24, z = 15.86},
        {x = 3041.68, y = -4593.65, z = 15.86} 
    }
    local nearestCatapult = nil
    local nearestDistance = math.huge

    for _, coords in ipairs(catapultCoords) do
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pedCoords.x, pedCoords.y, pedCoords.z, true)
        if distance < nearestDistance then
            nearestDistance = distance
            nearestCatapult = coords
        end
    end

    if nearestDistance <= 30.0 and nearestCatapult then
        local veh = GetVehiclePedIsIn(ped, false)
        local takeoffSpeed = 84.0
        local slowdownSpeed = 60.0

        SetVehicleForwardSpeed(veh, takeoffSpeed)
        SetVehicleBoostActive(veh, 1, 0) 
        StartScreenEffect("RaceTurbo", 0, 0)
        Citizen.Wait(1500)
        SetVehicleForwardSpeed(veh, slowdownSpeed)
        ControlLandingGear(veh, 1)
        Noti("~g~Launching from catapult " .. selectedCatapult, 'success')
        Noti("~b~Shoot and salute!", 'inform')
    else
        print('Not close enough (Good try though!)')
        Noti("~r~Not close enough! Please use /catapultset", 'error')
    end
end, false)
