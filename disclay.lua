local renders = {}
local monitor = peripheral.wrap("top")
local template_render = {x=20,y=20,ypos=0, xpos=0, color=colors.cyan}

table.insert(template_render,renders)
term.redirect(monitor)

for _, render in ipairs(renders) do
    monitor.clear()
    for y = 0, render.y do
        for x = 0, render.x do
            monitor.setCursorPos(x+xpos,y+ypos)
            monitor.setForegroundPos(colors.cyan)
        end
    end
end
