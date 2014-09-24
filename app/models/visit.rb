class Visit < ActiveRecord::Base
  validates :short_url_id, :visitor_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor_id: user.id, short_url_id: shortened_url.id)
  end

  belongs_to :visitor,
  class_name: "User",
  foreign_key: :visitor_id,
  primary_key: :id

  belongs_to :short_url,
  class_name: "ShortenedUrl",
  foreign_key: :short_url_id,
  primary_key: :id

  def inspect
    p "[ID: #{self.id}, #{self.short_url}, #{self.visitor_id}, #{self.created_at}]"
  end

end