
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

void drawTunnel(PGraphics canvas) {
  PGraphics g = createGraphics(canvas.width, canvas.height, P2D);

  g.pushStyle();
  g.pushMatrix();

  g.beginDraw();

  g.background(0);

  g.noFill();
  g.strokeWeight(15);

  g.stroke(pink);
  drawTunnelShape(g);

  blur(g, blur20);

  g.stroke(pink, 128);
  drawTunnelShape(g);

  blur(g, blur5);

  g.strokeWeight(8);

  g.stroke(reddish);
  drawTunnelShape(g);

  g.translate(-4, 2);

  g.stroke(pink);
  drawTunnelShape(g);

  g.endDraw();

  g.popMatrix();
  g.popStyle();

  canvas.image(g, 0, 0);
}

void drawTunnelShape(PGraphics g) {
  g.quad(
    0.3 * width, 0.2 * height,
    0.7 * width, 0.2 * height,
    0.8 * width, 0.8 * height,
    0.2 * width, 0.8 * height);
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

