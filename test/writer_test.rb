$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'wavefile.rb'

include WaveFile

class WriterTest < Test::Unit::TestCase
  OUTPUT_FOLDER = "test/fixtures/actual_output"

  def test_no_sample_data
    clean_output_folder()

    writer = Writer.new("#{OUTPUT_FOLDER}/no_samples.wav", Format.new(1, 8, 44100))
    writer.close()
    
    assert_equal(read_file(:expected, "no_samples.wav"), read_file(:actual, "no_samples.wav"))
  end

  def read_file(type, file_name)
    # For Windows compatibility with binary files, File.read() is not directly used
    return File.open("test/fixtures/#{type}_output/#{file_name}", "rb") {|f| f.read() }
  end

  def clean_output_folder()
    # Make the folder if it doesn't already exist
    Dir.mkdir(OUTPUT_FOLDER) unless File.exists?(OUTPUT_FOLDER)

    dir = Dir.new(OUTPUT_FOLDER)
    file_names = dir.entries
    file_names.each do |file_name|
      if(file_name != "." && file_name != "..")
        File.delete("#{OUTPUT_FOLDER}/#{file_name}")
      end
    end
  end
end
