# name: hummingbird
# about: discourse customizations for hummingbird
# version: 0.1
# authors: Vikhyat Korrapati

plugins_dir = File.expand_path(File.dirname(__FILE__))

### Hummingbird login
load File.expand_path("../hummingbird_current_user_provider.rb", __FILE__)
Discourse.current_user_provider = HummingbirdCurrentUserProvider
register_asset "javascripts/custom_auth.js"

### Onebox
load File.expand_path('../onebox.rb', __FILE__)

### Custom avatars
eval File.read("#{plugins_dir}/custom_avatar.rb")
register_asset "javascripts/custom_avatar.js"

### Load profile data from Hummingbird
register_asset "javascripts/custom_profile.js"

### Template Customization
register_asset "javascripts/discourse/templates/header.js.handlebars"
register_asset "javascripts/discourse/templates/user/user.js.handlebars"

### Account Sync
load File.expand_path("../sync.rb", __FILE__)
SyncPlugin = SyncPlugin
after_initialize do
  module SyncPlugin
    class Engine < ::Rails::Engine
      engine_name "sync_plugin"
      isolate_namespace SyncPlugin
    end

    class SyncController < ActionController::Base
      def sync
        if params[:secret] == ENV["SYNC_SECRET"]
          HummingbirdCurrentUserProvider.create_or_update_user(params[:auth_token])
          render text: "Hello world"
        else
          render text: "Goodbye world"
        end
      end
    end
  end

  SyncPlugin::Engine.routes.draw do
    get '/' => 'sync#sync'
  end

  Discourse::Application.routes.append do
    mount ::SyncPlugin::Engine, at: '/sync'
  end
end
