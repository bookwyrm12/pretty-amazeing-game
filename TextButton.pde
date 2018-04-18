class TextButton {
  String text;
  Rect bounds;
  color rectColor;
  color textColor;
  float textSize;
  boolean wasClicked;
  
  TextButton(String text) {
    this.text = text;
    this.bounds = new Rect(0, 0, 100, 50);
    this.rectColor = color(0);
    this.textColor = color(255);
    this.textSize = 12;
    this.wasClicked = false;
  }
  
  void tick() {
    boolean mouseClicked = app.wasMouseClicked();
    boolean mouseWithinBounds = bounds.contains(app.getMousePos());
    if (mouseClicked && mouseWithinBounds) {
      wasClicked = true;
    } else {
      wasClicked = false;
    }
  }
  
  void draw() {
    // For whatever reason, an alpha == 255 renders as alpha == 255
    if (alpha(rectColor) > 0) {
      noStroke();
      fill(rectColor);
      rect(bounds.x, bounds.y, bounds.w, bounds.h);
    }
    
    if (alpha(textColor) > 0) {
      fill(textColor);
      textSize(textSize);
      textAlign(CENTER, CENTER);
      text(text, bounds.getCenter().x, bounds.getCenter().y);
    }
  }
  
  void setAlpha(float alpha) {
    rectColor = color(red(rectColor), green(rectColor), blue(rectColor), alpha);
    textColor = color(red(textColor), green(textColor), blue(textColor), alpha);
  }
}
