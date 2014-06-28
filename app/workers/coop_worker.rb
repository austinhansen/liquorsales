class CoopWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly.day(:friday)
  end

  def perform
    sale = SaleCreator.new("coop")
    sale.create
  end
end
