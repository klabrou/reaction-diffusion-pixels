class Cell{
  
  float a,b;
  
  Cell(float _a, float _b){
    a = _a;
    b = _b;
  }
  
  void setParameter(char _ab, float _p){
    if (_ab == 'a') a = _p;
    if (_ab == 'b') b = _p;
  }
  
  float getAB(char _ab){
    if (_ab == 'a'){ 
      return a;
    } else { 
      return b;
    }
  }
  
}
