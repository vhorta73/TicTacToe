#!usr//bin/perl 

use Modern::Perl;

use TicTacToe::Model::Board;

use Test::More;
use Test::Exception;

require_ok( 'TicTacToe::Model::Board' );

#-------------------------------------------------------------------------------
# Scripted tests.
my @board_test = (
  { 
    msg         => 'Testing no args',
    init_args   => {}, 
    tests       => [
      { method_name => 'winner', expected => '', },
    ]
  },
  { 
    msg         => 'Testing args with no values set',
    init_args   => {
      7 => '', 8 => '', 9 => '',
      4 => '', 5 => '', 6 => '', 
      1 => '', 2 => '', 3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '', },
    ]
  },
  { 
    msg         => 'Testing no winning with values set',
    init_args   => {
      7 => '1', 8 => '2', 9 => '1',
      4 => '2', 5 => '2', 6 => '1', 
      1 => '1', 2 => '1', 3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '', },
    ]
  },
  { 
    msg         => 'Testing winning first row',
    init_args   => {
      7 => '',  8 => '',  9 => '',
      4 => '',  5 => '',  6 => '', 
      1 => '1', 2 => '1', 3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning second row',
    init_args   => {
      7 => '',  8 => '',  9 => '',
      4 => '1', 5 => '1', 6 => '1', 
      1 => '',  2 => '',  3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning third row',
    init_args   => {
      7 => '1', 8 => '1', 9 => '1',
      4 => '',  5 => '',  6 => '', 
      1 => '',  2 => '',  3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning first column',
    init_args   => {
      7 => '1',  8 => '',  9 => '',
      4 => '1',  5 => '',  6 => '', 
      1 => '1',  2 => '',  3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning second column',
    init_args   => {
      7 => '',  8 => '1',  9 => '',
      4 => '',  5 => '1',  6 => '', 
      1 => '',  2 => '1',  3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning third column',
    init_args   => {
      7 => '',  8 => '',  9 => '1',
      4 => '',  5 => '',  6 => '1', 
      1 => '',  2 => '',  3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning cross down',
    init_args   => {
      7 => '',  8 => '',  9 => '1',
      4 => '',  5 => '1', 6 => '', 
      1 => '1', 2 => '',  3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing winning cross up',
    init_args   => {
      7 => '1', 8 => '',  9 => '',
      4 => '',  5 => '1', 6 => '', 
      1 => '',  2 => '',  3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning first row',
    init_args   => {
      7 => '2', 8 => '2', 9 => '',
      4 => '2', 5 => '',  6 => '2', 
      1 => '1', 2 => '1', 3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning second row',
    init_args   => {
      7 => '',  8 => '',  9 => '2',
      4 => '1', 5 => '1', 6 => '1', 
      1 => '',  2 => '',  3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning third row',
    init_args   => {
      7 => '1', 8 => '1', 9 => '1',
      4 => '',  5 => '2', 6 => '', 
      1 => '2', 2 => '2', 3 => '', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning first column',
    init_args   => {
      7 => '1',  8 => '',  9 => '',
      4 => '1',  5 => '2', 6 => '2', 
      1 => '1',  2 => '',  3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning second column',
    init_args   => {
      7 => '2', 8 => '1',  9 => '',
      4 => '',  5 => '1',  6 => '2', 
      1 => '',  2 => '1',  3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning third column',
    init_args   => {
      7 => '',  8 => '2', 9 => '1',
      4 => '2', 5 => '2', 6 => '1', 
      1 => '2', 2 => '',  3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning cross down',
    init_args   => {
      7 => '2', 8 => '',  9 => '1',
      4 => '',  5 => '1', 6 => '2', 
      1 => '1', 2 => '2', 3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning cross up',
    init_args   => {
      7 => '1', 8 => '2', 9 => '2',
      4 => '2', 5 => '1', 6 => '2', 
      1 => '2', 2 => '2', 3 => '1', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '1', },
    ]
  },
  { 
    msg         => 'Testing combined winning cross up on other player',
    init_args   => {
      7 => '2', 8 => '1', 9 => '1',
      4 => '1', 5 => '2', 6 => '1', 
      1 => '1', 2 => '1', 3 => '2', 
    }, 
    tests       => [
      { method_name => 'winner', expected => '2', },
    ]
  },

);

#-------------------------------------------------------------------------------
# Executing all tests.
foreach my $data ( @board_test ) {
  my $init_args    = $data->{init_args};
  my $tests        = $data->{tests};

  foreach my $test ( @$tests ) {
    my $board       = TicTacToe::Model::Board->new( %$init_args );
    my $method_name = $test->{method_name};
    my $expected    = $test->{expected};
    my $result      = $board->$method_name();
    is_deeply( $result, $expected, $data->{msg} );
  }
}

#-------------------------------------------------------------------------------
done_testing();
#-------------------------------------------------------------------------------
__END__
#-------------------------------------------------------------------------------
