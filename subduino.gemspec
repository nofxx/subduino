# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{subduino}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Piccinini"]
  s.date = %q{2010-09-18}
  s.description = %q{Interface, compile, upload, play with arduino/ruby}
  s.email = %q{x@nofxx.com}
  s.executables = ["subduino-cli", "subduino"]
  s.files = [
    ".document",
     ".gitignore",
     "Rakefile",
     "Readme.textile",
     "VERSION",
     "bin/subduino",
     "bin/subduino-cli",
     "duino/.gitignore",
     "duino/Makefile",
     "duino/duino.pde",
     "duino/duino.rb",
     "duino/methods.pde",
     "lib/subduino.rb",
     "lib/subduino/ard_io.rb",
     "lib/subduino/ard_ps.rb",
     "lib/subduino/arduino.rb",
     "lib/subduino/parse.rb",
     "lib/subduino/parse/bool.rb",
     "lib/subduino/parse/lux.rb",
     "lib/subduino/parse/temp.rb",
     "lib/subduino/scaffold/Makefile",
     "lib/subduino/scaffold/Makefile2",
     "lib/subduino/scaffold/generator.rb",
     "lib/subduino/scaffold/scaffold.pde",
     "lib/subduino/scaffold/scaffold.rb",
     "lib/subduino/store.rb",
     "node/arduinode.js",
     "node/server.js",
     "node/vendor/faye.js",
     "spec/spec_helper.rb",
     "spec/subduino/ard_io_spec.rb",
     "spec/subduino/parse_spec.rb",
     "spec/subduino/store_spec.rb",
     "spec/subduino_spec.rb",
     "subduino.gemspec",
     "webapp/Gemfile",
     "webapp/Gemfile.lock",
     "webapp/Rakefile",
     "webapp/Readme.textile",
     "webapp/VERSION",
     "webapp/config.yml",
     "webapp/lib/app.rb",
     "webapp/lib/duino.rb",
     "webapp/lib/environment.rb",
     "webapp/lib/messenger.rb",
     "webapp/public/app.css",
     "webapp/public/app.js",
     "webapp/public/custom.js",
     "webapp/public/date_input.css",
     "webapp/public/facebox.css",
     "webapp/public/facebox.js",
     "webapp/public/favicon.ico",
     "webapp/public/faye.js",
     "webapp/public/icons/alarm-clock-blue.png",
     "webapp/public/icons/alarm-clock.png",
     "webapp/public/icons/balloon-left.png",
     "webapp/public/icons/bandaid.png",
     "webapp/public/icons/bell-disable.png",
     "webapp/public/icons/bell.png",
     "webapp/public/icons/big_icon.png",
     "webapp/public/icons/bomb.png",
     "webapp/public/icons/bookmark.png",
     "webapp/public/icons/box-label.png",
     "webapp/public/icons/brightness-control-up.png",
     "webapp/public/icons/brightness-control.png",
     "webapp/public/icons/brightness-small.png",
     "webapp/public/icons/broom.png",
     "webapp/public/icons/bug.png",
     "webapp/public/icons/calculator.png",
     "webapp/public/icons/calendar-day.png",
     "webapp/public/icons/camera.png",
     "webapp/public/icons/cards-address.png",
     "webapp/public/icons/chart.png",
     "webapp/public/icons/clock-select.png",
     "webapp/public/icons/color.png",
     "webapp/public/icons/compass.png",
     "webapp/public/icons/control-power-small.png",
     "webapp/public/icons/control-power.png",
     "webapp/public/icons/control-record-small.png",
     "webapp/public/icons/cpus.png",
     "webapp/public/icons/credit-card.png",
     "webapp/public/icons/cross-small.png",
     "webapp/public/icons/current.png",
     "webapp/public/icons/dashboard.png",
     "webapp/public/icons/database.png",
     "webapp/public/icons/databases.png",
     "webapp/public/icons/day.png",
     "webapp/public/icons/door-big.png",
     "webapp/public/icons/door-open-in.png",
     "webapp/public/icons/door-open-out.png",
     "webapp/public/icons/door-open.png",
     "webapp/public/icons/door.png",
     "webapp/public/icons/drive-globe.png",
     "webapp/public/icons/equalizer.png",
     "webapp/public/icons/exclamation-diamond.png",
     "webapp/public/icons/exclamation.png",
     "webapp/public/icons/eye-disable.png",
     "webapp/public/icons/eye.png",
     "webapp/public/icons/false.png",
     "webapp/public/icons/favicon.png",
     "webapp/public/icons/gear-small.png",
     "webapp/public/icons/gear.png",
     "webapp/public/icons/groups.png",
     "webapp/public/icons/heart.png",
     "webapp/public/icons/heart_empty.png",
     "webapp/public/icons/info.png",
     "webapp/public/icons/irrigation.png",
     "webapp/public/icons/key.png",
     "webapp/public/icons/lamp-big.png",
     "webapp/public/icons/lightbulb.png",
     "webapp/public/icons/lightbulb_off.png",
     "webapp/public/icons/lightning-disable.png",
     "webapp/public/icons/lightning-small.png",
     "webapp/public/icons/lightning.png",
     "webapp/public/icons/lock-unlock.png",
     "webapp/public/icons/lock.png",
     "webapp/public/icons/locked.png",
     "webapp/public/icons/lux.png",
     "webapp/public/icons/marker.png",
     "webapp/public/icons/media-player-phone.png",
     "webapp/public/icons/megaphone.png",
     "webapp/public/icons/mem.png",
     "webapp/public/icons/microphone.png",
     "webapp/public/icons/monitor.png",
     "webapp/public/icons/navigation.png",
     "webapp/public/icons/night.png",
     "webapp/public/icons/noise.png",
     "webapp/public/icons/off.png",
     "webapp/public/icons/on.png",
     "webapp/public/icons/onoff.png",
     "webapp/public/icons/pin.png",
     "webapp/public/icons/plug--exclamation.png",
     "webapp/public/icons/plug-disable.png",
     "webapp/public/icons/plug.png",
     "webapp/public/icons/rain.png",
     "webapp/public/icons/refrigeration.png",
     "webapp/public/icons/restart.png",
     "webapp/public/icons/ruby.png",
     "webapp/public/icons/server.png",
     "webapp/public/icons/shield-disable.png",
     "webapp/public/icons/shield.png",
     "webapp/public/icons/socket--exclamation.png",
     "webapp/public/icons/socket-disable.png",
     "webapp/public/icons/socket.png",
     "webapp/public/icons/start.png",
     "webapp/public/icons/stop.png",
     "webapp/public/icons/switch--exclamation.png",
     "webapp/public/icons/switch-disable.png",
     "webapp/public/icons/switch-small.png",
     "webapp/public/icons/switch.png",
     "webapp/public/icons/target.png",
     "webapp/public/icons/television-off.png",
     "webapp/public/icons/television.png",
     "webapp/public/icons/temp.png",
     "webapp/public/icons/terminal.png",
     "webapp/public/icons/tick-small.png",
     "webapp/public/icons/traffic-light-off.png",
     "webapp/public/icons/traffic-light.png",
     "webapp/public/icons/traffic.png",
     "webapp/public/icons/true.png",
     "webapp/public/icons/umbrella.png",
     "webapp/public/icons/unlocked.png",
     "webapp/public/icons/unmonitor.png",
     "webapp/public/icons/unmonitored.png",
     "webapp/public/icons/users.png",
     "webapp/public/icons/vcard.png",
     "webapp/public/icons/wall.png",
     "webapp/public/icons/wall_brick.png",
     "webapp/public/icons/wall_disable.png",
     "webapp/public/icons/wand-disable.png",
     "webapp/public/icons/wand.png",
     "webapp/public/icons/warn.png",
     "webapp/public/icons/weather_clouds.png",
     "webapp/public/icons/weather_cloudy.png",
     "webapp/public/icons/weather_lightning.png",
     "webapp/public/icons/weather_rain.png",
     "webapp/public/icons/weather_snow.png",
     "webapp/public/icons/weather_sun.png",
     "webapp/public/icons/wrench-screwdriver.png",
     "webapp/public/icons/wrench.png",
     "webapp/public/images/ajax-loader.gif",
     "webapp/public/images/b.png",
     "webapp/public/images/bendl.gif",
     "webapp/public/images/bendr.gif",
     "webapp/public/images/bendsb.gif",
     "webapp/public/images/bg.jpg",
     "webapp/public/images/bhead.gif",
     "webapp/public/images/bheadl.gif",
     "webapp/public/images/bheadr.gif",
     "webapp/public/images/bl.png",
     "webapp/public/images/bnd.gif",
     "webapp/public/images/br.png",
     "webapp/public/images/bread.gif",
     "webapp/public/images/btnb.gif",
     "webapp/public/images/btnb_.gif",
     "webapp/public/images/btnm.gif",
     "webapp/public/images/btnm_.gif",
     "webapp/public/images/btns.gif",
     "webapp/public/images/btns_.gif",
     "webapp/public/images/cal.jpg",
     "webapp/public/images/close.png",
     "webapp/public/images/closelabel.gif",
     "webapp/public/images/error.gif",
     "webapp/public/images/ft.gif",
     "webapp/public/images/hdr.gif",
     "webapp/public/images/hdrl.gif",
     "webapp/public/images/hdrr.gif",
     "webapp/public/images/hld.jpg",
     "webapp/public/images/imgb.gif",
     "webapp/public/images/imgo.gif",
     "webapp/public/images/imgt.gif",
     "webapp/public/images/info.gif",
     "webapp/public/images/jquery.wysiwyg.gif",
     "webapp/public/images/li.gif",
     "webapp/public/images/mbg.png",
     "webapp/public/images/nsp.gif",
     "webapp/public/images/phs.gif",
     "webapp/public/images/sdd.jpg",
     "webapp/public/images/sdd_.jpg",
     "webapp/public/images/sidebar.gif",
     "webapp/public/images/sorta.gif",
     "webapp/public/images/sortd.gif",
     "webapp/public/images/srch.gif",
     "webapp/public/images/srch_.gif",
     "webapp/public/images/success.gif",
     "webapp/public/images/thumb1.jpg",
     "webapp/public/images/thumb2.jpg",
     "webapp/public/images/thumb3.jpg",
     "webapp/public/images/tiny.gif",
     "webapp/public/images/tiny_.gif",
     "webapp/public/images/tl.png",
     "webapp/public/images/tr.png",
     "webapp/public/images/upload.gif",
     "webapp/public/images/warning.gif",
     "webapp/public/iui/backButton.png",
     "webapp/public/iui/blueButton.png",
     "webapp/public/iui/cancel.png",
     "webapp/public/iui/grayButton.png",
     "webapp/public/iui/greenButton.png",
     "webapp/public/iui/iui-logo-touch-icon.png",
     "webapp/public/iui/iui.css",
     "webapp/public/iui/iui.js",
     "webapp/public/iui/iuix.css",
     "webapp/public/iui/iuix.js",
     "webapp/public/iui/listArrow.png",
     "webapp/public/iui/listArrowSel.png",
     "webapp/public/iui/listGroup.png",
     "webapp/public/iui/loading.gif",
     "webapp/public/iui/pinstripes.png",
     "webapp/public/iui/redButton.png",
     "webapp/public/iui/selection.png",
     "webapp/public/iui/thumb.png",
     "webapp/public/iui/toggle.png",
     "webapp/public/iui/toggleOn.png",
     "webapp/public/iui/toolButton.png",
     "webapp/public/iui/toolbar.png",
     "webapp/public/iui/whiteButton.png",
     "webapp/public/iui/yellowButton.png",
     "webapp/public/jquery.img.preload.js",
     "webapp/public/jquery.js",
     "webapp/public/jquery.sparkline.js",
     "webapp/public/jquery.tablesorter.min.js",
     "webapp/public/jquery.visualize.js",
     "webapp/public/jquery.wysiwyg.css",
     "webapp/public/layout.css",
     "webapp/public/right.js",
     "webapp/public/rt.js",
     "webapp/public/sparkline.js",
     "webapp/public/style.css",
     "webapp/public/visualize.css",
     "webapp/spec/duino_spec.rb",
     "webapp/spec/spec_helper.rb",
     "webapp/views/command.haml",
     "webapp/views/icon.haml",
     "webapp/views/index.haml",
     "webapp/views/layout.haml",
     "webapp/views/mobile.haml",
     "webapp/views/switch.haml",
     "webapp/views/template.haml",
     "webapp/views/top.haml",
     "webapp/views/watch.haml"
  ]
  s.homepage = %q{http://github.com/nofxx/subduino}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Arduino Ruby Helpers}
  s.test_files = [
    "spec/subduino_spec.rb",
     "spec/spec_helper.rb",
     "spec/subduino/ard_io_spec.rb",
     "spec/subduino/parse_spec.rb",
     "spec/subduino/store_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

