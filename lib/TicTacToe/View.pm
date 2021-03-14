package TicTacToe::View;

=head1 NAME

TicTacToe::View - The TicTacToe View class

=head1 SYNOPSYS

  TicTacToe::View->new();

=head1 DESCRIPTION

The tic-tac-toe view class.

=cut

use Modern::Perl;

use TicTacToe::View::Board;

use Moo;
use namespace::clean;


#------------------------------------------------------------------------------

=head2 board

The L<TicTacToe::View::Board> class.

  my $board = $self->board();

return L<TicTacToe::View::Board>

=cut

has board => (
  is      => 'ro',
  default => sub {
    return TicTacToe::View::Board->new();
  },
);

#------------------------------------------------------------------------------

=head2 printBoard

Printing board supplied into STDIO.

  my $board = $self->printBoard(
    board => L<TicTacToe::Model::Board> # OPTIONAL: Defaults to empty board
  );

return nothing

=cut

sub printBoard {
  my ( $self, %arg ) = @_;

  if ( my $board = $arg{board} ) {

    $self->board->print( data => $board->data() );

    return;
  }

  $self->board->print( data => TicTacToe::Model::Board->new()->data() );

  return;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
