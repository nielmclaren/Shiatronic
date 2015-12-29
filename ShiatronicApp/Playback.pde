
class Playback {
  private int numFrames;
  private int frameDuration;
  private int frameUpdated;
  private int currFrame;
  boolean isPaused;

  Playback(int n) {
    numFrames = n;
    frameDuration = 100;
    frameUpdated = millis();
    currFrame = 0;
    isPaused = false;
  }

  boolean isPaused() {
    return isPaused;
  }

  Playback isPaused(boolean v) {
    isPaused = v;
    return this;
  }

  int frame() {
    return currFrame;
  }

  Playback update() {
    int now = millis();

    if (isPaused) {
      frameUpdated = now;
    }
    else {
      int delta = now - frameUpdated;
      currFrame += floor(delta / frameDuration);
      frameUpdated = now - delta % frameDuration;
      while (currFrame >= numFrames) {
        currFrame -= numFrames;
      }
    }
    return this;
  }
}
