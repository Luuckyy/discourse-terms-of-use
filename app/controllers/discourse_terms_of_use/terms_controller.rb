# frozen_string_literal: true

module ::DiscourseTermsOfUse
  class TermsController < ::ApplicationController

    def show
      render "terms/show", layout: "no-ember"
    end

    def accept
      if params[:terms_accepted]
        current_user.custom_fields[DiscourseTermsOfUse::USER_ACCEPTED_TERMS_FIELD] = Time.zone.now
        current_user.save_custom_fields
        redirect_to "/"
      else
        flash[:error] = I18n.t("terms_of_use.must_accept")
        redirect_to "/terms-of-use"
      end
    end
  end
end 