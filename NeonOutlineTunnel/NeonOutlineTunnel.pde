
int numFrames = 1540;

color pink;
color reddish;

ArrayList<Float> scales;
float scaleMultiplier;
float startScale;
float maxStartScale;
float maxScale;

PGraphics output;

void setup() {
  size(1280, 720, P2D);

  pink = 0xffcc5efc;
  reddish = 0xffb805c4;

  scales = new ArrayList<Float>();
  scaleMultiplier = 1.03;
  startScale = 0.1;
  maxStartScale = 0.15;
  maxScale = 6;

  loadAndProcessImage(8);
}

void draw() {
  updateScales();

  background(64);

  g.pushMatrix();
  g.translate(width/2, height/2);

  drawTunnel(g);

  g.popMatrix();
}

void updateScales() {
  for (int i = 0; i < scales.size(); i++) {
    float scale = scales.get(i);
    if (scale > maxScale) {
      scales.remove(i);
    }
    else {
      scales.set(i, scale * scaleMultiplier);
    }
  }

  if (scales.size() < 1 || scales.get(0) > maxStartScale) {
    scales.add(0, startScale);
  }
}

void drawTunnel(PGraphics g) {
  g.pushStyle();
  g.blendMode(ADD);

  for (int i = 0; i < scales.size(); i++) {
    float scale = scales.get(i);

    g.pushMatrix();
    g.scale(scale);
    g.translate(mouseX - width/2, mouseY - height/2);

    drawTunnelSection(g);

    g.popMatrix();
  }

  g.popStyle();
}

void drawTunnelSection(PGraphics g) {
  g.pushStyle();
  g.pushMatrix();

  g.imageMode(CENTER);

  g.tint(pink);
  g.image(output, 0, 0);

  g.tint(reddish);
  g.image(output, -2, 0.5);


  g.popMatrix();
  g.popStyle();
}

void loadAndProcessImage() {
  loadAndProcessImage(floor(random(1, 1541)));
}

void loadAndProcessImage(int index) {
  PImage outline = loadImage("in/" + getFilename(index));

  output = createGraphics(outline.width, outline.height, P2D);
  output.beginDraw();
  output.image(outline, 0, 0);
  output.endDraw();
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
