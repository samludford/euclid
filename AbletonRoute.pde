import themidibus.*;

class AbletonRoute implements PatternModListener {
  
  final String BUS = "AbletonRoute";
  final int channel = 0;
  final int vel = 100;
  
  private MidiBus midiBus;
  
  AbletonRoute() {
    MidiBus.list();
    midiBus = new MidiBus(this, BUS, BUS);
  }
  
  void play(int pitch) {
    midiBus.sendNoteOn(channel, pitch, vel);
    //midiBus.sendNoteOff(channel, pitch, vel);
  }
  
  void patternDidHit(PatternMod patternMod, boolean hit) {
    int pitch = hit ? patternMod.noteUp : patternMod.noteDown;
    play(pitch);
  }
  
}