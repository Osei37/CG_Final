// CG Final work

// image files
PImage treeImage,cobblestoneImage,roofImage,wallImage,snowImage;

// global variables
int zoom = 0;
int seazon = 0;
Tree tree;
int MAX = 16384;
int WARPNUM = 3000;
int count = 0;

float[] createBranchArray = new float[MAX];
float[] opennessArray = new float[MAX];
float[] stemArray = new float[MAX];
float[][] treeRArray = new float[4][MAX];
float[][] treeGArray = new float[4][MAX];
float[][] treeBArray = new float[4][MAX];
float[] warpx = new float[WARPNUM];
float[] warpy = new float[WARPNUM];

// setup
void setup(){
  size(600, 600, P3D);
  treeImage=loadImage("wood.gif");
  cobblestoneImage=loadImage("isi.gif");
  roofImage=loadImage("glass.gif");
  snowImage=loadImage("snow.gif");
  wallImage=loadImage("wall.gif");
  setparam();
  tree = new Tree();
  noStroke();
}

// initialization
void setparam(){
  for(int i = 0; i < MAX; i++){
    createBranchArray[i] = random(1.0);
    opennessArray[i] = random(-20, 20);
    stemArray[i] = random(-20, 20);
    treeRArray[0][i] = random(220, 255);
    treeGArray[0][i] = random(100, 160);
    treeBArray[0][i] = random(100, 160);
    treeRArray[1][i] = random(0, 25);
    treeGArray[1][i] = random(128, 255);
    treeBArray[1][i] = random(0, 25);
    treeRArray[2][i] = random(220, 255);
    treeGArray[2][i] = random(30, 90);
    treeBArray[2][i] = random(0, 60);
    treeRArray[3][i] = random(220, 255);
    treeGArray[3][i] = random(220, 255);
    treeBArray[3][i] = random(220, 255);
  }
  setwarp();
}

// warp initialization
void setwarp(){
  for(int i = 0; i < WARPNUM; i++){
    warpx[i] = 0;
    warpy[i] = 0;
  }
}  

