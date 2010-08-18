before do
  unless (DUINO_CONFIG['username'].nil? && DUINO_CONFIG['password'].nil?) || self.request.path_info == '/heartbeat'
    use Rack::Auth::Basic do |user, pass|
      [user, pass] == [DUINO_CONFIG['username'], DUINO_CONFIG['password']]
    end
  end
  # DUINO.ping
end

# This one shows how you can use refer to
# variables in your Haml views.
# This method uses member variables.

get '/hello/:name' do |name|
  @name = name
  haml :hello
end
# This method shows you how to inject
# local variables

get '/goodbye/:name' do |name|
  haml :goodbye, :locals => { :name => name }
end

# __END__
# @@ layout

# %html
#   %head
#   %title Haml on Sinatra Example
# %body     =yield @@ index
# #header
# %h1 Haml on Sinatra Example
# #content
# %p     This is an example of using Haml on Sinatra.     You can use Haml in all your projeccts now, instead     of Erb.
#   I'm sure you'll find it much easier! @@ hello
# %h1= "Hello #{@name}!" @@ goodbye %h1= "Goodbye #{name}!"

get '/' do
  @statuses = DUINO.status
  @watches = []
  # @statuses.each do |watch, status|
  #   @watches << watch.to_s
  # end
  # @watches = @watches.group_by { |w| @statuses[w][:state].to_s }
  @groups = [] #]DUINO.groups
  @host = `hostname`
  @stats = Duino.cpu_status
  @footer = "Duino v0.2.5 - #{@host}"
  show(:index, @host)
end

get '/w/:watch' do
  @watch = params["watch"]
  @status = DUINO.status[@watch][:state]
  @commands = Duino.possible_statuses(@status)
  @log = DUINO.last_log(@watch)
  show(:switch, @watch)
end

get '/g/:group' do
  @watch = @group = params["group"]
  @child = DUINO.status.keys.each.select { |k| DUINO.status[k][:group] == @group } #.select { |w| w["group"] = @group }
  @child.map!{ |c| [c, DUINO.status[c][:state]]}
  @status = nil
  @commands = Duino.possible_statuses(@status)
  show(:watch, "#{@group} [group]")
end

get '/w/:watch/:command' do
  @watch = params["watch"]
  @command = params["command"]
  @success = DUINO.switch(@command, @watch)
  @success = false if @success == []
  @log = DUINO.last_log(@watch)
  show(:command, "#{@command}ing #{@watch}")
end

get '/o' do
  @commands = %w{ true }
  show(:switch, "god itself")
end

get '/i' do
  @text = `hostname`
  show(:icon)
end

get '/t' do
  @text = `top -Hibn 1`.gsub("top - ", "")
  show(:top)
end

get '/heartbeat' do
  @statuses = DUINO.status
  'OK'
end

private

def show(template, title = 'Duino')
  @title = title
  haml(template)
end
