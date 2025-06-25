# frozen_string_literal: true

module DiscourseTermsOfUse
  module TermsOfUseChecker
    extend ActiveSupport::Concern

    included do
      prepend_before_action :check_terms_of_use_acceptance, if: -> { SiteSetting.terms_of_use_enabled && current_user&.active? && request.format.html? }
    end

    private

    def check_terms_of_use_acceptance
      return if current_user.custom_fields[DiscourseTermsOfUse::USER_ACCEPTED_TERMS_FIELD].present?
      return if current_user.staff?
      
      # Skip check if we're already on the terms controller
      return if controller_name == "terms" && controller.class.name.include?("DiscourseTermsOfUse")
      
      # More comprehensive path exemptions
      exempt_paths = ["/terms-of-use", "/terms-of-use/", "/users/logout-and-redirect", "/about"]
      return if exempt_paths.any? { |path| request.path == path || request.path.start_with?(path) }
      return if request.path.start_with?("/u/admin-login") || request.path.start_with?("/assets/")

      redirect_to "/terms-of-use" and return
    end
  end
end 