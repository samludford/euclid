static class Bjorklund {
  
  // public methods
  
  public static boolean[] getPattern(int steps, int hits) 
  {
    if(hits > steps) return null;
    
    boolean[] input = new boolean[steps];
    for(int i=0 ; i<steps ; i++) {
      input[i] = (i < hits);
    }
    return bjorklund(format(input));
  }
  
  // Main algorithm
  
  private static boolean[] bjorklund(boolean[][] input) 
  {
    if(isStoppingCase(input)) {
      return unFormat(input);
    } else {
      return bjorklund(iterate(input));
    }
  }
  
  private static boolean isStoppingCase(boolean[][] input) {
    
    // stopping case if any [0]'s at end, or more than one remainder (e.g. [10][10])
    
    // count [0]'s and remainders
    int zeroCount = 0;
    int remainderCount = 0;
    
    // length of a non-remainder (to be set by first element)
    int nonRemLength = 0;
    
    for(int i=0 ; i<input.length ; i++) {
       
      // check if [0]
      if(input[i].length == 1 && !input[i][0]) zeroCount++;
      
      // check if remainder
      if(i==0) {
        // first element is never a remainder. Store length for further checks 
        nonRemLength = input[i].length;
      } else {
        // a remainder is any element with length < the first element
        if(input[i].length < nonRemLength) remainderCount++;      
      }
    }
  
    // if there are any [0]'s, not a stopping case. Otherwise, stopping case only if 1 or less remainders
    if(zeroCount > 0) 
      return false;
    else
      return remainderCount<=1; 
  }
  
  private static boolean[][] iterate(boolean[][] input) {
     
    // remove remainders (including [0]s) and concatenate with initial elements 
    
    // first find number of remainders (or [0]s)
    int nonRemLength = 0;
    int remainderCount = 0;
    boolean[] rem = new boolean[0];
    for(int i=0 ; i<input.length ; i++) {
      
      // set nonRemLength
      if(i == 0) nonRemLength = input[0].length;
      
      // first check if a [0]
      if(input[i].length == 1 && !input[i][0]) {
        remainderCount++;
        rem = input[i];
        continue;
      }
      
      // check if remainder
      if(input[i].length < nonRemLength) {
        rem = input[i];
        remainderCount++;
      }
    }
    
    // set up iteration
    int difference = input.length - remainderCount;
    int columnCount = max(remainderCount, difference);
    int cutOffIndex = min(remainderCount, difference);
    
    boolean[][] iteration = new boolean[columnCount][];
    
    // insert remainders
    for(int i=0 ; i < iteration.length ; i++) {
      boolean[] concat = (i < cutOffIndex) ? rem : new boolean[0];
      iteration[i] = concat(input[i], concat);
    }
    
    return iteration;
  }
  
  // Utilities
  
  private static boolean[][] format(boolean[] input) 
  {
    
    // turns e.g. [111000] into [1][1][1][0][0][0]
    
    boolean[][] bjork = new boolean[input.length][1];
    for(int i=0 ; i<input.length ; i++) {
      bjork[i][0] = input[i];
    }
    return bjork;
  }
  
  private static boolean[] unFormat(boolean[][] input) {
    
    // turns e.g. [100][100][10] into [10010010]
    
    boolean[] output = new boolean[0];
    for(int i=0 ; i < input.length ; i++) {
      output = concat(output, input[i]);
    }
    return output;
  }  
  
}