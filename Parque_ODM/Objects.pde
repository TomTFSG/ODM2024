class Cloud {
  int x, y;
  int dir;
  color[][] c=new color[13][9];
  int[][] blank = {
    {0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {9, 0}, {10, 0}, {11, 0}, {12, 0},
    {0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {10, 1}, {11, 1}, {12, 1},
    {0, 2}, {1, 2}, {5, 2}, {11, 2}, {12, 2},
    {0, 3}, {12, 3},
    {0, 8}, {12, 8}
  };
  Cloud(int x, int y, color c) {
    this.x = x;
    this.y = y;
    dir=int(random(1,3));
    for (int cW = 0; cW < 13; cW++) {
      for (int cH = 0; cH < 9; cH++) {
        // Check if (cW, cH) is one of the specified coordinate pairs
        boolean isSpecified = false;
        for (int[] coordinates : blank) {
          if (cW == coordinates[0] && cH == coordinates[1]) {
            isSpecified = true;
            break;
          }
        }
        // If (cW, cH) is one of the specified coordinate pairs, set the color
        if (!isSpecified) {
          this.c[cW][cH]=c; // Set color of objectGrid cells to cloud color
        }
        else{
          this.c[cW][cH]=color(255,0);
        }
      }
    }
  }

  void move() {
    for (int cW = 0; cW < 13; cW++) {
      for (int cH = 0; cH < 9; cH++) {
        int gridX = (x + cW) % cols;
        if (gridX >= 0 && gridX < cols) {
          if(objectGrid[gridX][y + cH].getColor()==color(255,0) || objectGrid[gridX][y + cH].getColor()==this.c[cW][cH]){
            objectGrid[gridX][y + cH].setColor(color(255, 0));
          }
        }
      }
    }
    if (dir == 1) {
      x++;
      if (x >= cols) {
          x = 0;
      }
    } 
    else {
      x--;
      if (x < 0) {
          x = cols - 1;
      }
    }
    for (int cW = 0; cW < 13; cW++) {
      for (int cH = 0; cH < 9; cH++) {
        int gridX = (x + cW) % cols;
        if (gridX >= 0 && gridX < cols) {
            objectGrid[gridX][y + cH].setColor(c[cW][cH]);
        }
      }
    }
  }
}
class Tree{
  int x, y;
  int dir;
  color[][] spring=new color[22][50];
  color[][] summerA=new color[22][50];
  color[][] summerB=new color[22][50];
  color[][] autumnA=new color[22][50];
  color[][] autumnB=new color[22][50];
  color[][] winterA=new color[22][50];
  color[][] winterB=new color[22][50];
  color[][] winterC=new color[22][50];
  PImage origin;
  
  Tree(int x, int y) {
    origin=loadImage("trees.png");
    this.x = x;
    this.y = y;
    origin.loadPixels();
    for (int cW = 0; cW < 22; cW++) {
        for (int cH = 0; cH < 50; cH++) {
          int index = cW + cH * origin.width;
          color pixelColor = origin.pixels[index];
            if (alpha(pixelColor) > 0) {
              this.spring[cW][cH]=pixelColor;
            }
            else{
              this.spring[cW][cH]=color(255,0);
            }
        }
    }
    for (int cW = 22; cW < 44; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.summerA[cW-22][cH]=pixelColor;
          }
          else{
            this.summerA[cW-22][cH]=color(255,0);
          }
        }
      }
    for (int cW = 44; cW < 66; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.summerB[cW-44][cH]=pixelColor;
          }
          else{
            this.summerB[cW-44][cH]=color(255,0);
          }
        }
      }
    for (int cW = 66; cW < 88; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.autumnA[cW-66][cH]=pixelColor;
          }
          else{
            this.autumnA[cW-66][cH]=color(255,0);
          }
        }
      }
    for (int cW = 88; cW < 110; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.autumnB[cW-88][cH]=pixelColor;
          }
          else{
            this.autumnB[cW-88][cH]=color(255,0);
          }
        }
      }
    for (int cW = 110; cW < 132; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.winterA[cW-110][cH]=pixelColor;
          }
          else{
            this.winterA[cW-110][cH]=color(255,0);
          }
        }
      }
      for (int cW = 132; cW < 154; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.winterB[cW-132][cH]=pixelColor;
          }
          else{
            this.winterB[cW-132][cH]=color(255,0);
          }
        }
      }
      for (int cW = 154; cW < 176; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int index = cW + cH * origin.width;
        color pixelColor = origin.pixels[index];
          if (alpha(pixelColor) > 0) {
            this.winterC[cW-154][cH]=pixelColor;
          }
          else{
            this.winterC[cW-154][cH]=color(255,0);
          }
        }
      }
  }

  void draw(){
    for (int cW = 0; cW < 22; cW++) {
      for (int cH = 0; cH < 50; cH++) {
        int gridX = (x + cW) % cols;
        if (gridX >= 0 && gridX < cols) {
          if (dial>=0 && dial<=90) {
            objectGrid[gridX][y + cH].setColor(interpolateColors(spring[cW][cH], summerA[cW][cH], map(dial, 0, 90, 0, 1)));
          }
          if (dial>90 && dial<=140) {
            objectGrid[gridX][y + cH].setColor(summerA[cW][cH]);
          }
          if (dial>140 && dial<=180) {
            objectGrid[gridX][y + cH].setColor(summerB[cW][cH]);
          }
          if (dial>180 && dial<=230) {
            objectGrid[gridX][y + cH].setColor(autumnA[cW][cH]);
          }
          if (dial>230 && dial<=270) {
            objectGrid[gridX][y + cH].setColor(autumnB[cW][cH]);
          }
          if (dial>270 && dial<=300) {
            objectGrid[gridX][y + cH].setColor(winterA[cW][cH]);
          }
          if (dial>300 && dial<=330) {
            objectGrid[gridX][y + cH].setColor(winterB[cW][cH]);
          }
          if (dial>330 && dial<=360) {
            objectGrid[gridX][y + cH].setColor(spring[cW][cH]);
          }  
        }
      }
    }
  }
}
class Grass {
  int x, y;
  int frame;
  PImage[] origin;
  int frameCounter;
  boolean rev;

