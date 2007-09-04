package PSQL::Query::Token::Operation::Cost;
use Moose;

extends 'PSQL::Query::Token::Operation';

has 'width' => (
	isa       => 'Int'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_width
);

has 'regex_range_src' => (
	isa       => 'RegexpRef'
	, is      => 'ro'
	, default => sub { qr/cost=(\S+)/ }
);

sub get_width {
	my $self = shift;

	$self->src =~ /width=(\d+)/;

	$1;

}

sub get_rows {
	my $self = shift;

	$self->src =~ /rows=(\d+)/;

	$1;

}

1;
