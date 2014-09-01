after_initialize do
  User.class_eval do
    def avatar_template
      self.read_attribute(:avatar_template) || "https://hummingbird.me/assets/processing-avatar.jpg"
    end

    def self.letter_avatar_template(username)
      User.find_by(username: username).avatar_template
    end

    def self.avatar_template(username, uploaded_avatar_id)
      User.find_by(username: username).avatar_template
    end

    def small_avatar_url
      avatar_template_url.gsub("{size}", "small")
    end
  end
end
