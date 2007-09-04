package PSQL::Query::Token::Operation;
use Moose;

extends 'PSQL::Query::Token';

use PSQL::Query::Token::Range;

has 'rows'  => (
	isa       => 'Int'
	, is      => 'ro'
	, lazy    => 1
	, default => sub { shift->get_rows(@_) }
);

has 'range' => (
	isa       => 'PSQL::Query::Token::Range'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_range
	, handles => {
		startup => 'min'
		, total => 'max'
	}
);

sub get_range {
	my $self = shift;

	my $regex = $self->regex_range_src;

	$self->src =~ $regex;

	my $range = PSQL::Query::Token::Range->new({ src => $1 });

	$range;

}

1;
