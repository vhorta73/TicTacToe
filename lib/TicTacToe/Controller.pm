package TicTacToe::Controller;

=head1 NAME

TicTacToe::Controller - The TicTacToe Controller class

=head1 SYNOPSYS

  TicTacToe::Controller->new();

=head1 DESCRIPTION

The tic-tac-toe controller class.

=cut

use Modern::Perl;
use Ref::Util qw{ is_arrayref };

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
  handles => [qw{ printBoard }],
);

#------------------------------------------------------------------------------

=head2 players

The array ref of L<TicTacToe::Player::Interface> classes.

  my $players = $self->players();

return Array ref

=cut

has players => (
  is      => 'ro',
  isa     => sub {
    die "Must supply an array ref of TicTacToe::Player classes. "
      unless is_arrayref( $_[0] )
        and scalar @{ $_[0] }
        and ref( $_[0]->[0] ) =~ m/^TicTacToe::Player::/;
  },
  required => 1,
);

#------------------------------------------------------------------------------

=head2 showBoard

Given the game data to display, it calls respective view to process given data
and print it on the STDIO.

  $self->showBoard( L<TicTacToe::Model::Board> );

return nothing

=cut

sub showBoard {
  my ( $self, $game_board ) = @_;

  if ( $game_board ) {
    $self->printBoard( board => $game_board );
  }
  else {
    $self->printBoard();
  }
  
  return;
}

#------------------------------------------------------------------------------

=head2 isGameOver

Returns 1 if there are no more plays or if there is a winner, and 0 oterhwise.

  if ( $self->isGameOver( L<TicTacToe::Model::Board> );

return Boolean

=cut

sub isGameOver {
  my ( $self, $board_model ) = @_;

  my $available_actions = scalar @{ $board_model->availableActions() };

  # A winner is found, game over.
  if ( $board_model->hasAWinner ) {
    $self->tellPlayers( $board_model );
    return 1;
  }

  # No winner and players still have available actions..
  return 0 if $available_actions;

  # No winner, no more available actions, it is a tie!
  $self->tellPlayers( $board_model );

  return 1;
}

#------------------------------------------------------------------------------

=head2 getWinner

Returns the winning player or undef.

  my $winner = $self->getWinner( L<TicTacToe::Model::Board> );

return L<TicTacToe::Player::Interface> or undef

=cut

sub getWinner {
  my ( $self, $board_model ) = @_;

  return $board_model->getWinner;
}

#------------------------------------------------------------------------------

=head2 play

Given a player and the game data as it is known, returns the updated game data
with the selected action played.

  my %game = $self->play(
    player      => L<TicTacToe::Player::Interface>, # REQUIRED
    game_board  => L<TicTacToe::Model::Board>,      # OPTIONAL: Defaults to empty board
  );

return L<TicTacToe::Model::Board>

=cut

sub play {
  my ( $self, %arg ) = @_;
  
  my $board_model = $arg{game_board} // TicTacToe::Model::Board->new();
  my $player      = $arg{player};
  my $actions     = $board_model->availableActions();
  my $state       = $board_model->state();

  # Give up play if no actions available.
  return $board_model unless scalar @$actions;

  my $reward = $board_model->isWinner( $player ) ? 1 : 0;

  my $action_selected = $player->getPlayFrom( 
    state       => $state,
    actions     => $actions,
    reward      => $reward,
  );

  return TicTacToe::Model::Board->new(
    %{ $board_model->data() }, 
    $action_selected => $player->xo,
  );
}

#------------------------------------------------------------------------------

=head2 tellPlayers

Updating all players that the game is over, with the current board model set by
L<TicTacToe::Model::Board>

  $self->tellPlayers( L<TicTacToe::Model::Board> );

return nothing

=cut

sub tellPlayers {
  my ( $self, $board_model ) = @_;

  foreach my $player ( @{ $self->players } ) {
    $player->gameOver( $board_model );
  }
 
  return;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
