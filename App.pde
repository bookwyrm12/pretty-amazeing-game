class App {
  float deltaTime = 0;
  float _timeLast = 0;
  float _timeMouseClicked = 0;
  boolean _wasMouseClicked = false;
  boolean _wasKeyPressedW = false;
  boolean _wasKeyPressedA = false;
  boolean _wasKeyPressedS = false;
  boolean _wasKeyPressedD = false;
  
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
    // Reset key presses because onKeyPress() will be triggered before preTick()
    _wasKeyPressedW = false;
    _wasKeyPressedA = false;
    _wasKeyPressedS = false;
    _wasKeyPressedD = false;
  }
  
  void onKeyPress(char key, int keyCode) {
    if (key == 'w') {
      _wasKeyPressedW = true;
    } else if (key == 'a') {
      _wasKeyPressedA = true;
    } else if (key == 's') {
      _wasKeyPressedS = true;
    } else if (key == 'd') {
      _wasKeyPressedD = true;
    }
    
    // Yeah, this next part is a bit of a hack...
    if (key == CODED) {
      if (keyCode == UP) {
        _wasKeyPressedW = true;
      } else if (keyCode == LEFT) {
        _wasKeyPressedA = true;
      } else if (keyCode == DOWN) {
        _wasKeyPressedS = true;
      } else if (keyCode == RIGHT) {
        _wasKeyPressedD = true;
      }
    }
  }
  
  // Returns true if mouse button was clicked this frame
  boolean wasMouseClicked() {
    return _wasMouseClicked;
  }
  
  // Returns true if a key was pressed this frame. Only supports WASD
  boolean wasKeyPressed(char key) {
    if (key == 'w') {
      return _wasKeyPressedW;
    } else if (key == 'a') {
      return _wasKeyPressedA;
    } else if (key == 's') {
      return _wasKeyPressedS;
    } else if (key == 'd') {
      return _wasKeyPressedD;
    }
    return false;
  }
  
  Vec2 getMousePos() {
    return new Vec2(mouseX, mouseY);
  }
}
