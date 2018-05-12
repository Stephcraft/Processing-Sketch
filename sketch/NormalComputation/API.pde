public static final int SOLID = 1;
public static final int DOTTED = 2;

//Dash Settings
public static String pattern = "_ . ";
public static float dashLength = 4.0;
public static int dashSpace = 1;

void dashStyle(float l, int s) {
  dashLength = l;
  dashSpace = s;
}

void dashedLine(float x1, float y1, float x2, float y2) {
  float d = dist(x1, y1, x2, y2) * (1.0 / dashLength);
  
  for (int i = 0; i <= d; i+=(dashSpace+1)) {
    
    float x01 = lerp(x1, x2, i/d);
    float y01 = lerp(y1, y2, i/d);
    
    float x02 = lerp(x1, x2, (i+1)/d);
    float y02 = lerp(y1, y2, (i+1)/d);
    
    if(i >= d-1) {
      x02 = x2;
      y02 = y2;
    }
    
    line(x01, y01, x02, y02);
  }
}

void dashedLine(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = dist(x1, y1, z1, x2, y2, z2) * (1.0 / dashLength);
  
  for (int i = 0; i <= d; i+=(dashSpace+1)) {
    
    float x01 = lerp(x1, x2, i/d);
    float y01 = lerp(y1, y2, i/d);
    float z01 = lerp(z1, z2, i/d);
    
    float x02 = lerp(x1, x2, (i+1)/d);
    float y02 = lerp(y1, y2, (i+1)/d);
    float z02 = lerp(z1, z2, (i+1)/d);
    
    if(i >= d-1) {
      x02 = x2;
      y02 = y2;
      z02 = z2;
    }
    
    line(x01, y01, z01, x02, y02, z02);
  }
}

void dashedQuad(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  dashedLine(x1,y1,z1, x2,y2,z2);
  dashedLine(x2,y2,z2, x3,y3,z3);
  dashedLine(x3,y3,z3, x4,y4,z4);
  dashedLine(x4,y4,z4, x1,y1,z1);
}

void quad(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  line(x1,y1,z1, x2,y2,z2);
  line(x2,y2,z2, x3,y3,z3);
  line(x3,y3,z3, x4,y4,z4);
  line(x4,y4,z4, x1,y1,z1);
}
