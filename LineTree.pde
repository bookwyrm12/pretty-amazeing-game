class LineTree {
  float x, y, h;
  color branch, leaf;
  int min = 30;
  
  LineTree() {
    this.x = 0;
    this.y = 0;
    this.h = 0;
    this.branch = color(0);
    this.leaf = color(0);
  }

  LineTree(float x, float y, float h, color branch, color leaf) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.branch = branch;
    this.leaf = leaf;
  }
  
  void display() {
    //Define colours
    stroke(branch);
    strokeWeight(2);
    fill(leaf);
    pushMatrix();
    translate(this.x, this.y);
    line(0, 0, 0, -this.h);
    branch(this.min);
    popMatrix();
  }
  
  void branch(float i) {
    if(i < this.h) {
      translate(0, -this.min);
      rotate(PI / 4);
      float b = (i - this.h) / 3;
      line(0, 0, 0, b);
      ellipse(0, b, -b / 4, -b / 4);
      rotate(-PI / 2);
      line(0, 0, 0, b);
      ellipse(0, b, -b / 4, -b / 4);
      rotate(PI / 4);
      i += this.min;
      branch(i);
    }
  }
  
  void changeSize(float h) {
    this.h = h;
  }
  
  void move(float x, float y, float h){
    this.x = x;
    this.y = y;
    this.h = h;
  }
}
