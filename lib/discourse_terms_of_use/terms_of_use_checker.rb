# frozen_string_literal: true

module DiscourseTermsOfUse
  module TermsOfUseChecker
    extend ActiveSupport::Concern

    included do
      prepend_before_action :check_terms_of_use_acceptance, if: -> { SiteSetting.terms_of_use_enabled && current_user&.active? }
    end

    private

    def check_terms_of_use_acceptance
      return if current_user.custom_fields[DiscourseTermsOfUse::USER_ACCEPTED_TERMS_FIELD].present?
      return if current_user.staff?
      
      exempt_paths = ["/terms-of-use", "/users/logout-and-redirect", "/about"]
      return if exempt_paths.include?(request.path) || request.path.start_with?("/u/admin-login") || request.path.start_with?("/assets/")

      redirect_to "/terms-of-use"
    end
  end
end 