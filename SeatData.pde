class Seat {
  private int seatNum;
  private int x, y;

  private boolean isPointed, isDisabled;

  private boolean isHighlighted;
  private boolean isFilled, isLastFilled;

  private int flashTime;
  private boolean flashMode;
  private boolean flashFlip;

  private float screenX, screenY;

  Seat(int _seatNum, int _x, int _y) {
    seatNum = _seatNum;
    x = _x;
    y = _y;

    isPointed = false;
    isDisabled = false;

    isHighlighted = false;

    flashTime = 0;
    flashMode = false;
    flashFlip = false;
  }

  public void SetHighlighted(boolean flag) {
    if (isDisabled) return;
    isHighlighted = flag;
  }

  public boolean GetBlank() {
    if (!isFilled && !isDisabled) {
      return true;
    } else return false;
  }

  public void SetFill() {
    isFilled = true;
    isLastFilled = true;
    flashTime = 0;
    flashMode = true;
    flashFlip = true;
  }

  public void SetFillReset() {
    isLastFilled = false;
  }

  public void Update() {
    screenX = Map.seatLeft + Map.oneSizeX * x;
    screenY = Map.seatTop + Map.oneSizeY * y;


    if (mouseX > screenX && mouseX < screenX + Map.oneSizeX && mouseY > screenY && mouseY < screenY + Map.oneSizeY) {
      isPointed = true;
      if (Mouse.clickTime == 1 && Map.luckyMode && !Map.seatSelected && !isDisabled && !isFilled) {
        SetFill();
        Map.seatSelected = true;
      }
      if (Mouse.clickTime == 1 && !Map.setDone) {
        isDisabled = !isDisabled;
      }
    } else {
      isPointed = false;
    }

    if (flashMode) {
      flashTime++; 
      if (flashTime % 30 == 0) flashFlip = !flashFlip;
    }
  }

  public void Draw() {
    if (isPointed) {
      fill(88, 164, 176);
    } else {
      fill(230, 230, 230);
    }
    if (isHighlighted) {
      fill(241, 162, 8);
    }
    if (isFilled) {
      fill(136, 90, 137);
    }
    if (isLastFilled) {
      if (flashFlip) {
        fill(158, 25, 70);
      } else {
        fill(230, 230, 230);
      }
    }
    if (isDisabled) {
      fill(50, 50, 50);
    }
    if (isPointed && Map.luckyMode && !isDisabled && !isFilled) {
      fill(88, 164, 176);
    }
    stroke(0);
    strokeWeight(2);
    rect(screenX, screenY, Map.oneSizeX, Map.oneSizeY);
  }

  public boolean GetDisabled() {
    return isDisabled;
  }
}
