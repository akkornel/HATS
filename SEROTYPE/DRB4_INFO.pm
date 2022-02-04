#!/usr/bin/perl -w

# Author: Kazutoyo Osoegawa, Ph.D.
# Developed at Stanford Blood Center
# email: kazutoyo@stanford.edu
# phone: 650-724-0169

# module: DRB4_INFO.pm 
# This module was developed to convert HLA allele to HLA serotype
# last modified and documented on December 16 2019

package DRB4_INFO;
use strict;

my @dr53 = (9, 10, 11, 12, 13);

my %dr53;
my %group;
my %base;
$dr53{"DR53"} = "HLA00905";		# DRB4*01:01:01:01
$group{"DR53"} = "DR53";
$base{"DR53"} = "DR53";


my @subtype = ();	# modify here if serotype modified

sub DRB4 {
	my $gene = "DRB4";
	return $gene;
}

sub DRB4_LEADER {
	my $leader = 28;		# DRB4 specific
	return $leader;
}

sub GROUP {
	my $group_ref = \%group;
	return $group_ref;
}

sub BASE {
	my $base_ref = \%base;
	return $base_ref;
}

sub BASETYPE {
	my @basetype = ("DR53");

	my $basetype_ref = \@basetype;
}

sub BROAD {
	my %broad;
	foreach my $base ( keys %base ) {
		$broad{ $base } = $base{ $base };
	}
	my $broad_ref = \%broad;
	return $broad_ref;
}

sub RESIDUES {
	my ( $serotype ) = @_;
	my @combined = ();
	push @combined, @dr53;
	my %seen;
	my @unique;
	foreach my $value ( sort { $a <=> $b } @combined ) {
		unless ( exists $seen{ $value } ) {
			push @unique, $value;
			$seen{ $value } = 0;
		}
	}
	
	my @residues = ();
	my $residues_ref = \@residues;
	if ( $serotype eq "DR53" ) {
		@residues = @dr53;
	}
	else {
		@residues = @unique;
	}
	return $residues_ref;
}

sub REF {
	my ( $serotype ) = @_;
	my %ref;
	my $ref_ref = \%ref;

	if ( $serotype eq "DR53" ) {
		%ref = %dr53;
	}
	else {
		%ref = (%dr53);
	}
	
	return $ref_ref;
}

sub SERO {
	my @sero;
	my %ref = (%dr53);
	my @tmp = sort keys %ref;
	for ( my $index = 0; $index < scalar @tmp; $index++ ) {
		$sero[0][$index] = $tmp[$index];
	}
	for ( my $index = 0; $index < scalar @subtype; $index++ ) {
		$sero[1][$index] = $subtype[$index];
	}
	my $sero_ref = \@sero;
	return $sero_ref;
}

sub KEY {
	my %tmp = (%dr53);
	my %ref;
	my $key_ref = \%ref;
	for my $key ( sort keys %tmp ) {
		if ( $key =~ /DR53/ ) {
			$ref{$key} = "DRB4\\*";
		}
	}
	return $key_ref;

}

sub PARTIAL {		# partial sequence
	my %partial;
	my $partial_ref = \%partial;
	my $seq = "N" x 34;
		
	return $partial_ref;
}


1;
