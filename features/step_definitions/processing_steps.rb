
############### pending steps below ################


When /^I request tags for the first story$/ do
  r = get_from_calais @story
  get_tag_from_json(get_from_calais(@story)) do |tag|
    tag.each{|k,v| puts "#{k} : #{v}"}
  end
end

When /^I request stories from Topix$/ do 
  search_term = 'london'
  url = "#{YAML::load_file('config/config.yml')['topix']}#{search_term}"
  @response = get_from_as_xml url
end

When /^I get some news stories from the first keyword$/ do
  search_term = @trend['name'].gsub('#','') #removing hash from start of trend name
  search_term = 'london'
  url = "#{YAML::load_file('config/config.yml')['topix']}#{search_term}"
  rss_response = get_from_as_xml url
  items = get_items_from rss_response
  links = []
  items.each do |item|
    links << attribute_from(item, :link)
  end
  @story = sanitize from_doc get_from links[0]
end
