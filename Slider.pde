class Slider {
  float sw, sh;    // width and height of bar
  float x, y;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  boolean over;           // is the mouse over the slider?
  boolean locked;

  Slider (float x, float w) {
    this.x = 0;
    this.y = 0;
    this.sw = 0;
    this.sh = 0;
    this.spos = x - w/2;
    this.newspos = this.spos;
    this.sposMin = 0;
    this.sposMax = 0;
  }
  
  Slider (float x, float y, float w, float h) {
    this.x = x - w/2;
    this.y = y - h/2;
    this.sw = w;
    this.sh = h;
    this.spos = x - w/2;
    this.newspos = this.spos;
    this.sposMin = x;
    this.sposMax = x + this.sw - this.sh;
  }

  void update() {
    if (overEvent()) {
      this.over = true;
    } else {
      this.over = false;
    }
    if (mousePressed && this.over) {
      this.locked = true;
    }
    if (!mousePressed) {
      this.locked = false;
    }
    if (this.locked) {
      this.newspos = mouseX;
      if(this.newspos < this.sposMax) this.spos = this.sposMin;
      else this.spos = this.sposMax;
    }
  }

  boolean overEvent() {
    if (mouseX > this.x && mouseX < this.x+this.sw &&
       mouseY > this.y && mouseY < this.y+this.sh) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(CP.lightText);
    rect(this.x, this.y, this.sw, this.sh);
    if (over || locked) {
      fill(CP.darkText);
    } else {
      fill(102, 102, 102);
    }
    rect(this.spos, this.y, this.sh, this.sh);
  }
  
  boolean is_left() {
    if(this.spos == this.sposMin) return true;
    return false;
  }
  
  boolean is_right() {
    if(this.spos == this.sposMax) return true;
    return false;
  }
  
  void location(float x, float y, float w, float h) {
    this.x = x - w/2;
    this.y = y - h/2;
    this.sw = w;
    this.sh = h;
    this.sposMin = this.x;
    this.sposMax = this.x + this.sw - this.sh;
  }
}
