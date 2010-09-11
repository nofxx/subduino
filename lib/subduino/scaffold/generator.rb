
module Subduino
  class Generator

    Files = %w{ Makefile scaffold.rb scaffold.pde}
    class << self

      def copy_files(dir)
        name = dir.split("/").last
        Files.each do |file|
          puts "Working on #{file}"
          dump = File.open(File.dirname(__FILE__) + "/#{file}").readlines
          file.gsub!(/scaffold/, name)
          File.open(dir + "/#{file}", 'w') do |f|
            f.write(dump.join.gsub(/!!SCAFFOLD!!/, name))
          end
        end
      end

      def os_detect
        case RUBY_PLATFORM
        when /linux/ then ""
        when /darwin/ then ""
          else raise "Dunno how to play with #{RUBY_PLATFORM}"
        end
      end
    end
  end
end
