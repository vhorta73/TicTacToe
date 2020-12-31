package TicTacToe::Model::Board;

=head1 NAME

TicTacToe::Model::Board - The TicTacToe Board model class

=head1 SYNOPSYS

  TicTacToe::Model::Board->new(
    1 => 'X',
    2 => '',
    3 => '',
    4 => 'X',
    5 => '',
    6 => '',
    7 => 'O',
    8 => '',
    9 => 'O',
  );

=head1 DESCRIPTION

The tic-tac-toe board model class, which once instantiated with all the board
data, it can answer many questions.

Board data supplied is expected to come represented with following cell numbers:

    +---+---+---+
    | 1 | 2 | 3 |
    +---+---+---+
    | 4 | 5 | 6 |
    +---+---+---+
    | 7 | 8 | 9 |
    +---+---+---+

=cut

use Modern::Perl;
use Const::Fast;
use List::Util qw{ max };

use Moo;
use namespace::clean;


const my @WINNING_CELLS => (
  [ 1, 2, 3, ],
  [ 4, 5, 6, ],
  [ 7, 8, 9, ],

  [ 1, 4, 7, ],
  [ 2, 5, 8, ],
  [ 3, 6, 9, ],

  [ 1, 5, 9, ],
  [ 3, 5, 7, ],
);

#------------------------------------------------------------------------------

=head2 _data

PRIVATE

The board data as known, represented with cell numbers as keys and respective
cell values as values.

  my $data = $self->_data();

return hash ref

=cut

has _data => ( is => 'ro', required => 1 );

#------------------------------------------------------------------------------

=head2 new

  TicTacToe::Model::Board->new(
    1 => $cell_1_value, # OPTIONAL: String, defaults to empty string.
    2 => $cell_2_value, # OPTIONAL: String, defaults to empty string.
    3 => $cell_3_value, # OPTIONAL: String, defaults to empty string.
    4 => $cell_4_value, # OPTIONAL: String, defaults to empty string.
    5 => $cell_5_value, # OPTIONAL: String, defaults to empty string.
    6 => $cell_6_value, # OPTIONAL: String, defaults to empty string.
    7 => $cell_7_value, # OPTIONAL: String, defaults to empty string.
    8 => $cell_8_value, # OPTIONAL: String, defaults to empty string.
    9 => $cell_9_value, # OPTIONAL: String, defaults to empty string.
  );

=cut

sub BUILDARGS {
  my ( $class, %board_data ) = @_;

  my $arg = {};
  foreach my $cell_key ( 1 .. 9 ) {
    $arg->{_data}->{ $cell_key } = $board_data{ $cell_key } 
      ? $board_data{ $cell_key } 
      : '';
  }

  return $arg;
}

#------------------------------------------------------------------------------

=head2 winner

Returns the value set on the winning cell. Default to empty string otherwise.

  my $winner = $self->winner();

return string

=cut

sub winner {
  my ( $self ) = @_;

  # Going over all possible winning combinations.
  foreach my $cells ( @WINNING_CELLS ) {

    # The given list of $cells must have same values to be a winning position.
    my %same_values;
    foreach my $cell ( @$cells ) {
      my $value = $self->_data->{ $cell };

      # If the cell does not have data, then it is not yet played 
      # and thus impossible win in this cell group.
      last if ( $value // '' ) eq '';

      $same_values{ $value }++;
    }

    # No keys set on %same_value, means nothing played in this group of cells
    next unless keys %same_values;

    # Plays happened in these $cells but do all same values sum up to three? 
    return 1 if max( values %same_values ) == 3;
  }

  return 0;
}


#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
