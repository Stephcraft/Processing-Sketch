import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

PVector[] vertex = new PVector[4];

int index = 0;

public void setup() {
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 0, 0, 0, 50);
  cam.lookAt(0, 0, 0, 200.0d);
  cam.rotateY(radians(45));
  cam.rotateX(radians(45));
  
  vertex[0] = new PVector( 20, 40,  20);
  vertex[1] = new PVector(-20, 20,  20);
  vertex[2] = new PVector(-20, 50, -20);
  vertex[3] = new PVector( 20, 60, -20);
}

public void draw() {
  background(255);
  
  //Event
  if(keyPressed) {
    if(key == '=') vertex[index].y++;
    if(key == '-' && vertex[index].y > 0) vertex[index].y--;
  }
  
  //Because camera.up = -1
  scale(-1.0);
  
  stroke(0);
  strokeWeight(1);
  
  //Box bottom
  dashedQuad(20, 0, 20, 20, 0, -20, -20, 0, -20, -20, 0, 20);
  
  //Box edge
  dashedLine( 20, 0,  20, vertex[0].x, vertex[0].y, vertex[0].z);
  dashedLine(-20, 0,  20, vertex[1].x, vertex[1].y, vertex[1].z);
  dashedLine(-20, 0, -20, vertex[2].x, vertex[2].y, vertex[2].z);
  dashedLine( 20, 0, -20, vertex[3].x, vertex[3].y, vertex[3].z);
  
  //Face
  quad(
    vertex[0].x, vertex[0].y, vertex[0].z,
    vertex[1].x, vertex[1].y, vertex[1].z,
    vertex[2].x, vertex[2].y, vertex[2].z,
    vertex[3].x, vertex[3].y, vertex[3].z
  );
  
  //Compute quad normals
  PVector[] normal = computeNormal(vertex);
  
  //Compute quad center
  PVector center = average(vertex);
  
  //Multiply normals for visibility
  for(int i=0; i<normal.length; i++) {
    normal[i].mult(10);
  }
  
  //Display Vertex normals
  stroke(255, 0, 0);
  for (int i=0; i<4; i++) {
    line(vertex[i].x, vertex[i].y, vertex[i].z, vertex[i].x + normal[i].x, vertex[i].y + normal[i].y, vertex[i].z + normal[i].z);
  }
  
  //Display Face normal
  line(center.x, center.y, center.z, center.x + normal[4].x, center.y + normal[4].y, center.z + normal[4].z);
  
  //Vertex Position on Screen
  pushMatrix();
  translate(vertex[0].x, vertex[0].y, vertex[0].z);
  PVector p0 = new PVector(screenX(0, 0, 0), screenY(0, 0, 0));
  popMatrix();
  
  pushMatrix();
  translate(vertex[1].x, vertex[1].y, vertex[1].z);
  PVector p1 = new PVector(screenX(0, 0, 0), screenY(0, 0, 0));
  popMatrix();
  
  pushMatrix();
  translate(vertex[2].x, vertex[2].y, vertex[2].z);
  PVector p2 = new PVector(screenX(0, 0, 0), screenY(0, 0, 0));
  popMatrix();
  
  pushMatrix();
  translate(vertex[3].x, vertex[3].y, vertex[3].z);
  PVector p3 = new PVector(screenX(0, 0, 0), screenY(0, 0, 0));
  popMatrix();
  
  //UI
  cam.beginHUD();
  
  noFill();
  strokeWeight(10);
  
  if(index == 0) { stroke(0); strokeWeight(1); ellipse(p0.x, p0.y, 15, 15); strokeWeight(10); }
  stroke(66, 134, 244);
  point(p0.x, p0.y);
  
  if(index == 1) { stroke(0); strokeWeight(1); ellipse(p1.x, p1.y, 15, 15); strokeWeight(10); }
  stroke(244, 65, 104);
  point(p1.x, p1.y);
  
  if(index == 2) { stroke(0); strokeWeight(1); ellipse(p2.x, p2.y, 15, 15); strokeWeight(10); }
  stroke(65, 244, 199);
  point(p2.x, p2.y);
  
  if(index == 3) { stroke(0); strokeWeight(1); ellipse(p3.x, p3.y, 15, 15); strokeWeight(10); }
  stroke(190, 65, 244);
  point(p3.x, p3.y);
  
  fill(0);
  textAlign(TOP, LEFT);
  text("Finding Face Normal", 10, 20);
  
  noStroke();
  fill(66, 134, 244);
  rect(10, 30, 60, 19, 5);
  
  noStroke();
  fill(244, 65, 104);
  rect(10, 60, 60, 19, 5);
  
  noStroke();
  fill(65, 244, 199);
  rect(10, 90, 60, 19, 5);
  
  noStroke();
  fill(190, 65, 244);
  rect(10, 120, 60, 19, 5);
  
  textAlign(LEFT, CENTER);
  
  //Vertex Names
  fill(255);
  text("Vertex 0", 15, 37);
  text("Vertex 1", 15, 67);
  text("Vertex 2", 15, 97);
  text("Vertex 3", 15, 127);
  
  //Vertex Info
  fill(0);
  text("{ "+ vertex[0].x +", "+ vertex[0].y +", "+ vertex[0].z +" }", 80, 37);
  text("{ "+ vertex[1].x +", "+ vertex[1].y +", "+ vertex[1].z +" }", 80, 67);
  text("{ "+ vertex[2].x +", "+ vertex[2].y +", "+ vertex[2].z +" }", 80, 97);
  text("{ "+ vertex[3].x +", "+ vertex[3].y +", "+ vertex[3].z +" }", 80, 127);
  
  //Controls
  text("[0] [1] [2] [3] : Change Vertex\n[-] [+] : Control Y Coordinate", 10, height-30);
  
  cam.endHUD();
}

public void keyPressed() {
  if(key == '0') index = 0;
  if(key == '1') index = 1;
  if(key == '2') index = 2;
  if(key == '3') index = 3;
}
