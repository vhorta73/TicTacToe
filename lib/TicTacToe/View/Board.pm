package TicTacToe::View::Board;

=head1 NAME

TicTacToe::View::Board - The TicTacToe Board view class

=head1 SYNOPSYS

  my $view_board = TicTacToe::View::Board->new();

  $view_board->show( %data );

=head1 DESCRIPTION

The tic-tac-toe view class knowing how to display the game based on the data
supplied. Main method is L</show> and will work as follows:

  $self->show( 
    data => {
      7 => '',  8 => 'X', 9 => '',
      4 => '',  5 => '',  6 => '',
      1 => 'O', 2 => 'X', 3 => '',
    },
  );

Displays:

    +---+---+---+
    |   | X |   |
    +---+---+---+
    |   |   |   |
    +---+---+---+
    | O | X |   |
    +---+---+---+


=cut

use Modern::Perl;
use Const::Fast;

use Moo;
use namespace::clean;

const my $COLUMN_SEPARATOR => "|";
const my $ROW_SEPARATOR    => "-";
const my $JOIN_CHAR        => "+";
const my @GAME_STRUCTURE   => (
  [ 7, 8, 9 ],
  [ 4, 5, 6 ],
  [ 1, 2, 3 ],
);

#------------------------------------------------------------------------------

=head2 show

Displays to terminal the tic-tac-toe board updated with the given data. If no
data is supplied, nothing is done. Data structure is expected as follows:

  $self->show( 
    data => {
      7 => '',  8 => 'X', 9 => '',
      4 => '',  5 => '',  6 => '',
      1 => 'O', 2 => 'X', 3 => '',
    },
    size => 1,
  );

to display:

    +---+---+---+
    |   | X |   |
    +---+---+---+
    |   |   |   |
    +---+---+---+
    | O | X |   |
    +---+---+---+

return nothing

=cut

sub show {
  my ( $self, %arg ) = @_;

  my %data = %{ $arg{data} // return };

  return unless keys %data == 9;

  my $size = $arg{size} || 1;

  my @print_lines;
  push @print_lines, $self->_row_separator( $size );
  
  foreach my $row ( @GAME_STRUCTURE ) {
    push @print_lines, $self->_empty_line( $size ) for ( 1 .. $self->_extra_line( $size ) );
    push @print_lines, $self->_data_line( $row, \%data, $size );
    push @print_lines, $self->_empty_line( $size ) for ( 1 .. $self->_extra_line( $size ) );
    push @print_lines, $self->_row_separator( $size );
  }  

  print join( "\n", @print_lines ) . "\n";

  return;
}

#------------------------------------------------------------------------------

=head2 _row_separator

PRIVATE

The string line that separates rows. The size of the separator can be supplied 
for the number of extra spaces required. Defaults to 1.

  my $row_separator = $self->_row_separator( 1 );

return string

=cut

sub _row_separator { 
  my ( $self, $size ) = @_;

  my $spacing = ( $size // 0 ) > 0 
    ? $size 
    : 1;

  my $half_size = $size / 2;

  return $JOIN_CHAR . 
    ( $ROW_SEPARATOR x $half_size . 
      $ROW_SEPARATOR x 3 . 
      $ROW_SEPARATOR x $half_size . 
      $JOIN_CHAR 
    ) x 3; 
}

#------------------------------------------------------------------------------

=head2 _empty_line

PRIVATE

Returns an empty line for the size given. Default to size 0.

  my $extra_lines = $self->_extra_line( $size );

return Number

=cut

sub _empty_line {
  my ( $self, $size ) = @_;

  my $half_size = ( $size // 0 ) / 2;
  my $cell_str  = ' ' x $half_size . '   ' . ' ' x $half_size;
  my @line      = ( $cell_str, $cell_str, $cell_str );

  return $self->_build_line( @line );
}

#------------------------------------------------------------------------------

=head2 _extra_line

PRIVATE

Returns the number of extra lines required for supplied size. Defaults to 0.

  my $extra_lines = $self->_extra_line( $size );

return Number

=cut

sub _extra_line {
  my ( $self, $size ) = @_;
  return int( ( $size // 0 ) / 4 );
}

#------------------------------------------------------------------------------

=head2 _data_line

Builds the data line to be displaying based on the row it is refered to and the
data originally supplied. It selects the respective data and builds respective
row for the supplied size.

  my $printing_line = $self->_data_line(
    $row,   # REQUIRED: Array ref of three numbers e.g. [ 1, 2, 3 ]
    $data,  # REQUIRED: Hash ref for the data to display, e.g.: { 1 => 'X', .. }
    $size,  # OPTIONAL: Defaults to 1.
  );

return string

=cut

sub _data_line {
  my ( $self, $row, $data, $size ) = @_;

  my $spacing = ( $size // 0 ) > 0 
    ? $size 
    : 1;

  my $half_size  = $size / 2;
  my $empty_line = ' ' x $half_size . '   ' . ' ' x $half_size;
  my $extra_line = int( $size / 3 );

  my @data = map { $_ 
    ? ' ' x $half_size . " $_ ". ' ' x $half_size 
    : $empty_line
  } $data->@{ @$row };

  return $self->_build_line( @data );
}

#------------------------------------------------------------------------------

=head2 _build_line

PRIVATE 

Given a list of elements, fits them into the row separated by the respective
chars.

  my $line = $self->_build_line( String, String, String ... );

return string

=cut

sub _build_line {
  my ( $self, @data ) = @_;
  return $COLUMN_SEPARATOR . join ( $COLUMN_SEPARATOR, @data ) . $COLUMN_SEPARATOR;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
