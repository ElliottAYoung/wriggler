require 'spec_helper'

describe Wriggler do
  it 'has a version number' do
    expect(Wriggler::VERSION).not_to be nil
  end

  context '#crawl' do
  	it 'should call #navigate_directory' do
  	end

  	it 'should call #write_to_csv with appropriate arguments' do
  	end
  end

  context '#navigate_directory' do
  	it 'should change the cwd to @directory' do
  	end

  	it 'should call gather_files' do
  	end
  end

  context '#gather_files' do
  	xit 'should return an array of filepaths (as Strings)' do
  	end

  	xit 'should only have .html or .xml files in the array' do
  	end

  	xit 'should return an empty array if there are no valid files' do
  	end
  end

  context '#open_next_file' do
  	it 'should create a File object' do
  	end

  	it 'should call #set_HTML for .html files' do
  	end

  	it 'should call #set_XML for .xml files' do
  	end
  end

  context '#is_HTML?' do
  	it 'should return true or false' do
  	end

  	it 'should return true is the given file is HTML' do
  	end

  	it 'should return false if it is not HTML' do
  	end
  end

  context '#is_XML?' do
  	it 'should return true or false' do
  	end

  	it 'should return true is the given file is XML' do
  	end

  	it 'should return false if it is not XML' do
  	end
  end

  context '#set_HTML' do
  	it 'should create a Nokogiri Object' do
  	end

  	it 'should call #crawl_files with appropriate arguments' do
  	end
  end

  context '#set_XML' do
   	it 'should create a Nokogiri Object' do
  	end

  	it 'should call #crawl_files with appropriate arguments' do
  	end
  end

  context '#crawl_file' do
  	it 'should return a Hash' do
  	end

  	it 'should update @content' do
  	end

  	it 'should add to the array if the tag is present' do
  	end

  	it 'should have an empty array if the tag is not present' do
  	end
  end

  context '#sanitize' do
  	it 'should return a String' do
  	end

  	it 'should remove any " from a String' do
  	end

    it 'should remove any \n from a String' do
    end

  	it 'should not modify a String that has no "s or \ns' do
  	end
  end

  context '#fill_array' do
    it 'should shovel into @content if it is not empty' do
    end

    it 'should not modify @content if it is empty' do
    end
  end
end

describe Writer do
	context '#write' do
		xit 'should create a new CSV file named "tag_content.csv"' do
		end
	end
end
