// In this tab, you must write code in:
//
// * move()

class Player extends Paddle {
  public Player(float x, float y, float w, float h, PVector vector, color c) {
    super(x, y, w, h, vector, c);
  }

// TODO: move()
//
// The player's move() method should work as follows:
// 1. Change the y-coordinate of the paddle (x-coordinate remains fixed)
// 2. Check to see if the new y-coordinate means that the paddle is touching the
//    top or bottom wall.  If it is:
//       2A. Set the paddle's vector (0, 0); such a vector exists near the top
//           of the first Processing tab
//       2B. Set the y-coordinate so that the edge of the paddle is touching the wall
  public void move() {
    super.move();
    if (super.intersectsHorizontal()) {
      super.setVector(new PVector(0, 0, 0));
      if (super.getY() < 0) {
        super.setY((float) -height/2 +super.getHeight()/2 + 1);
      }
      else {
        super.setY((float) height/2 - super.getHeight()/2 - 1);//super.getHeight()/2);
      }
    }
  }
}
