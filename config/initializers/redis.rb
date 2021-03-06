redis_url = ENV['redis_url'] || ''
$redis = Redis.new(url: redis_url) 

heartbeat_thread = Thread.new do
  while true
    $redis.publish('heartbeat','thump')
    sleep 1.seconds
  end
end

at_exit do
  heartbeat_thread.kill
  $redis.quit
end
