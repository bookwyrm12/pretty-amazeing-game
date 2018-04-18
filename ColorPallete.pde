static class ColorPallete {
  //Static Colours
  static color beige = #F0F3BD;
  static color brown = #46351D;
  
  //Blue Pallete
  static color darkBlue = #05668D;
  static color lightBlue = #028090;
  static color blueGreen = #00A896;
  
  //PurplePallete
  static color darkPurple = #413F54;
  static color purple = #8D6B94;
  static color lightPurple = #B185A7;
  
  //Dark Pallete
  static color black = #000000;
  static color grey = #4E6766;
  static color paleBlue = #D4F2DB;
  
  //Generic Vars
  color line;
  color background;
  color border;
  color fillCol;
  color lightText;
  color darkText;
  
  ColorPallete() { // Default colours
    line = blueGreen;
    background = lightBlue;
    border = darkBlue;
    fillCol = darkBlue;
    lightText = beige;
    darkText = brown;
  }
  
  void setBlue() {
    line = blueGreen;
    background = lightBlue;
    border = darkBlue;
    fillCol = darkBlue;
  }
  
  void setPurple() {
    line = lightPurple;
    background = purple;
    border = darkPurple;
    fillCol = darkPurple;
  }
  
  void setDark() {
    line = paleBlue;
    background = black;
    border = grey;
    fillCol = grey;
  }
}
