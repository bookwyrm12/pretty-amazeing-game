class Vec2 {
  float x, y;

  Vec2() {
    this.x = 0;
    this.y = 0;
  }

  Vec2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Vec2 copy() {
    return new Vec2(this.x, this.y);
  }

  float length() {
    return sqrt(this.x * this.x + this.y * this.y);
  }

  Vec2 add(Vec2 v) {
    return new Vec2(this.x + v.x, this.y + v.y);
  }

  Vec2 sub(Vec2 v) {
    return new Vec2(this.x - v.x, this.y - v.y);
  }

  Vec2 mult(float t) {
    return new Vec2(this.x * t, this.y * t);
  }

  Vec2 div(float t) {
    return new Vec2(this.x / t, this.y / t);
  }
  
  Vec2 neg() {
    return new Vec2(-this.x, -this.y);
  }

  Vec2 unit() {
    return this.mult(1 / this.length());
  }

  float dot(Vec2 v) {
    return this.x * v.x + this.y * v.y;
  }

  Vec2 rotate(float rad) {
    float s = sin(rad);
    float c = cos(rad);
    return new Vec2(this.x * c - this.y * s, this.x * s + this.y * c);
  }
}