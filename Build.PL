use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new( 
  module_name     => 'TicTacToe',
  license         => 'perl',
  test_files      => [
    't/TicTacToe/Model',
  ],
)->create_build_script;
