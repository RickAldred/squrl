module UrlsHelper
  def format_squeezed_url_for_display(site_url, url)
    site_url + "/" + url.squeezed_url
  end
end