// draw
void draw(){
  // setting ambientLight
  ambientLight(150, 150, 150);
  
  // setting situations:
  // spring morning
  if(seazon == 0){
    background(160, 216, 239);
    directionalLight(128, 128, 128, 1, 1, 1);
    pushMatrix();
    translate(-1000, -1800, -3000);
    emissive(255);
    sphere(100);
    popMatrix();
  }
  // summer noon
  else if(seazon == 1){
    background(160, 216, 239);
    directionalLight(128, 128, 128, 0, 1, 1);
    pushMatrix();
    translate(0, -2000, -3000);
    emissive(255);
    sphere(100);
    popMatrix();
  }
  // autumn evening
  else if(seazon == 2){
    background(255, 99, 0);
    directionalLight(128, 128, 128, -1, 1, 1);
    pushMatrix();
    translate(1000, -1800, -3000);
    emissive(255, 165, 0);
    sphere(100);
    popMatrix();
  }
  // winter night
  else{
    background(30, 30, 30);
    directionalLight(128, 128, 128, 0, 1, 1);
    pushMatrix();
    translate(0, -2000, -3000);
    emissive(255, 204, 51);
    sphere(100);
    popMatrix();
  }
  // reset emissive
  emissive(0);
  
  noStroke();
  translate(0, 120, 100);
  int treeNumber=0;

  // torii 1
  pushMatrix();
  translate(0, 0, -150);
  drawTorii();
  popMatrix();

  // torii 2
  pushMatrix();
  translate(0, 0, 900);
  drawTorii();
  popMatrix();

  // warp
  if(zoom > 1300){
    pushMatrix();
    translate(0, -110, -100);
    warp();
    popMatrix();
  }

  // tree left
  for(int i = 0; i < 4; i++){
    pushMatrix();
    translate(-200, 0, 700-200 * i);
    drawTree(treeNumber++);
    popMatrix();
  }

  // tree right
  for(int i = 0; i < 4; i++){
    pushMatrix();
    translate(200, 0, 700 - 200 * i);
    drawTree(treeNumber++);
    popMatrix();
  }
  
  // tree far
  for(int i = 0; i < 3; i++){
    pushMatrix();
    translate(200 - 200 * i, 0, -400);
    drawTree(treeNumber++);
    popMatrix();
  }
  for(int i = 0; i < 5; i++){
    pushMatrix();
    translate(500 - 200 * i, 0, -800);
    drawTree(treeNumber++);
    popMatrix();
  }
  
  // cobblestone
  for(int i = 0; i < 11; i++){
    pushMatrix();
    translate(0,0,880 - 100 * i);
    texturedBox(100, 1, 100, 1);
    popMatrix();
  }
  
  // ground
  pushMatrix();
  // spring, summer, autumn
  if(seazon != 3){
    translate(0, 1, 0);
    texturedBox(2500, 1, 2500, 2);
  }
  // winter
  else{
    translate(0, -1, 0);
    texturedBox(2500, 1, 2500, 3);
  }
  popMatrix();  
  
  // wall left
  for(int i = 0; i < 3; i++){
    pushMatrix();
    translate(-600, -150, 600 - 500 * i);
    rotateZ(-PI);
    drawWall(200, 300, 500);
    popMatrix();
  }

  // wall right
  for(int i = 0; i < 3; i++){
    pushMatrix();
    translate(600, -150, 600 - 500 * i);
    rotateX(PI);
    drawWall(200, 300, 500);
    popMatrix();
  }

  // camera
  camera(0, 0, 1500 - zoom, 0, 0, 0, 0, 1.0, 0);
  zoom += 10;
  if(zoom > 1450){
    zoom = 400;
    setwarp();
    seazon++;
  }
  if(seazon == 4){
    setparam();
    seazon = 0;
  } 
}

// Torii
void drawTorii(){
  // top black
  pushMatrix();
    translate(0, -227, 0);
    fill(0);
    box(200, 10, 30);
  popMatrix();

  // top red
  pushMatrix();
    translate(0, -217, 0);
    fill(255, 0, 0);
    box(190, 10, 20);
  popMatrix();

  // bottum red
  pushMatrix();
    translate(0, -187, 0);
    fill(255, 0, 0);    
    box(170, 10, 20);
  popMatrix();
  
  // center red
  pushMatrix();
    translate(0, -202, 0);
    fill(255, 0, 0);    
    box(10, 20, 15);
  popMatrix();

  // prop
  pushMatrix();
    fill(255, 0, 0);
    translate(60, -110, 0);
    rotateZ(radians(-3));
    pillar(217, 8, 10, 30, 0);
    fill(0);
    translate(0, 85, 0);
    pillar(50, 12, 14, 30, 0);
  popMatrix();

  pushMatrix();
    fill(255, 0, 0);
    translate(-60, -110, 0);
    rotateZ(radians(3));
    pillar(217, 8, 10, 30, 0);
    fill(0);
    translate(0, 85, 0);
    pillar(50, 12, 14, 30, 0);
  popMatrix();
}

