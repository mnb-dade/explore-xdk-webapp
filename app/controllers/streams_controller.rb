class StreamsController < ApplicationController
  include ActionController::Live

  def stream
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    
    # redis.psubscribe('stream.*') do |on|
    #   on.pmessage do |pattern, event, data|
    #     response.stream.write("event: #{event}\n")
    #     response.stream.write("data: #{data}\n\n")
    #   end
    # end

    redis.psubscribe(['stream.*','heartbeat']) do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end


  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

end
