
color pink;
color reddish;

int numFrames = 1540;

PGraphics output;

void setup() {
  size(1280, 720, P2D);

  pink = 0xffcc5efc;
  reddish = 0xffb805c4;

  loadAndProcessImage(8);
}

void draw() {
  background(64);
  drawTunnel(g);
}

void drawTunnel(PGraphics g) {
  g.pushMatrix();
  g.translate(width/2, height/2);

  g.pushStyle();
  g.blendMode(ADD);

  println(mouseX);
  int numTunnelSections = 15;
  for (int i = 0; i < numTunnelSections; i++) {
    g.pushMatrix();
    g.scale(pow(2, map(i, 0, numTunnelSections, 0.001, 3)) - 1);
    g.translate(mouseX - width/2, mouseY - height/2);

    drawTunnelSection(g);

    g.popMatrix();
  }

  g.popStyle();
  g.popMatrix();
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

