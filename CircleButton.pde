class CircleButton {
  PShape img;
  float x, y, w, h;
  boolean over;
  color fillCol;
  
  CircleButton (float x, float y, float w, float h, color fillCol) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillCol = fillCol;
  }
  
  CircleButton (float x, float y, float w, float h, String img) { 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = loadShape(img);
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
    fill(-1);
    ellipse(x, y, w, h);
    shape(this.img, this.x, this.y, this.w, this.h);
    noLoop();
  }
  
  void displayBack() {
    stroke(CP.line);
    strokeWeight(2);
    fill(fillCol);
    ellipse(x, y, w, h);
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
