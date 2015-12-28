
class Palette {
  ArrayList<Integer> colors;

  Palette() {
    colors = new ArrayList<Integer>();
  }

  Palette add(color c) {
    colors.add(c);
    return this;
  }

  Palette add(color c, int weight) {
    for (int i = 0; i < weight; i++) {
      colors.add(c);
    }
    return this;
  }

  color random() {
    if (colors.size() < 1) {
      return 0xff000000;
    }

    int i = (int) (Math.random() * colors.size());
    return (color) colors.get(i);
  }
}
