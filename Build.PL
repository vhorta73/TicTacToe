use Module::Build;
# See perldoc Module::Build for details of how this works

my $build = Module::Build->new( 
  module_name     => 'TicTacToe',
  license         => 'perl',
  test_files      => [
    't/TicTacToe/Model',
  ],
  requires => { 'RLearn' => '1.00', },
);

$build->dispatch( 'build' );
$build->dispatch( 'test', verbose => 1 );
$build->dispatch( 'install' );
