public class Button{
  int x, y;
  int sizeX, sizeY;
  
  private boolean isPointed, isSelected;
  
  Button(int _x, int _y, int _sizeX, int _sizeY){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
  }
  
  public boolean GetClicked(){
    return isSelected;
  }
  
  public void Update(){
    
    isSelected = false;
    
    if (mouseX > x && mouseX < x + sizeX && mouseY > y && mouseY < y + sizeY) {
      isPointed = true;
      
      if (Mouse.clickTime == 1){
        isSelected = true;
      }
    } else {
      isPointed = false;
    }
  }
  
  public void Draw(){
    if (isPointed){
      fill(255,120,0);
    }else if (isSelected){
      fill(35,43,61);
    }else{
      fill(255,144,0);
    }
    noStroke();
    rect(x, y, sizeX, sizeY);
  }
}
