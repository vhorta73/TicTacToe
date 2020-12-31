package TicTacToe;

=head1 NAME

TicTacToe - The TicTacToe build class.

=head1 SYNOPSIS

  perl Build.PL
  Build test
  Build install

=head1 DESCRIPTION

The TicTacToe game.

=head1 DEFINITIONS

=cut

BEGIN {
  use Exporter;
  use vars     qw{ $VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS };
  $VERSION     = '1.00';
  push @ISA,   qw{ Exporter };
 
  @EXPORT      = qw{};
  @EXPORT_OK   = qw{};
  %EXPORT_TAGS = ();
}

#-------------------------------------------------------------------------------
1;
#===============================================================================
__END__
#===============================================================================
