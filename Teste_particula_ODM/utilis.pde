void newImageLoad(){
  img=loadImage("1.jpg");
  img.resize(width,height);
  int particlesWidth = ceil(float(img.width) / PARTICLE_RATIO);
  int particlesHeight = ceil(float(img.height) / PARTICLE_RATIO);
  
  // Calculate the total number of particles
  PARTICLE_COUNT = particlesWidth * particlesHeight;
  
  // Calculate the actual particle size
  partSize = max(img.width, img.height) / max(particlesWidth, particlesHeight);
  spawnParticles();
}

void spawnParticles(){
  particles= new Particle[PARTICLE_COUNT];
  color[]cores=setupImg(); //Vai buscar todas as cores de cada pixel na imagem
  int n = 0;
  for (int x = 0; x < img.width; x = x + PARTICLE_RATIO) {
    for (int y = 0; y < img.height; y = y + PARTICLE_RATIO) {
        int index = x + y * img.width;
        if(cores[index]==color(#CF9D48)){
          particles[n] = new Particle(x, y, cores[index], partSize);
          n++;
        }
    }
  }
  PARTICLE_COUNT=n;
}
color[] setupImg(){
  color[] cores=new color[img.width*img.height];
  for(int x=0;x<img.width;x++){
    for(int y=0;y<img.height;y++){
      int index= (x + y * img.width);
      color cor=color(img.pixels[index]);
      cores[index]=cor;
    }
  }
  return cores;
}
