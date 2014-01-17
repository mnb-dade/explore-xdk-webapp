if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS_CONNECTION_OPTS = { host: uri.host, port: uri.port, password: uri.password }
else
  REDIS_CONNECTION_OPTS = {}
end

$redis = Redis.new(REDIS_CONNECTION_OPTS)

heartbeat_thread = Thread.new do
  while true
    $redis.publish("heartbeat", "thump")
    sleep 30.seconds
  end
end

at_exit do
  # not sure this is needed, but just in case
  heartbeat_thread.kill
  $redis.quit
end