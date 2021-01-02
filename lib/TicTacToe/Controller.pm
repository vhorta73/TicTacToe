package TicTacToe::Controller;

=head1 NAME

TicTacToe::Controller - The TicTacToe Controller class

=head1 SYNOPSYS

  TicTacToe::Controller->new();

=head1 DESCRIPTION

The tic-tac-toe controller class.

=cut

use Modern::Perl;

use TicTacToe::View;
use TicTacToe::Model::Board;

use Moo;
use namespace::clean;


#------------------------------------------------------------------------------

=head2 view

The L<TicTacToe::View> class.

  my $view = $self->view();

return L<TicTacToe::View>

=cut

has view => (
  is      => 'ro',
  default => sub {
    return TicTacToe::View->new();
  },
  handles => [qw{ board }],
);

#------------------------------------------------------------------------------

=head2 showBoard

Given the game data to display, it calls respective view to process given data
and print it on the STDIO.

  $self->showBoard( %game );

return nothing

=cut

sub showBoard {
  my ( $self, %game ) = @_;

  $self->board->show( data => \%game );

  return;
}

#------------------------------------------------------------------------------

=head2 hasWinner

Returns -1, 0 or 1 for tie, no winner yet or winner found respectively. For more
information, please see L<TicTacToe::Model::Board/winner>.

  my $winner_value = $self->hasWinner( %game );

return Number

=cut

sub hasWinner {
  my ( $self, %game ) = @_;

  my $board_model = TicTacToe::Model::Board->new( %game );

  return $board_model->winner;
}

#------------------------------------------------------------------------------

=head2 play

Given a player and the game data as it is known, returns the updated game data
with the selected action played.

  my %game = $self->play(
    player => L<TicTacToe::Player::Interface>, # REQUIRED
    game   => $game,                           # REQUIRED: Hash ref
  );

return hash 

=cut

sub play {
  my ( $self, %arg ) = @_;
  
  my %game        = %{ $arg{game} };
  my $player      = $arg{player};
  my $board_model = TicTacToe::Model::Board->new( %game );
  my $actions     = $board_model->availableActions();
  my $state       = $board_model->state();

  # Give up play if no actions available.
  return %game unless scalar @$actions;

  my $action_selected = $player->getPlayFrom( 
    state   => $state,
    actions => $actions,
  );

  return ( %game,
    $action_selected => $player->name,
  );
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
