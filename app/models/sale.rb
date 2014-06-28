require 'open-uri'

class Sale < ActiveRecord::Base
  validates_presence_of :url
  validates_presence_of :picture

  validates_uniqueness_of :url
  validates_uniqueness_of :picture

  scope :current_week, ->{ where("created_at > ?", 1.week.ago).order(created_at: :desc) }
end
