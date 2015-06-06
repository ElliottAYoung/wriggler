require "wriggler/version"

module Wriggler
  def crawl_HTML(directory, tags=[])
  	files = open_directory(directory)

  	files.each do |file|
  		doc = Nokogiri::HTML(file)

  	end
  end

  private

  def open_directory(directory)
  	files = Dir.entries(directory)
  end

  def open_next_file
  end
end

module Writer
end
