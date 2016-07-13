module BetterFrame
  class ApiController < ApplicationController
    before_action :set_headers

    def include
      render 'include.js'
    end

    private
    def set_headers
      headers['Access-Control-Allow-Origin'] = ENV.fetch("BETTER_FRAME_ORIGIN", "*")
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
      headers['Access-Control-Max-Age'] = "1728000"
    end
  end
end
