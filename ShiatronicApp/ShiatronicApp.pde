
Playback playback;
ShiaClip clip;
ShiaTunnel tunnel;
FileNamer fileNamer;

void setup() {
  size(1280, 720, P2D);

  int startFrame = 60;
  int numFrames = 40;
  playback = new Playback(numFrames);
  clip = new ShiaClip(startFrame, numFrames);
  tunnel = new ShiaTunnel(startFrame, numFrames);
  fileNamer = new FileNamer("output/export", "png");
}

void draw() {
  playback.update();
  g.background(0);
  tunnel.draw(g, playback.frame());
  clip.draw(g, playback.frame());
}

void keyReleased() {
  switch (key) {
    case ' ':
      boolean isPaused = !playback.isPaused();
      playback.isPaused(isPaused);
      tunnel.isPaused(isPaused);
      break;
    case 'r':
      save(fileNamer.next());
      break;
  }
}

