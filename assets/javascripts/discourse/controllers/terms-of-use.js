import Controller from "@ember/controller";
import { ajax } from "discourse/lib/ajax";

export default Controller.extend({
  actions: {
    accept() {
      ajax("/terms-of-use/accept", { type: "POST" }).then(() => {
        window.location.href = "/";
      });
    }
  }
});