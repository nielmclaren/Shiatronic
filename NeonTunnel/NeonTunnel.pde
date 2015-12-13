

color reddish = 0xffa55ef8;
color pink = 0xffcc5efc;
color bluish = 0xffcc13e1;
color other = 0xff270004;

void setup() {
  size(640, 640, P2D);

  println(red(pink) - red(reddish));
  println(green(pink) - green(reddish));
  println(blue(pink) - blue(reddish));
}

void draw() {
  drawBackground(g);
  drawTunnel(g);
}

void drawBackground(PGraphics g) {
  g.background(0);
}

void drawTunnel(PGraphics g) {
  g.pushStyle();
  g.pushMatrix();

  g.noFill();
  g.strokeWeight(8);

  g.blendMode(ADD);

  g.stroke(bluish);
  drawTunnelShape(g);

  g.translate(2, 2);
  g.stroke(reddish);
  drawTunnelShape(g);

  g.popMatrix();
  g.popStyle();
}

void drawTunnelShape(PGraphics g) {
  g.quad(
    0.3 * width, 0.2 * height,
    0.7 * width, 0.2 * height,
    0.8 * width, 0.8 * height,
    0.2 * width, 0.8 * height);

}
