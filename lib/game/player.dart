import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/enemy.dart';
import 'package:spacescape/game/game.dart';

class Player extends SpriteComponent
    with HasGameRef<SpacescapeGame>, CollisionCallbacks {
  final double _speed = 10;
  final Random _random = Random();
  int _score = 0;
  int get score => _score;
  int _health = 100;
  int get health => _health;

  Vector2 getRandomVector() =>
      (Vector2.random(_random) - Vector2(0.5, -1)) * 200;

  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
          sprite: sprite,
          position: position,
          size: size,
        );

  @override
  Future<void>? onLoad() {
    add(CircleHitbox(anchor: Anchor.center, position: size / 2, radius: 30));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.joystick.direction != JoystickDirection.idle) {
      position.add(gameRef.joystick.delta * _speed * dt);
      position.clamp(Vector2.zero() + size / 2, gameRef.size - size / 2);
    }

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone() + Vector2(0, size.y / 3),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
    gameRef.add(particleComponent);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      gameRef.camera.shake(intensity: 20);
      _health -= 10;
      if (health < 0) {
        _health = 0;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void addToScore(int points) {
    _score += points;
  }

  void reset() {
    _score = 0;
    _health = 100;
    position = gameRef.canvasSize / 2;
  }
}
