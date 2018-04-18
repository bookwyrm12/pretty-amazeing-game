class ButtonPattern {
  float x, y, w, h;
  
  ButtonPattern(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void displayMain() {
    
    stroke(CP.line);
    strokeWeight(2);
    fill(CP.border);
    octogon();
    fill(CP.background);
    stroke(CP.line);
    strokeWeight(2);
    rect(this.x, this.y, this.w, this.h);
    
  }
  
  
  void displayLevel() {
    
    stroke(CP.darkText);
    strokeWeight(2);
    fill(CP.lightText);
    octogon();
    fill(CP.lightText);
    stroke(CP.darkText);
    strokeWeight(2);
    rect(this.x, this.y, this.w, this.h);
    
  }
  
  void octogon() {
    int d = 8;
    pushMatrix();
    translate(this.x, this.y);
    beginShape();
    vertex(-d, 0);
    vertex(0, -d);
    vertex(this.w, -d);
    vertex(this.w + d, 0);
    vertex(this.w + d, this.h);
    vertex(this.w, this.h + d);
    vertex(0, this.h + d);
    vertex(-d, this.h);
    endShape(CLOSE);
    popMatrix();
  }
}
