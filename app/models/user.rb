class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    class_name: "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :visitor_id,
    primary_key: :id

  has_many :visited_urls, -> { distinct }, :through => :visits, :source => :short_url

  def inspect
    print "[ID: #{self.id}, #{self.email}] "
  end
end