class Music {
SoundFile music;
  
  Music() {
    music = new SoundFile(pretty_amazeing_game.this, "Puzzle-Game_Looping.mp3");
    music.loop(0.9, 1, 1);
  }
  
  void play_music() {
    music.amp(1);
  }
  
  void stop_music() {
    music.amp(0);
  }
}
