Searchkick.redis = ConnectionPool.new { Redis.new(url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1')) }
