class Particle{
  PVector pos,target;
  PVector acc;
  PVector vel,acel;
  int size;
  float mapped_angle;
  color cor;
  float maxForce;
  Particle(int x,int y,color c,int s){
    this.pos=new PVector(width/2,height/2);
    this.vel=new PVector(0,0);
    this.acc=new PVector(0,0);
    this.target=new PVector(x,y);
    this.size=s;
    this.mapped_angle= map(x, 0, img.width, -180, 180) + map(y, 0, img.height, -180, 180);
    this.cor=c;
    this.maxForce=FORCE;
  }
  void show(){
    noStroke();
    fill(cor);
    rectMode(CENTER);
    rect(pos.x,pos.y,size,size);
  }
  void move(){
    goToTarget();
    
    avoid();
    
    this.vel.mult(0.95);
    
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  void goToTarget(){
    PVector steer= new PVector(target.x,target.y);
    float distance=dist(this.pos.x, this.pos.y, this.target.x, this.target.y);
    if (distance > 0.5) {
      int distThreshold = 20;
      steer.sub(this.pos);
      steer.normalize();
      steer.mult(map(min(distance, distThreshold), 0, distThreshold, 0, this.maxForce));
      this.acc.add(steer);
    }
  }
  void avoid() {
  int px = int(this.pos.x);
  int py = int(this.pos.y);
  
  // Define the size of the neighborhood to check for movement
  int neighborhoodSize = 5; // Adjust as needed
  
  for (int dx = -neighborhoodSize; dx <= neighborhoodSize; dx++) {
    for (int dy = -neighborhoodSize; dy <= neighborhoodSize; dy++) {
      // Calculate the index of the pixel in the moved array
      int index = (px + dx) + (py + dy) * img.width;
      
      // Check if the index is within bounds
      if (index >= 0 && index < moved.length && moved[index]) {
        // Calculate the distance between the particle and the pixel
        float distance = dist(this.pos.x, this.pos.y, px + dx, py + dy);
        
        // Repulse the particle if it's within the repulsion radius
        if (distance < REPULSION_RADIUS) {
          PVector repulse = new PVector(this.pos.x, this.pos.y);
          repulse.sub(px + dx, py + dy);
          repulse.mult(map(distance, REPULSION_RADIUS, 0, 0, REPULSION_STRENGTH));
          this.acc.add(repulse);
        }
      }
    }
  }
}

}
