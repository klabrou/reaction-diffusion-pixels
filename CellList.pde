class CellList{
  ArrayList<Cell> clist = new ArrayList<Cell>(); 
  Cell c; 
  
  CellList(){
    initList();  
  }
  
  void initList(){
    for (int i = 0; i < height; i++){
      Cell c = new Cell(0.5, 0);
      clist.add(c); 
    }
  }
  
  Cell getCell(int _index){
    // for index value from 0 to width
    return clist.get(_index);
  }
  
  //void updateList(){
    
  //}
  
}
