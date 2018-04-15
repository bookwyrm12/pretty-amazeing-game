class Rect {
  float x, y, w, h;

  Rect() {
    this.x = 0;
    this.y = 0;
    this.w = 0;
    this.h = 0;
  }

  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  boolean equals(Rect r) {
    return (this.x == r.x &&
            this.y == r.y &&
            this.w == r.w &&
            this.h == r.h);
  }
  
  Rect copy() {
    return new Rect(this.x, this.y, this.w, this.h);
  }
  
  Vec2 getPos() {
    return new Vec2(this.x, this.y);
  }
  
  Vec2 getSize() {
    return new Vec2(this.w, this.h);
  }
  
  Vec2 getCenter() {
    return this.getPos().add(this.getSize().div(2));
  }
  
  float getMaxX() {
    return this.getPos().add(this.getSize()).x;
  }
  
  float getMaxY() {
    return this.getPos().add(this.getSize()).y;
  }

  boolean intersects(Rect r) {
    return (this.x <= r.x + r.w &&
            this.y <= r.y + r.h &&
            this.x + this.w > r.x &&
            this.y + this.h > r.y);
  }
  
  boolean contains(Vec2 v) {
    return (this.x <= v.x &&
            this.y <= v.y &&
            this.x + this.w > v.x &&
            this.y + this.h > v.y);
  }
  
  Rect lerp(Rect r, float t) {
    return new Rect(
      this.x + (r.x - this.x) * t,
      this.y + (r.y - this.y) * t,
      this.w + (r.w - this.w) * t,
      this.h + (r.h - this.h) * t
    );
  }
}
