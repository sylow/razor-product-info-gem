require 'concurrent'

module RazorProductInfo

  @@refresh_task = nil

  def self.setup_refresh_task!
    stop_refresh_task!
    return unless config.cache_refresh_interval

    @@refresh_task = Concurrent::TimerTask.new(run_now: false) do
      ProductInfo.safely_refresh_cache!(&config.on_cache_refresh_error)
    end

    @@refresh_task.execution_interval = config.cache_refresh_interval
    @@refresh_task.timeout_interval   = 1.minute
    @@refresh_task.execute
  end

  def self.stop_refresh_task!
    return unless @@refresh_task

    @@refresh_task.shutdown
    @@refresh_task = nil
  end

end
