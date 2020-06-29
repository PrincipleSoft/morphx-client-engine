module Unite::Concerns::Session::Bridge
  extend ActiveSupport::Concern

  module ClassMethods
    def request_all(params = {})
      Unite::Api::V1::Organization::Sessions.index(params)
    end
  end

  def request_show
    Unite::Api::V1::Organization::Sessions.show(self.unite_id)
  end

  private

  def request_create
    api_response = Unite::Api::V1::Organization::Sessions.create(session_params)
    p api_response
    self.unite_id = api_response['response']['id']
    # temporary fix
    self.embed = api_response['response']['embed'].each{|k, v| v.gsub!('http://', 'https://')}
                                                  .each{|k, v| v.gsub!('srcdoc=\'\'', '')}
  end

  def request_update
    Unite::Api::V1::Organization::Sessions.update(self.unite_id, session_params)
  end

  def request_destroy
    Unite::Api::V1::Organization::Sessions.destroy(self.unite_id)
  end

  def session_params
    params = {}
    p '+++++++++++'
    p self.user.unite_id
    p self.channel.unite_id
    params['user_id'] = self.user.unite_id
    params['channel_id'] = self.channel.unite_id
    params['session'] = self.attributes.slice("title", "description", "record", "allow_chat", "duration", "pre_time",
                                              "autostart", "device_type", "service_type", "start_at", "channel_id")
    p '------======'*10
    p self.start_now
    p 30.seconds.from_now
    p '------======'*10

    params['session']['start_at'] = 30.seconds.from_now if self.start_now
    p self.start_now
    p '------======'*10
    params
  end
end

# {"status" => 200, "response" => {
#     "id" => 37,
#     "channel_id" => 48,
#     "presenter_id" => 40,
#     "duration" => 30,
#     "start_at" => "2020-06-24T07:54:46.289-05:00",
#     "immersive_type" => nil,
#     "title" => "My first Organization channel",
#     "cancelled_at" => nil,
#     "status" => "unpublished",
#     "stopped_at" => nil,
#     "pre_time" => 5,
#     "description" => "Description",
#     "donations_goal" => nil,
#     "start_now" => false,
#     "autostart" => true,
#     "service_type" => "rtmp",
#     "device_type" => "studio_equipment",
#     "allow_chat" => true,
#     "created_at" => "2020-06-23T07:54:48.811-05:00",
#     "embed" => {
#         "simple_html" => "<div id='unite_embed'>\n<div class='unite_embed_videoIframeWrapp' id='unite_embed_videoWrapp'>\n<div id='unite_embed_video'>\n<iframe allow='encrypted-media' allowfullscreen data-role='vplayer' frameborder='0' name='' src='http://localhost:3000/widgets/37/session/player' srcdoc=''></iframe>\n</div>\n<link rel=\"stylesheet\" media=\"screen\" href=\"http://localhost:3000/assets/widgets/template_V.css\" />\n</div>\n</div>\n",
#         "complex_html" => "<div id='unite_embed'>\n<div class='unite_embed_videoIframeWrapp' id='unite_embed_videoWrapp'>\n<div id='unite_embed_video'>\n<iframe allow='encrypted-media' allowfullscreen class='' data-role='vplayer' frameborder='0' name='' src='http://localhost:3000/widgets/37/session/player' srcdoc=''></iframe>\n</div>\n</div>\n<div class='unite_embed_additionsIframeWrapp'>\n<iframe data-role='additions' id='unite_embed_additions' name='' src='http://localhost:3000/widgets/37/session/additions' srcdoc=''></iframe>\n</div>\n<link rel=\"stylesheet\" media=\"screen\" href=\"http://localhost:3000/assets/widgets/template_V_L.css\" />\n</div>\n",
#         "simple_shop_html" => "<div class='full' id='unite_embed'>\n<div class='unite_embed_videoIframeWrapp' id='unite_embed_videoWrapp'>\n<div id='unite_embed_video'>\n<iframe allow='encrypted-media' allowfullscreen class='' data-role='vplayer' frameborder='0' name='' src='http://localhost:3000/widgets/37/session/player' srcdoc=''></iframe>\n</div>\n</div>\n<div class='unite_embed_additionsIframeWrapp'>\n<iframe data-role='additions' id='unite_embed_additions' name='' src='http://localhost:3000/widgets/37/session/additions' srcdoc=''></iframe>\n</div>\n<div class='unite_embed_shopIframeWrapp'>\n<iframe allowfullscreen data-role='shop' frameborder='0' id='unite_embed_shop' name='' src='http://localhost:3000/widgets/37/session/shop' srcdoc=''></iframe>\n</div>\n<link rel=\"stylesheet\" media=\"screen\" href=\"http://localhost:3000/assets/widgets/template_V_P_L.css\" />\n</div>\n",
#         "complex_shop_html" => "<div class='full' id='unite_embed'>\n<div class='unite_embed_videoIframeWrapp' id='unite_embed_videoWrapp'>\n<div id='unite_embed_video'>\n<iframe allow='encrypted-media' allowfullscreen class='' data-role='vplayer' frameborder='0' name='' src='http://localhost:3000/widgets/37/session/player' srcdoc=''></iframe>\n</div>\n</div>\n<div class='unite_embed_additionsIframeWrapp'>\n<iframe data-role='additions' id='unite_embed_additions' name='' src='http://localhost:3000/widgets/37/session/additions' srcdoc=''></iframe>\n</div>\n<div class='unite_embed_shopIframeWrapp'>\n<iframe allowfullscreen data-role='shop' frameborder='0' id='unite_embed_shop' name='' src='http://localhost:3000/widgets/37/session/shop' srcdoc=''></iframe>\n</div>\n<link rel=\"stylesheet\" media=\"screen\" href=\"http://localhost:3000/assets/widgets/template_V_P_L.css\" />\n</div>\n"
#     }
#   }
# }