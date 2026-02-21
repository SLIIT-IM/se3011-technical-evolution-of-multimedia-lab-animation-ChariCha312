int state = 0; 
int startTime;
int duration = 30; 
int score = 0;

float px = 350, py = 175;
float pr = 20;
float step = 6;

float hx, hy;
float ease = 0.08;

float ox, oy;
float or = 18;
float xs = 4;
float ys = 3;

boolean trails = false;

void setup() {
  size(700, 350);
  hx = px;
  hy = py;
  resetOrb();
}

void draw() {

  if (state == 0) {
    background(240);
    textAlign(CENTER, CENTER);
    textSize(26);
    fill(0);
    text("Catch the Orb!", width/2, height/2 - 20);
    textSize(18);
    text("Press ENTER to Start", width/2, height/2 + 20);
  }

  else if (state == 1) {

    if (!trails) {
      background(255);
    } else {
      noStroke();
      fill(255, 30);
      rect(0, 0, width, height);
    }

    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if (left <= 0) {
      state = 2;
    }

    
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    
    ox += xs;
    oy += ys;

    if (ox > width - or || ox < or) xs *= -1;
    if (oy > height - or || oy < or) ys *= -1;

    
    float d = dist(px, py, ox, oy);
    if (d < pr + or) {
      score++;
      xs *= 1.1;
      ys *= 1.1;
      resetOrb();
    }

    
    fill(60, 120, 200);
    ellipse(px, py, pr*2, pr*2);

    fill(80, 200, 120);
    ellipse(hx, hy, 14, 14);

    fill(255, 100, 80);
    ellipse(ox, oy, or*2, or*2);

    
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Score: " + score, 20, 15);
    text("Time Left: " + left, 20, 35);
    text("Press T for Trails", 20, 55);
  }

  else if (state == 2) {
    background(230);
    textAlign(CENTER, CENTER);
    textSize(26);
    fill(0);
    text("Time Over!", width/2, height/2 - 30);
    textSize(20);
    text("Final Score: " + score, width/2, height/2);
    text("Press R to Restart", width/2, height/2 + 30);
  }
}

void keyPressed() {

  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
    score = 0;
  }

  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
    xs = 4;
    ys = 3;
    px = width/2;
    py = height/2;
    hx = px;
    hy = py;
  }

  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}

void resetOrb() {
  ox = random(or, width - or);
  oy = random(or, height - or);
}
