<!--START-->
  <p align="center">
    <img align="center" width="60%" src="images/logo.svg" alt="Logo">
  </p>
  <h1 align="center">Tic - Tac - Toe</h1>
  <h3 align="center"><i>The Tic-tac-toe game written in perl open for machine learning investigations</i></h3>

  <br>
<!--END-->

# Contents
  - [Installation](#installation)
  - [Quick Start](#quick-start)
  - [RLearn Agents](#rlearn-agents)
  - [Extending to other agents](#extending-to-other-agents)

## Installation

One single command line for installation.

```perl
  perl Build.PL
```

### Quick Start

```perl

  use TicTacToe::Game;
  use TicTacToe::Player::RandomAgent;
  use TicTacToe::Player::Human;

  # Instantiating a Human player to become the X.
  my $human_player = TicTacToe::Player::Human->new( 
    name => 'Human', 
    xo   => 'X', 
  );
  
  # Instantiating a Random Agent player to become the O.
  my $random_agent_player = TicTacToe::Player::RandomAgent->new( 
    name => 'Random Agent', 
    xo   => 'O' 
  );

  # Tossing the coin on who will play first.
  my @players = rand() > 0.5 
    ? ( $human_player,        $random_agent_player ) 
    : ( $random_agent_player, $human_player        );

  # Instantiating a Tic-tac-toe game.
  my $game   = TicTacToe::Game->new();

  # Playing the game and getting the winner.
  my $winner = $game->run( players => \@players );

  print "... and the winer is: $winner \n";

```

### RLearn Agents

This game was originally build to work with [RLearn](https://github.com/vhorta73/RLearn) project, to aid with the reinforcement learning investigations. To use this module, please follow the installation procedures [here](https://github.com/vhorta73/RLearn#install), before attempting the below example:

```perl

  use TicTacToe::Game;
  use TicTacToe::Player::RLAgent;
  use TicTacToe::Player::Human;

  # Instantiating a Human player to become the X.
  my $human_player = TicTacToe::Player::Human->new( 
    name => 'Human', 
    xo   => 'X', 
  );

  # Instantiating a RLearn player to become the O.
  my $rlearn_agent_player = TicTacToe::Player::RLAgent->new( 
    name => 'RLAgent', 
    xo => 'O' 
  );

  # Tossing the coin on who will play first.
  my @players             = rand() > 0.5 
    ? ( $human_player,        $rlearn_agent_player ) 
    : ( $rlearn_agent_player, $human_player        );

  # Instantiating a Tic-tac-toe game.
  my $game   = TicTacToe::Game->new();

  # Playing the game and getting the winner.
  my $winner = $game->run( players => \@players );

  print "... and the winer is: $winner \n";

```

### Extending to other agents

