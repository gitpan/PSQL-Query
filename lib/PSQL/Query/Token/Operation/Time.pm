package PSQL::Query::Token::Operation::Time;
use Moose;

extends 'PSQL::Query::Token::Operation';

has 'loops'  => (
	isa       => 'Int'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_loops
);

has 'regex_range_src' => (
	isa => 'RegexpRef'
	, is => 'ro'
	, default => sub { qr/time=(\S+)/ }
);

sub get_rows {
	my $self = shift;

	$self->src =~ /rows=(\d+)/;

	$1;

}

sub get_loops {
	my $self = shift;

	$self->src =~ /loops=(\d+)/;

	$1;

}

1;
