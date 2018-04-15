class App {
  float deltaTime = 0;
  float _timeLast = 0;
  float _timeMouseClicked = 0;
  boolean _wasMouseClicked = false;
  
  void preTick() {
    // Update deltaTime
    float time = millis() / 1000.0;
    deltaTime = time - _timeLast;
    _timeLast = time;
    
    // Detect mouse clicks
    _wasMouseClicked = false;
    if (mousePressed && _timeMouseClicked == 0) {
      _timeMouseClicked = time;
      _wasMouseClicked = true;
    }
    if (!mousePressed) {
      _timeMouseClicked = 0;
    }
  }
  
  void postTick() {
  }
  
  // Returns true if mouse button was clicked this frame
  boolean wasMouseClicked() {
    return _wasMouseClicked;
  }
  
  Vec2 getMousePos() {
    return new Vec2(mouseX, mouseY);
  }
}
