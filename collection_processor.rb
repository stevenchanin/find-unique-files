require 'pathname'

class CollectionProcessor
  attr_reader :options, :source,
    :source_collection, :destination_collection,
    :delete_pen

  def self.call(options, source, source_collection, destination_collection)
    new(options, source, source_collection, destination_collection).tap do |me|
      me.execute
    end
  end

  def initialize(options, source, source_collection, destination_collection)
    @options = options
    @source = source
    @source_collection = source_collection
    @destination_collection = destination_collection
  end

  def execute
    create_delete_pen
    process_records
  end

  private

  def create_delete_pen
    @delete_pen = Pathname.new("#{source}/_delete")
    puts "Creating _delete directory: #{@delete_pen.split}" if options.verbose?

    return if options.debug?
    FileUtils.mkdir(delete_pen)
  end

  def process_records
    @source_collection.each do |record|
      puts record
      match = destination_collection.find(record)
      if match
        handle_match(record, match)
      else
        handle_unique(record)
      end
    end
  end

  def handle_match(record, match)
    puts "  ==> Dup(#{match})"
    move_to_delete_pen(record)
  end

  def handle_unique(record)
    puts "  ==> is unique"
  end

  def move_to_delete_pen(record)
    return if options.debug?

    puts "  ==> Moving #{record.name}" if options.verbose?
    FileUtils.mv(record.path, delete_pen)
  end
end
