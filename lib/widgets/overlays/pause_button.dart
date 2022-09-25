import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/widgets/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String id = "PauseButton";
  final SpacescapeGame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        child: const Icon(
          Icons.pause_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.remove(PauseButton.id);
          gameRef.overlays.add(PauseMenu.id);
        },
      ),
    );
  }
}
