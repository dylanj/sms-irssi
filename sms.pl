use Irssi;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = '0.02';
%IRSSI = (
	authors => 'Dylan Johnston',
	contact => 'qdylanj@gmail.com',
	name 	=> 'SMS Highlights when Away',
	description => 'texts you your highlights if you\'re away.',
	license => 'GPL',
);

my $away = 0; # should probably figure out if we are away or not

sub sms {
	my ($msg) = @_;
	
	my $token = "PUT YOUR TROPO TOKEN HERE";
	my $apiurl = "https://api.tropo.com/1.0/sessions?action=create&token=";
		
	$msg =~ s/#/\%23/g;

	my $url = $apiurl . $token . "&msg=" . $msg;
	my $cmd = "wget \"" . $url ."\"";

	$SIG{CHLD} = 'IGNORE';
 
	if(fork() == 0) {

		close(STDOUT);
		close(STDIN);
		close(STDERR);
		
		system( "wget", $url, "-O", "/dev/null" );
		exit(0);
	}
}

sub parse_msg {
	my ($dest, $text, $stripped) = @_;
	if ( $dest->{level} & MSGLEVEL_HILIGHT && $away ) {
		sms($dest->{target}. " " .$stripped );
	}
}

sub parse_privmsg {
	my ($server, $msg, $nick, $address) = @_;
	
	if ( $away ) {
		sms($nick.": " .$msg );
	}
}

sub parse_away {
	my ($server ) = @_;
	if ( $server->{usermode_away} ) {
		$away = 1;	
	} else {
		$away = 0;
	}
}

Irssi::signal_add('print text', \&parse_msg );
Irssi::signal_add('message private', \&parse_privmsg );
Irssi::signal_add('away mode changed', \&parse_away );

