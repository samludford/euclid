class PatternMod {
  
  private final int[] SPEEDS = { 1, 2, 3, 4, 5, 8, 12, 16, 32 };
  private final int minSteps = 10;
  private final int maxSteps = 21;
  private final int minHits = 5;
  
  private boolean[] pattern;
  private int speed;
  private int offset;
  
  public int noteUp;
  public int noteDown;
  
  private PatternModListener listener;
  
  PatternMod(int noteUp, int noteDown, PatternModListener listener) {
    this.noteUp = noteUp;
    this.noteDown = noteDown;
    this.listener = listener;
    mutate();
  }
  
  void mutate() {
      int steps = (int) random(minSteps,maxSteps);
      int hits = (int)random(minHits, steps);
      pattern = Bjorklund.getPattern(steps, hits);
      this.speed = SPEEDS[(int) random(0, SPEEDS.length)];
  }
  
  void update(int counter) {
    
    int c = counter + offset;
    int n = normalisedCounter(c);
    if(n >= 0) {
      listener.patternDidHit(this, pattern[n % pattern.length]);   
    }
    
    if(n == pattern.length - 1) {
      int rnd = (int) random(0,3);
      if (rnd==1) {
        mutate();
        offset = (int) random(0, 5);
      }
      
    }
  }
  
  private int normalisedCounter(int counter) {
    if(counter % speed == 0) {
      return counter / speed;
    } else {
      return -1;
    }
  }
  
}

interface PatternModListener {
    public void patternDidHit(PatternMod patternMod, boolean hit);
}