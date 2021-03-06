// In this tab, you must write code in:
//
// * showScores()
// * updateScores()
//
// Note: The ball does not actually get created until the SPACE key is hit.
// See the keypresses tab for construction of the ball.

Ball ball;        
Paddle computer;
Player player;
enum GAME_STATE { IN_PLAY, NO_PLAY, BEFORE_GAME, GAME_OVER };
GAME_STATE state = GAME_STATE.BEFORE_GAME;  // Keeps track of state of game
PVector NO_MOVE = new PVector(0, 0);
final int POINTS_NEEDED_TO_WIN = 5;
PFont font;
PFont gameOverFont;

void setup() {
  size(1024, 768);
  ellipseMode(RADIUS);
  
  computer = new Paddle(width/2 - 100, 0, 9, 3*height/4, new PVector(0, 3), color(#000000));
  player = new Player(-width/2 + 100, 0, 9, height/5, NO_MOVE, color(#000000));

  // For scoring
  font = createFont("Courier", 72);
  gameOverFont = createFont("Courier", 256);
  textFont(font);
  textAlign(CENTER, CENTER);  // Specify center of where text should be printed
}

void draw() {
  background(#ffffff);
  // Translation removed because there is a fair amount of text that is easier
  // to draw if the origin is at top left
  //translate(width/2, height/2);
  
  showScores();  
  moveObjects();
  drawObjects();
}

public void moveObjects() {
  // The ball shouldn't move unless it is in play
  if (state == GAME_STATE.IN_PLAY) ball.move();
  computer.move();
  player.move();
}

    
public void drawObjects() {
  // Don't draw a ball until a game has started
  if (state != GAME_STATE.BEFORE_GAME) ball.draw();
  computer.draw();
  player.draw();
}

// TODO: showScores()
public void showScores() {
  // Make sure the scores are correct
  updateScores();
  
  // show scores instead of "hi"
  text(player.getScore(), 200, 50); 
  text(computer.getScore(), width - 200, 50); 
  
  // Display "GAME OVER" if the game is over
  // (Changing the game state to indicate that the game is over is handled in
  // updateScores(), below; you just need to check the game state and display text
  if (state == GAME_STATE.GAME_OVER) {
    text("GAME OVER", width/2, 300);
  }
  // YOUR CODE HERE
}

// TODO: updateScores()
public void updateScores() {
  // If the ball is not in play, there is no score to update, so just return
  if (state != GAME_STATE.IN_PLAY) return;
  
  // If the ball is in play, then check to see if it has hit a wall.
  // If so, then:
  // 1. Stop the ball (think vector)
  // 2. Change the state of the game so the ball is no longer in play
  // 3. Figure out who scored and give that side a point.
  // 4. Check to see if the game is over; if so, change the game state accordingly
  if (ball.intersectsVertical()) { // point scored
    ball.setVector(NO_MOVE);
    state = GAME_STATE.NO_PLAY;
    if (ball.getX() < player.getX()) {
      computer.scorePoint();
    } else if (ball.getX() > computer.getX()) {
      player.scorePoint();
    }
    if (player.getScore() >= POINTS_NEEDED_TO_WIN || computer.getScore() >= POINTS_NEEDED_TO_WIN) {
      state = GAME_STATE.GAME_OVER;
    }
  }
}
