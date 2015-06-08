require "nokogiri"
require "find"
require "CSV"

class Wriggler
 def initialize(tags=[], directory="", subdirectories=true)
    @content = Hash[tags.map {|k| [k, []]}]   #Hash with content
    @directory = directory                    #Current top-level directory
    @subdirectories = subdirectories          #Default true for the existence of subdirs

    navigate_directory
    write
  end

  private

  def navigate_directory
    #Set the cwd to the given dir send to gather all nested files from there
    Dir.chdir(@directory) 
    open_files(gather_files)
  end

  def gather_files
    #Gathers all of the HTML or XML files from this and all subdirectories into an array
    file_array = []
    Find.find(@directory) do |f|
      file_array << f if f.match(/\.xml\Z/) || f.match(/\.html\Z/)
    end
    file_array
  end

  def open_files(file_array)
    file_array.each do |file|
      open_next_file(file)
    end
  end

  def open_next_file(file)
    #Opens the next file on the list, depending on the extension passes it to HTML or XML
    f = File.open(file)

    if is_HTML?(file)
      set_HTML(f)
    elsif is_XML?(file)
      set_XML(f)
    end
  end

  def is_HTML?(file)
    #Determines, using a regex check, if it is an HTML file
    file =~ /.html/
  end

  def is_XML?(file)
    #Determines, using a regex check, if it is an XML file
    file =~ /.xml/
  end

  def set_HTML(file)
    #Set the HTML file into Nokogiri for crawling
    doc = Nokogiri::HTML(file)
    crawl_file(doc)
  end

  def set_XML(file)
    #Set the XML file into Nokogiri for crawling
    doc = Nokogiri::XML(file)
    crawl_file(doc)
  end

  def crawl_file(doc)
    #Crawl the Nokogiri Object for the file
    @content.each_key do |key|
      arr = []
      if !doc.xpath("//#{key}").empty?        #Returns an empty array if tag is not present
        doc.xpath("//#{key}").map{ |tag| arr << sanitize(tag.text) }
      end
      fill_content(arr, key)
    end
  end

  def sanitize(text)
    #Removes any escaped quotes, replaces them
    text.gsub(/"/, "'").lstrip.chomp        
  end

  def fill_content(arr, key)
    #Doesn't shovel if there is no content found for the specific tag
    !arr.empty? ? (@content.fetch(key) << arr) : nil
  end

  def write
    # s = CSV.generate do |csv|
    #   csv << @content.keys
    #   @content.each do |key|
    #     csv << key.value
    #   end
    # end
    # File.write('out.csv', s)
    p @content
  end
end

test = Wriggler.new(["character", "content", "name", "title", "test"], "/Users/47900/Desktop/Ruby/wriggler/dirtest", false)
