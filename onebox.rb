module Onebox
  module Engine
    class HummingbirdOnebox
      include Engine
      include JSON

      matches_regexp /https?:\/\/hummingbird\.me\/anime\/.+/

      def url
        slug = @url.match(/https?:\/\/hummingbird\.me\/anime\/(.+)/)[1]
        "http://hummingbird.me/api/v1/anime/#{slug}"
      end

      def to_html
        anime = raw
        "
        <div class='onebox-result'>
          <div class='source'>
            <div class='info'>
              <a href='#{@url}' class='track-link' target='_blank'>
                Anime (#{anime["show_type"]})
              </a>
            </div>
          </div>
          <div class='onebox-result-body'>
            <img src='#{anime["cover_image"]}' class='thumbnail'>
            <h3><a href='#{@url}' target='_blank'>#{anime["title"]}</a></h3>
            <h4>#{anime["genres"].map {|x| x["name"] } * ", "}</h4>
            #{anime["synopsis"]}
          </div>
          <div class='clearfix'></div>
        </div>
        "
      end
    end
  end
end

#require 'oneboxer'
#
#Oneboxer::Whitelist.entries << Oneboxer::Whitelist::Entry.new(/https?:\/\/hummingbird\.me\/anime\/.+/)
#
#class Oneboxer::HummingbirdAnimeOnebox < Oneboxer::HandlebarsOnebox
#  matcher /https?:\/\/hummingbird\.me\/anime\/.+/
#
#  def template
#    template_path('simple_onebox')
#  end
#
#  def onebox
#    slug = @url.match(/https?:\/\/hummingbird\.me\/anime\/(.+)/)[1]
#    anime_json = open("http://hummingbird.me/api/v1/anime/#{slug}").read
#    anime = JSON.parse anime_json
#
#    result = {}
#
#    Mustache.render(File.read(template), result)
#  end
#end
#
#Oneboxer.add_onebox Oneboxer::HummingbirdAnimeOnebox
