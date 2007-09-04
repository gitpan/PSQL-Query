package PSQL::Query;
use Moose;

use PSQL::Query::Token::Row::Operation;

has 'rows_by_dom_depth' => (
	isa       => 'HashRef'
	, is      => 'ro'
	, lazy    => 1
	, default => \&get_rows_by_dom_depth
);

has 'rows_by_query_order' => (
	isa         => 'ArrayRef'
	, is        => 'ro'
	, 'default' => sub { [] }
);

sub shift_row {
	my $self = shift;
	shift @{$self->rows_by_query_order};
}

sub unshift_row {
	my ( $self, $row ) = @_;
	unshift @{$self->rows_by_query_order}, $row;
}

sub pop_row {
	my $self = shift;
	pop @{$self->rows_by_query_order};
}

sub push_row {
	my ( $self, $row ) = @_;
	push @{$self->rows_by_query_order}, $row;
}

sub get_rows_by_dom_depth {
	my $self = shift;

	my $rows = {};

	foreach my $row (@{  $self->rows_by_query_order  }) {

		my $dom_level = $row->dom_level;
		my $name      = $row->name;

		push @{  $rows->{ $dom_level }->{ $name }  }, $row;

	}

	$rows;

}

=head1 NAME

PSQL::Query - A framework to parse pg-query plans via the output of Explain / Explain Analyze

=head1 AUTHOR

Evan Carroll, C<< <me at evancarroll.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Evan Carroll, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
