/*

  #Equation
  cross((v[i-1] - v[i]), (v[i+1] - v[i]))
  
  #Exemple
  cross((v2 - v1), (v3 - v1))
  
  #Detail
  We take the 2 vertex neighbors because together they make a triangle.
  The triangle is the polygon containing the smallest amount of vertex.
  In the equation, i would be the current vertex index, i-1 and i+1 the
  vertex neighbors.
*/

//Quad Version
public PVector[] computeNormal(PVector p1, PVector p2, PVector p3, PVector p4) {
  PVector[] normal = new PVector[5];
  
  //Vertex Normal
  normal[0] = p4.copy().sub(p1).cross(p2.copy().sub(p1));
  normal[1] = p1.copy().sub(p2).cross(p3.copy().sub(p2));
  normal[2] = p2.copy().sub(p3).cross(p4.copy().sub(p3));
  normal[3] = p3.copy().sub(p4).cross(p1.copy().sub(p4));
  
  //Face Normal
  normal[4] = average(normal[0], normal[1], normal[2], normal[3]);
  
  //Normalize
  for(int i=0; i<5; i++) {
    normal[i].normalize();
  }
  
  return normal;
}

//Exemple : Tri Version {extends} PVector[] computeNormal(PVector... v)
public PVector[] computeNormal(PVector p1, PVector p2, PVector p3) {
  return computeNormal(new PVector[] { p1, p2, p3 });
}

//Infinite Version
public PVector[] computeNormal(PVector... v) {
  PVector[] normal = new PVector[v.length + 1];
  
  //Vertex Normal
  for(int i=0; i<v.length; i++) {
    PVector prev = (i-1 < 0 ? v[v.length-1] : v[i-1]);
    PVector next = (i+1 >= v.length ? v[0] : v[i+1]);
    
    normal[i] = prev.copy().sub(v[i]).cross(next.copy().sub(v[i]));
    normal[i].normalize();
  }
  
  //Face Normal
  normal[v.length] = average((PVector[])subset(normal, 0, v.length));
  normal[v.length].normalize();
  
  return normal;
}

public PVector average(PVector... v) {
  PVector vector = new PVector();
  
  for(int i=0; i<v.length; i++) {
    vector.add(v[i]);
  }
  
  vector.div(v.length);
  
  return vector;
}
