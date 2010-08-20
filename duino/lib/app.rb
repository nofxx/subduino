before do
  unless (DUINO_CONFIG['username'].nil? && DUINO_CONFIG['password'].nil?) || self.request.path_info == '/heartbeat'
    use Rack::Auth::Basic do |user, pass|
      [user, pass] == [DUINO_CONFIG['username'], DUINO_CONFIG['password']]
    end
  end
  # DUINO.ping
end

get '/' do
  @statuses = DUINO.status
  @watches = []
  # @statuses.each do |watch, status|
  #   @watches << watch.to_s
  # end
  # @watches = @watches.group_by { |w| @statuses[w][:state].to_s }
  @sensors = { "Temp" => 20, "Lux" => 500 } #]DUINO.groups
  @host = `hostname`
  @stats = Duino.cpu_status
  @footer = "Duino v0.0.1 - #{@host}"
  show(:index, @host)
end

get '/o' do
  @commands = %w{ false false }
  @watch = :all
  show(:switch, "Pins Switch")
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

get '/w/:watch' do
  @watch = params["watch"]
  @status = DUINO.status[@watch][:state]
  @commands = Duino.possible_statuses(@status)
  @log = DUINO.last_log(@watch)
  show(:switch, @watch)
end

get '/w/:watch/:command' do
  @watch = params["watch"]
  @command = params["command"]
  @success = DUINO.switch(@watch, @command)
 # @success = false if @success == []
  @log = DUINO.last_log(@watch)
  show(:command, "#{@command}ing #{@watch}")
end

get '/g/:group' do
  @watch = @group = params["group"]
  @child = DUINO.status.keys.each.select { |k| DUINO.status[k][:group] == @group } #.select { |w| w["group"] = @group }
  @child.map!{ |c| [c, DUINO.status[c][:state]]}
  @status = nil
  @commands = Duino.possible_statuses(@status)
  show(:watch, "#{@group} [group]")
end


private

def show(template, title = 'Duino')
  @title = title
  haml(template)
end
