int[] cells;
int[] rules = {0,1,1,0,1,1,1,0}; // rule 110
int generation = -1;

void setup() {
  frameRate(120);
  size(1400, 1000);
  noSmooth();
  noFill();
  cells = new int[width];
  center();
}

void draw() {
  for (int i = 0; i < cells.length; i++) {
    stroke((1-cells[i])*255);
    point(i, generation);
  }
  if (generation < height) {
    populate();
  } else {
    //background(255);
    generation = -1;
    //center();
  }
}

void wave() {
  for (int i = 0; i < cells.length; i++) {
    float t = map(i, 0, cells.length, 0, 133*PI);
    float s = tan(t);
    cells[i] = int(s > 0);
  }
  generation++;
}

void center() {
  int center = cells.length / 2;
  for (int i = 0; i < cells.length; i++) {
    cells[i] = int(i==center);
  }
  generation++;
}

void bang() {
  for (int i = 0; i < cells.length; i++) {
    cells[i] = round(random(1));
  }
  generation++;
}

void populate() {
  int[] next = new int[cells.length];
  for (int i = 0; i < cells.length; i++) {
    int me = cells[i];
    int left = (i > 0) ? cells[i-1] : cells[cells.length-1]; 
    int right = (i < cells.length-2) ? cells[i+1] : cells[0];
    next[i] = execute(left, me, right); 
  }
  cells = next;
  generation++;
}

int execute(int a, int b, int c) {
  if (a == 1 && b == 1 && c == 1) { 
    return rules[0];
  }
  if (a == 1 && b == 1 && c == 0) { 
    return rules[1];
  }
  if (a == 1 && b == 0 && c == 1) { 
    return rules[2];
  }
  if (a == 1 && b == 0 && c == 0) { 
    return rules[3];
  }
  if (a == 0 && b == 1 && c == 1) { 
    return rules[4];
  }
  if (a == 0 && b == 1 && c == 0) { 
    return rules[5];
  }
  if (a == 0 && b == 0 && c == 1) { 
    return rules[6];
  }
  if (a == 0 && b == 0 && c == 0) { 
    return rules[7];
  }
  return 0;
}