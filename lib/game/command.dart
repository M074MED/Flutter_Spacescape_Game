import 'package:flame/components.dart';

class Command<T extends Component> {
  void Function(T target) action;

  Command({required this.action});

  void run(Component c) {
    if (c is T) {
      action.call(c);
    }
  }
}
