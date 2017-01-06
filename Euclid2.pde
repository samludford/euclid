static final int DELAY = 200; 
int counter = 0;

AbletonRoute router;

PatternMod m1;
PatternMod m2;
PatternMod m3;

void setup() {
  
  size(20, 20);
  background(0);
  
  router = new AbletonRoute();
  
  m1 = new PatternMod(36, 40 ,router);
  m2 = new PatternMod(38, 39 ,router);
  m3 = new PatternMod(44, 45 ,router);
  
}

void draw() {
  
  m1.update(counter);
  m2.update(counter);
  m3.update(counter);
  counter++;
  delay(DELAY);
  
}