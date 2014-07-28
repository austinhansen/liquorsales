class SuperstoreWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly.day(:thursday)
  end

  def perform
    sale = SaleCreator.new("superstore")
    sale.create
  end
end
