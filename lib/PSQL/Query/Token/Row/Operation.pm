package PSQL::Query::Token::Row::Operation;
use Moose;

extends 'PSQL::Query::Token::Row';

use PSQL::Query::Token::Operation::Cost;
use PSQL::Query::Token::Operation::Time;
use PSQL::Query::Token::Row::OperationInfo;

has 'cost' => (
	isa       => 'PSQL::Query::Token::Operation::Cost'
	, is      => 'rw'
	, lazy    => 1
	, default => \&get_cost
);

has 'time' => (
	isa         => 'PSQL::Query::Token::Operation::Time'
	, predicate => 'has_time'
	, is        => 'rw'
	, lazy      => 1
	, default   => \&get_time
);

has 'info' => (
	isa          => 'ArrayRef'
	, is         => 'ro'
	, lazy       => 1
	, default    => sub { [] }
	, predicate  => 'has_info'
	, auto_deref => 1
);

has 'dom_level' => (
	isa       => 'Str'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_dom_level
);

sub get_dom_level {
	my $self = shift;

	my $src = $self->src;

	my $dom = ( $src =~ s/ {6}//g );

	$dom += 1;

	$dom;

}

sub add_info_row {
	my ( $self, $src ) = @_;

	my $t = PSQL::Query::Token::Row::OperationInfo->new({
		src => $src
	});

	push @{ $self->info }, $t;

}

sub pop_info {
	my $self = shift;
	pop @{$self->info};
}

sub shift_info {
	my $self = shift;
	shift @{$self->info};
}

sub get_cost {
	my $self = shift;

	$self->src =~ /\((cost.*?)\)/;

	my $t = PSQL::Query::Token::Operation::Cost->new({ src => $1 });

	$t;

}

sub get_time {
	my $self = shift;

	$self->src =~ /\((actual.*?)\)/;

	my $t = PSQL::Query::Token::Operation::Time->new({ src => $1 });

	$t;

}

1;
