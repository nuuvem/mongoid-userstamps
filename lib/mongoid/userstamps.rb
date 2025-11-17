require "mongoid/userstamps/version"
require "mongoid/userstamps/config"
require "mongoid/userstamps/user"
require "mongoid/userstamps/model"
require "mongoid/userstamps/created"
require "mongoid/userstamps/updated"
require "mongoid/userstamps/deleted"
require "mongoid/userstamps/railtie" if defined? Rails

module Mongoid
  module Userstamps
    extend ActiveSupport::Concern

    include Created
    include Updated

    included do
      if defined?(Mongoid::Paranoia) && self < Mongoid::Paranoia
        include Deleted
      end
    end

    def self.config
      if block_given?
        Mongoid::Userstamps::Config.module_eval do |config|
          yield config
        end
      end
    end
  end
end
