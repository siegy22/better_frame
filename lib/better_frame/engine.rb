module BetterFrame
  class Engine < ::Rails::Engine
    require 'better_frame/better_frameable'
    isolate_namespace BetterFrame
  end
end
