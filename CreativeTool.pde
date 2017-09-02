import controlP5.*;

Button buttonMode; //a button controller (it states if pressed)
Button buttonMethod;
Button buttonClear;
Button buttonBlend;
Button socIndDis;
Button grid;
Button grid2;

Textlabel curMode;
Textlabel userChose;
Textlabel click;
Textlabel drag;

float bx;
float by;

int speed;
int counter;
int gridRow;
int onClickX;
int onClickY;
int gridCol;
int shapeClickedOn;

boolean started;
boolean overBox;
boolean locked;
boolean draw;
boolean blend;
boolean messAll;

Slider sideNum;
Slider sizeRad;
Slider numC;
Slider numR;
Slider disruptSpeed;

ControlP5 cp5; //thing/core that runs controllers in ControlP5 lib

ArrayList<Polygon> shapes = new ArrayList<Polygon>();
Slider cp;

void setup() {
  colorMode(HSB);
  size(1100, 600);
  draw = true;
  overBox = false;
  locked = false;
  started = false;
  speed = 10;
  messAll = true;
  gridRow = 4;
  gridCol = 4;
  blend = false;
  cp5 = new ControlP5(this); //processing applet
  bx = width/2.0;
  by = height/2.0;
  buttons();
  shapes = new ArrayList<Polygon>();
  showButtons(locked);
  curMode = new Textlabel(cp5, "Current Mode: Disrupt Color", 900, 50);
  userChose = new Textlabel(cp5, "Select Aspects of Uniformity", 900, 175);
  click = new Textlabel(cp5, "Selet the number of sides, size, and color \nof your polygons. Then select a structure.\nSelect a new color and click on a polygon \nto disrupt it's color individually.", 910, 450); 
  drag = new Textlabel(cp5, "Drag mouse to disrupt the polygon's shape. \nSelect Render to overlay colors.", 910, 450);
}

void grid1(int rowNum, int colNum) {
  for (int row = 1; row <= rowNum; row++) {
    for (int col = 1; col <= colNum; col++) {
      shapes.add(new Polygon((890/(colNum))*(col)-((890/(colNum))/2), (545/(rowNum))*(row)+55-((545/(rowNum))/2) , ((int) sizeRad.getValue()) , ((int) sideNum.getValue()), (int) cp.getValue()));
    }
  }
}

void grid2(int rowNum, int colNum) {
  int total1 = rowNum*colNum/2;
  int total2 = (rowNum*colNum)-total1;
  for (int count = 0; count < total1; count++) {
     float angle = TWO_PI*count/(float)total1;
     float radius = 100;
     shapes.add(new Polygon(445 + radius*cos(angle), 325 + radius*sin(angle) , ((int) sizeRad.getValue()) , ((int) sideNum.getValue()), (int) cp.getValue()));
  }
  for (int count = 0; count < total2; count++) {
     float angle = TWO_PI*count/(float)total2;
     float radius = 200;
     shapes.add(new Polygon(445 + radius*cos(angle),325 + radius*sin(angle) , ((int) sizeRad.getValue()) , ((int) sideNum.getValue()), (int) cp.getValue()));
  }
}

void buttons() {
  grid = new Button(cp5, "Linear Structure");
  grid.setPosition(940,280);
  grid.setWidth(100);
  grid.hide();
  
  grid2 = new Button(cp5, "Circular Structure");
  grid2.setPosition(940,305);
  grid2.setWidth(100);
  grid2.hide();
  
  buttonMethod = new Button(cp5, "Disrupt Shape");
  buttonMethod.setPosition(940,75);
  buttonMethod.setWidth(100);

  socIndDis = new Button(cp5, "Total Disruption");
  socIndDis.setPosition(940,200);
  socIndDis.setWidth(100);
  socIndDis.hide();
  
  sideNum = cp5.addSlider("Number of Sides");
  sideNum.getCaptionLabel().setPaddingX(-95);
  sideNum.setHeight(20);
  sideNum.setWidth(100);
  sideNum.setValue(3);
  sideNum.getValueLabel().setPaddingX(80);
  sideNum.setNumberOfTickMarks(8);
  sideNum.setPosition(940 , 200);
  sideNum.setRange(3,10);
  sideNum.hide();

  sizeRad = cp5.addSlider("Size");
  sizeRad.getCaptionLabel().setPaddingX(-95);
  sizeRad.getValueLabel().setPaddingX(75);
  sizeRad.setHeight(20);
  sizeRad.setWidth(100);
  sizeRad.setValue(50);
  sizeRad.setNumberOfTickMarks(10);
  sizeRad.setPosition(940 , 240);
  sizeRad.setRange(5,50);
  sizeRad.hide();

  buttonClear = new Button(cp5, "Clear");
  buttonClear.setPosition(940, height-70);
  buttonClear.setWidth(100);
  buttonClear.setHeight(60);

  cp = cp5.addSlider("Current Color Selected Slider");
  cp.setPosition(10,15);
  cp.setHeight(30);
  cp.setWidth(255);
  cp.setValue(255);
  cp.setRange(0,255);
  cp.getValueLabel().setVisible(false);
  cp.setColorBackground(255);
  
  buttonBlend = new Button(cp5, "Render");
  buttonBlend.setPosition(940, 270);
  buttonBlend.setWidth(100);
  buttonBlend.hide();

  disruptSpeed = cp5.addSlider("Disrupt Speed");
  disruptSpeed.getCaptionLabel().setPaddingX(-95);
  disruptSpeed.getValueLabel().setPaddingX(80);
  disruptSpeed.setHeight(20);
  disruptSpeed.setWidth(100);
  disruptSpeed.setValue(1);
  disruptSpeed.setNumberOfTickMarks(5);
  disruptSpeed.setPosition(940 , 230);
  disruptSpeed.setRange(1,5);
  disruptSpeed.hide();
}

