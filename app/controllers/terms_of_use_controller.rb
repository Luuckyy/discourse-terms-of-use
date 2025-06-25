# frozen_string_literal: true

class TermsOfUseController < ::ApplicationController
  before_action :redirect_if_already_accepted, only: [:show, :accept]

  # Affiche la page des conditions d'utilisation
  def show
    # Cette action peut simplement rendre le bootstrap de Discourse (template application.hbs),
    # car nous gérons l'affichage avec Ember. Ou bien on pourrait directement rendre une vue HTML.
    render layout: !current_user || current_user.anonymous?  # Par défaut, affiche layout standard
  end

  # Enregistre l'acceptation des conditions par l'utilisateur courant
  def accept
    if current_user
      current_user.custom_fields['terms_of_use_accepted'] = true
      current_user.save
      render json: success_json
    else
      render json: failed_json
    end
  end

  private

  # Si l'utilisateur a déjà accepté, on le redirige ailleurs
  def redirect_if_already_accepted
    if current_user&.custom_fields&.[]('terms_of_use_accepted') == 'true'
      redirect_to path('/') and return
    end
  end
end