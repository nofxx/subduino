h1. Subduino

Arduino Tools on Ruby

http://github.com/nofxx/subduino


h2. Install

    gem install subduino


h3. Requirements

* "Arduino":http://arduino.cc

PubSub (gems):

* "serialport":http://github.com/hparra/ruby-serialport
* "redis":http://github.com/ezmobius/redis-rb

Compile/Upload to arduino (archlinux pkgs):

* "arduino" or "arduino64"
* "gcc-avr"
* "avrdude"

WebApp (gems):

* sinatra
* haml


h2. Create a project

<pre><code>
    subduino some/dir/bot
    ...creates folder and some sketch files...

</pre></code>

h3. bot.rb

Simple example that monitors arduinos on the USB.

h3. bot.pde

Common arduino source, can be compiled/uploaded via the IDE or:

h3. Makefile

Nice makefile so you don't need the IDE ;)
Use 'make' or 'make upload'.

It's being tested (works) on archlinux with arduino 0019.
It's just a matter of setting the first lines of the Makefile correct for your OS.
Please let me know so I can detect the OS and write a correct makefile for other distros.


h2. PubSub

<pre><code>

    Subduino.start do |reading|
      puts "Received from arduino: #{reading}"
      # Mail.send("foo@bla.com") if reading && reading.digital?
      # Postgre.remember(:sensor => reading)
    end

    Subduino.write(TXT)

</pre></code>


h2. Webapp

Need some heavy work...


h2. Contributing

Fork/work/push.


h3. Author

nofxx


h3. License

"WTFPL":http://sam.zoy.org/wtfpl/