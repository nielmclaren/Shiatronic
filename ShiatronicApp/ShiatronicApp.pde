
int startFrame;
int numFrames;

PImage background;
LightStreaks streaks;
ShiaClip clip;
ShiaTunnel tunnel;
PFont subtitleFont;
FileNamer fileNamer;

void setup() {
  size(480, 270, P2D);

  startFrame = 60;
  numFrames = 40;

  background = loadImage("starfield.jpg");
  streaks = new LightStreaks(width, height);
  clip = new ShiaClip(startFrame, numFrames);
  tunnel = new ShiaTunnel(startFrame, numFrames);
  subtitleFont = createFont("Xolonium", 20);
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

void drawSubtitle(PGraphics g) {
  g.beginDraw();
  g.pushStyle();
  g.textFont(subtitleFont);
  g.textAlign(CENTER, CENTER);
  drawText(g, "Don't let your dreams be dreams.", 0.5 * width, 0.90 * height);
  g.popStyle();
  g.endDraw();
}

void drawText(PGraphics g, String text, float x, float y) {
  float offset = 1;
  g.fill(0);

  g.text(text, x + offset, y + offset);
  g.text(text, x - offset, y + offset);
  g.text(text, x + offset, y - offset);
  g.text(text, x - offset, y - offset);

  g.fill(255);
  g.text(text, x, y);
}

void keyReleased() {
  switch (key) {
    case 'r':
      save(fileNamer.next());
      break;
  }
}

