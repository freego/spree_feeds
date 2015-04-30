class FeedsWorker
  include Sidekiq::Worker

  def perform(klass, repeat = true)
    klass.to_s.constantize.new.perform

    if repeat
      self.class.perform_in(SpreeFeeds::Config.run_every_hours.hours, klass, repeat)
    end
  end
end
