void setup() {
  size(1440, 810);
  frameRate(60);

  Map.seatMan = new SeatManager(7, 7);
  ButtonStock.start = new Button(300, 60, 840, 75);
  ButtonStock.setDone = new Button(0, 760, 1440, 50);

  Mouse.clickTime = 0;
  Keys.up = false;
  Keys.down = false;
  Keys.left = false;
  Keys.right = false;

  Map.setDone = false;

  randomSeed(System.currentTimeMillis());

  Effect.sc = new SceneChange(160, "Change Sheat");
}

void draw() {
  background(250, 250, 250);

  Map.seatMan.Update();
  ButtonStock.start.Update();
  if (ButtonStock.setDone != null) ButtonStock.setDone.Update();

  Map.seatMan.Draw();
  ButtonStock.start.Draw();
  if (ButtonStock.setDone != null) ButtonStock.setDone.Draw();

  fill(255);
  textAlign(CENTER, CENTER);
  SetTextSize("Accept (Lock Seats) [←][→][↑][↓]:Change Size [Mouse Click]:Switch", 30, 1440);
  text("Accept (Lock Seats) [←][→][↑][↓]:Change Size [Mouse Click]:Switch", 720, 780);

  fill(255);
  textAlign(CENTER, CENTER);
  if (!Map.seatMan.GetRouletting()) {
    SetTextSize("Start Roulette", 60, 600);
    text("Start Roulette", 720, 90);
  } else {
    SetTextSize("Rouletting...", 60, 600);
    text("Rouletting...", 720, 90);
  }

  fill(30);
  SetTextSize("Front", 25, 500);
  text("Front", 720, 260);

  if (ButtonStock.setDone != null) {
    fill(30);
    String s = Map.massX + " x " + Map.massY + " - " + (Map.massX*Map.massY-Map.blankNum) + " = " + Map.blankNum;
    SetTextSize(s, 30, 600);
    text(s, 720, 210);
  }

  if (Map.luckyMode) {
    fill(30);
    SetTextSize("Choose Any Seats You Want To Get", 60, 600);
    text("Choose Any Seats You Want To Get", 720, 210);
  }

  if (ButtonStock.start.GetClicked() && !Map.seatMan.GetRouletting() && ButtonStock.setDone == null) {
    Map.seatMan.StartRoulette();
  }

  if (ButtonStock.setDone != null)
    if (ButtonStock.setDone.GetClicked()) {
      Map.setDone = true;
      ButtonStock.setDone = null;
    }

  if (Mouse.clickTime != 0) Mouse.Pressing();

  Effect.sc.Update();
  Effect.sc.Draw();
}

void mousePressed() {
  Mouse.Pressing();
}

void mouseReleased() {
  Mouse.clickTime = 0;
}

void keyPressed() {
  if (Map.setDone) return;

  if (keyCode == UP) {
    Map.seatMan = new SeatManager(Map.seatMan.GetSizeX(), Map.seatMan.GetSizeY()+1);
  }
  if (keyCode == DOWN) {
    if (Map.seatMan.GetSizeY()-1 <= 0) return;
    Map.seatMan = new SeatManager(Map.seatMan.GetSizeX(), Map.seatMan.GetSizeY()-1);
  }
  if (keyCode == LEFT) {
    Map.seatMan = new SeatManager(Map.seatMan.GetSizeX()+1, Map.seatMan.GetSizeY());
  }
  if (keyCode == RIGHT) {
    if (Map.seatMan.GetSizeX()-1 <= 0) return;
    Map.seatMan = new SeatManager(Map.seatMan.GetSizeX()-1, Map.seatMan.GetSizeY());
  }
}
