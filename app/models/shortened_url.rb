# require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :visitors, -> { distinct }, :through => :visits, :source => :visitor

  has_many :tags,
    class_name: "Tagging",
    foreign_key: :long_url_id,
    primary_key: :id

  has_many :tagged_topics, through: :tags, source: :tag_topic

  def self.random_code
    begin
      new_code = SecureRandom.urlsafe_base64(16)
    end while ShortenedUrl.exists?(short_url: new_code)

    new_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_url = self.random_code
    ShortenedUrl.create!(long_url: long_url,
      short_url: new_url, submitter_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.select(:id).count
  end

  def num_recent_uniques(n)
    self.visits.select(:visitor_id).where({ created_at:
      (n.days.ago)..Time.now }).distinct.count
  end

  def inspect
    p "[ID: #{self.id}, #{self.short_url}, #{self.submitter_id}]"
  end

end