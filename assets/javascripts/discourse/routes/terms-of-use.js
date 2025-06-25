import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    // On peut retourner le contenu dynamique ou rien
    return this.siteSettings.terms_of_use_content;
  }
});