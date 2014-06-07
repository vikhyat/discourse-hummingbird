after_initialize do
  User.class_eval do
#    def avatar_template
#      uploaded_avatar_template || "http://hummingbird.me/assets/processing-avatar.jpg"
#    end
  end
end
