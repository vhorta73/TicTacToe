<!--START-->
  <p align="center">
    <img align="center" width="60%" src="logo.svg" alt="Logo">
  </p>
  <h1 align="center">Tic - Tac - Toe</h1>
  <h4 align="center"><i>The Tic-tac-toe game written in perl for machine learning investigations.</i></h4>

  <br>
<!--END-->

# Contents
  - [Installation](#installation)
  - [Quick Start](#quick-start)
  - [RLearn Agents](#rlearn-agents)
  - [Extending to other agent players](#extending-to-other-agent-players)
  - [Final Remarks](#final-remarks)

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
  my $game = TicTacToe::Game->new();

  # Playing the game and getting the winner.
  my $winner = $game->run( players => \@players );

  print "... and the winner is: $winner \n";

```

### RLearn Agents

This game was originally build to work with [RLearn](https://github.com/vhorta73/RLearn) project, to aid with the reinforcement learning investigations. To use this module, please first follow installation procedures set [here](https://github.com/vhorta73/RLearn#install).

The following example provides the minimum memory only reinforcement learning agent implementation which will be equivalent to a random agent. 

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
    xo   => 'O' 
  );

  # Tossing the coin on who will play first.
  my @players = rand() > 0.5 
    ? ( $human_player,        $rlearn_agent_player ) 
    : ( $rlearn_agent_player, $human_player        );

  # Instantiating a Tic-tac-toe game.
  my $game = TicTacToe::Game->new();

  # Playing the game and getting the winner.
  my $winner = $game->run( players => \@players );

  print "... and the winer is: $winner \n";

```

To learn how to configure the RL Agent differently and keep past experiences learned saved, please see [RLearn](https://github.com/vhorta73/RLearn#configuration) project for more information.


### Extending to other agent players

TicTacToe project, allows other agent players to be implemented as long as [TicTacToe::Player::Interface](https://github.com/vhorta73/TicTacToe/blob/master/lib/TicTacToe/Player/Interface.pm) interface is followed. The [TicTacToe::Player::RLAgent](https://github.com/vhorta73/TicTacToe/blob/master/lib/TicTacToe/Player/RLAgent.pm) implementation allows for [RLearn::Agent::Reactive](https://github.com/vhorta73/RLearn/blob/master/lib/RLearn/Agent/Reactive.pm) implementations be supplied as follows:

```perl

  use RLearn::Agent::Reactive;
  use TicTacToe::Player::RLAgent;

  my $agent        = RLearn::Agetn::Reactive;
  my $agent_player = TicTacToe::Player::RLAgent->new( agent => $agent );

```

The then supplied RLearn Agent `$agent` will be available for update setting IO, policy, status, etc... which when combined with the Random Agent implementation player, it can run multiple epocs of the game in a non-interactive way as follows:

```perl

  # If not the first time this agent is running, best to first load previously saved data:
  $agent->load();

  # Do many loops until number of epocs are satisfied..
  while ( ... ) {
    my $winner = $game->run(
      players => \@players,
      options => { interactive => 0, },
    );
  }

  # Making sure data is saved into the set IO.
  $agent->save();

```

For more details no how to work with `RLearn` agents, please visit [RLearn Configuration](https://github.com/vhorta73/RLearn#configuration)

## Final remarks

This project was build to provide an `Environment` for reinforcement learning studies and analysis. If any bugs or issues, please raise an issue, and it will be addressed as soon as possible.
