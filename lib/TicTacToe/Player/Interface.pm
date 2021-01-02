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

=cut

use Modern::Perl;

use Moo::Role;
use namespace::clean;

requires qw{
  name
  getPlayFrom
};

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
