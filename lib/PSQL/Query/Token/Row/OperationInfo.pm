package PSQL::Query::Token::Row::OperationInfo;
use Moose;

extends 'PSQL::Query::Token::Row';

has 'verbose' => (
	isa       => 'Str'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_verbose
);

sub get_verbose {
	my $self = shift;

	my $src = $self->src;

	$src =~ /.*?:(.*)/;

	$1;

}

1;
