import java.util.ArrayDeque;

class MazeGenerator {
  
  class Direction extends Vec2 {
    Direction() {
      super();
    }
    
    Direction(float x, float y) {
      super(x, y);
    }
    
    Direction(Vec2 vec) {
      super(vec.x, vec.y);
    }
    
    boolean isNorth() {
      return x == 0 && y > 0;
    }
    
    boolean isSouth() {
      return x == 0 && y < 0;
    }
    
    boolean isEast() {
      return x > 0 && y == 0;
    }
    
    boolean isWest() {
      return x < 0 && y == 0;
    }
  }
  
  // CarveNode is used for the stack within the generate() method. It stores the
  // current position we're exploring, as well as the position that we came
  // from. This is useful because it allows us to favor creating straight
  // hallways vs creating a confusing, twisty mess.
  class CarveNode {
    Vec2 pos;
    Vec2 lastPos;
    
    CarveNode(Vec2 pos) {
      this.pos = pos;
      this.lastPos = pos;
    }
    
    CarveNode(Vec2 pos, Vec2 lastPos) {
      this.pos = pos;
      this.lastPos = lastPos;
    }
    
    Direction getDir() {
      return new Direction(pos.sub(lastPos));
    }
  }
  
  class CarveDirGenerator {
    class WeightedDirection extends Direction {
      float weight;
      
      WeightedDirection(float x, float y, float w) {
        super(x, y);
        weight = w;
      }
    }
    
    private float probNorth;
    private float probEast;
    private float probSouth;
    private float probWest;
    
    CarveDirGenerator() {
      reset();
    }
    
    private void normalize() {
      float mag = sqrt(
        pow(probNorth, 2) +
        pow(probEast,  2) +
        pow(probSouth, 2) +
        pow(probWest,  2)
      );
      if (mag != 0) {
        probNorth /= mag;
        probEast  /= mag;
        probSouth /= mag;
        probEast  /= mag;
      }
    }
    
    // Resets the generator so that each probability is enabled with equal weight
    void reset() {
      probNorth = 0.25;
      probEast  = 0.25;
      probSouth = 0.25;
      probWest  = 0.25;
    }
    
    // Disables a direction as a possibility
    void disableDir(Direction dir) {
      if (dir.isNorth()) {
        probNorth = 0;
      } else if (dir.isEast()) {
        probEast = 0;
      } else if (dir.isSouth()) {
        probSouth = 0;
      } else if (dir.isWest()) {
        probWest = 0;
      }
      this.normalize();
    }
    
    // Sets the absolute probability for a particular direction. The remaining
    // probability will be distributed to the other directions based on their
    // relative weights. For example, if the current weighting is:
    //   north = 0.55
    //   east  = 0.30
    //   south = 0.15
    //   west  = 0
    // and you set the absolute probability for north to 0.9, the resulting
    // weights will look like:
    //   north = 0.900
    //   east  = 0.066
    //   south = 0.033
    //   west  = 0
    void setAbsProbForDir(Direction dir, float prob) {
      
    }
  }
  
  
  // Probability the maze will split/branch into two different paths at any
  // given position
  float probBranch;
  
  // Probability the maze will continue carving in a straight line vs turning
  float probStraight;
  
  MazeGenerator() {
    probBranch = 0.05;
    probStraight = 0.9;
  }
  
  
  // Generates a random integer vector representing a position within the maze
  Vec2 getRandomPos(Maze maze) {
    float x = floor(random(0, maze.width));
    float y = floor(random(0, maze.height));
    return new Vec2(x, y);
  }
  
  
  // Generates a new maze based on the current class settings
  void generate(Maze maze) {
    // Reset all tiles to solid; we'll be carving out our maze
    maze.resetTiles();
    
    // ___=========-=========-=========-=========-=========-=========-=========-
    
    // Generate our start and end positions to be a random position within the
    // maze
    Vec2 startPos = getRandomPos(maze);
    Vec2 endPos = getRandomPos(maze);
    
    // While carving out hallways, there is a certain probability that the
    // hallway will branch. If we used a recursive function to carve, then the
    // exploration would behave like a depth-first search. This means that one
    // branch would have freedom to explore everything before the second hallway
    // had a chance to move. To avoid this, we'll use a stack (in Java, a deque)
    // to get breadth-first search-style behavior.
    ArrayDeque<CarveNode> nodesToExplore = new ArrayDeque<CarveNode>();
    
    // Begin exploring from our start pos
    nodesToExplore.push(new CarveNode(startPos));
    
    // Explore until we can't anymore. Note that this doesn't necessarily mean
    // the entire maze has been covered; it's possible for algo to back itself
    // into a corner.
    while (!nodesToExplore.isEmpty()) {
      CarveNode node = nodesToExplore.pop();
      
    }
  }
}
