// I wanted to see the potential paterns in prime numbers when they are placed in spiral 
// At each step, we look at newN = previousN +1 and draw a coloured square if it is a prime number

// Screen and grid parameters
int screenWidth = 1000;
int gridWidth = 100;
int cellWidth;
int[][] grid; // The grid is used to know where whe have already draw (0 if already computed) ; it is used to know how to draw the spiral

// Position
int x;
int y;

// Direction to place the squares in spiral
int d_x = 1;
int d_y = 0;

int n =1;

void setup(){

  size(1000,1000);
  background(40,40,40);
  
  init();

}

void init(){
  
  // Initilizes the grid and position
  
  grid = new int[gridWidth][gridWidth];
  cellWidth = (int) ((float)screenWidth/gridWidth);
  
  x =(int) (gridWidth/(float)2);
  y =(int) (gridWidth/(float)2);
  
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      grid[i][j] = 1;
    }
  }
  
  grid[x][y] = 0;
}



void draw(){
  if (n<(gridWidth-1)*(gridWidth-1)){
    iterate();
    n++;
  }
}



void iterate(){
  
  // If the cell is in the bounds
  if(x+d_x < gridWidth && y + d_y < gridWidth) { 
  
  // If the next position in straight line is accessible
    if(grid[x+d_x][y+d_y] == 1){ 
    
    // If we can change the direction (the position added to the direction is available in the grid) we do it (depends on the direction we chose)
    // If not, we keep the same direction
      if(d_y !=0 && grid[x+d_y][y] == 1){ 
        d_x = d_y;
        d_y = 0 ;
      }
      else if(grid[x][y-d_x] == 1){ 
        d_y = -d_x;
        d_x = 0;
      }
    }
  
    // We draw the cell
    drawCell();
    
    // We change the direction
    x += d_x;
    y += d_y;
    println(d_x , d_y);
    
    // We set the cell to 0 to know that it has been checked already
    grid[x][y] = 0;
  
  }
}

void drawCell(){

  int count = 2;
  float temp = pow((float) n , .5f);
  
  // We look for a divider
  while (n%count !=0 && count < temp){
    count++;
  } 
  
  // If we didn't find any divider we draw a coloured square
  if(count > temp){ 
    noStroke();
    float c = ((2*max(abs(y - gridWidth/2),abs(x-gridWidth/2)) )/ (float) gridWidth * 255) ;
    fill(c , 255 , 255-c);
    rect(cellWidth*x,cellWidth*y,cellWidth*0.98,cellWidth*0.98);
  }
  
  // If it is not a prime, we fill it in grey
  else{ 
    noStroke();
    fill(100);
    rect(cellWidth*x,cellWidth*y,cellWidth*0.98,cellWidth*0.98);  
  }
  

}
