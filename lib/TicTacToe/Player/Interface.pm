package TicTacToe::Player::Interface;

=head1 NAME

TicTacToe::Player::Interface - The TicTacToe Player Interface.

=head1 SYNOPSYS

  package Foo {
    use Modern::Perl;

    use Moo;
    use namespace::clean;

    with 'TicTacToe::Player::Interface';

    ...

  };

=head1 DESCRIPTION

The tic-tac-toe player's interface explaining which methods should be implemented
to provide required compatibility with the tic-tac-tow game.

=head2 name

Returns the player name.

  my $player_name = $self->name;

return string

=head2 getPlayFrom

Given a state and available actions, expects one of these available actions to
be returned.

  my $play_action = $self->getPlayFrom(
    state   => $state,
    actions => [ $action1, ... ]
  );

return string

=head2 gameOver

Given a L<TicTacToe::Model::Board> class, updates the player with any details
when the game is about to be closed. This is quite useful for learning agents
that may wish to update the outcomes of the game or reset their steps to a new
start.

  $self->gameOver( L<TicTacToe::Model::Board> );

return string

=head2 xo

Required to be supplied at instantiation to set which choice player made if 
playing as X or as O. It does not accept other values and will die if none is
supplied at instantiation.

  my $xo = $self->xo();

return string

=cut

use Modern::Perl;

use Moo::Role;
use namespace::clean;

requires qw{
  name
  xo
  getPlayFrom
  gameOver
};

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
