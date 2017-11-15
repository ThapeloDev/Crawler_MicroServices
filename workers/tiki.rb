require 'rubygems'
require 'mechanize'
require 'open_uri_redirections'

class Tiki
  # include Sidekiq::Worker

  def self.do

    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    host = ["http://tiki.vn"]
    # host = ["http://kenh14.vn","http://gamek.vn","http://vnexpress.net","http://dantri.com.vn"]
    host.each do |h|
      begin
        page = agent.get(h)
      rescue
        puts "Error #{$!}"
      end

      @docs = Nokogiri::HTML(page.body)
      @content = @docs.css('img')
      binding.pry
      @data = @content
      array = ['.html','.htm','.chn','http']
      @content.each_with_index do |i,c|
        title = i['title']
        url = i['href']

        if (title != nil) && array.any? {|word| url.to_s.include?(word)}
          unless url.to_s.include? "http//e."
            if (url.to_s.include? "http") == false
              PostData.create(title: title.to_s,url: h + url.to_s)
              fetch_data(h + url.to_s)
            else
              PostData.create(title: title.to_s,url: url.to_s)
              fetch_data (url.to_s)
            end
          end
        end
      end
    end
  end

  private

  def fetch_data url
      require 'rubygems'
      require 'mechanize'
      agent = Mechanize.new
      if (url.to_s.include? "https") == false
        begin
          page = agent.get(url)
        rescue
          puts "Error #{$!}"
        end


        @docs = Nokogiri::HTML(page.body)
        @content = @docs.css('a')
        insert_data @content,url
      end

    end

    def insert_data content , host
     array = ['.html','.htm','.chn','http']
      content.each_with_index do |i,c|
        title = i['title']
        url = i['href']

        if (title != nil) && array.any? {|word| url.to_s.include?(word)}
          unless url.to_s.include? "http//e."
            if (url.to_s.include? "http") == false
              root = host.split("/")[2]


                PostData.create(title: title.to_s,url: "http://"+root.to_s + url.to_s)

            else
              PostData.create(title: title.to_s,url: url.to_s)

            end
          end
        end
      end
    end

end
