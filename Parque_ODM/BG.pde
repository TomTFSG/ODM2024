class Ground {
  color c;
  Ground(color c) {
    this.c=c;
  }
  
  void drawLastRow() {
    this.c=verde;
    for (int i = 0; i < cols; i++) {
      objectGrid[i][rows-1].setColor(c);
    }
  }
}

class Sky {
  color c;
  Sky(color c) {
    this.c=c;
  }
  
  void drawS() {
    this.c=ceu;
    for (int i = 0; i < cols; i++) {
      for(int l=0;l<rows-1;l++){
        backgroundGrid[i][l].setColor(c);
      }
    }
  }
}

class TopRow {
  int cols;
  
  TopRow(int cols) {
    this.cols = cols;
  }
  
  void draw() {
    for (int i = 0; i < cols; i++) {
      fill(0); // Set text color to black
      textAlign(CENTER);
      textSize(10);
      String label = getColumnLabel(i); // Generate column label
      text(label, i * w + w / 2, h / 2 +5); // Draw text at the top of each column
    }
  }
  
  String getColumnLabel(int index) {
    StringBuilder label = new StringBuilder();
    while (index >= 0) {
      label.insert(0, (char)('A' + index % 26));
      index = index / 26 - 1;
    }
    return label.toString();
  }
}
