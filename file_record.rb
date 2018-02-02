class FileRecord
  attr_reader :path, :name, :size, :create_datetime, :modify_datetime

  def initialize(path)
    @path = path

    load_file_details
  end

  def ==(other)
    name == other.name &&
      size == other.size &&
      modify_datetime == other.modify_datetime
  end

  def to_s
    "#{name} [#{path}, #{size}, Modified: #{modify_datetime}]"
  end

  private

  def load_file_details
    @name = File.basename(path)

    stats = File.stat(path)

    @size = stats.size
    @create_datetime = stats.ctime
    @modify_datetime = stats.mtime
  end
end
