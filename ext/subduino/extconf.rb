require 'mkmf'

def crash(s)
  puts "--------------------------------------------------"
  puts " extconf failure: #{s}"
  puts "--------------------------------------------------"
  exit 1
end

unless find_executable("pkg-config")
  crash("pkg-config needed")
end

$CFLAGS += " -std=c99 -Wall -I. " #+ `pkg-config --cflags glib-2.0`.strip
# $LIBS += " " + `pkg-config --libs glib-2.0`
# $CFLAGS += " -DOS_#{os.upcase}"
# $CFLAGS += " -DRUBY_1_9" if RUBY_VERSION =~ /^1\.9/


# unless have_library('glib-2.0')
#   crash "libglib-2.0 needed"
# end

if ARGV.include?("-d")
  $CFLAGS += " -D CUBDUINO_DEBUG"
end

if ARGV.include?("-O0")
  $CFLAGS.gsub!(/-O./, "-O0")
else
  $CFLAGS.gsub!(/-O./, "-O3")
end

if ARGV.include?("-gdb")
  $CFLAGS += " -g -gdwarf-2 -g3"
end

create_makefile("cubduino")
