module BetterFrameable
  extend ActiveSupport::Concern

  included do
    before_action :set_headers
    skip_before_action :verify_authenticity_token
    layout 'better_frame/application'
  end

  private
  def set_headers
    headers['Access-Control-Allow-Origin'] = ENV.fetch("BETTER_FRAME_ORIGIN", "*")
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
