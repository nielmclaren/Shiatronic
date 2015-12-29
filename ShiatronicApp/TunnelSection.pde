
class TunnelSection {
  private float scale;
  private int frame;

  TunnelSection() {
    scale = 1;
    frame = 0;
  }

  float scale() {
    return scale;
  }

  TunnelSection scale(float v) {
    scale = v;
    return this;
  }

  int frame() {
    return frame;
  }

  TunnelSection frame(int v) {
    frame = v;
    return this;
  }
}
