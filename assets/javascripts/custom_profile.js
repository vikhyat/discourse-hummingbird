Discourse.UserRoute.reopen({
  afterModel: function() {
    user = this.modelFor('user');
    user.setProperties({"hummingbird": {"loaded": false}});
    $.ajax("https://hummingbird.me/api/v1/users/" + user.get('username'), {
      type: "GET",
      contentType: "application/json; charset=utf-8",
      success: function(data) {
        user.setProperties({
          "hummingbird": {
            "loaded": true,
            "coverImage": data.cover_image,
            "online": data.online,
            "following": data.following
          }
        })
      },
      xhrFields: {
        withCredentials: true
      },
      crossDomain: true
    });

    return user.findDetails();
  }
});

