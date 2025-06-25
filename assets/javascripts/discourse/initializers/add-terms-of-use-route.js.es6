export default {
  name: "add-terms-of-use-route",

  initialize() {
    const app = require("discourse/app").default;

    app.reopen({
      router: app.router.map(function () {
        this.route("terms-of-use", { path: "/terms-of-use" });
      }),
    });
  },
};