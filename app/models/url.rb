class Url < ActiveRecord::Base
  attr_accessible :original_url, :squeezed_url

  validates :original_url, :squeezed_url, presence: true
  validates :original_url, :squeezed_url, uniqueness: true
  validates_format_of :original_url, with: URI::regexp(%w(http https))

  def squeeze_url(original_url)
    self.original_url = original_url
    self.squeezed_url = generate_url_token
  end

private

  def generate_url_token
    ("%d%d" % [rand(100), Time.now.to_i]).to_i.to_s(36)
  end
end
