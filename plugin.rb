# name: hummingbird
# about: discourse customizations for hummingbird
# version: 0.1
# authors: Vikhyat Korrapati

plugins_dir = File.expand_path(File.dirname(__FILE__))

### Custom avatars
eval File.read("#{plugins_dir}/custom_avatar.rb")
register_asset "javascripts/custom_avatars.js", :server_side

### Hummingbird login
load File.expand_path("../hummingbird_current_user_provider.rb", __FILE__)
Discourse.current_user_provider = HummingbirdCurrentUserProvider
register_asset "javascripts/custom_auth.js"

### Onebox
load File.expand_path('../onebox.rb', __FILE__)

### Load profile data from Hummingbird
register_asset "javascripts/custom_profile.js"

### Template Customization
register_asset "javascripts/discourse/templates/post.js.handlebars"
register_asset "javascripts/discourse/templates/embedded_post.js.handlebars"
register_asset "javascripts/discourse/templates/header.js.handlebars"
register_asset "javascripts/discourse/templates/user/user.js.handlebars"

### Temporary: Onebox fix.
require 'cgi/util'
CGI::TABLE_FOR_ESCAPE_HTML__ = CGI::Util::TABLE_FOR_ESCAPE_HTML__
load File.expand_path('../image_onebox.rb', __FILE__)
