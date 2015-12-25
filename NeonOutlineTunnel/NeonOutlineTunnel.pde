
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

void setup() {
  size(1280, 720, P2D);

  pink = 0xffcc5efc;
  reddish = 0xffb805c4;

  tunnelSections = new ArrayList<TunnelSection>();
  scaleMultiplier = 1.02;
  startScale = 0.1;
  maxStartScale = 0.15;
  maxScale = 9;

  frameDuration = 100;
  frameUpdated = millis();
  currFrame = 0;

  frames = new ArrayList<PImage>();
  for (int i = 0; i < numFrames; i++) {
    frames.add(loadAndProcessImage(i));
  }
}

void draw() {
  updateFrame();

  updateScales();

  background(64);

  g.pushMatrix();
  g.translate(width/2, height/2);

  drawTunnel(g);

  g.popMatrix();
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
    g.translate(mouseX - width/2, mouseY - height/2);

    drawTunnelSection(g, ts);

    g.popMatrix();
  }

  g.popStyle();
}

void drawTunnelSection(PGraphics g, TunnelSection ts) {
  PImage frame = frames.get(ts.frame());

  g.pushStyle();
  g.pushMatrix();

  g.imageMode(CENTER);

  g.tint(pink);
  g.image(frame, 0, 0);

  g.tint(reddish);
  g.image(frame, -2, 0.5);

  g.popMatrix();
  g.popStyle();
}

void updateFrame() {
  int now = millis();
  int delta = now - frameUpdated;
  currFrame += floor(delta / frameDuration);
  frameUpdated = now - delta % frameDuration;
  while (currFrame >= numFrames) {
    currFrame -= numFrames;
  }
}

PImage loadAndProcessImage(int index) {
  return loadImage("in/" + getFilename(index));
}

String getFilename(int index) {
  return "frame" + nf(index, 4) + ".png";
}

void keyReleased() {
  switch (key) {
  }
}

void mouseReleased() {
  println(mouseX + ", " + mouseY);
}
