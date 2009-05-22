require 'net/http'

module MigreMeUrl
  def self.encode(url)
    xml = get_xml("http://migre.me/api.xml?url=#{url}")
    xml.match(/migre>(.*)?</)[1]
  end

  def self.decode(url)
    xml = get_xml("http://migre.me/api_redirect.xml?url=#{url}")
    xml.match(/url>(.*)?</)[1]
  end

  private
  def self.get_xml(url)
    uri = URI.parse(url)
    Net::HTTP.get_response(uri).body
  end
end
