Discourse.ApplicationRoute.reopen({
  actions: {
    showLogin: function() {
      window.location = "https://hummingbird.me/users/sign_in";
    }
  }
});
