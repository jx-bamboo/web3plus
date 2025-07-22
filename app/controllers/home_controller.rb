require "open-uri"
class HomeController < ApplicationController
  def index
    # url = "https://www.chaincatcher.com/rss/clist"
    url = "https://www.panewslab.com/zh/rss/newsflash.xml"

    begin
      uri = URI.open(url)
      rss = RSS::Parser.parse(uri, false)
      @articles = rss.items.map do |item|
        {
          title: item.title.gsub(/PANews/, "web3plus"),
          link: item.link,
          description: item.description.gsub(/PANews/, "web3plus"),
          pub_date: item.pubDate
        }
      end
    rescue => e
      Rails.logger.error "RSS 解析失败： #{e.message}}"
      @articles = []
    end
  end
end
