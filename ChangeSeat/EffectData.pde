class SceneChangeBall {
  private float vx, vy, x, y;
  private float fy;
  private color col;
  private int size;
  private int sizeAfter;
  private int boundNum;
  private int exFrame, exFrameMax;
  private int fadeFrame, fadeFrameMax;
  private float fadeDistance;

  private boolean falling;
  private boolean exploding;
  private boolean fading;

  SceneChangeBall(float _x, float _y) {
    x = _x;
    y = _y;
    col = color(53+(int)random(0, 30), 223, 189+(int)random(0, 20));
    size = 20+(int)random(0, 30);
    sizeAfter = 2000;
    vx = 0;
    vy = 0;
    fy = 1.21f;
    falling = true;
    exploding = false;
    fading = false;
    boundNum = 0;
  }

  void Update() {
    if (falling) {
      vy += fy;
      if (boundNum > 0 && vy > 0) {
        Fix();
      }

      x = x + vx;
      y = y + vy;

      if (y>810-size/2) {
        y = 810-size/2;
        vy = -vy*0.6;
        vx = vx*0.9;
        boundNum++;
      }
    }
    if (exploding) {
      exFrame--;
      if (exFrame >= 0) {
        size += (sizeAfter-size)/exFrameMax;
      }
    }
    if (fading) {
      fadeFrame--;
      y += fadeDistance/fadeFrameMax;
    }
  }

  void Explode(int _frame) {
    Fix();
    exploding = true;
    exFrame = _frame;
    exFrameMax = exFrame;
  }

  void Fade(int _frame) {
    Fix();
    fading = true;
    fadeFrame = _frame;
    fadeFrameMax = fadeFrame;
    fadeDistance = (810-y)+sizeAfter;
  }

  private void Fix() {
    falling = false;
    vx = 0; 
    vy = 0;
  }

  void Draw() {
    fill(col);
    strokeWeight(2);
    stroke(250);
    if (exploding) {
      noStroke();
    }
    ellipse(x, y, size, size);
    blendMode(BLEND);
  }
}

class SceneChange {
  SceneChangeBall[] ball;

  private int max = 5;

  private int time, timeMax;
  private float exTimeRate, fadeTimeRate;
  private boolean fading;

  private String str;

  SceneChange(int _time, String _str) {
    max += (int)random(0, 3);
    ball = new SceneChangeBall[max];
    str = _str;
    for (int i = 0; i < max; i++) {
      if (i == 0) {
        ball[i] = new SceneChangeBall(0+random(0, 50), random(0, 800)-800);
      } else if (i == max/2) {
        ball[i] = new SceneChangeBall(650+random(0, 50), random(0, 800)-800);
      } else if (i == max-1) {
        ball[i] = new SceneChangeBall(1300+random(0, 50), random(0, 800)-800);
      } else {
        ball[i] = new SceneChangeBall(random(0, 1440), random(0, 800)-800);
      }
    }

    time = _time;
    timeMax = time;

    exTimeRate = 0.5f;
    fadeTimeRate = 0.8f;

    fading = false;
  }

  void Update() {
    if (timeMax == 0) return;
    time--;
    for (int i = 0; i < max; i++) {
      if (time == (int)(timeMax*(1-exTimeRate))) {
        ball[i].Explode(12);
      }
      if (time == (int)(timeMax*(1-fadeTimeRate))) {
        fading = true;
        ball[i].Fade(time);
      }
      ball[i].Update();
    }
  }

  boolean FadeOutStart() {
    return fading;
  }

  void Draw() {
    if (timeMax == 0) return;
    for (int i = 0; i < max; i++) {
      ball[i].Draw();
    }

    if (time < timeMax*(1-exTimeRate) && time > (int)(timeMax*(1-fadeTimeRate))) {
      textAlign(CENTER);
      fill(255);
      noStroke();
      textSize(70);
      text(str, 1440/2, 810/2);
      textAlign(LEFT);
    }
  }
}
