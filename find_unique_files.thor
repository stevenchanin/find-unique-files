require './collection_processor'
require './directory_walker'
require './file_collection'
require './file_record'
require 'thor'

class FindUnique < Thor
  package_name "App"

  desc "execute /PATH/TO/SOURCE /PATH/TO/DESTINATION", "eliminate duplicates in source"
  method_option :debug, :type => :boolean, :default => false, :aliases => 'd'
  method_option :verbose, :type => :boolean, :default => true, :aliases => 'v'
  def execute(source, destination)
    puts "Running with: #{options}" if options.verbose?

    source_collection = FileCollection.new(options)
    destination_collection = FileCollection.new(options)

    DirectoryWalker.call(options, source, source_collection, 0)
    DirectoryWalker.call(options, destination, destination_collection, 0)

    CollectionProcessor.call(options, source, source_collection, destination_collection)
  end
end
