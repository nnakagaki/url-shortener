class Tagging < ActiveRecord::Base

  belongs_to :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_topic_id,
    primary_key: :id

  belongs_to :long_url,
    class_name: "ShortenedUrl",
    foreign_key: :long_url_id,
    primary_key: :id

end