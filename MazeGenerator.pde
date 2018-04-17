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
    
    Direction getNegDir() {
      return new Direction(lastPos.sub(pos));
    }
  }
  
  
  class CarveDirGenerator {
    private float probNorth;
    private float probEast;
    private float probSouth;
    private float probWest;
    
    CarveDirGenerator() {
      reset();
    }
    
    // Normalizes all the probabilities so that they sum to 1
    private void normalize() {
      float sum = probNorth + probEast + probSouth + probWest;
      if (sum != 0) {
        probNorth /= sum;
        probEast  /= sum;
        probSouth /= sum;
        probWest  /= sum;
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
    // Undefined behavior if prob is not within [0, 1].
    void setAbsProbForDir(Direction dir, float prob) {
      
      if (dir.isNorth()) {
        probNorth = prob;
        float sum = probEast + probSouth + probWest;
        if (sum > 0) {
          probEast  = (1 - prob) * probEast  / sum;
          probSouth = (1 - prob) * probSouth / sum;
          probWest  = (1 - prob) * probWest  / sum;
        }
        
      } else if (dir.isEast()) {
        probEast = prob;
        float sum = probNorth + probSouth + probWest;
        if (sum > 0) {
          probNorth = (1 - prob) * probNorth / sum;
          probSouth = (1 - prob) * probSouth / sum;
          probWest  = (1 - prob) * probWest  / sum;
        }
        
      } else if (dir.isSouth()) {
        probSouth = prob;
        float sum = probNorth + probEast + probWest;
        if (sum > 0) {
          probNorth = (1 - prob) * probNorth / sum;
          probEast  = (1 - prob) * probEast  / sum;
          probWest  = (1 - prob) * probWest  / sum;
        }
        
      } else if (dir.isWest()) {
        probWest = prob;
        float sum = probNorth + probEast + probSouth;
        if (sum > 0) {
          probNorth = (1 - prob) * probNorth / sum;
          probEast  = (1 - prob) * probEast  / sum;
          probSouth = (1 - prob) * probSouth / sum;
        }
      }
    }
    
    Direction generate() {
      this.normalize();
      float r = random(1);
      if (r < probNorth) {
        return new Direction(0, 1);
      } else if (r < probNorth + probEast) {
        return new Direction(1, 0);
      } else if (r < probNorth + probEast + probSouth) {
        return new Direction(0, -1);
      } else if (r < probNorth + probEast + probSouth + probWest) {
        return new Direction(-1, 0);
      }
      // Possible if all probabilities are disabled
      return null;
    }
  }
  
  
  // Probability the maze will split/branch into two different paths at any
  // given position
  float probBranch;
  
  // Probability the maze will continue carving in a straight line vs turning
  float probStraight;
  
  // Multiplier to avoid tiles that have already been opened/covered
  float multAvoidOpen;
  
  MazeGenerator() {
    probBranch = 0.15;
    probStraight = 0.5;
    multAvoidOpen = 0.0;
  }
  
  
  // Generates a random integer vector representing a position within the maze
  Vec2 getRandomPos(Maze maze) {
    float x = floor(random(0, maze.width));
    float y = floor(random(0, maze.height));
    return new Vec2(x, y);
  }
  
  
  // Opens maze tile from a direction by setting solid to false and disabling
  // one of the walls
  void openMazeTile(Maze.Tile tile, Direction dir) {
    tile.solid = false;
    if (dir.isNorth()) tile.southWall = false;
    if (dir.isEast())  tile.westWall  = false;
    if (dir.isSouth()) tile.northWall = false;
    if (dir.isWest())  tile.eastWall  = false;
  }
  
  
  void generate(Maze maze) {
    generate(maze, (int)random(0, pow(2, 31)));
  }
  
  // Generates a new maze based on the current class settings
  void generate(Maze maze, int seed) {
    // 80 chars ===-=========-=========-=========-=========-=========-=========-
    
    // Save and active the seed
    maze.seed = seed;
    randomSeed(seed);
    
    // Reset all tiles to solid; we'll be carving out our maze
    maze.resetTiles();
    
    // Generate our start and end positions to be a random position within the
    // maze
    Vec2 startPos = getRandomPos(maze);
    Vec2 endPos = getRandomPos(maze);
    maze.startX = (int)startPos.x;
    maze.startY = (int)startPos.y;
    maze.endX = (int)endPos.x;
    maze.endY = (int)endPos.y;
    
    // While carving out hallways, there is a certain probability that the
    // hallway will branch. If we used a recursive function to carve, then the
    // exploration would behave like a depth-first search. This means that one
    // branch would have freedom to explore everything before the second hallway
    // had a chance to move. To avoid this, we'll use a queue (in Java, a deque)
    // to get breadth-first search-style behavior.
    ArrayDeque<CarveNode> nodesToExplore = new ArrayDeque<CarveNode>();
    
    // Begin exploring from our start pos
    nodesToExplore.add(new CarveNode(startPos));
    
    // Explore until we can't anymore. Note that this doesn't necessarily mean
    // the entire maze has been covered; it's potentially possible for algo to
    // back itself into a corner.
    //int debugCount = 0;
    while (!nodesToExplore.isEmpty()) {
      //debugCount++;
      
      // Get the current node
      CarveNode node = nodesToExplore.remove();
      int ix = (int)node.pos.x;
      int iy = (int)node.pos.y;
      //maze.tiles[ix][iy].debug = "" + debugCount;
      
      // If we're at the end, stop here
      if (node.pos.equals(endPos)) {
        continue;
      }
      
      // Next, we will pick a new direction to walk in
      CarveDirGenerator dirGenerator = new CarveDirGenerator();
      
      // Disable the direction we came from
      dirGenerator.disableDir(node.getNegDir());
      
      // Encourage moving in a straight line
      dirGenerator.setAbsProbForDir(node.getDir(), probStraight);
      
      // Disable edges of maze
      if (ix == 0)               dirGenerator.disableDir(new Direction(-1,  0));
      if (iy == 0)               dirGenerator.disableDir(new Direction( 0, -1));
      if (ix == maze.width - 1)  dirGenerator.disableDir(new Direction( 1,  0));
      if (iy == maze.height - 1) dirGenerator.disableDir(new Direction( 0,  1));
      
      // Avoid tiles that have already been opened/covered. We check
      // probabilites first to avoid checking past edges of maze.
      boolean northOpen = iy < maze.height - 1 && !maze.tiles[ix][iy + 1].solid;
      boolean  eastOpen = ix < maze.width  - 1 && !maze.tiles[ix + 1][iy].solid;
      boolean southOpen = iy > 0               && !maze.tiles[ix][iy - 1].solid;
      boolean  westOpen = ix > 0               && !maze.tiles[ix - 1][iy].solid;
      if (northOpen) dirGenerator.probNorth *= multAvoidOpen;
      if (eastOpen)  dirGenerator.probEast  *= multAvoidOpen;
      if (southOpen) dirGenerator.probSouth *= multAvoidOpen;
      if (westOpen)  dirGenerator.probWest  *= multAvoidOpen;
      
      // Generate the new direction
      Direction newDir = dirGenerator.generate();
      
      // If the direction is null, that means that we've backed ourselves into a
      // corner; this is where this path ends
      if (newDir == null) {
        continue;
      }
      
      // Save the new node
      CarveNode newNode = new CarveNode(node.pos.add(newDir), node.pos);
      int nix = (int)newNode.pos.x;
      int niy = (int)newNode.pos.y;
      openMazeTile(maze.tiles[ ix][ iy], newNode.getNegDir());
      openMazeTile(maze.tiles[nix][niy], newNode.getDir());
      nodesToExplore.add(newNode);
      
      // Maybe start a new branch
      if (random(1) < probBranch) {
        
        // Disable the other new direction
        dirGenerator.disableDir(newDir);
        
        // Generate the new direction
        newDir = dirGenerator.generate();
        if (newDir == null) {
          continue;
        }
        
        // Save the new node
        newNode = new CarveNode(node.pos.add(newDir), node.pos);
        nix = (int)newNode.pos.x;
        niy = (int)newNode.pos.y;
        openMazeTile(maze.tiles[ ix][ iy], newNode.getNegDir());
        openMazeTile(maze.tiles[nix][niy], newNode.getDir());
        nodesToExplore.add(newNode);
      }
    }
    
    // Check that it's possible to reach the end; otherwise, retry
    if (maze.tiles[(int)endPos.x][(int)endPos.y].solid) {
      generate(maze);
      return;
    }
    
    // Mark the start and end
    maze.tiles[(int)startPos.x][(int)startPos.y].debug = "start";
    maze.tiles[(int)endPos.x][(int)endPos.y].debug = "end";
  }
}
