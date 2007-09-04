package PSQL::Query::Token::Row;
use Moose;

extends 'PSQL::Query::Token';

has 'name' => (
	isa       => 'Str'
	, is      => 'rw'
	, lazy    => 1
	, default => \&get_name
);

sub get_name {
	my $self = shift;

	$self->src =~ /^\s*(?:->  )?(.*?)\s*[(:]/;

	$1;

}

1;
