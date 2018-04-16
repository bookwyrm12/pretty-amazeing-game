class Flower {
  float x, y, size, num;
  
  Flower() {
    this.x = 0;
    this.y = 0;
    this.num = 0;
  }

  Flower(float x, float y, float num) {
    this.x = x;
    this.y = y;
    this.num = num;
  }
  
  void display() {
    //Define colours for petals
    stroke(CP.line);
    strokeWeight(2);
    fill(CP.fillCol);
    //Center flower
    pushMatrix();
    translate(this.x, this.y);
    //Draw the petals
    petals(0);
    popMatrix();
  }
  
  void petals(float level) {
    float MAX = 8;
    if(level < this.num) {
      float theta = level * radians(137.5);
      float r = MAX * sqrt(level);
      ellipse(cos(theta)*r, sin(theta)*r, MAX, MAX);
      petals(++level);
    }
  }
}
