class TwitterDataController < ApplicationController

  layout "application", :only=>"index"
  
  include HTTParty
  format :xml
#  include LibXML

  def index
  end

  def view
    
    income_url="http://search.twitter.com/search.atom?q=income"
    @income_xml_data = open(income_url).read
    @data = Hpricot::XML(@income_xml_data)

    @income_picture = []
    @income_name = []
    @income_title = []
    
    (@data/:entry).each do |res|
      if res.to_s =~/(.*?)<link(.*?)href=\"(.*?)\" rel=\"image\"(.*?)/
       @img_url = $3.to_s
      end
      @income_picture.push @img_url.to_s
      @income_name.push res.at('name').innerHTML.split(' ')[0] if res.at('name')
      @income_title.push res.at('title').innerHTML if res.at('title')
    end

#    result = (@data/:entry).first
#    if result.to_s =~/(.*?)<link(.*?)href=\"(.*?)\" rel=\"image\"(.*?)/
#     @img_url = $3.to_s
#    end
#
#    @income_picture = @img_url
#    @income_name = result.at('name').innerHTML.split(' ')[0] if result.at('name')
#    @income_title = result.at('title').innerHTML if result.at('title')

    expense_url="http://search.twitter.com/search.atom?q=expense"
    @expense_xml_data = open(expense_url).read
    @data = Hpricot::XML(@expense_xml_data)

    @expense_picture = []
    @expense_name = []
    @expense_title = []

    (@data/:entry).each do |res|
      if res.to_s =~/(.*?)<link(.*?)href=\"(.*?)\" rel=\"image\"(.*?)/
       @img_url = $3.to_s
      end
      @expense_picture.push @img_url.to_s
      @expense_name.push res.at('name').innerHTML.split(' ')[0] if res.at('name')
      @expense_title.push res.at('title').innerHTML if res.at('title')
    end


#    result = (@data/:entry).first
#
#    if result.to_s =~/(.*?)<link(.*?)href=\"(.*?)\" rel=\"image\"(.*?)/
#     @img_url = $3.to_s
#    end
#
#    @expense_picture = @img_url
#    @expense_name = result.at('name').innerHTML.split(' ')[0] if result.at('name')
#    @expense_title = result.at('title').innerHTML if result.at('title')

  end

  def xmlparty

    @data = TwitterDataController.get('http://search.twitter.com/search.atom?q=income')

    @entry = @data.values[0].values[7]
    @first_entry = @entry[0]
    @picture = @first_entry["link"]
    @pic = @picture[1].values[0]
    
    @income_picture = []
    @income_name = []
    @income_title = []
    
    @entry.each do |res|
      if res['author']["name"] =~/(.*?) (.*?)/
       @name = $1.to_s
      end
      @income_picture.push res["link"][1]["href"]
      @income_name.push @name
      @income_title.push res['title'] if res['title']
    end
    
  end

  def xmllib

    income_url="http://search.twitter.com/search.atom?q=income"
    @income_xml_data = open(income_url).read
    @data = LibXML::XML::Parser.document.url(@income_xml_data)
    render :text=>@data.inspect and return false
    
  end

  def xmlnokogiri

    @data = Nokogiri::XML(open("http://search.twitter.com/search.atom?q=income").read)

#    render :text=>@data and return false

    @node = []
    @income_picture = []
    @income_name = []
    @income_title = []

    reader = Nokogiri::XML::Reader(open("http://search.twitter.com/search.atom?q=income").read)

    @data.xpath('//xmlns:name').each do |name|
      if name.to_s =~/(.*?) (.*?)/
       @name = $1.to_s
      end
      @income_name.push @name
    end

#    @data.xpath('//link').collect(&:text).each do |link|
#      render :text=>link and return false
#      @income_picture.push link
#    end

    @data.xpath('//xmlns:title').collect(&:text).each do |title|

      @income_title.push title

    end
    
  end

end