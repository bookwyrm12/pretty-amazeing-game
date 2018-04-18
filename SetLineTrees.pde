class SetLineTrees {
  float x, y;
  float[] multiples = {1, 2, 3, 2};
  
  SetLineTrees() {
    this.x = 0;
    this.y = 0;
  }
  
  SetLineTrees(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    setTrees(0, 0);
  }
  
  void setTrees(float i, int j) {
    float minHeight = this.x * 2 / 25;
    float d = minHeight * this.multiples[j];
    
    if(i < this.x - minHeight / 5) {
      LineTree lt = new LineTree(i + d/4, this.y, d, CP.line, CP.fillCol);
      lt.display();
      setTrees(i + d/2, j== 3? 0: ++j);
    }
  }
}
