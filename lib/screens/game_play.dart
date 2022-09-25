import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/widgets/overlays/game_over_menu.dart';
import 'package:spacescape/widgets/overlays/pause_button.dart';
import 'package:spacescape/widgets/overlays/pause_menu.dart';

SpacescapeGame _spacescape = SpacescapeGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: _spacescape,
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, SpacescapeGame gameRef) =>
                PauseButton(gameRef: gameRef,),
            PauseMenu.id: (BuildContext context, SpacescapeGame gameRef) =>
                PauseMenu(gameRef: gameRef,),
            GameOverMenu.id: (BuildContext context, SpacescapeGame gameRef) =>
                GameOverMenu(gameRef: gameRef,),
          },
        ),
      ),
    );
  }
}
