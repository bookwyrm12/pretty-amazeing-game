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
    float MAX = 15;
    if(level < this.num) {
      float theta = level * radians(137.5);
      float r = MAX * sqrt(level);
      pushMatrix();
      translate(cos(theta)*r, sin(theta)*r);
      rotate(theta);
      quad(-MAX/2, 0, 0, -MAX/2, MAX/2, 0, 0, MAX/2);
      popMatrix();
      petals(++level);
    }
  }
}
