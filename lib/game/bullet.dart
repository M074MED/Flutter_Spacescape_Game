import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spacescape/game/enemy.dart';

class Bullet extends SpriteComponent with CollisionCallbacks {
  final double _speed = 450;

  Bullet({
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
    add(CircleHitbox(anchor: Anchor.center, position: size / 2, radius: 10));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
