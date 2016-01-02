
class ShiaTunnel {
  private final color pink = 0xffcc5efc;
  private final color reddish = 0xffb805c4;

  private ArrayList<TunnelSection> tunnelSections;
  private float scaleMultiplier;
  private float startScale;
  private float maxStartScale;
  private float maxScale;

  private ArrayList<PImage> outlines;

  private boolean isPaused;

  ShiaTunnel(int startFrame, int numFrames) {
    tunnelSections = new ArrayList<TunnelSection>();
    scaleMultiplier = 1.03;
    startScale = 1;
    maxStartScale = 1.12;
    maxScale = 12;

    println("Loading outlines...");
    outlines = new ArrayList<PImage>();
    for (int i = startFrame; i < startFrame + numFrames; i++) {
      outlines.add(loadOutline(i));
    }
    println("Loading outlines complete.");

    isPaused = false;
  }

  boolean isPaused() {
    return isPaused;
  }

  ShiaTunnel isPaused(boolean v) {
    isPaused = v;
    return this;
  }

  void draw(PGraphics g, int currFrame) {
    updateScales(currFrame);

    g.beginDraw();
    g.pushMatrix();
    g.translate(width/2, height/2);

    drawTunnel(g);

    g.popMatrix();
    g.endDraw();
  }

  private void updateScales(int currFrame) {
    if (isPaused) {
      return;
    }

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

  private void drawTunnel(PGraphics g) {
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

  private void drawTunnelSection(PGraphics g, TunnelSection ts) {
    PImage outline = outlines.get(ts.frame());

    g.pushStyle();
    g.imageMode(CENTER);

    g.tint(pink);
    g.image(outline, 0, 0);

    g.tint(reddish);
    g.image(outline, -2, 0.5);

    g.popStyle();
  }

  PImage loadOutline(int index) {
    return loadImage("outlines270/" + getFilename(index));
  }

  String getFilename(int index) {
    return "frame" + nf(index, 4) + ".png";
  }
}
