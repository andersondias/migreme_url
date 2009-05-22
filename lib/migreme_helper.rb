module MigreMeHelper
  def link_to_migreme(url, html_options = {})
    options = {:title => url, :alt => url}
    options.merge! html_options
    migreme_url = MigreMeUrl::encode(url)
    link_to migreme_url, migreme_url, options
  end
end
