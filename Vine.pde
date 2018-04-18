class Vine {
  float x1, y1, x2, y2;
  color lineCol, fillCol;
  float min = 20;
  
  Vine() {
    this.x1 = 0;
    this.y1 = 0;
    this.x2 = 0;
    this.y2 = 0;
    this.lineCol = color(255);
    this.fillCol = color(255);
  }

  Vine(float x1, float y1, float x2, float y2, color lineCol, color fillCol) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.lineCol = lineCol;
    this.fillCol = fillCol;
  }
  
  void display() {
    fill(fillCol);
    stroke(lineCol);
    strokeWeight(2);
    pushMatrix();
    line(this.x1, this.y1, this.x2, this.y2);
    translate(this.x1, this.y1);
    float theta = atan((this.y1 - this.y2)/(this.x1 - this.x2));
    //theta *= 360 / PI;
    if (theta < 0) theta = PI + theta; // range [0, 360)
    rotate(theta);
    vine(this.min, -1);
    popMatrix();
  }
  
  void vine(float h, int s) {
    float check = sqrt(pow(this.x2 - this.x1,2) + pow(this.y2 - this.y1,2));
    if(h < check) {
      pushMatrix();
      translate(h, 0);
      ellipse(0, s*check/48, check / 48, check/24);
      popMatrix();
      vine(h + this.min, -1*s);
    }
  }
}
