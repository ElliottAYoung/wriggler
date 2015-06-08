require "nokogiri"

class Wriggler
	def initialize(tags=[], directory="", subdirectories=true)
		@content = Hash[tags.map {|k| [k, []]}]		#Hash with content
		@subdirectories = subdirectories					#Default true for the existence of subdirs
		@directory = directory 										#Directory to grab files from

		navigate_directory
		# Writer.write_to_csv(@content)
	end

  private

  def navigate_directory
 		#Set the cwd to the given dir send to gather all nested files from there
 		Dir.chdir(@directory) 
 		gather_files
  end

  def gather_files
  	#Gathers all of the HTML or XML files from this and all subdirectories
    open_next_file("test1.xml")
    puts "=============="
    puts "1:"
    p @content
    puts "=============="
    puts ""
    open_next_file("test2.xml")
    puts "=============="
    puts "2:"
    p @content
    puts "=============="
    puts ""
    open_next_file("test3.xml")
    puts "=============="
    puts "3:"
    p @content
    puts "=============="
    puts ""
  end

  def open_next_file(file)
  	#Opens the next file on the list, depending on the extension passes it to HTML or XML
  	f = File.open(file)

  	if is_html?(file)
  		set_HTML(f)
  	elsif is_xml?(file)
  		set_XML(f)
  	end
  end

  def is_html?(file)
  	#Determines, using a regex check, if it is an HTML file
  	file =~ /.html/
  end

  def is_xml?(file)
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
  		if !doc.xpath("//#{key}").empty?				#Returns an empty array if tag is not present
  			doc.xpath("//#{key}").map{ |tag| arr << sanitize(tag.text) }
  		end
      @content.fetch(key) << arr
  	end
  end

  def sanitize(text)
  	#Removes any escaped quotes, replaces them
  	text.gsub(/"/, "'")					
  end
end

test = Wriggler.new(["character", "content", "name", "title"], "/Users/47900/Desktop/Ruby/wriggler/dirtest", false)