// create pillar (length, top radius, bottom radius, int resolution, int texturenumber)
void pillar(float length, float radius1, float radius2, int res, int MODE){
  float x, y, z;
  pushMatrix();
  //top surface
  beginShape(TRIANGLE_FAN);
  y = -length / 2;
  vertex(0, y, 0);
  for(int deg = 0; deg <= 360; deg = deg + res){
    x = cos(radians(deg)) * radius1;
    z = sin(radians(deg)) * radius1;
    vertex(x, y, z);
  }
  endShape();
  //buttom surface
  beginShape(TRIANGLE_FAN);
  y = length / 2;
  vertex(0, y, 0);
  for(int deg = 0; deg <= 360; deg = deg + res){
    x = cos(radians(deg)) * radius2;
    z = sin(radians(deg)) * radius2;
    vertex(x, y, z);
  }
  endShape();
  //side surface
  beginShape(TRIANGLE_STRIP);
  if(MODE==1){
    texture(treeImage);
    textureMode(NORMAL);
  }
  
  for(int deg =0; deg <= 360; deg = deg + res){
    x = cos(radians(deg)) * radius1;
    y = -length / 2;
    z = sin(radians(deg)) * radius1;
    if(MODE==1){
      vertex(x, y, z, 0, deg%60);
    }
    else{
      vertex(x, y, z);
    }
    x = cos(radians(deg)) * radius2;
    y = length / 2;
    z = sin(radians(deg)) * radius2;
    if(MODE==1){
      vertex(x, y, z, 1, deg%60);
    }
    else{
      vertex(x, y, z);
    }
  }
  endShape();
  popMatrix();
}

// Tree
void drawTree(int treeNumber){
  fill(0);
  pushMatrix();
  translate(0, -37.5, 0);
  fill(255);
  pillar(-75, 18, 12, 30, 1);
  popMatrix();
  
  pushMatrix();
  translate(0, -60, 0);
  count=0;
  tree.display(treeNumber);
  popMatrix();  
}

class Tree{
  
  float stem, openness, scale;
  int branch, depth, maxDepth;
  
  Tree(){
    stem = 80.0;
    openness = 30;
    scale = 0.7;
    branch = 5;
    depth = 0;
    maxDepth = 4;
  }

  Tree(float _stem, float _openness, float _scale,
       int _branch, int _depth, int _maxDepth){
    stem = _stem;
    openness = _openness;
    scale = _scale;
    branch = _branch;
    depth = _depth;
    maxDepth = _maxDepth;
  }
  void display(int treeNumber){
    pushMatrix();
    for(int bi = 0; bi < branch; bi++){
      pushMatrix();
      float radian1 = radians(openness + opennessArray[count + treeNumber]);
      float radian2 = TWO_PI * (float(bi) / branch);
      float x = (stem+stemArray[count + treeNumber]) * sin(radian1) * cos(radian2);
      float y = -(stem+stemArray[count + treeNumber]) * cos(radian1);
      float z = (stem+stemArray[count + treeNumber]) * sin(radian1) * sin(radian2);
      count++;

      noStroke();
      if(depth < 1){
        coodinateBox(x, y, z, 2*maxDepth - depth + 1, 1);
      }
      else if(depth == 1 && createBranchArray[count] < 0.5){
        coodinateBox(x, y, z, 2*maxDepth - depth + 1, 1);
      }
      else{
        fill(treeRArray[seazon][count + treeNumber], treeGArray[seazon][count + treeNumber],treeBArray[seazon][count + treeNumber]);
        coodinateBox(x, y, z, maxDepth - depth + 1, 0);
      }

      if(depth < maxDepth && (createBranchArray[count + treeNumber] < 0.7 || depth < 2) ){
        translate(x, y, z);
        rotateX(atan2(z, y));
        rotateZ(atan2(x, y));
        new Tree(stem * scale, openness, scale, branch, depth + 1, maxDepth).display(count + treeNumber);
      }
      popMatrix();
    }
    popMatrix();
  }
  
}

// coodinateBox
void coodinateBox(float x, float y, float z, float d, int MODE){
  beginShape(QUADS);
  if(MODE == 1){
    texture(treeImage);
  }
  textureMode(NORMAL);
  vertex(-d, 0, -d, 0, 0); vertex(-d, 0, d, 1, 0); vertex(d, 0, d, 1, 1); vertex(d, 0, -d, 0, 1);
  vertex(-d, 0, -d, 0, 0); vertex(d, 0, -d, 1, 0); vertex(x + d, y, z - d, 1, 1); vertex(x - d, y, z - d, 0, 1);
  vertex(d, 0, -d, 0, 0); vertex(d, 0, d, 1, 0); vertex(x + d, y, z + d, 1, 1); vertex(x + d, y, z - d, 0, 1);
  vertex(d, 0, d, 0, 0); vertex(-d, 0, d, 1, 0); vertex(x - d, y, z + d, 1, 1); vertex(x + d, y, z + d, 0, 1);
  vertex(-d, 0, d, 0, 0); vertex(-d, 0, -d, 1, 0); vertex(x - d, y, z - d, 1, 1); vertex(x - d, y, z + d, 0, 1);
  endShape();
}

