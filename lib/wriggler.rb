require "wriggler/version"
require "nokogiri"
require "find"

module Wriggler
  attr_reader :content, :directory

  def self.crawl(tags=[], directory="")
    @content    = Hash[tags.map {|k| [k, []]}]  #Hash with content
    @directory  = directory                     #Current top-level directory

    navigate_directory
    @content
  end

  private

  def self.navigate_directory
    #Set the cwd to the given dir send to gather all nested files from there
    Dir.chdir(@directory) 
    gather_files
  end

  def self.gather_files
    #Gathers all of the HTML or XML files from this and all subdirectories into an array
    Find.find(@directory) do |file|
      if is_XML?(file) || is_HTML?(file) || is_TXT?(file)
        open_next_file(file)
      end
    end
  end

  def self.open_next_file(file)
    #Opens the next file on the list, depending on the extension passes it to HTML or XML
    f = File.open(file)

    if is_HTML?(file)
      set_HTML(f)
    elsif is_XML?(file)
      set_XML(f)
    elsif is_TXT?(file)
      set_TXT(f)
    end
  end

  def self.is_HTML?(file)
    #Determines, using a regex check, if it is an HTML file
    file =~ /.html/
  end

  def self.is_XML?(file)
    #Determines, using a regex check, if it is an XML file
    file =~ /.xml/
  end

  def self.is_TXT?(file)
    #Determines, using a regex check, if it is a TXT file
    file =~ /.txt/
  end

  def self.set_HTML(file)
    #Set the HTML file into Nokogiri for crawling
    doc = Nokogiri::HTML(file)
    crawl_file(doc)
  end

  def self.set_XML(file)
    #Set the XML file into Nokogiri for crawling
    doc = Nokogiri::XML(file)
    crawl_file(doc)
  end

  def self.set_TXT(file)
    #Set the TXT file into a readable String for Regex checking
    doc = File.read(file)
    txt_content(doc)
  end

  def self.crawl_file(doc)
    #Crawl the Nokogiri Object for the file
    @content.each_key do |key|
      arr = []
      if !doc.xpath("//#{key}").empty? 
        doc.xpath("//#{key}").map{ |tag| arr << sanitize(tag.text) }
      elsif key == "html"
        arr << "#{doc}"
      else
        doc.xpath("//#{key}").map{ |_| arr << "" }
      end
      @content.fetch(key) << arr
    end
  end

  def self.txt_content(doc)
    #Now run through the raw text and regex out what is inbetween the tags
    @content.each_key do |key|
      arr = []
      if key == "html"
        arr << "#{doc}"
      elsif contains_key(doc, key)
        arr << doc.slice(/<#{key}>.*<\/#{key}>/)
      else
        arr << ""
      end
      @content.fetch(key) << arr
    end
  end

  def self.contains_key(doc, key)
    #Checks if the String contains the necessary tags
    doc.include?("<#{key}>") && doc.include?("</#{key}>")
  end

  def self.sanitize(text)
    #Removes any escaped quotes, replaces them
    text.gsub(/"/, "'").lstrip.chomp        
  end
end
