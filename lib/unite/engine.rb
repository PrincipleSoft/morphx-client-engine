require "mongoid"

module Unite
  class Engine < ::Rails::Engine
    isolate_namespace Unite

    config.generators do |g|
      g.orm :mongoid
      g.test_framework :rspec
      g.factory_bot dir: 'spec/factories'
    end
  end
end
