package PSQL::Query::Token::Range;
use Moose;

extends 'PSQL::Query::Token';

has 'max' => (
	isa       => 'Str'
	, is      => 'rw'
	, lazy    => 1
	, default => \&get_max
);

has 'min'  => (
	isa       => 'Str'
	, is      => 'rw'
	, lazy    => 1
	, default => \&get_min
);

sub get_max {
	my $self = shift;

	$self->src =~ /\.+(\d+?.\d+?)$/;

	$1;
	
}

sub get_min {
	my $self = shift;

	$self->src =~ /(\d+?\.\d+?)\.{2}/;

	$1;

}

1;
