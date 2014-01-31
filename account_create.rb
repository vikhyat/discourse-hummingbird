Auth::OAuth2Authenticator.class_eval do
  def after_authenticate(auth_token)

    result = Auth::Result.new

    oauth2_provider = auth_token[:provider]
    oauth2_uid = auth_token[:uid]
    data = auth_token[:info]
    result.email = email = data[:email]
    result.name = name = data[:name]

    # Automatically create user account if need.
    if @opts[:auto_create_account] && User.find_by_email(email).nil?
      user = User.create(name: name, email: email, username: name)
      open("http://hummingbird.me/users/#{name}/trigger_forum_sync?secret=topsecretsecret").read
    end

    oauth2_user_info = Oauth2UserInfo.where(uid: oauth2_uid, provider: oauth2_provider).first

    if !oauth2_user_info && @opts[:trusted] && user = User.find_by_email(email)
      oauth2_user_info = Oauth2UserInfo.create(uid: oauth2_uid,
                                               provider: oauth2_provider,
                                               name: name,
                                               email: email,
                                               user: user)
    end

    result.user = oauth2_user_info.try(:user)
    result.email_valid = @opts[:trusted]

    result.extra_data = {
      uid: oauth2_uid,
      provider: oauth2_provider
    }

    result
  end
end
