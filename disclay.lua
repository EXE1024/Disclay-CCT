local renders = {}
local monitor = peripheral.wrap("top")
local frame_default = {x=20,y=20,ypos=0, xpos=0, color=colors.cyan, type="frame", name="Template"}
local text_default = {x=20,y=20, color=colors.cyan, text="Hello World",type="label", name="Template"}
local dark = {
    [colors.red]       = colors.maroon,
    [colors.blue]      = colors.navy,
    [colors.lime]      = colors.green,
    [colors.yellow]    = colors.orange,
    [colors.magenta]   = colors.purple,
    [colors.white]     = colors.lightGray,
    [colors.lightGray] = colors.gray,
    [colors.gray]      = colors.black,
}

term.redirect(monitor)

local disclay = {}
function disclay.shadow(color)
    return dark[color] or color
end

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
        elseif render.type == "shframe" then
            for y = 0, render.y do
                for x = 0, render.x do
                    if y ~= render.y then
                        monitor.setCursorPos(x+render.xpos,y+render.ypos)
                        monitor.setBackgroundColor(render.color)
                        io.write("   ")
                    else
                        monitor.setCursorPos(x+render.xpos,y+render.ypos)
                        monitor.setBackgroundColor(disclay.shadow(render.color))
                        io.write("   ")                
                    end
                end
            end
        elseif render.type == "label" then
            monitor.setCursorPos(render.x,render.y)
            monitor.setTextColor(render.color)
            io.write(render.text)
        end
        monitor.setBackgroundColor(colors.white)
        monitor.setTextColor(colors.black)
        monitor.setCursorPos(1,1)
        io.write("Disclay 1.0")
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

function disclay.ShadowFrame(x,y,ypos,xpos,color,name)
    local copy = frame_default
    copy.x = x
    copy.y = y 
    copy.ypos = ypos 
    copy.xpos = xpos 
    copy.color = color
    copy.name = name
    copy.type = "shframe"
    table.insert(renders,copy)
end

function disclay.Label(x,y,color,name,text)
    local copy = text_default
    copy.x = x
    copy.y = y
    copy.color = color
    copy.name = name
    copy.text = text 
    table.insert(renders, copy)
end

function disclay.EditSize(xnew,ynew,name) 
    for _, render in ipairs(renders) do
        if render.name == name then
            render.x = xnew
            render.y = ynew
        end
    end
end

function disclay.EditPosition(xnew,ynew,name) 
    for _, render in ipairs(renders) do
        if render.name == name then
            render.xpos = xnew
            render.ypos = ynew
        end
    end
end
return disclay
