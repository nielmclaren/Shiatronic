
class ShiaClip {
  private ArrayList<PImage> frames;

  ShiaClip(int startFrame, int numFrames) {
    println("Loading frames...");
    frames = new ArrayList<PImage>();
    for (int i = startFrame; i < startFrame + numFrames; i++) {
      frames.add(loadFrame(i));
    }
    println("Loading frames complete.");
  }

  void draw(PGraphics g, int currFrame) {
    g.beginDraw();
    g.pushStyle();
    g.pushMatrix();

    g.translate(width/2, height/2);

    g.imageMode(CENTER);

    PImage frame = frames.get(currFrame);
    g.image(frame, 0, 0);

    g.popMatrix();
    g.popStyle();
    g.endDraw();
  }

  PImage loadFrame(int index) {
    return loadImage("frames270/" + getFilename(index));
  }

  String getFilename(int index) {
    return "frame" + nf(index, 4) + ".png";
  }
}
