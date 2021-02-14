package TicTacToe::Player::Human;

=head1 NAME

TicTacToe::Player::Human - The TicTacToe Player Human.

=head1 SYNOPSYS

  my $human_player = TicTacToe::Player::Human->new(
    name => 'Player 1',
  );  

=head1 DESCRIPTION

Implementing the Player interface for a human selecting action.

=cut

use Modern::Perl;

use TicTacToe::Interactive::InputKeyReader qw{ getOneKey };

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
    _player_name => $arg{name},
    xo           => $arg{xo},
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

  my $selected_action = $self->_selectAction( \@actions );
  
  return $selected_action;
}

#------------------------------------------------------------------------------

=head2 _selectAction

Given a list of actions, prompts the user to select one of the actions in the 
list. The question will remain asked until the user presses a valid key.

  my $selected_action = $selef->_selectAction( [ $action1, ... ] );

return string

=cut

sub _selectAction {
  my ( $self, $actions ) = @_;

  print join( '', 
    "Player ",
    $self->name,
    ", please select one of the available actions: [ ",
    join( ', ', @$actions ),
    " ]: "
  ); 

  my $selected_action;

  do {
    $selected_action = chr( getOneKey() );
  } until ( grep { $selected_action eq $_ } @$actions );

  print "\n";

  return $selected_action;
}

#------------------------------------------------------------------------------

=head2 gameOver

See L<TicTacToe::Player::Interface/gameOver>

Noop

=cut

sub gameOver { return; }

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
