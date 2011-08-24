sms.pl
======

is an irssi script that will send you text messages when a highlight is triggered and youre away. It uses tropo.com ( an awesome service ) for sending text messages. to install put `sms.pl` into `~/.irssi/scripts/autorun`
###How to create the tropo application:
1. Create an account on [tropo.com](http://tropo.com "tropo")
2. Go to __Your Hosted Files__ and create a new file. I called mine irc.rb and use paste this code into the text area replacing the number with your phone number.
`call "+12505551234", { :network => "SMS" }
say $msg`
3. Create a new __Tropo Scriping Application__, name it whatever you want. For the box below use a __"Hosted File"__ and find the file you just created then click __Create Application__. 
4. Add a new phone number that supports messaging. _( US & Canada Only )_.
5. Now copy your messaging token and use it in `sms.pl`.

Have fun :D
