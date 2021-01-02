package TicTacToe::Player::RandomAgent;

=head1 NAME

TicTacToe::Player::RandomAgent - The TicTacToe Player RandomAgent.

=head1 SYNOPSYS

  my $random_agent_player = TicTacToe::Player::RandomAgent->new(
    name => 'Player 1',
  );  

=head1 DESCRIPTION

Implementing the Player interface for a random selecting action agent.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

with 'TicTacToe::Player::Interface';

#------------------------------------------------------------------------------

=head2 _player_name

PRIVATE

The player name.

  my $self->_player_name;

return string

=cut

has _player_name => ( is => 'ro', required => 1 );

#------------------------------------------------------------------------------

=head2 new

  TicTacToe::Player::RandomAgent->new(
    name => 'Player 1',
  );  

=cut

sub BUILDARGS {
  my ( $class, %arg ) = @_;

  return {
    _player_name => $arg{name},
  };
}

#------------------------------------------------------------------------------

=head2 name

See L<TicTacToe::Player::Interface/name>

=cut

sub name { return $_[0]->_player_name }

#------------------------------------------------------------------------------

=head2 getPlayFrom

See L<TicTacToe::Player::Interface/getPlayFrom>

=cut

sub getPlayFrom {
  my ( $self, %arg ) = @_;

  my $state   = $arg{state} // '';
  my @actions = @{ $arg{actions} // [] };

  my $selected_action = $actions[ int( rand() * $#actions ) ];

  return $selected_action;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
