import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/audio_player_component.dart';
import 'package:spacescape/game/bullet.dart';
import 'package:spacescape/game/command.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/game/player.dart';

class Enemy extends SpriteComponent
    with HasGameRef<SpacescapeGame>, CollisionCallbacks {
  final double _speed = 250;
  final Random _random = Random();

  Vector2 getRandomVector() =>
      (Vector2.random(_random) - Vector2.random(_random)) * 500;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
          sprite: sprite,
          position: position,
          size: size,
        ) {
    angle = pi;
  }

  @override
  Future<void>? onLoad() {
    add(CircleHitbox(anchor: Anchor.center, position: size / 2, radius: 30));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet || other is Player) {
      removeFromParent();
      gameRef.addCommand(Command<AudioPlayerComponent>(action: (audioPlayer) {
        audioPlayer.playSfx("laser.ogg");
      }));

      final command = Command<Player>(action: (player) {
        player.addToScore(1);
      });
      gameRef.addCommand(command);

      final particleComponent = ParticleSystemComponent(
        particle: Particle.generate(
          count: 10,
          lifespan: 0.1,
          generator: (i) => AcceleratedParticle(
            acceleration: getRandomVector(),
            speed: getRandomVector(),
            position: position.clone(),
            child: CircleParticle(
              radius: 1.5,
              paint: Paint()..color = Colors.white,
            ),
          ),
        ),
      );
      gameRef.add(particleComponent);
    }
    super.onCollision(intersectionPoints, other);
  }
}
