package TicTacToe::Player::RLAgent;

=head1 NAME

TicTacToe::Player::RLAgent - The TicTacToe Player RLAgent.

=head1 SYNOPSYS

  my $rlagent_player = TicTacToe::Player::RLAgent->new(
    name => 'Player 1',
    xo   => 'X',     # REQUIRED: String X or O.
  );  

=head1 DESCRIPTION

Implementing the Player interface for a reinforcement learning agent selecting
action.

=cut

use Modern::Perl;

use RLearn::Agent::Reactive;
use RLearn::Agent::IO::File;

use Moo;
use namespace::clean;

extends qw{ TicTacToe::Player };
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

  TicTacToe::Player::Human->new(
    name => 'Player 1',
  );  

=cut

sub BUILDARGS {
  my ( $class, %arg ) = @_;

  return {
    _player_name => $arg{name} || 'R',
    _agent => RLearn::Agent::Reactive->new(
      io => RLearn::Agent::IO::File->new( file => "tictactoe$arg{name}.txt", delimiter => ' -> ' ),
    ),
    xo => $arg{xo},
  };
}

#------------------------------------------------------------------------------

=head2 BUILD

Loading the agent's data.

return nothing

=cut

sub BUILD {
  my ( $self ) = @_;

  $self->_agent->load();

  return;
}

#------------------------------------------------------------------------------

=head2 name

See L<TicTacToe::Player::Interface/name>

=cut

sub name { return $_[0]->_player_name }

#------------------------------------------------------------------------------

=head2 _agent

PRIVATE

Instantiating the required agent to play.

  my $agent = $self->_agent();

return L<RLearn::Agent::Reactive>

=cut

has _agent => ( 
  is => 'ro',
  default => sub { 
    return RLearn::Agent::Reactive->new(
      io => RLearn::Agent::IO::File->new( file => 'tictactoe.txt', delimiter => ' -> ' ),
    ),
  },
);

#------------------------------------------------------------------------------

=head2 getPlayFrom

See L<TicTacToe::Player::Interface/getPlayFrom>

=cut

sub getPlayFrom {
  my ( $self, %arg ) = @_;

  my $state   = $arg{state} // '';
  my @actions = @{ $arg{actions} // [] };
 
  my $selected_action = $self->_agent->getActionFor( 
    state   => $state,
    actions => \@actions,
  );
  
  return $selected_action;
}

#------------------------------------------------------------------------------

=head2 gameOver

See L<TicTacToe::Player::Interface/gameOver>

Updates the agent with the game outcome.

=cut

sub gameOver {
  my ( $self, $board_model ) = @_;

  my $winner = $board_model->getWinner();
  my $reward = defined $winner 
    ? uc( $self->xo ) eq uc( $winner // '' ) 
      ? 10
      : -10
    : -1; # A tie is not very desireable, but not as bad.

  $self->_agent->updateRewardAtLastIteration( 
    state  => $board_model->state,
    reward => $reward,
  );

  return;
}

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
