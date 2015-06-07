require "wriggler/version"

module Wriggler
	def crawl(tags=[], directory, subdirectories = true)
		@content = Hash[tags.map {|k| [k, []]}]		#Hash with content
		@subdirectories = subdirectories					#Default true for the existence of subdirs
		@directory = directory 										#Directory to grab files from

		navigate_directory
	end

  private

  def navigate_directory
 		#Set the cwd to the given dir send to gather all nested files from there
 		Dir.chdir(@directory) 
 		gather_files
  end

  def gather_files
  	#Gathers all of the HTML or XML files from this and all subdirectories

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
  	#Crawl any HTML files looking for tags in @content
  	doc = Nokogiri::HTML(file)
  	crawl(doc)
  end

  def set_XML(file)
  	#Crawl any XML files looking for tags in @content
  	doc = Nokogiri::XML(file)
  	crawl(doc)
  end

  def crawl(doc)
  	@content.each_key do |key|
  		if !doc.xpath("//#{key}").empty?				#Returns an empty array if tag is not present
  			doc.xpath("//#{key}").map{ |tag| @content.fetch(key) << sanitize(tag.text) }
  		end
  	end
  end

  def sanitize(text)
  	text.gsub(/"/, "'")					#Removes any escaped quotes, replaces them
  end
end

module Writer
	def write_to_csv(content)
	end
end