  Grass(int i, PImage[] img) {
    x = i * 5;
    y = rows - 18;
    origin = img;
    frame=0;
    frameCounter=0;
    rev=false;
  }
  
  void draw() {
    origin[frame].loadPixels();
    
    for (int w = 0; w < 5; w++) {
      for (int h = 0; h < 18; h++) {
        int gridX = (x + w) % cols;
        int gridY = (y + h) % rows;
        if (objectGrid[gridX][gridY].getColor() != color(255,0)) {
          continue;
        }
        objectGrid[gridX][gridY].setColor(color(255, 0));
      }
    }

    // Draw grass based on the dial value
    int startW = 0;
    int endW = 5;

    if (dial > 45 && dial <= 90) {
      startW = 35;
      endW = 40;
    } else if (dial > 90 && dial <= 135) {
      startW = 0;
      endW = 5;
    } else if (dial > 135 && dial <= 180) {
      startW = 5;
      endW = 10;
    } else if (dial > 180 && dial <= 230) {
      startW = 10;
      endW = 15;
    } else if (dial > 230 && dial <= 270) {
      startW = 15;
      endW = 20;
    } else if (dial > 270 && dial <= 315) {
      startW = 20;
      endW = 25;
    } else if (dial > 315 && dial <= 360) {
      startW = 25;
      endW = 30;
    } else if (dial >= 0 && dial <= 45) {
      startW = 30;
      endW = 35;
    }

    for (int w = startW; w < endW; w++) {
      for (int h = 0; h < 18; h++) {
        int gridX = (x + w - startW) % cols;
        int gridY = (y + h) % rows;
        int index = w + h * origin[frame].width;
        color pixelColor = origin[frame].pixels[index];
        if (alpha(pixelColor) > 0) {
          objectGrid[gridX][gridY].setColor(pixelColor);
        }
      }
    }
    
    frameCounter++;
    if (frameCounter == 5) {
      if(rev){
        if(frame==0){
          rev=!rev;
        }
        else{
          frame--;
        }
      }
      else{
        if(frame==origin.length-1){
          rev=!rev;
        }
        else{
          frame++;
        }
      }
      frameCounter=0;
    }
    
  }
}
