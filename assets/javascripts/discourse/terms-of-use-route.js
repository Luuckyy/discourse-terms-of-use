export default {
  name: "terms-of-use-route",
  initialize(container) {
    const app = container.lookup("application:main");

    app.router.map(function () {
      this.route("terms-of-use", { path: "/terms-of-use" });
    });
  }
};