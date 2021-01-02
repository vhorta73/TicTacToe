package TicTacToe::Model::Board;

=head1 NAME

TicTacToe::Model::Board - The TicTacToe Board model class

=head1 SYNOPSYS

  TicTacToe::Model::Board->new(
    7 => 'O',   8 => '',   9 => 'O',
    4 => 'X',   5 => '',   6 => '',
    1 => 'X',   2 => '',   3 => '',
  );

=head1 DESCRIPTION

The tic-tac-toe board model class, which once instantiated with all the board
data, it can answer many questions.

Board data supplied is expected to come represented with following cell numbers:

    +---+---+---+
    | 7 | 8 | 9 |
    +---+---+---+
    | 4 | 5 | 6 |
    +---+---+---+
    | 1 | 2 | 3 |
    +---+---+---+

=cut

use Modern::Perl;
use Const::Fast;
use List::Util qw{ max sum };

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
    7 => $cell_7_value, # OPTIONAL: String, defaults to empty string.
    8 => $cell_8_value, # OPTIONAL: String, defaults to empty string.
    9 => $cell_9_value, # OPTIONAL: String, defaults to empty string.
    4 => $cell_4_value, # OPTIONAL: String, defaults to empty string.
    5 => $cell_5_value, # OPTIONAL: String, defaults to empty string.
    6 => $cell_6_value, # OPTIONAL: String, defaults to empty string.
    1 => $cell_1_value, # OPTIONAL: String, defaults to empty string.
    2 => $cell_2_value, # OPTIONAL: String, defaults to empty string.
    3 => $cell_3_value, # OPTIONAL: String, defaults to empty string.
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

Returns 1 if there is a winning player, 0 if no winner yet.. and -1 if not first
possible plays and no winner.

  if ( $self->winner() ) { .. 

return Number

=cut

sub winner {
  my ( $self ) = @_;

  # Going over all possible winning combinations.
  foreach my $cells ( @WINNING_CELLS ) {

    # The given list of $cells must have same values to be a winning position.
    my %same_values;
    foreach my $cell ( @$cells ) {
      my $player = $self->_data->{ $cell };

      # If the cell does not have data, then it is not yet played 
      # and thus impossible win in this cell group.
      last if ( $player // '' ) eq '';

      $same_values{ $player }++;
    }

    # No keys set on %same_value, means nothing played in this group of cells
    next unless keys %same_values;

    # Plays happened in these 3 $cells from the same player. 
    return 1 if max( values %same_values ) == 3;
  }

  return -1 unless scalar @{ $self->availableActions() };
 
  return 0;
}

#------------------------------------------------------------------------------

=head2 state

Returns the board state as it is seen now.

  my $state = $self->state();

return string

=cut

sub state {
  my ( $self ) = @_;

  return join( ',', values %{ $self->_data } ); 
}

#------------------------------------------------------------------------------

=head2 availableActions

Returns the list of available plays that be done on the board as it is now.

  my $available_actions = $self->availableActions();

return array ref

=cut

sub availableActions {
  my ( $self ) = @_;

  return [ grep { $self->_data->{ $_ } eq '' } keys %{ $self->_data } ]; 
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
