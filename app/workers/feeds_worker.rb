class FeedsWorker
  include Sidekiq::Worker if defined? Sidekiq

  def perform(klass, repeat_every_hours = 12)
    klass.to_s.constantize.new.perform

    if repeat_every_hours > 0
      self.class.perform_in(repeat_every_hours.hours, klass, repeat_every_hours)
    end
  end
end
