# frozen_string_literal: true

# name: discourse-terms-of-use
# about: Terms of Use plugin for Discourse
# meta_topic_id: 1234567890
# version: 0.0.1
# authors: Discourse
# url: https://github.com/Luuckyy/discourse-terms-of-use
# required_version: 2.7.0

enabled_site_setting :terms_of_use_content

after_initialize do
  Discourse::Application.routes.append do
    get "/terms-of-use" => "home#index", constraints: lambda { |req|
      !req.xhr? && req.format.html?
    }
  end

  reloadable_patch do
    ApplicationController.prepend(Module.new do
      def check_terms_of_use
        if current_user && !current_user.anonymous? && current_user.custom_fields['terms_of_use_accepted'] != 'true'
          unless request.path.starts_with?("/terms-of-use") || request.format.json?
            redirect_to '/terms-of-use' and return
          end
        end
      end
  
      def self.prepended(base)
        base.before_action :check_terms_of_use
      end
    end)
  end
end