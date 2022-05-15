static class Mouse{
  static int clickTime;
  static boolean firstClick;
  
  static void Pressing(){
    clickTime++;
    
    if (clickTime == 0){
      firstClick = true;
    }else{
      firstClick = false;
    }
  }
}
