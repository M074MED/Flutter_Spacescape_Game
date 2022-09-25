class Settings {
  bool _sfx = true;
  bool get soundEffects => _sfx;
  set soundEffects(bool value) => _sfx = value;
  
  bool _bgMusic = true;
  bool get backgroundMusic => _bgMusic;
  set backgroundMusic(bool value) => _bgMusic = value;
}
