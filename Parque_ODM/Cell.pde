class BackgroundCell {
  color c;
  int x, y;
  int w,h;
  BackgroundCell(int x, int y, int w, int h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
  void setColor(color newC){
    c=newC;
  }
  void draw(){
    fill(c); // Fill color
    rect(x,y, w, h); // Draw rectangle at (i*w, j*h) with width w and height h
  }
}

class Cell {
  color c;
  int x, y;
  int w,h;
  Cell(int x, int y, int w, int h,color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c=c;
  }
  void clear(){
    setColor(color(255,0));
  }
  void setColor(color newC){
    c=newC;
  }
  color getColor(){
    return c;
  }
  void draw(){
    fill(c); // Fill color
    rect(x,y, w, h); // Draw rectangle at (i*w, j*h) with width w and height h
  }
}
