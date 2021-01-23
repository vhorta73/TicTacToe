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

use TicTacToe::Interactive::InputKeyReader qw{ getOneKey };
use TicTacToe::Controller;
use TicTacToe::View;

use Moo;
use namespace::clean;


#------------------------------------------------------------------------------

=head2 run

Runs the game with a list of player class implementations. If a winner is found,
the winning player name is returned, otherwise, in case of a tie, undef is returned.
If the interactive option is set to FALSE, the game will run without displaying
any game results.

  my $winner = $self->run(
    players => [
      L<TicTacToe::Player::Interface>, 
      L<TicTacToe::Player::Interface>,
    ]
    options => {
      interactive => 1,               # OPTIONAL: Default to 1
    },
  );

return String or undef

=cut

sub run {
  my ( $self, %arg ) = @_;

  my $players = $arg{players};
  my $options = $arg{options};

  # Only players if two players are supplied.
  return unless @$players == 2;

  my $interactive = $options->{interactive} // 1;

  my $controller = TicTacToe::Controller->new(
    view    => TicTacToe::View->new(),
    players => $players,
  );

  my ( $player, $player_index, $end_game, $winner );
  
  my %game = map { $_ => '', } ( 1 .. 9 );

  $controller->showBoard( %game ) if $interactive;

  do {
    $player_index = $self->_nextPlayerIndex( $player_index );
    $player       = $players->[ $player_index ];

    %game = $controller->play( 
      player      => $player,
      game        => \%game,
      interactive => $interactive,
    );

    $controller->showBoard( %game ) if $interactive;
 
  } until ( $controller->isGameOver( %game ) );

  my $winning_player_name = $controller->getWinner( %game );

  if ( $interactive ) {
    if ( $winning_player_name ) {
      print "Player " . $winning_player_name . " has won!!\n";
    }
    else {
      print "It was a tie!\n";
    }

    print "Please press any key to continue . . .\n";
    getOneKey();
  } 
  
  return $winning_player_name;
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
