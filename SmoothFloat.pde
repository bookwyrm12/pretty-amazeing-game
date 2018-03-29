class SmoothFloat {
  float value;
  float _targetValue;
  float _startValue;
  float _accumTime;
  float _duration;
  float _direction;
  boolean _loop;
  
  SmoothFloat(float initial, float duration) {
    this.value = initial;
    this._targetValue = initial;
    this._startValue = initial;
    this._accumTime = duration;
    this._duration = duration;
    this._direction = 1;
    this._loop = false;
  }
  
  void animateTo(float target) {
    this._targetValue = target;
    this._startValue = this.value;
    this._accumTime = 0;
    this._direction = 1;
  }
  
  void animateToAndLoop(float target) {
    this.animateTo(target);
    this._loop = true;
  }
  
  void tick(float dt) {
    if (dt == 0) {
      return;
    }
    this._accumTime = max(0, min(this._duration, this._accumTime + dt * this._direction));
    this.value = this._startValue + (this._targetValue - this._startValue) * (this._accumTime / this._duration);
    if (this._loop) {
      if (this._direction > 0 && this._accumTime >= this._duration ||
          this._direction < 0 && this._accumTime <= 0) {
        this._direction *= -1;
      }
    }
  }
  
  boolean isStable() {
    return !this._loop && this._accumTime >= this._duration;
  }
}
