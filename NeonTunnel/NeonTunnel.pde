
color pink;
color reddish;

FastBlurrer blur20;
FastBlurrer blur5;

void setup() {
  size(640, 640, P2D);

  pink = 0xffcc5efc;
  reddish = 0xffb805c4;

  blur20 = new FastBlurrer(width, height, 20);
  blur5 = new FastBlurrer(width, height, 5);

  reset();
}

void draw() {
}

void reset() {
  drawBackground(g);
  drawTunnel(g);
}

void drawBackground(PGraphics g) {
  g.background(0);
}

void drawTunnel(PGraphics g) {
  g.pushMatrix();
  g.translate(width/2, height/2);

  g.pushStyle();
  g.blendMode(ADD);

  int numTunnelSections = 15;
  for (int i = 0; i < numTunnelSections; i++) {
    g.pushMatrix();
    g.scale(pow(2, map(i, 0, numTunnelSections, 0.001, 2)) - 1);

    drawTunnelSection(g);

    g.popMatrix();
  }

  g.popStyle();
  g.popMatrix();
}

void drawTunnelSection(PGraphics canvas) {
  PGraphics g = createGraphics(canvas.width, canvas.height, P2D);

  g.pushStyle();
  g.pushMatrix();

  g.beginDraw();

  g.background(0);

  g.noFill();
  g.strokeWeight(8);

  g.stroke(pink);
  drawTunnelShape(g);

  blur(g, blur20);

  g.stroke(pink, 128);
  drawTunnelShape(g);

  blur(g, blur5);

  g.strokeWeight(4);

  g.stroke(reddish);
  drawTunnelShape(g);

  g.translate(-2, 0.5);

  g.stroke(pink);
  drawTunnelShape(g);

  g.endDraw();

  g.popMatrix();
  g.popStyle();

  canvas.pushStyle();
  canvas.imageMode(CENTER);
  canvas.image(g, 0, 0);
  canvas.popStyle();
}

void drawTunnelShape(PGraphics g) {
  g.quad(
    0.3 * g.width, 0.2 * g.height,
    0.7 * g.width, 0.2 * g.height,
    0.8 * g.width, 0.8 * g.height,
    0.2 * g.width, 0.8 * g.height);
}

void blur(PGraphics g, FastBlurrer blurrer) {
  g.loadPixels();
  blurrer.blur(g.pixels);
  blurrer.blur(g.pixels);
  blurrer.blur(g.pixels);
  g.updatePixels();
}

void keyReleased() {
  switch (key) {
    case ' ':
      reset();
      break;

    case 'r':
      saveFrame();
      break;
  }
}

