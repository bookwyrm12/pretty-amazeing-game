class CircleButton {
  PShape img;
  float x, y, w, h;
  boolean over;
  color fillCol;
  boolean wasClicked;
  
  CircleButton (float x, float y, float w, float h, color fillCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
    this.wasClicked = false;
  }
  
  CircleButton (float x, float y, float w, float h, String img) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = loadShape(img);
    this.wasClicked = false;
  }
  
  void update() {
    if ( overCircle(this.x, this.y, this.w + this.h) ) {
      this.over = true;
    } else {
      this.over = false;
    }
  }
  
  void bounds(float x, float y, float w, float h, color fillCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
  }
  
  void displayNoImage() {
    stroke(CP.line);
    strokeWeight(2);
    fill(fillCol);
    ellipse(x, y, w, h);
  }
  
  void displayImage() {
    stroke(CP.line);
    strokeWeight(2);
    fill(CP.lightText);
    ellipse(x, y, w, h);
    shape(this.img, this.x - 3*this.w/8, this.y - 3*this.h/8, 3*this.w/4, 3*this.h/4);
  }
  
  void displayBackMain() {
    stroke(CP.line);
    strokeWeight(2);
    fill(CP.fillCol);
    ellipse(x, y, w, h);
    line(x - w/3, y, x + w/3, y);
    line(x - w/3, y, x, y - w/3);
    line(x - w/3, y, x, y + w/3);
  }
  
  void displayBackLevel() {
    stroke(CP.darkText);
    strokeWeight(2);
    fill(CP.lightText);
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
