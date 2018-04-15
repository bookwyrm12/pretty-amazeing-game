class SceneButton {
  // Used for identifying a scene button within the code
  String name;
  
  // This scene will be rendered/resized by this button
  Scene scene;
  
  // When a scene is clicked on, its sizing is no longer controlled by the
  // SceneButtonList, but instead, it is zoomed in on and made fullscreen. The
  // zoom ranges from 0 (totally determined by SceneButtonList) to 1
  // (fullscreen).
  SmoothFloat zoom;
  
  
  SceneButton(String name, Scene scene) {
    this.name = name;
    this.scene = scene;
    
    float initial = 0;
    float duration = 0.8;
    this.zoom = new SmoothFloat(initial, duration);
  }
  
  // This will allow the buttons to be sorted by zoom, which allows us to
  // render the "active" scene (the one being zoomed in on) in front of the
  // rest.
  int compareTo(SceneButton button) {
    if (this.zoom.value < button.zoom.value) return -1;
    if (this.zoom.value > button.zoom.value) return 1;
    return 0;
  }
  
  // This returns zoom.value after cubic easing
  float easedZoom() {
    return easeInOutCubic(zoom.value);
  }
  
  private float easeInOutCubic(float t) {
    // Stolen from: https://gist.github.com/gre/1650294
    return t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;
  }
}