// texturedBox
void texturedBox(float x, float y, float z, int MODE){
  scale(x, y, z);
  pushMatrix();
    translate(-.5, -.5, -.5);
    beginShape(QUADS);
      fill(255);
      if(MODE == 1){
        texture(cobblestoneImage);
      }
      else if(MODE == 2){
        texture(roofImage);
      }
      else if(MODE == 3){
        texture(snowImage);
      }
      textureMode(NORMAL);
                  
      vertex(1, 1, 1, 0, 0); vertex(1, 0, 1, 0, 1);
      vertex(0, 0, 1, 1, 1); vertex(0, 1, 1, 1, 0);

      vertex(1, 1, 0, 0, 0); vertex(1, 0, 0, 0, 1);
      vertex(1, 0, 1, 1, 1); vertex(1, 1, 1, 1, 0);

      vertex(0, 1, 1, 0, 0); vertex(0, 0, 1, 0, 1);
      vertex(0, 0, 0, 1, 1); vertex(0, 1, 0, 1, 0);
      
      vertex(0, 1, 1, 0, 0); vertex(0, 1, 0, 0, 1);
      vertex(1, 1, 0, 1, 1); vertex(1, 1, 1, 1, 0);
      
      vertex(0, 0, 0, 0, 0); vertex(0, 0, 1, 0, 1);
      vertex(1, 0, 1, 1, 1); vertex(1, 0, 0, 1, 0);

      vertex(0, 1, 0, 0, 0); vertex(0, 0, 0, 0, 1);
      vertex(1, 0, 0, 1, 1); vertex(1, 1, 0, 1, 0);
      
    endShape();
  popMatrix();
}

// Wall
void drawWall(float x, float y, float z){
  scale(x, y, z);
  pushMatrix();
    translate(-.5, -.5, -.5);
    beginShape(QUADS);
    texture(wallImage);
      textureMode(NORMAL);
      vertex(-1, 0, 0, 0, 0); vertex(0, 1, 0, 0.5, 1);
      vertex(1, 1, 0, 1, 1); vertex(1, 0, 0, 1, 0);
      
      vertex(0, 1, 0, 0, 0); vertex(0, 1, 1, 0, 1);
      vertex(1, 1, 1, 1, 1); vertex(1, 1, 0, 1, 0);
      
      vertex(1, 0, 0, 0, 0); vertex(1, 1, 0, 0, 1);
      vertex(1, 1, 1, 1, 1); vertex(1, 0, 1, 1, 0);
      
      vertex(1, 0, 1, 0, 0); vertex(1, 1, 1, 0, 1);
      vertex(0, 1, 1, 0.5, 1); vertex(-1, 0, 1, 1, 1);
      
      vertex(-1, 0, 1, 0, 0); vertex(0, 1, 1, 0, 1);
      vertex(0, 1, 0, 1, 1); vertex(-1, 0, 0, 1, 0);
      
      vertex(-1, 0, 1, 0, 0); vertex(1, 0, 1, 0, 1);
      vertex(1, 0, 0, 1, 1); vertex(-1, 0, 0, 1, 0);

    endShape();
  popMatrix();
}

// warp
void warp(){
  for(int i = 0; i < WARPNUM; i++){
    stroke(0);
    ellipse(warpx[i], warpy[i], 4, 4);
    warpx[i] = warpx[i] +random(-8.0, 8.0);
    warpy[i] = warpy[i] +random(-8.0, 8.0);
  }
}
