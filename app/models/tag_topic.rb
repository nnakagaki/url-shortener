class TagTopic < ActiveRecord::Base

  has_many :tags,
    class_name: "Tagging",
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_many :tagged_urls, through: :tags, source: :long_url

  def self.most_visited_topic

  end

  def self.visit_hash
    visit_hash = Hash.new(0)
    TagTopic.all.each do |tag_topic|
      visit_hash[tag_topic.topic] = tag_topic.visit_count
    end

    visit_hash
  end

  def visit_count
    sites = most_visited_sites
    sites.values.inject(:+)
  end

  def most_visited_sites
    sites = Hash.new(0)
    urls = tagged_urls
    urls.each do |url|
      sites[url.long_url] += url.num_recent_uniques(365)
    end

    sites
  end

end