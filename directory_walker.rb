require 'pathname'
require './file_collection'
require './file_record'

class DirectoryWalker
  attr_reader :options, :path, :file_collection, :depth

  def self.call(options, path, file_collection, depth = 0)
    new(options, path, file_collection, depth).tap do |me|
      me.execute
    end
  end

  def initialize(options, path, file_collection, depth = 0)
    @options = options
    @path = path
    @file_collection = file_collection
    @depth = depth
  end

  def execute
    puts "Reading #{path}" if options.verbose?
    Dir.entries(path).each do |item|
      next if item == '.' || item == '..' || item[0] == '.'

      item_path = Pathname.new("#{path}/#{item}")

      if File.directory?(item_path)
        log "Stepping into directory: #{item}" if options.verbose?
        DirectoryWalker.call(options, item_path, file_collection, depth + 1)
      else
        log "Remembering file: #{item}" if options.verbose?
        record = FileRecord.new(item_path)
        file_collection.add(record)
      end
    end
  end

  private

  def log(msg)
    # puts ("  " * depth) + msg
  end
end
