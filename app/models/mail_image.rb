class MailImage
  include Mongoid::Document
  include Mongoid::Timestamps

  # mail_queue_id is used to pass embedding mail_queue through controller

  field :text, type: String

  field :image, type: String
  validates :image, presence: true

  field :thumb, type: String

  # has_and_belongs_to_many :clients

  belongs_to :mail_queue

  index({created_at: 1}, {unique: true})

  has_many :client_keyword_matches, dependent: :destroy

  has_many :mail_image_requests, dependent: :destroy

  def clients
    self.client_keyword_matches.map{ |client_keyword_match| client_keyword_match.client }.uniq
  end

  def is_requestable_for?(client)
    client.mail_image_requests.each do |mir|
      if mir.mail_image == self
        if (mir.type == 'disposal' || mir.type == 'forward') && mir.complete?
          return false
        end
      end
    end

    return true
  end

  def match_to_clients
    # Creates ClientKeywordMatches
    Client.all.each do |client|
      client.keywords.each do |keyword|
        if /#{keyword}/i =~ self.text
          client_keyword_match = ClientKeywordMatch.new(keyword: keyword)
          client_keyword_match.client = client
          client_keyword_match.mail_image = self
          client_keyword_match.save!
        end
      end
    end
  end
end
