require 'net/http'
require 'json'
require 'open-uri'

User.destroy_all

0.upto(4) do |i|
  u = User.new
  u.email = "employer#{i+1}@google.com"
  u.password = "Q1w2e3r4"  
  u.save
end   

puts "#{User.count} users created."

Job.destroy_all

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
    attrs[:employer_id] = User.all.shuffle[0].id

    job = Job.new
    job.update_attributes attrs
  end
end

puts "#{Job.count} jobs loaded."

