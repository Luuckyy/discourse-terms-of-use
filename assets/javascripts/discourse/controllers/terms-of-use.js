import { ajax } from 'discourse/lib/ajax';

export default Ember.Controller.extend({
  actions: {
    accept() {
      ajax("/terms-of-use/accept", { type: "POST" }).then(() => {
        // Rafraîchir la page ou revenir à l'accueil
        window.location = "/";
      });
    }
  }
});