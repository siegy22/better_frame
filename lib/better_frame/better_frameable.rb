module BetterFrameable
  extend ActiveSupport::Concern

  FALLBACK_ORIGIN_MESSAGE = <<-MSG
    set me using ENV["BETTER_FRAME_ORIGIN"]="http://my-host.com"
  MSG

  included do
    before_action :set_headers
    layout 'better_frame/application'
  end

  private
  def set_headers
    headers['Access-Control-Allow-Origin'] = ENV.fetch("BETTER_FRAME_ORIGIN", FALLBACK_ORIGIN_MESSAGE)
    headers['Access-Control-Allow-Credentials'] = "true"
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
