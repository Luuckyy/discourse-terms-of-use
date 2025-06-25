# frozen_string_literal: true

class TermsController < ::ApplicationController
  requires_plugin DiscourseTermsOfUse::PLUGIN_NAME

  before_action :ensure_logged_in, only: :accept

  def show
    render :show, layout: false
  end

  def accept
    if params[:terms_accepted] == "on" || params[:terms_accepted] == "1"
      current_user.custom_fields[DiscourseTermsOfUse::USER_ACCEPTED_TERMS_FIELD] = Time.zone.now
      current_user.save_custom_fields
      redirect_to "/"
    else
      flash[:error] = I18n.t("terms_of_use.must_accept")
      redirect_to "/terms-of-use"
    end
  end
end