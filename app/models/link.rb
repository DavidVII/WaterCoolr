class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, presence: true

  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  before_validation :add_url_protocol

  validates :url, presence: true
  validates :url, format: { with: VALID_URL_REGEX, :message => " is not valid" }

  def add_url_protocol
    unless self.url[URI::regexp(%w(http https))]
      self.url = 'http://' + self.url
    end
  end
end


