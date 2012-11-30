require 'redis'
require 'castache/version'

class Castache
  class << self
    attr_accessor :redis

    def fetch (key, &block)
      unless object = get(key)
        object = set(key, block.call) if block_given?
      end
      object
    end

    def set(key, object)
      object if @redis.set(key, Marshal.dump(object))
    end

    def get(key)
      if value = @redis.get(key)
        Marshal.load(value)
      end
    end
    
    # Pass it a connected Redis object, a redis:// uri string, or a hash of
    # options for Redis.new
    def redis=(connection)
      if connection.is_a? Redis
        Redis.current = connection
      elsif connection.is_a? String
        Redis.current = connect(connection) if URI(connection).scheme == 'redis'
      elsif connection.is_a? Hash
        Redis.current = Redis.new connection
      end
      @redis = Redis.current
    end

    def redis
      @redis ||= Redis.current
    end
  end

  private

  def self.connect(redis_uri)
    uri = URI(redis_uri)
    Redis.new(:host => uri.host,
              :port => uri.port,
              :password => uri.password,
              :thread_safe => true)
  end
end
