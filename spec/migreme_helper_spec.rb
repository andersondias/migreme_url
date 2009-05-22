require File.dirname(__FILE__) + '/spec_helper'

describe MigreMeHelper do
  include MigreMeHelper

  def link_to(name, options = {}, html_options = {})
    [name, html_options[:title]]
  end

  it 'should return a link to a migreme url' do
    url = 'http://www.google.com/'
    migreme_url = 'http://migre.me/1moT'
    MigreMeUrl.should_receive(:encode).and_return(migreme_url)
    link, title = link_to_migreme(url, :title => 'test')
    link.should == migreme_url
    title.should == 'test'
  end
end
