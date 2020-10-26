// Lillian Schwartz/Kenneth Knowlton's Pixillation. Scene recreation. 
// For course MAS.S48: Recreating the past (MAS.S68), instr. Zach Lieberman
// Fall 2020
// Based on the Reaction-Diffusion Algorithm, by Carl Sims
// >> https://www.karlsims.com/rd.html
// Adaptation of p5.js code for Processing --> https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_013_ReactionDiffusion/P5/sketch.js

ArrayList<CellList> grid = new ArrayList<CellList>();   // to keep pixel col values
ArrayList<CellList> next = new ArrayList<CellList>();   // to keep next pixel col values

float dA = 1.0;
float dB = 0.5;
float feed = 0.55;      // feed rate of chemical A
float kill = 0.062;     // kill rate of chemical B

// The convolution matrix for stored as a 3 x 3 two-dimensional array
float[][] matrix = { { 0.05, 0.2, 0.05 } , 
                     { 0.2 , -1 , 0.2  } ,
                     { 0.05, 0.2, 0.05 } } ;

void setup(){
  size(200, 300);
  background(255);
  pixelDensity(1);
  initGrid(grid);
  initGrid(next);  
  
  
  // Create rectangle with chem B
  for (int i = width/2 - 10 ; i < width/2 + 10; i++){
    for (int j = height / 2 - 10; j < height / 2 + 10; j++){
      grid.get(i).getCell(j).setParameter('b', 0.2);
      //grid.get(i).getCell(j).setParameter('a', 0);
      println(grid.get(i).getCell(j).b);
    }
  }
  
}

void draw(){
  background(0);
  update_next();
  loadPixels();
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++) {
      //col = color(random(255), 0, random(50, 200));
      int pix = (x + y * width);      // pixel location on grid
      int red = int(next.get(x).getCell(y).a * 255);
      int green = 0;
      int blue = int(next.get(x).getCell(y).b * 255);
      int alpha = 255;     
      pixels[pix] = color(red, green, blue, alpha);
      
      //println(grid.get(x).getCell(y).a);
    }
    //println("pixel color:", pixels[0]);
    //println("length:", pixels.length);
  } 
  updatePixels();
  swap();
}

void initGrid(ArrayList<CellList> _grid){
  //add aList to grid and next
  for (int y = 0; y < height; y++){
    CellList a = new CellList();
    _grid.add(a);
  }
}


// A function to Update grid Next
void update_next(){
  for (int x = 1; x < width -1; x++){
    for (int y = 1; y < height -1; y++){
      //float new_a = grid.get(x).getCell(y).a * 0.9;
      //float new_b = grid.get(x).getCell(y).b * 0.8;
      float a = grid.get(x).getCell(y).a;
      float b = grid.get(x).getCell(y).b;
      println(b);
      float new_a = a + (dA * laplace(x, y, 'a')) - (a * b * b) + (feed * (1 - a));
      float new_b = b + (dB * laplace(x, y, 'b')) + (a * b * b) - ((kill + feed) * b);
      //float new_a = a + (dA * laplaceA(x, y)) - (a * b * b) + (feed * (1 - a));
      //float new_b = b + (dB * laplaceB(x, y)) + (a * b * b) - ((kill + feed) * b);
      
      
      next.get(x).getCell(y).setParameter('a', new_a);
      next.get(x).getCell(y).setParameter('b', new_b);
      //println(grid.get(x).getCell(y).a);
      //println(new_a);
      //println(new_b);
    }
  }
}

void swap(){
  ArrayList<CellList> temp = grid;
  grid = next;
  next = temp;
}

float laplaceA(int x, int y){
  // For chemical A 
  float sumA = 0;
  for (int i = -1; i <= 1; i++){
    for (int j = -1; j <= 1; j++){
      sumA += grid.get(x + i).getCell(y + i).a * matrix[i+1][j+1];
    }
  }
  return sumA;
}

float laplaceB(int x, int y){
  // For chemical B 
  float sumB = 0;
  for (int i = -1; i <= 1; i++){
    for (int j = -1; j <= 1; j++){
      sumB += grid.get(x + i).getCell(y + i).b * matrix[i+1][j+1];
    }
  }
  return sumB;
}

float laplace(int x, int y, char c){
  // For chemical c : 'a' or 'b'
  float sum = 0;
  for (int i = -1; i <= 1; i++){
    for (int j = -1; j <= 1; j++){
      sum += grid.get(x + i).getCell(y + i).getAB(c) * matrix[i+1][j+1];
    }
  }
  return sum;
}
