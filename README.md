Subduino
========

AVR/Arduino Serial Tools on Ruby

http://github.com/nofxx/subduino


Install
-------

    gem install subduino


Requirements
------------

* "serialport":http://github.com/hparra/ruby-serialport

If you want:

PubSub:
* "redis":http://github.com/ezmobius/redis-rb

WebApp:
* sinatra
* haml


Use
---

     subduino -p <PORT> -b <BAUDS>



PubSub
------


    Subduino.start do |reading|
      puts "Received from mcu: #{reading}"
      # Mail.send("foo@bla.com") if reading && reading.digital?
      # Postgre.remember(:sensor => reading)
      # Mongoid.insert(:sensor => reading)
      # ...
    end

    Subduino.write(TXT)


Webapp
------

Need some love...



License
-------

"WTFPL":http://sam.zoy.org/wtfpl/
