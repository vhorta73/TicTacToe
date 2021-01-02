package TicTacToe::Game;

=head1 NAME

TicTacToe::Game - The Main TicTacToe class

=head1 SYNOPSYS

  my $winner = TicTacToe::Game->new()->run( 
    L<TicTacToe::Player::Interface>, 
    L<TicTacToe::Player::Interface>, 
  );

=head1 DESCRIPTION

The tic-tac-toe game, open for Reinforcement Learning experimentations. At the 
instantiation point. Only two players allowed and most implement the respective
interface: L<TicTacToe::Player::Interface>. The players array ref list should 
have at the first index the player that is to play first.

The winner implementation is returned or none if a tie.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;


#------------------------------------------------------------------------------

=head2 run

Runs the game with a list of player class implementations. If a winner is found,
the winning class is returned, otherwise, in case of a tie, undef is returned.

  my $winner = $self->run( 
    L<TicTacToe::Player::Interface>, 
    L<TicTacToe::Player::Interface> 
  );

return L<TicTacToe::Player::Interface> or undef

=cut

sub run {
  my ( $self, @players ) = @_;

  # Only playes if two players are supplied.
  return unless @players == 2;

  my $controller = TicTacToe::Controller->new(
    view => TicTacToe::View->new(),
  );

  my ( $player, $player_index, $end_game );
  
  my %game = map { $_ => '', } ( 1 .. 9 );
  $controller->showBoard( %game );

  do {
    $player_index = $self->_nextPlayerIndex( $player_index );
    $player       = $players[ $player_index ];

    %game = $controller->play( 
      player => $player,
      game   => \%game,
    );

    $controller->showBoard( %game );

    $end_game = $controller->hasWinner( %game );

  } until ( $end_game );

  return $end_game == 1 ? $player : undef ;
}

#------------------------------------------------------------------------------

=head2 _nextPlayerIndex

PRIVATE

Toggles between 0 and 1 from the 0 or 1 index supplied. If no index is supplied, 
defaults to 0.

  my $next_player_index = $self->_nextPlayerIndex( $current_index );

return number

=cut

sub _nextPlayerIndex {
  my ( $self, $current_index ) = @_;
 
  return $current_index ? 0 : 1
    if defined $current_index;

  return 0;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
