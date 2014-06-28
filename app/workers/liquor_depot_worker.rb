class LiquorDepotWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly.day(:tuesday)
  end

  def perform
    sale = SaleCreator.new("liquor depot")
    sale.create
  end
end
