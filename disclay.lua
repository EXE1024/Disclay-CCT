local renders = {}
local monitor = peripheral.wrap("top")
local frame_default = {x=20,y=20,ypos=0, xpos=0, color=colors.cyan, type="frame", name="Template"}

term.redirect(monitor)

local disclay = {}
function disclay.update() 
    for _, render in ipairs(renders) do
        monitor.setBackgroundColor(colors.black)
        monitor.clear()
        if render.type == "frame" then
            for y = 0, render.y do
                for x = 0, render.x do
                    monitor.setCursorPos(x+render.xpos,y+render.ypos)
                    monitor.setBackgroundColor(render.color)
                    io.write("   ")
                end
            end
        end
    end
end

function disclay.Frame(x,y,ypos,xpos,color,name)
    local copy = frame_default
    copy.x = x
    copy.y = y
    copy.xpos = xpos
    copy.ypos = ypos
    copy.color = color
    copy.name = name
    table.insert(renders, copy)
end
return disclay
