input = File.readlines('./input/07.txt', chomp: true)

class AdventFile
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def dir?
    false
  end
end

class AdventDir
  attr_accessor :nodes
  attr_reader :name, :parent

  def initialize(parent, name, nodes)
    @parent = parent
    @name = name
    @nodes = nodes
  end

  def size
    nodes.map(&:size).sum
  end

  def dir?
    true
  end

  def find_dir(name)
    nodes.find { |node| node.dir? && node.name == name } or raise "Directory '#{name}' is not found"
  end

  def all_dirs
    [self] + nodes.select(&:dir?).flat_map(&:all_dirs)
  end
end

root_dir = AdventDir.new(nil, '/', [])
cwd = root_dir

input.each do |line|
  if line.start_with?('$ ')
    next if line == '$ ls'

    path = line[5..]
    cwd = case path
          when '/'
            root_dir
          when '..'
            cwd.parent
          else
            cwd.find_dir(path)
          end
  elsif line.start_with? 'dir'
    name = line[4..]
    cwd.nodes << AdventDir.new(cwd, name, [])
  else
    size, name = line.split ' '
    cwd.nodes << AdventFile.new(name, size.to_i)
  end
end

total_space = 70_000_000
required_space = 30_000_000
used_space = root_dir.size
unused_space = total_space - used_space
gap = required_space - unused_space

part1 = root_dir.all_dirs.select { |dir| dir.size < 100_000 }.map(&:size).sum
part2 = root_dir.all_dirs.map(&:size).select { |size| size > gap }.min

puts part1, part2
