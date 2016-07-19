class ForeignWebsiteController < ApplicationController
  def show
    @rails_url = "http://lvh.me:#{request.port}"
    @include_url = @rails_url + "/better_frame"
    @base_url = request.original_url
  end
end
