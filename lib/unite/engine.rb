require "mongoid"
require "faraday"
require 'oj'

module Unite
  class Engine < ::Rails::Engine
    isolate_namespace Unite

    config.generators do |g|
      g.orm :mongoid
      g.test_framework :rspec
      g.factory_bot dir: 'spec/factories'
    end

    def self.app_path
      File.expand_path('../../app', called_from)
    end

    %w{controller helper mailer model}.each do |resource|
      class_eval <<-RUBY
    def self.#{resource}_path(name)
      File.expand_path("#{resource.pluralize}/unite/\#{name}.rb", app_path)
    end
      RUBY
    end
  end
end