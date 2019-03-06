# frozen_string_literal: true

# All workers inherit this
class ApplicationWorker
  include Sidekiq::Worker
end
