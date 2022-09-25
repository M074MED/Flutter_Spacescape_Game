import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spacescape/screens/settings_menu.dart';

class AudioPlayerComponent extends Component {
  late AudioPool fire;
  late AudioPool kill;

  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      "laser.ogg",
      "laserSmall.ogg",
      "SpaceInvaders.wav",
    ]);

    fire = await AudioPool.create("audio/laserSmall.ogg", maxPlayers: 9999999);
    kill = await AudioPool.create("audio/laser.ogg", maxPlayers: 9999999);

    return super.onLoad();
  }

  void playBgm(String fileName) {
    if (settings.backgroundMusic) {
      FlameAudio.bgm.play(fileName);
    }
  }

  void playSfx(String fileName) {
    if (settings.soundEffects) {
      // FlameAudio.play(fileName);
      switch (fileName) {
        case "laserSmall.ogg":
          fire.start();
          break;
        case "laser.ogg":
          kill.start();
          break;
        default:
      }
    }
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
