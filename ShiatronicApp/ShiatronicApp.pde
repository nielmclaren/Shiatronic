
int startFrame;
int numFrames;

PImage background;
LightStreaks streaks;
ShiaClip clip;
ShiaTunnel tunnel;
FileNamer fileNamer;

void setup() {
  size(1280, 720, P2D);

  startFrame = 60;
  numFrames = 40;

  background = loadImage("starfield.jpg");
  streaks = new LightStreaks(width, height);
  clip = new ShiaClip(startFrame, numFrames);
  tunnel = new ShiaTunnel(startFrame, numFrames);
  fileNamer = new FileNamer("output/export", "png");
}

void draw() {
  int currFrame = frameCount / 3 % numFrames;

  drawBackground(g);
  streaks.draw(g);
  tunnel.draw(g, currFrame);
  clip.draw(g, currFrame);
}

void drawBackground(PGraphics g) {
  float scale = 0.5;
  g.beginDraw();
  g.image(background, 0, 0, background.width * scale, background.height * scale);
  g.endDraw();
}

void keyReleased() {
  switch (key) {
    case 'r':
      save(fileNamer.next());
      break;
  }
}

