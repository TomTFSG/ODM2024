// Função para girar o matiz de uma imagem
PImage girarMatiz(PImage img, boolean rodar, int hue) {
  PImage novaImagem = createImage(img.width, img.height, RGB);
  
  img.loadPixels();
  novaImagem.loadPixels();
  
  int novaCor = 0;
     
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int corOriginal = img.pixels[y * img.width + x];
      float[] hsb = rgbToHsb(corOriginal);

      if(rodar){
        novaCor = color(hue, hsb[1], hsb[2]);
      }else{
        float novoHue = (hsb[0] + hue) % 360; // Girar o matiz
        novaCor= color(novoHue, hsb[1], hsb[2]);
      }
      
      novaImagem.pixels[y * img.width + x] = novaCor;
    }
  }
  
  novaImagem.updatePixels();
  
  colorMode(RGB, 255, 255, 255);
  return novaImagem;
}

// Função para converter uma cor de RGB para HSB
float[] rgbToHsb(int corRGB) {
  float r = red(corRGB);
  float g = green(corRGB);
  float b = blue(corRGB);
  float[] hsb = new float[3];
  
  hsb[0] = hue(color(r,g,b));
   hsb[1] = saturation(color(r,g,b));
    hsb[2] = brightness(color(r,g,b));
    
  colorMode(HSB, 360, 100, 100); // Define o modo de cor para HSB
  return hsb;
}
