function love.conf(t)
  if arg[#arg] == "-debug" then
    t.console = true
  end
end