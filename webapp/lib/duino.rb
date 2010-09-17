
class Duino

  Config = YAML.load(File.read("config.yml"))

  def initialize(config)
    @config = config
    @redis = Redis.new(:timeout => 0)
  end

  def sensors(one=nil)
    sensors = Config["inputs"]
    # s = one ? Sensors.select { |k,v| k.to_s == one.to_s } : Sensors
    sensors.map do |s|
      p s
      val = @redis.get(s[0]) #rescue nil
      next unless val
      Subduino::Parse.work(s[1]["type"], val, s[1]["name"])
    end.reject(&:nil?)
  end

  def switch(pins, comm)
    comm = Message.new(comm =~ /start/).txt
    puts "[OUT] #{pins} #{comm}"
    command(comm)
  end

  def log(n)
    key = n + "_log"
    size = @redis.llen key
    @redis.lrange key, size - 100, size
  end

  # ping server to ensure that it is responsive
  def ping
    tries = 3
    begin
     # @server.ping
    rescue Exception => e
      retry if (tries -= 1) > 1
      raise e, "The server is not available (or you do not have permissions to access it)"
    end
  end

  def last_log(watch)
    format_log(log_command(watch, true))
  end

  def self.possible_statuses(status)
    # need to check, but god doesn't have a monitored and offline state...
    case status
    when :up then [true, true] #%w{start monitor}
    when :unmonitored then [false, false] #%w{start monitor}
    else [] # nil #[false, false] #%w{start stop restart}
    end
  end

  def self.ram_status
    mem = `free -mo`.split(" ")
    used, free, cached, swap = mem[8], mem[9], mem[12], mem[15]
  end

  def self.cpu_status
    #stat = `cat /proc/stat`.split(" ")
    # top = `top -bn 1`
    # info, tasks, cpus, mem, swap, *rest = *top
    # # Use array to keep order (ruby < 1.9)
    # [[:info, info.gsub(/top - |\d{2}:\d{2}(:\d{2})?(\s|,)|\saverage/, "")],
    #   [:cpus, cpus.gsub("Cpu\(s\): ", "").split(", ")[0..4].join(", ")],
    #   [:mem, mem.gsub("Mem:  ", "").gsub(/(\d*k)/) { ($1.to_i / 1000).to_s }]]
    []
  end
  def status
    status_command
  end

  private

  def command(line)
    @redis.publish('subduin', line) unless line.empty?
  end


  # def method_missing(meth,*args)
  #   if %w{groups status log quit terminate}.include?(meth.to_s)
  #     ping
  #     send("#{meth}_command")
  #   # elsif %w{start stop restart unmonitor monitor}.include?(meth.to_s)
  #   #   ping
  #   #   lifecycle_command(args.first, meth.to_s)
  #   else
  #     raise NoMethodError, meth
  #   end
  # end

  def groups_command
    groups = []
    @server.groups.each do |key, value|
      groups << key
    end
    groups.sort
  end

  def status_command
  #  @server.status
  end

  #
  # To make it look good (no horiz scrollbars) in the iphone
  #
  def format_log(raw)
    return "..." unless raw
    raw.split("\n").map do |l|
      # clean stuff we don't need
      l.gsub!(/I\s+|\(\w*\)|within bounds/, "") #        gsub(/\(\w*\)/, """)
      # if ok, span is green
      ok = l =~ /\[ok\]/
      if l =~ /\[\w*\]/
        # get some data we want...
        l.gsub(/\[\S*\s(\S*)\]\W+INFO: (\w*-?\w*|.*)?\s\[(\w*)?\]/, "<span class='gray'>\\1</span> | <span class='#{ok ? 'green' : 'red'}'>\\3</span> |").
          # take only the integer from cpu
          gsub(/cpu/, "cpu %").gsub(/(\d{1,3})\.\d*%/, "\\1").
          # show mem usage in mb
          gsub(/memory/, "mem mb").gsub(/(\d*kb)/) { ($1.to_i / 1000).to_s }
      else
        l.gsub(/\[\S*\s(\S*)\]\W+INFO: \w*\s(\w*)/, "<span class='gray'>\\1</span> | <span class='act'>act</span> | \\2")
      end

    end.reverse.join("</br>")
  end

  #TODO
  def log_command(name, sample=false)
    # begin
    #   Signal.trap('INT') { exit }
    # #  name = @args[1]

    #   unless name
    #     puts "You must specify a Task or Group name"
    #     exit!
    #   end

    #   t = Time.at(0)
    #   if sample
    #     @server.running_log(name, t)
    #   else
    #     loop do
    #       @server.running_log(name, t)
    #       t = Time.now
    #       sleep 1
    #     end
    #   end
    # rescue God::NoSuchWatchError
    #   puts "No such watch"
    # rescue DRb::DRbConnError
    #   puts "The server went away"
    # end
  end

  def quit_command
    begin
      @server.terminate
      return false
    rescue DRb::DRbConnError
      return true
    end
  end

  def terminate_command
    stopped_all = false
    if @server.stop_all
      stopped_all = true
    end

    begin
      @server.terminate
      return false
    rescue DRb::DRbConnError
      return stopped_all
    end
  end


  def lifecycle_command(*args)
    # get the name of the watch/group
    name = args.first
    command = args.last

    # send @command
    watches = @server.control(name, command)

    watches.empty? ? [] : watches
  end

end


# def halt!
#   puts "Closing server"
#   @redis.quit
#   puts "..."
#   exit
# end

# trap(:TERM) { halt! }
# trap(:INT)  { halt! }
