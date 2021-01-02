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
  handles => [qw{ show }],
);


#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