void draw() {
  background(0);
  curMode.draw();
  if (!locked) {
    click.draw();
  } else {
    drag.draw();
  }
  userChose.draw();
  fill(100);
  noStroke();
  rect(0, 50, 891, 5);
  rect(891, 50, 5, height);
  stroke(255);
  noFill();
  rect(9, 14, 256, 31);
  cp.setColorForeground(color(cp.getValue(), 255, 255));
  cp.setColorActive(color(cp.getValue(), 255, 255));
  for (int count = 0; count < shapes.size(); count++) {
      shapes.get(count).draw();
  }
}
void mouseReleased() {
  if (!blend) {
    if (locked) {
      started = true;
    }
  }
}
void showButtons(boolean off) {
  if (!off) {
    grid.show();
    grid2.show();
    sideNum.show();
    sizeRad.show();
    buttonBlend.hide();
    socIndDis.hide();
    disruptSpeed.hide();
  } else {
    grid.hide();
    grid2.hide();
    sideNum.hide();
    sizeRad.hide();
    buttonBlend.show();
    disruptSpeed.show();
    socIndDis.show();
  }
}
void mousePressed() {
if (!blend) {
  if (!locked) {
      for (int count = 0; count < shapes.size(); count++) {
        if (shapes.get(count).clickedOn(mouseX, mouseY)) {
          shapes.get(count).setColor((int)cp.getValue());
          break;
        }
      }
    } else {
      if (started) {
        if (!messAll) {
          onClickX = mouseX;
          onClickY = mouseY;
          for (int count = 0; count < shapes.size(); count++) {
            if (shapes.get(count).clickedOn(onClickX, onClickY)) {
              shapes.get(count).setXY(mouseX, mouseY);
              shapeClickedOn = count;
              started = false;
              break;
            }
          }
        } else {
          for (int count = 0; count < shapes.size(); count++) {
              shapes.get(count).setXY(mouseX, mouseY);
              started = false;
          }
        }
      }
    }
    if (buttonMethod.isPressed()) {
      if(locked) {
        buttonMethod.setCaptionLabel("Disrupt Shape");
        curMode.setText("Current Mode: Disrupt Color");
        userChose.setText("Select Aspects of Uniformity");
        locked = false;
        showButtons(locked);
      } else {
        buttonMethod.setCaptionLabel("Disrupt Color");
        curMode.setText("Current Mode: Disrupt Shape");
        userChose.setText("Select Aspects of Disruption");
        locked = true;
        showButtons(locked);
      }
    }
  } 
  if(buttonBlend.isPressed()) {
      if (!blend) {
        blendMode(EXCLUSION);
        buttonBlend.setCaptionLabel("Unrender");
        blend = true;
      } else {
        blendMode(BLEND);
        buttonBlend.setCaptionLabel("Render");
        blend = false;
      }
    } else if (grid2.isPressed()) {
      shapes.clear();
      grid2(gridCol, gridRow);
    } else if (grid.isPressed()) {
      shapes.clear();
      grid1(gridCol, gridRow);
    } else if (socIndDis.isPressed()) {
      if (messAll) {
        socIndDis.setCaptionLabel("Individual Disruption");
        messAll = false;
      } else {
        socIndDis.setCaptionLabel("Total Disruption");
        messAll = true;
      }
    } else if (buttonClear.isPressed()) {
      shapes.clear();
      blend = false;
      blendMode(BLEND);
      buttonBlend.setCaptionLabel("Render");
      buttonMethod.setCaptionLabel("Disrupt Shape");
      curMode.setText("Current Mode: Disrupt Color");
      userChose.setText("Select Aspects of Uniformity");
      locked = false;
      socIndDis.setCaptionLabel("Total Disruption");
      messAll = true;
      showButtons(locked);
  }
}

void mouseDragged() {
  if (!blend) {
    if ((mouseX < 890)&&(mouseY > 50)) {
      if(locked) {
        if(!messAll) {
            shapes.get(shapeClickedOn).change((int)(disruptSpeed.getValue()*speed), mouseX, mouseY);
          } else {
            for (int count = 0; count < shapes.size(); count++) {
            shapes.get(count).change((int)(disruptSpeed.getValue()*speed), mouseX, mouseY);
          }
        }
        draw = true;
      }
    }
  }
}