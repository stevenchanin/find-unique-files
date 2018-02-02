require './file_record'

class FileCollection
  attr_reader :options, :contents

  def initialize(options)
    @options = options
    @contents = {}
  end

  def add(record)
    name = record.name

    unless contents[name]
      contents[name] = []
    end

    contents[name] << record
    # puts "Adding #{name} to Collection" if options.verbose?
  end

  def find(record)
    name = record.name
    matching_set = contents[name]

    return(false) if matching_set.nil?
    matching_set.find { |element| element == record }
  end

  def each
    contents.each do |key, matches|
      matches.each do |record|
        yield(record)
      end
    end
  end

  def to_s
    contents.each do |key, matches|
      puts "Name: #{key}"

      matches.each { |record| puts "  #{record}" }
    end
  end
end
