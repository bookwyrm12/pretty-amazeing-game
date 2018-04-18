class Squares {
  float x, y, w;
  color lineCol, fillCol;
  float min = 20;
  
  
  Squares() {
    this.x = 0;
    this.y = 0;
    this.w = 0;
    this.lineCol = color(255);
    this.fillCol = color(255);
  }

  Squares(float x, float y, float w, color lineCol, color fillCol) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.lineCol = lineCol;
    this.fillCol = fillCol;
  }
  
  void display() {
    fill(fillCol);
    stroke(lineCol);
    pushMatrix();
    rectMode(CENTER);
    translate(x, y);
    rect(0, 0, w, w);
    squares(w);
    rectMode(CORNER);
    popMatrix();
  }
  
  void squares(float s) {
    float check = s*0.618;
    if(check > 10) {
      pushMatrix();
      translate(-s/2, -s/2);
      rect(0, 0, check, check);
      squares(check);
      popMatrix();
      
      pushMatrix();
      translate(s/2, -s/2);
      rect(0, 0, check, check);
      squares(check);
      popMatrix();
      
      pushMatrix();
      translate(s/2, s/2);
      rect(0, 0, check, check);
      squares(check);
      popMatrix();
      
      pushMatrix();
      translate(-s/2, s/2);
      rect(0, 0, check, check);
      squares(check);
      popMatrix();
    }
  }
}
