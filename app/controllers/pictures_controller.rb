class PicturesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @pictures = Picture.by_newest
  end

  def create
    @picture = Picture.new
    @picture.image = params[:Filedata]

    if @picture.save!
      # $redis.publish('stream.pictures.created', @picture.to_json)
      Pusher['stream'].trigger('picture.created', @picture.to_json)
      render status: 200
    end
  end

end
