# frozen_string_literal: true

# name: discourse-terms-of-use
# about: Terms of Use plugin for Discourse
# meta_topic_id: 1234567890
# version: 0.0.1
# authors: Discourse
# url: https://github.com/Luuckyy/discourse-terms-of-use
# required_version: 2.7.0

enabled_site_setting :terms_of_use_enabled

module ::DiscourseTermsOfUse
  PLUGIN_NAME = "discourse-terms-of-use"
  USER_ACCEPTED_TERMS_FIELD = "user_accepted_terms_at"
end

require_relative "lib/discourse_terms_of_use/engine"

register_asset "stylesheets/terms_of_use.scss"

after_initialize do
  if SiteSetting.terms_of_use_enabled
    User.register_custom_field_type(DiscourseTermsOfUse::USER_ACCEPTED_TERMS_FIELD, :datetime)
    ApplicationController.include(DiscourseTermsOfUse::TermsOfUseChecker)

    DiscourseTermsOfUse::TermsController.class_eval do
      skip_before_action :check_terms_of_use_acceptance
    end
  end
end
