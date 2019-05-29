require 'nokogiri'
require 'open-uri'
require 'csv'
require 'benchmark'

def word_scraping(base_url, page_url, word_type)
  p "#{word_type} hello!"
  word_list = Array.new

  loop do
    html = open(base_url + page_url) {|f| f.read}
    doc = Nokogiri::HTML.parse(html, nil, @charset)
    word_list_xpath = doc.xpath("//div[@class='mw-category']/div[@class='mw-category-group']/ul/li/a/text()")
    word_list_xpath.each do |w|
      word_list << w
    end
    puts page_url
    break if doc.xpath("//*[@id='mw-pages']/a[2]/@href").to_s.include?('until')
    page_url = doc.xpath("//*[@id='mw-pages']/a[2]/@href").to_s
    puts word_list.first
  end
  puts word_list
  # CSV.open('adjective_verbs.csv', 'w') do |csv|
  #   csv << word_list
  # end

  # result = Benchmark.realtime do
  #   word_list.each do |w|
  #     Word.create!(body: w, word_type: word_type)
  #   end
  # end

  words = Array.new
  result = Benchmark.realtime do
    word_list.count do |w|
      words << Word.new(body: w, word_type: word_type)
    end
    Word.import words
  end
  puts "処理時間 : #{result} "

  p "#{word_type} saved!"

  # return word_list
end

word_type = {"形容動詞": 1, "名詞": 2}

base_url = 'https://ja.wiktionary.org/'
page_url = 'wiki/%E3%82%AB%E3%83%86%E3%82%B4%E3%83%AA:%E6%97%A5%E6%9C%AC%E8%AA%9E_%E5%BD%A2%E5%AE%B9%E5%8B%95%E8%A9%9E'
@charset = 'utf-8'


word_scraping(base_url, page_url, word_type[:"形容動詞"])

base_url = 'https://ja.wiktionary.org/'
page_url = 'wiki/%E3%82%AB%E3%83%86%E3%82%B4%E3%83%AA:%E6%97%A5%E6%9C%AC%E8%AA%9E_%E5%90%8D%E8%A9%9E'

word_scraping(base_url, page_url, word_type[:"名詞"])