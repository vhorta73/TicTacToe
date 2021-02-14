package TicTacToe::Player;

=head1 NAME

TicTacToe::Player - The TicTacToe Player Abstrace implementation.

=head1 SYNOPSYS

  package Foo {

    use Modern::Perl;

    use Moo;
    use namespace::clean;

    extends qw{ TicTacToe::Player };
    with qw{ TicTacToe::Player::Interface };

    ...
  }

=head1 DESCRIPTION

Implements L<TicTacToe::Player::Interface> methods that are required to be in
sync across all player implementations.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

#------------------------------------------------------------------------------

=head2 xo

See L<TicTacToe::Player::Interface/xo>

Supplying an universal implementation for L<TicTacToe::Player::Interface/io>, 
ensuring the inputs are only X or O and that are set uppercased.

  my $xo = $self->xo();

return string

=cut

has xo => ( 
  is       => 'ro', 
  required => 1,
  isa      => sub {
    die "Not a valid xo value supplied. [$_[0]] Only 'X' or 'O' are accepted"
      unless $_[0] and $_[0] =~ m/^[xo]{1}$/i;
    
    # Ensure X and O are assigned uppercased.
    $_[0] = uc( $_[0] );
  },
);

#------------------------------------------------------------------------------
1;
#------------------------------------------------------------------------------
__END__
#------------------------------------------------------------------------------
