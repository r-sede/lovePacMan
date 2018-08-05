function love.conf(t)
    -- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
  if arg[#arg] == "-debug" then
    t.console = true
  end
end