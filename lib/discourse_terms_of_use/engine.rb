# frozen_string_literal: true

module ::DiscourseTermsOfUse
  class Engine < ::Rails::Engine
    engine_name "discourse_terms_of_use"
    isolate_namespace DiscourseTermsOfUse
    config.autoload_paths << File.join(config.root, "lib")
  end
end
