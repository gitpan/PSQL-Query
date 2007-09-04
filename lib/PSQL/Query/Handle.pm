package PSQL::Query::Handle;
use Moose;

extends 'PSQL::Query';

use IO::Handle;

has 'handle' => (
	isa        => 'IO::Handle'
	, is       => 'ro'
	, required => 1
);

sub BUILD {
	my $self = shift;
	$self->get_rows
}

sub get_rows {
	my $self = shift;

	my $h = $self->handle;

	my @lines = $h->getlines;

	chomp @lines;

	## Preprocess
	## Shift off the header
	until ( (shift @lines) =~ /^-+$/ ) { next };

	## ammend the lack of consistancy with the first row
	$lines[0] = "-> $lines[0]";
	foreach ( @lines[1..$#lines] ) {
		$_ = "   $_";
	}

	my $row;
	foreach my $line ( @lines ) {
		chomp $line;

		next unless $line =~ /\S/;
		## Operation
		if ( $line =~ /[.]{2}/ and $line !~ /:/ ) {

			$row = PSQL::Query::Token::Row::Operation->new({
				src => $line
			});
			$self->push_row( $row );

		}

		## Footer Rows
		elsif ( $line =~ /^\s*Total runtime:\s+\d+\.\d+\s*ms$/ ) {}
		elsif ( $line =~ /^\(\d+ rows\)$/ ) {}

		## OperationalInfo
		elsif ( $line !~ /^\s*->/ ) {
			$row->add_info_row( $line )
		}

	}

}

1;
