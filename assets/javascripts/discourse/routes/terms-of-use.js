export default Discourse.Route.extend({
  model() {
    return this.siteSettings.terms_of_use_content;
  }
});