class ForeignWebsiteController < ApplicationController
  def show
    @current_url = "#{request.protocol}#{request.host_with_port}"
    @rails_url = @current_url
    @base_url = request.original_url
    @include_url = @current_url + "/better_frame"
  end
end
