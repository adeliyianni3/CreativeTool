class Polygon {
  private float[] sidesX;
  private float[] sidesY;
  private float centerX;
  private float centerY;
  private int preX;
  private int preY;
  private int numPoints;
  private float myCol;
  Polygon(float x, float y, float radius, int npoints, int col) {
    sidesX = new float[npoints];
    numPoints = npoints;
    sidesY = new float[npoints];
    centerX = x;
    myCol = col;
    centerY = y;
    float angle = TWO_PI / npoints;
    beginShape();
    float a = 0;
    for (int count = 0; count < npoints; a+= angle) {
      sidesX[count] = centerX + cos(a) * radius;
      if (sidesX[count] > (float) 890) {
        sidesX[count] = 890;
      }
      sidesY[count] = centerY + sin(a) * radius;
      if (sidesY[count] < (float) 55) {
        sidesY[count] = 55;
      }
      vertex(sidesX[count], sidesY[count]);
      count++;
    }
    endShape(CLOSE);
  }
  void draw() {
    beginShape();
    stroke(0);
    for (int a = 0; a < sidesX.length; a++) {
      vertex(sidesX[a], sidesY[a]);
    }
    fill(myCol, 255, 255);
    endShape(CLOSE);
  }
  void change(int speed, int x, int y) {
      int altPoint = (int)random(0, numPoints);
        float dx = x - preX;
        float dy = y - preY;
        float newX = sidesX[altPoint] + (dx*(speed/10));
        float newY = sidesY[altPoint] + ((speed/10)*dy);
        if (newX < 10) {
          newX = 10;
        } else if ( newX > 890 ) {
          newX = 890;
        }
        if (newY < 55){
          newY = 55;
        } else if (newY > 600) {
          newY = 600;
        }
        sidesX[altPoint] = newX;
        sidesY[altPoint] = newY;
        preX = x;
        preY = y;
  }
void setXY(int x, int y) {
    preX = x;
    preY = y;
  }
  void setColor(int colo) {
  myCol = colo;
}
  boolean clickedOn(int x, int y) {
    if (x < (max(sidesX) - 5) && x > (min(sidesX)+ 5)) {
      if (y < (max(sidesY)- 5) && y > (min(sidesY)+ 5)) {
        return true;
      }
    }
    return false;
  }
}