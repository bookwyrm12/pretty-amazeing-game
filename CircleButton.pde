class CircleButton {
  PShape img;
  float x, y, w, h;
  boolean over;
  color fillCol, lineCol;
  float alpha; // 0 - 255
  boolean wasClicked;
  
  CircleButton (float x, float y, float w, float h, color fillCol, color lineCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
    this.lineCol = lineCol;
    this.alpha = 255;
    this.wasClicked = false;
  }
  
  CircleButton (float x, float y, float w, float h, color fillCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
    this.alpha = 255;
    this.wasClicked = false;
  }
  
  CircleButton (float x, float y, float w, float h, String img) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = loadShape(img);
    this.alpha = 255;
    this.wasClicked = false;
  }
  
  void update() {
    if ( overCircle(this.x, this.y, this.w + this.h) ) {
      this.over = true;
    } else {
      this.over = false;
    }
  }
  
  void bounds(float x, float y, float w, float h, color fillCol, color lineCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
    this.lineCol = lineCol;
  }
  
  void displayNoImage(color highlightCol) {
    if (this.overCircle(x, y, max(w, h))) {
      stroke(highlightCol, alpha);
    } else {
      stroke(CP.line, alpha);
    }
    strokeWeight(2);
    fill(fillCol, alpha);
    ellipse(x, y, w, h);
  }
  
  void displayImage(color highlightCol) {
    if (this.overCircle(x, y, max(w, h))) {
      stroke(highlightCol, alpha);
    } else {
      stroke(CP.line, alpha);
    }
    strokeWeight(2);
    fill(CP.lightText, alpha);
    ellipse(x, y, w, h);
    shape(this.img, this.x - 3*this.w/8, this.y - 3*this.h/8, 3*this.w/4, 3*this.h/4);
  }
  
  void displayBackMain() {
    stroke(lineCol, alpha);
    strokeWeight(2);
    fill(CP.fillCol, alpha);
    ellipse(x, y, w, h);
    line(x - w/3, y, x + w/3, y);
    line(x - w/3, y, x, y - w/3);
    line(x - w/3, y, x, y + w/3);
  }
  
  void displayBackLevel() {
    stroke(lineCol, alpha);
    strokeWeight(2);
    fill(fillCol, alpha);
    ellipse(x, y, w, h);
    line(x - w/3, y, x + w/3, y);
    line(x - w/3, y, x, y - w/3);
    line(x - w/3, y, x, y + w/3);
  }
  
  void tick() {
    boolean mouseClicked = app.wasMouseClicked();
    boolean mouseWithinBounds = overCircle(this.x, this.y, this.w+this.h);
    if (mouseClicked && mouseWithinBounds) {
      wasClicked = true;
    } else {
      wasClicked = false;
    }
  }
  
  boolean overCircle(float x, float y, float diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }
}
