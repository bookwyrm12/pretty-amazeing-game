class SceneOptions extends Scene {
  SceneMainMenu mainMenu;
  CircleButton backButton;
  Slider s;
  
  SceneOptions(SceneMainMenu mainMenu) {
    super(mainMenu.app);
    this.mainMenu = mainMenu;
    this.backButton = new CircleButton(0, 0, 0, 0, 255, 255);
    s = new Slider(bounds.x + bounds.w/2, bounds.w/24);
  }
  
  void tick() {
    boolean controlsActive = (bounds.w > 500);
    
    // Check for button clicks
    if (controlsActive) {
      
      // Check for back button
      backButton.tick();
      if (backButton.wasClicked) {
        mainMenu.goToMainMenu();
      }
    }
  }
  
  void draw() {
    pattern();
    
    { // Draw the back button
      float offsetX = bounds.x + 1.0 / 20 * bounds.w;
      float offsetY = bounds.y + 1.0 / 20 * bounds.w;
      float sizeY = 0.5 / 8.0 * bounds.h;
      
      backButton.bounds(offsetX, offsetY, sizeY, sizeY, CP.background, CP.line);
      backButton.displayBackMain();
    }
    { // If we're below a certain size, we want to fade out the scene buttons, so
      // we'll do that by rendering a translucent black rect over them.
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / height2, 0, 1);
      float alpha = (1 - t) * 255;
      
      fill(CP.background, alpha);
      noStroke();
      rect(bounds.x + 2, bounds.y + 2, bounds.w - 2, bounds.h - 2);
      //rect(bounds.x + bounds.w / 8, bounds.y + bounds.h / 4, 3 * bounds.w / 4, bounds.h / 2);
    }
    
    { // Draw options label
      Vec2 pos1 = bounds.getCenter();
      Vec2 pos2 = bounds.getCenter().sub(new Vec2(0, bounds.h / 4));
      Vec2 pos = pos1;
      
      float size1 = bounds.h * 0.618;
      float size2 = bounds.h / 9;
      float size = size1;
      
      int height1 = 50;
      int height2 = 600;
      float t = constrain((bounds.h - height1) / height2, 0, 1);
      
      if (bounds.h > height1) {
        pos = pos1.lerp(pos2, t);
        size = lerp(size1, size2, t);
      }
      
      fill(CP.lightText);
      textFont(createFont(FC.font, 1));
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Options", pos.x, pos.y-5);
    }
  }
  
  void pattern() {
    ButtonPattern bp = new ButtonPattern(bounds.x, bounds.y, bounds.w, bounds.h);
    bp.displayMain();
    
    fill(CP.lightText);
    textFont(createFont(FC.font, 1));
    textAlign(CENTER, CENTER);
    textSize(bounds.h/16);
    String[] text = {"Music", "Colours", "Character"};
    float htitles = bounds.h/7;
    float xtitles = bounds.x + bounds.w/2;
    float ytitles = bounds.y + 4*bounds.h/10;
    for(int i = 0; i < 3; i++) {
      text(text[i], xtitles, ytitles + i*htitles + htitles/5);
      line(xtitles - bounds.w/10, ytitles + i*htitles + htitles/2, xtitles + bounds.w/10, ytitles + i*htitles + htitles/2);
    }
    
    //Music slider
    s.location(bounds.x + bounds.w/2, bounds.y + bounds.h/2, bounds.w/24, bounds.h/36);
    s.update();
    s.display();
    if(mousePressed && s.is_left()) music.play_music();
    if(mousePressed && s.is_right()) music.stop_music();
    
    //Colour Select
    CircleButton blue = new CircleButton(bounds.x + bounds.w/2 - bounds.h/7, bounds.y + 2*bounds.h/3, bounds.h/20, bounds.h/20, ColorPallete.darkBlue);
    CircleButton purple = new CircleButton(bounds.x + bounds.w/2, bounds.y + 2*bounds.h/3, bounds.h/20, bounds.h/20, ColorPallete.darkPurple);
    CircleButton dark = new CircleButton(bounds.x + bounds.w/2  + bounds.h/7, bounds.y + 2*bounds.h/3, bounds.h/20, bounds.h/20, ColorPallete.black);
    blue.displayNoImage();
    purple.displayNoImage();
    dark.displayNoImage();
    
    blue.update();
    purple.update();
    dark.update();
    if(blue.over && mousePressed) { CP.setBlue();
    } else if(purple.over && mousePressed) { CP.setPurple();
    } else if(dark.over && mousePressed) { CP.setDark();
    }
    
    //Character Select
    CircleButton char1 = new CircleButton(bounds.x + bounds.w/2 - bounds.h/7, bounds.y + 4*bounds.h/5, bounds.h/20, bounds.h/20, "char_ladybug.svg");
    CircleButton char2 = new CircleButton(bounds.x + bounds.w/2, bounds.y + 4*bounds.h/5, bounds.h/20, bounds.h/20, "char_owl.svg");
    CircleButton char3 = new CircleButton(bounds.x + bounds.w/2  + bounds.h/7, bounds.y + 4*bounds.h/5, bounds.h/20, bounds.h/20, "char_cat.svg");
    char1.displayImage();
    char2.displayImage();
    char3.displayImage();
    char1.update();
    char2.update();
    char3.update();
    if(char1.over && mousePressed) { player.changeIcon("ladybug");
    } else if(char2.over && mousePressed) { player.changeIcon("owl");
    } else if(char3.over && mousePressed) { player.changeIcon("cat");
    }
  }
}
