
int numFrames = 100;

color pink;
color reddish;

ArrayList<TunnelSection> tunnelSections;
float scaleMultiplier;
float startScale;
float maxStartScale;
float maxScale;

int frameDuration;
int frameUpdated;
int currFrame;

ArrayList<PImage> frames;
ArrayList<PImage> outlines;

boolean isPaused;

void setup() {
  size(1280, 720, P2D);

  pink = 0xffcc5efc;
  reddish = 0xffb805c4;

  tunnelSections = new ArrayList<TunnelSection>();
  scaleMultiplier = 1.03;
  startScale = 0.5;
  maxStartScale = 0.62;
  maxScale = 12;

  frameDuration = 100;
  frameUpdated = millis();
  currFrame = 0;

  frames = new ArrayList<PImage>();
  outlines = new ArrayList<PImage>();
  for (int i = 0; i < numFrames; i++) {
    frames.add(loadAndProcessFrame(i));
    outlines.add(loadAndProcessOutline(i));
  }

  isPaused = false;
}

void draw() {
  updateFrame();

  updateScales();

  background(64);

  drawOutline(g);
  drawFrame(g);
}

void drawOutline(PGraphics g) {
  g.pushMatrix();
  g.translate(width/2, height/2);

  drawTunnel(g);

  g.popMatrix();
}

void drawFrame(PGraphics g) {
  g.pushStyle();
  g.pushMatrix();

  g.translate(width/2, height/2);
  g.scale(0.5);

  g.imageMode(CENTER);

  PImage frame = frames.get(currFrame);
  g.image(frame, 0, 0);

  g.popMatrix();
  g.popStyle();
}

void updateScales() {
  for (int i = 0; i < tunnelSections.size(); i++) {
    TunnelSection ts = tunnelSections.get(i);
    float scale = ts.scale();
    if (scale > maxScale) {
      tunnelSections.remove(i);
    }
    else {
      ts.scale(scale * scaleMultiplier);
    }
  }

  if (tunnelSections.size() < 1 || tunnelSections.get(0).scale > maxStartScale) {
    TunnelSection ts = (new TunnelSection())
      .scale(startScale)
      .frame(currFrame);
    tunnelSections.add(0, ts);
  }
}

void drawTunnel(PGraphics g) {
  g.pushStyle();
  g.blendMode(ADD);

  for (int i = 0; i < tunnelSections.size(); i++) {
    TunnelSection ts = tunnelSections.get(i);
    float scale = ts.scale();

    g.pushMatrix();
    g.scale(scale);

    drawTunnelSection(g, ts);

    g.popMatrix();
  }

  g.popStyle();
}

void drawTunnelSection(PGraphics g, TunnelSection ts) {
  PImage outline = outlines.get(ts.frame());

  g.pushStyle();
  g.pushMatrix();

  g.imageMode(CENTER);

  g.tint(pink);
  g.image(outline, 0, 0);

  g.tint(reddish);
  g.image(outline, -2, 0.5);

  g.popMatrix();
  g.popStyle();
}

void updateFrame() {
  int now = millis();

  if (isPaused) {
    frameUpdated = now;
    return;
  }

  int delta = now - frameUpdated;
  currFrame += floor(delta / frameDuration);
  frameUpdated = now - delta % frameDuration;
  while (currFrame >= numFrames) {
    currFrame -= numFrames;
  }
}

PImage loadAndProcessFrame(int index) {
  return loadImage("frames/" + getFilename(index));
}

PImage loadAndProcessOutline(int index) {
  return loadImage("outlines/" + getFilename(index));
}

String getFilename(int index) {
  return "frame" + nf(index, 4) + ".png";
}

void keyReleased() {
  switch (key) {
    case ' ':
      isPaused = !isPaused;
      break;
  }
}

void mouseReleased() {
  println(mouseX + ", " + mouseY);
}
