package TicTacToe::Interactive::InputKeyReader;

=head1 NAME

TicTacToe::Interactive::InputKeyReader - Input key reader

=head2 SYNOPSIS

  package Foo {
    use Modern::Perl;
    
    use TicTacToe::Interactive::InputKeyReader qw{ prompt };

    use Moo;
    use namespace::clean;
    

    sub ... {
      my ( $self ) = @_;
      
      my $typed_key = prompt( "Press [Q]uit [C]ontinue...", ['q', 'Q', 'c', 'C' ] );
      ...
    }

=head1 DESCRIPTION

Class knowing how to read keys pressed by the user.

=cut

use Modern::Perl;
use Term::ReadKey; 

use Moo;
use namespace::clean;

extends 'Exporter';

our @EXPORT_OK = qw{
  getOneKey
};


#-------------------------------------------------------------------------------

=head2 getOneKey

Returns the last char value for the key pressed as an integer.

  my $key_value = getOneKey();

return number

=cut

sub getOneKey {
  ReadMode('cbreak'); 

  $|=1;
  
  my $key_value = _getKeyValueFor( ReadKey( 0 ) );

  ReadMode('normal');

  return $key_value;
}

#-------------------------------------------------------------------------------

=head2 _getKeyValueFor

PRIVATE

For a given char, returns the respective ord. It also skips any special chars 
composed by more than one read key, returning the final value as unique.

  my $key_value = _getKeyValueFor( $char );

return number

=cut

sub _getKeyValueFor {
  my ( $char ) = @_;

  # Special chars line arrow and ESC, start with ord 27.
  $char = ReadKey( 0 ) if ord( $char ) == 27;

  # Special chars like arrow have ord 91 as second buffered char.
  $char = ReadKey( 0 ) if ord( $char ) == 91;

  # When all expections are dealt with, return ord of what is left.
  return ord( $char );
}

#-------------------------------------------------------------------------------
1;
#===============================================================================
__END__
#===============================================================================
