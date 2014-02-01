Discourse.ApplicationRoute.reopen({
  actions: {
    showLogin: function() {
      window.location = "http://hummingbird.me/users/sign_in";
    }
  }
});
