// Função para girar o matiz de uma imagem
PImage girarMatiz(PImage img, float angulo) {
  PImage novaImagem = createImage(img.width, img.height, RGB);
  img.loadPixels();
  novaImagem.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int corOriginal = img.pixels[y * img.width + x];
      float[] hsb = rgbToHsb(corOriginal);
      float novoHue = (hsb[0] + angulo) % 360; // Girar o matiz
      int novaCor = color(novoHue, saturation(corOriginal), brightness(corOriginal));
      novaImagem.pixels[y * img.width + x] = novaCor;
    }
  }
  
  novaImagem.updatePixels();
  return novaImagem;
}

// Função para converter uma cor de RGB para HSB
float[] rgbToHsb(int corRGB) {
  float r = red(corRGB);
  float g = green(corRGB);
  float b = blue(corRGB);
  float[] hsb = new float[3];
  colorMode(HSB, 360, 100, 100); // Define o modo de cor para HSB
  return hsb;
}
