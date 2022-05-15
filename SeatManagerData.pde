class SeatManager {
  private int baseX, baseY;

  private boolean isRouletting;

  private int rouletteTime;

  private int rx, ry;

  private float luckyRate = 0.1f;

  Seat seats[][];

  SeatManager(int _baseX, int _baseY) {
    baseX = _baseX;
    baseY = _baseY;
    
    Map.massX = baseX;
    Map.massY = baseY;

    isRouletting = false;

    GenerateSeat();

    rouletteTime = 0;
    Map.luckyMode = false;
  }

  public int GetSizeX() {
    return baseX;
  }
  public int GetSizeY() {
    return baseY;
  }

  private void GenerateSeat() {
    Map.oneSizeX = (float)Map.sizeX / (float)baseX;
    Map.oneSizeY = (float)Map.sizeY / (float)baseY;
    seats = new Seat[baseX][baseY];
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i] = new Seat(i*j, j, i);
      }
    }
  }

  public void StartRoulette() {
    print("Roulette\n");
    rouletteTime = 0;
    isRouletting = true;
    
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i].SetFillReset();
      }
    }

    Map.luckyMode = false;

    if (random(0f, 1f) < luckyRate) {
      Map.luckyMode = true;
      Mouse.clickTime++;
      print("Lucky");
      Effect.sc = new SceneChange(160,"You are Lucky!");
      Map.seatSelected = false;
    }
  }

  public boolean GetRouletting() {
    return isRouletting;
  }

  public void Update() {
    Map.blankNum = 0;
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        if (seats[j][i].GetBlank()) Map.blankNum++;
      }
    }
  
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i].Update();
      }
    }

    if (isRouletting) {
      if (!Map.luckyMode) {
        rouletteTime++;

        if (rouletteTime < 30) {
          ChangeHighAll(true);
        } else if (rouletteTime < 60) {
          ChangeHighAll(false);
        } else if (rouletteTime < 90) {
          ChangeHighAll(true);
        } else if (rouletteTime < 120) {
          ChangeHighAll(false);
        } else if (rouletteTime < 240) {
          Roop(2);
        } else if (rouletteTime < 360) {
          Roop(6);
        } else if (rouletteTime < 400) {
          Roop(8);
        } else {


          seats[rx][ry].SetFill();
          isRouletting = false;
        }
      } else {
        for (int i = 0; i < baseY; i++) {
          for (int j = 0; j < baseX; j++) {
            seats[j][i].SetHighlighted(true);
          }
        }
        if (Map.seatSelected) {
          Map.luckyMode = false;
          print("End");
          isRouletting = false;
          ChangeHighAll(false);
        }
      }
    }
  }

  private void Roop(int num) {
    if (rouletteTime % num != 0) return;
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i].SetHighlighted(false);
      }
    }
    while (true) {
      rx = (int)random(0, baseX);
      ry = (int)random(0, baseY);
      if (seats[rx][ry].GetBlank()) {
        seats[rx][ry].SetHighlighted(true);
        break;
      }
    }
  }

  public void Draw() {
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i].Draw();
      }
    }
  }
  
  private void ChangeHighAll(boolean flag){
    for (int i = 0; i < baseY; i++) {
      for (int j = 0; j < baseX; j++) {
        seats[j][i].SetHighlighted(flag);
      }
    }
  }
}
