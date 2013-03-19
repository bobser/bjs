require 'rubygems'
require 'nokogiri'

require 'net/http'
require 'json'
require 'open-uri'
   

0.upto(5) do |i|
  start_position = 25 * i
  search_string = "http://api.indeed.com/ads/apisearch?publisher=3778745818622735&q=a&l=&format=json&sort=&radius=&st=&jt=&start=#{start_position}&limit=25&v=2"
  result = Net::HTTP.get(URI.parse(search_string))
  parsed_json = JSON.parse result

  categories = ['Medical', 'Healthcare', 'Driver', 'Sales', 'Administrative', 'Financial']

  parsed_json['results'].each do |job|

    page = Nokogiri::HTML(open(job['url'].gsub(/&indpubnum=\d+/, '')))   
    
    attrs = {}
    attrs[:title] = job['jobtitle']
    attrs[:category] = categories[Random.rand(5)]
    attrs[:location] = job['formattedLocationFull']
    attrs[:date] = DateTime.parse(job['date'])
    attrs[:job_description] = page.css('span.summary').text
    attrs[:apply_link] = job['url']
    attrs[:employer_id] = Random.rand(4)

    puts attrs

  end
end
