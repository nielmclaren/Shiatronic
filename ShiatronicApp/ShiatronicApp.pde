
int startFrame;
int numFrames;

PImage background;
LightStreaks streaks;
ShiaClip clip;
ShiaTunnel tunnel;
PFont subtitleFont;
FileNamer fileNamer;

void setup() {
  size(270, 270, P2D);

  // 70, 60; 130, 50; 198, 60; 370, 65; 444, 50; 649, 50; 1012, 80; 1092, 40;
  startFrame = 1092;
  numFrames = 40;

  background = loadImage("starfield.jpg");
  streaks = new LightStreaks(width, height);
  clip = new ShiaClip(startFrame, numFrames);
  tunnel = new ShiaTunnel(startFrame, numFrames);
  subtitleFont = createFont("Xolonium", 20);
  fileNamer = new FileNamer("output/export", "png");
}

void draw() {
  int currFrame = frameCount / 2 % numFrames;
  drawFrame(g, currFrame);
}

void drawFrame(PGraphics g, int frame) {
  drawBackground(g);
  streaks.draw(g);
  tunnel.draw(g, frame);
  clip.draw(g, frame);
  drawSubtitle(g);
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
  drawText(g, "Yes you can!", 0.5 * width, 0.90 * height);
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

void saveFrames() {
  PGraphics g = createGraphics(width, height, P3D);
  FileNamer fileNamer = new FileNamer("output09/frame", "gif");
  for (int i = 0; i < numFrames * 2; i++) {
    drawFrame(g, floor(i/2));
    g.save(fileNamer.next());
  }
}

void keyReleased() {
  switch (key) {
    case 'r':
      save(fileNamer.next());
      break;
    case 's':
      saveFrames();
      break;
  }
}
