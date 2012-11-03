require "sentimentalizer/lib/api/api"

module Fbhack
  class Application < Rails::Application
    config.after_initialize do
      $SENT_API = Sentimentalizer.new
    end
  end
end