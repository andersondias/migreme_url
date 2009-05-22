require File.dirname(__FILE__) + '/spec_helper'
describe MigreMeUrl do
  it 'should encode an url an return a migreme url' do
    url = "http://test/"
    uri = "http://migre.me/api.xml?url=#{url}"
    MigreMeUrl.should_receive(:get_xml).with(uri).and_return(
      <<-XML
        <item>
          <title>XML Migre.me</title>
          <error>0</error>
          <errormessage>Sem erros</errormessage>
          <created_at>Fri, 22 May 2009 14:49:32 -0300</created_at>
          <source>web</source>
          <date>2009-05-22 14:49:32</date>
          <id>1oXU</id>
          <url>http://test/</url>
          <migre>http://migre.me/1oXU</migre>
          <category>free</category>
        </item>
      XML
    )
    MigreMeUrl::encode(url).should == 'http://migre.me/1oXU'
  end

  it 'should decode an migreme url an return the original url' do
    url = "http://migre.me/1oXU"
    uri = "http://migre.me/api_redirect.xml?url=#{url}"
    MigreMeUrl.should_receive(:get_xml).with(uri).and_return(
      <<-XML
        <item>
          <title>XML Migre.me</title>
          <error>0</error>
          <errormessage>No errors</errormessage>
          <created_at>Fri, 22 May 2009 14:49:05 -0300</created_at>
          <id>1oXU</id>
          <migre>http://migre.me/1oXU</migre>
          <url>http://test/</url>
        </item>
      XML
    )
    MigreMeUrl::decode(url).should == 'http://test/'
  end

  describe 'get_xml' do
  it 'should user Net::HTTP to get response from migreme server' do
      url = "http://test.com/"
      uri = URI.parse(url)
      text_response = 'test'
      response = mock('Response')
      response.stub!(:body).and_return(text_response)
      Net::HTTP.should_receive(:get_response).with(uri).and_return(response)
      MigreMeUrl.send('get_xml', url).should == text_response
    end
  end
end
