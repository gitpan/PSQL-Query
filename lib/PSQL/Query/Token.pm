package PSQL::Query::Token;
use Moose;

has 'trim_whitespace' => (
	isa       => 'RegexpRef'
	, is      => 'ro'
	, lazy    => 1
	, default => sub { qr/^\s+|\s+$/ }
);

has 'src' => (
	isa        => 'Str'
	, is       => 'ro'
	, required => 1
);

has 'src_trimmed' => (
	isa       => 'Str'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_src_trimmed
);

sub get_src_trimmed {
	my $self = shift;

	my $regex = $self->trim_whitespace;

	( my $trimmed = $self->src ) =~ s/$regex//g;

	$trimmed;
	
}

1;
