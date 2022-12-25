local dir = "slidescape/images"

function SLIDEs.GetImage(url, filename, callback)
    local destination = string.Explode("/", filename, true)
    local filename = destination[#destination]
    local finaldir = dir
    
    for k, v in pairs(destination) do
        if k != #destination then 
            finaldir = finaldir.."/"..v
        end
    end
    file.CreateDir(finaldir)

    if !file.Exists(finaldir.."/"..filename, "DATA") then
        http.Fetch(url, 
            function(data)
                file.Write(finaldir.."/"..filename, data)

                if callback then
                    callback(url, "data/"..finaldir.."/"..filename)
                end
            end
        )
    else
        if callback then
            callback(url, "data/"..finaldir.."/"..filename)
        end
    end
end