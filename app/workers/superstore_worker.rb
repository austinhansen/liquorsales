class SuperstoreWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly(3).hour_of_day(12)
  end

  def perform
    sale = SaleCreator.new("superstore")
    sale.create
  end
end
