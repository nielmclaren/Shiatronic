
Playback playback;

PImage background;
LightStreaks streaks;
ShiaClip clip;
ShiaTunnel tunnel;
FileNamer fileNamer;

void setup() {
  size(1280, 720, P2D);

  int startFrame = 60;
  int numFrames = 40;

  playback = new Playback(numFrames);

  background = loadImage("starfield.jpg");
  streaks = new LightStreaks(width, height);
  clip = new ShiaClip(startFrame, numFrames);
  tunnel = new ShiaTunnel(startFrame, numFrames);
  fileNamer = new FileNamer("output/export", "png");
}

void draw() {
  playback.update();

  drawBackground(g);
  streaks.draw(g);
  tunnel.draw(g, playback.frame());
  clip.draw(g, playback.frame());
}

void drawBackground(PGraphics g) {
  float scale = 0.5;
  g.beginDraw();
  g.image(background, 0, 0, background.width * scale, background.height * scale);
  g.endDraw();
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

