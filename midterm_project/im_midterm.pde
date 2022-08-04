import java.lang.Math;
import processing.sound.*;
SoundFile intro_song, background_song;

String audioName = "intro.mp3";
String audioName2 = "background.mp3";
String path, path2;

Game game;

// creating arrays for distractions and assignments which are used later
// also creating an array for the possible positions where assignments are launched
Distractions[] distractions;
Discussion[] discussion_list;
Discussion[] discussion_list2;
Assignment[] assignments;
Assignment[] assignments2;
Assignment[] assignments3;
int[][] position_list;

// Creating a Creature class which stores all the basic attributes, including the creature's position, radius, initial x and y velocities, and image attributes. 
// Each 'creature' will inherit certain attributes from this class and its display function where necessary.
class Creature {
  float posX, posY, radius, velocityX, velocityY, imgwidth, imgheight;
  PImage sprite_image;
  int num_frames, frame;
  String directionX;

  Creature(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    posX = x;
    posY = y;
    radius = r;
    velocityX = 0;
    velocityY = 0;
    directionX = "right";
    sprite_image = loadImage(image_name);
    imgwidth = img_w;
    imgheight = img_h;
    num_frames = number_frames;
    frame = 0;
  }

  // This function displays the image of each creature and inverts it according to the creature's direction of motion. It calls the update function of that specific creature.
  void display() {
    update();
    if (directionX == "right") {
      image(sprite_image, float(int(posX - imgwidth/2)), float(int(posY - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
    } else if (directionX == "left") {
      image(sprite_image, float(int(posX - imgwidth/2)), float(int(posY - imgheight/2)), imgwidth, imgheight, int((frame + 1) * imgwidth), 0, int(frame * imgwidth), int(imgheight));
    }
  }

  void update() {
  }
}


class Faiza extends Creature {
  boolean move_up, move_down, move_right, move_left;
  boolean alive;
  int breakdown_counter, distraction_counter;

  Faiza(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
    move_up = false;
    move_down = false;
    move_right = false;
    move_left = false;
    // Initially Faiza is set to alive, if Faiza collides with any of the obstacles, then "alive" becomes false and Faiza returns to her original position
    alive = true;
    // creating two counters which record the number of collisions with obstacles (Level 1-10) and distractions (level 11) respectively
    breakdown_counter = 0;
    distraction_counter = 0;
  }

  void update() {
    if (game.level >= 1 && game.level <= 5) {
      // For level 1-5 there are restrictions on the movement of Faiza because of the grid present in these levels
      // Hence, the following if conditions will restrict Faiza's movement by using coordinates of the lines in the grid/maze.
      // The first condition is for when Faiza moves left
      if (move_left == true){
        velocityX = -2;
        directionX = "left";
        if (posX - radius + velocityX < 6) {
          velocityX = 0;
        }
        if (posX - radius > 270 && posX - radius + velocityX < 280 && (posY - radius < 396 || posY + radius > 484)) {
          velocityX = 0;
        }
        if (posX - radius > 650 && posX - radius + velocityX < 660 && posY - radius < 286) {
          velocityX = 0;
        }
        if (posX - radius > 820 && posX - radius + velocityX < 830 && posY + radius > 244) {
          velocityX = 0;
        }
        posX += velocityX;
      }
      
      // the next condition is for when Faiza moves right
      else if (move_right == true) {
        velocityX = 2;
        directionX = "right";
        if (posX + radius < 120 && posX + radius + velocityX > 110 && (posY - radius < 396 || posY + radius > 484)) {
          velocityX = 0;
        }
        if (posX + radius < 750 && posX + radius + velocityX > 740 && posY + radius > 244) {
          velocityX = 0;
        }
        if (posX + radius < 920 && posX + radius + velocityX > 910 && posY - radius < 526) {
          velocityX = 0;
        }
        if (posX + radius > 1018) {
          velocityX = 0;
        }
        posX += velocityX;
      }
      
      // If none of the left and right keys are being pressed, Faiza stops moving horizontally
      else {
        velocityX = 0;
      }
      
      // The condition below is for when Faiza moves upwards
      if (move_up == true) {
        velocityY = -2;
        if (posX + radius < 120 && posY - radius + velocityY < 288) {
          velocityY = 0;
        }
        if (posX + radius >= 120 && posX - radius <= 270 && posY - radius + velocityY < 398) {
          velocityY = 0;
        }
        if (posX - radius > 270 && posX - radius <= 650 && posY - radius + velocityY < 288){
          velocityY = 0;
        }
        if (posX - radius > 650 && posX + radius < 920 && posY - radius + velocityY < 168) {
          velocityY = 0;
        }
        if (posX + radius >= 920 && posY - radius + velocityY < 528){
          velocityY = 0;
        }
        posY += velocityY;
      }
      
      // The condition below is for when Faiza moves downwards
      else if (move_down == true) {
        velocityY = 2;
        if (posX + radius < 120 && posY + radius + velocityY > 613) {
          velocityY = 0;
        }
        if (posX + radius >= 120 && posX - radius <= 270 && posY + radius + velocityY > 482) {
          velocityY = 0;
        }
        if (posX - radius > 270 && posX + radius < 750 && posY + radius + velocityY > 612){
          velocityY = 0;
        }
        if (posX + radius >= 750 && posX - radius <= 820 && posY + radius + velocityY > 242) {
          velocityY = 0;
        }
        if (posX - radius > 820 && posX + radius <= 1024 && posY + radius + velocityY > 612) {
          velocityY = 0;
        }
        posY += velocityY;
      }
      
      // If none of the up and down keys are being pressed, Faiza stops moving vertically
      else {
        velocityY = 0;
      }
    }
    
    else if (game.level >= 6) {
      //The condition below is for when Faiza moves left
      if (move_left == true) {
        velocityX = -2;
        directionX = "left";
        if (posX - radius + velocityX < 6) {
          velocityX = 0;
        }
        posX += velocityX;
      }
  
      //The condition below is for when Faiza moves right
      else if (move_right == true) {
        velocityX = 2;
        directionX = "right";
        if (posX + radius + velocityX > 1018) {
          velocityX = 0;
        }
        posX += velocityX;
      }
  
      //If none of the left and right keys are being pressed, Faiza stops moving horizontally
      else {
        velocityX = 0;
      }        
  
      if (move_up == true) {
        velocityY = -2;
        if (posY - radius + velocityY <= 5) {
          velocityY = 0;
        }
        posY += velocityY;
      }
  
      //The condition below is for when Faiza moves downwards
      else if (move_down == true) {
        velocityY = 2;
        if (posY + radius + velocityY >= 762) {
          velocityY = 0;
        }      
        posY += velocityY;
      }
  
      //If none of the up and down keys are being pressed, Faiza stops moving vertically
      else {
        velocityY = 0;
      }
    }

    // Animating Faiza by continuously iterating over each frame in it's sprite when Faiza is moving
    if ((frameCount%5 == 0) && (velocityX != 0 || velocityY != 0)) {
      frame = (frame + 1) % (num_frames - 1);
    } 
    // If Faiza is not moving, the frame where Faiza is still is displayed
    else if (velocityX == 0 && velocityY == 0) {
      frame = 8;
    }
    
    
    // For all the following blocks of code, "alive" is set to False when Faiza collides with any of these objects, and so Faiza returns to the starting position in that level
    // Also, the breakdown counter is incremented by 1 for every collision
    if (game.level >= 2 && game.level <= 5) {
      if (distance(game.clock) <= radius + game.clock.radius) {
        breakdown_counter += 1;
        alive = false;
      }
    }
    
    if (game.level == 4 || game.level == 5) {
      if (distance(game.clock2) <= radius + game.clock2.radius) {
        breakdown_counter += 1;
        alive = false;
      }
    }
    
    if (game.level == 5) {
      if (distance(game.clock3) <= radius + game.clock3.radius) {
        breakdown_counter += 1;
        alive = false;
      }
    }
    
    if (game.level >= 3 && game.level <= 5) {
      if (distance(discussion_list[0]) <= radius + discussion_list[0].radius) {
        breakdown_counter += 1;
        alive = false;
      }
    }
    
    if (game.level >= 6 && game.level <= 10) {
      if (distance(discussion_list2[0]) <= radius + discussion_list2[0].radius) {
        breakdown_counter += 1;
        alive = false;
        game.anxiety.alive = false;
        game.anxiety2.alive = false;
      }
    }
    
    if (game.level >= 1 && game.level <= 5) {
      if (distance(game.brain) <= radius + game.brain.radius) {
        game.level += 1;
        game.clock = new Clock(310, 330, 32, "clock.png", 66, 66, 4);
        game.clock2 = new Clock(695, 570, 32, "clock.png", 66, 66, 4);
        game.clock3 = new Clock(500, 440, 32, "clock.png", 66, 66, 4);
        alive = false;
      }
    }
    
    if (game.level >= 6 && game.level <= 10) {
      if (distance(game.brain2) <= radius + game.brain2.radius) {
        game.level += 1;
        alive = false;
        game.anxiety.alive = false;
        game.anxiety2.alive = false;
      }
    }

    if (game.level == 11) {
      if (!(posX >= 0 && posX <= 100 && posY >= 530 && posY <= 640)) { 
        for (int i = 0; i < 6; i++) {
          if (distance(distractions[i]) <= radius + distractions[i].radius) {
            distraction_counter += 1;
            alive = false;
          }
        }
      }
      
      // checking collision with the gpa in the last level
      if (distance(game.gpa) <= (radius + game.gpa.radius) && game.level == 11) {
        game.level += 1;
      }
    }
    
    // Incrementing x_shift in the Game class when Faiza in moving in the x-direction to implement parallax effect
    if (posX >= 0) {
      game.x_shift += velocityX;
    }
    
  }

  // this distance method will be used to check for collisions with distractions
  double distance(Creature target) {
    float a = (posX - target.posX);
    float b = (posY - target.posY);
    double c = Math.pow(a, 2);
    double d = Math.pow(b, 2);
    return Math.pow(c + d, 0.5);
  }
}

// Creating the obstacle Clock, which moves sideways within a certain x-range.
// Appears in levels 1-5
class Clock extends Creature {
  // x_left and x_right represent the boundaries of the movement of the clock
  int x_left, x_right, choose_direction;
  
  Clock(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
    x_left = 270;
    x_right = 740;
    velocityX = 3;
    
    // Choosing a random starting direction and multiplying vx by -1 if it's direction is chosen to be left at the beginning.
    choose_direction = int(random(0,2));
    if (choose_direction == 0) {
      velocityX *= -1;
    }
  }
    
    void update() {
      // Animating the clock by continuously iterating over each frame in it's sprite.
      if (frameCount % 12 == 0){
        frame = (frame + 1) % num_frames;
      }
      
      // Making the clock change it's direction if it hits one of the boundaries
      if (posX - radius <= x_left) {
        velocityX *= -1;
        directionX = "right";
      }
      
      if (posX + radius >= x_right) {
        velocityX *= -1;
        directionX = "left";
      }
      
      posX += velocityX;
      posY += velocityY;
      
    }
}

// creating the discussion class which represents random class discussions which pop up anywhere on the screen
// appears in levels 3-10
class Discussion extends Creature {
  
  Discussion(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
  }
  
  void update() {
    // Animating the quiz by continuously iterating over each frame in its sprite.
    if (frameCount % 20 == 0) {
      frame = (frame + 1) % num_frames;
    }
  }
}


// Creating the obstacle Anxiety, which continuously follows Faiza wherever she goes
// appears in levels 6-10
class Anxiety extends Creature {
  float target_x, target_y, target_r, velocity;
  boolean alive;
  boolean move_up, move_down, move_right, move_left;
  float difference_x, difference_y, angle;
  
  Anxiety(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames, float tx, float ty, float tr) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
    
    // Here we make a 'dummy' object which is precisely mapped to Faiza. It has it's separate keystroke functions which perfectly imitate 
    // Faiza's movements. This makes our task easier since everything is now handled within the Anxiety class. The 'dummy' object has of course, been
    // made invisible so that it seems Anxiety is always following Faiza. target_x, target_y, and target_r represent the position and radius of the 'dummy' object respectively.
    target_x = tx;
    target_y = ty;
    target_r = tr;
    
    // All attributes below are very similar to that of Faiza
    // There is also a velocity attribute to set the velocity of anxiety
    alive = true;
    velocity = 1.7;
    move_up = false;
    move_down = false;
    move_right = false;
    move_left = false;
    difference_x = 0;
    difference_y = 0;
    angle = 0;
  }
  
  void update() {
    if (frameCount % 20 == 0) {
      frame = (frame + 1) % num_frames;
    }
    
    
    // all the conditions below have been copies from Faiza's class to exactly imitate Faiza's movements
    if (move_left == true) {
      velocityX = -2;
      directionX = "left";
      if (target_x - target_r + velocityX < 6) {
        velocityX = 0;
      }
      target_x += velocityX;
    }

    else if (move_right == true) {
      velocityX = 2;
      directionX = "right";
      if (target_x + target_r + velocityX > 1018) {
        velocityX = 0;
      }
      target_x += velocityX;
    }

    else {
      velocityX = 0;
    }        

    if (move_up == true) {
      velocityY = -2;
      if (target_y - target_r + velocityY <= 5) {
        velocityY = 0;
      }
      target_y += velocityY;
    }

    else if (move_down == true) {
      velocityY = 2;
      if (target_y + target_r + velocityY >= 762) {
        velocityY = 0;
      }      
      target_y += velocityY;
    }

    else {
      velocityY = 0;
    }
    
    
    // We now calculate difference_x and difference_y for the difference in x and y positions between Anxiety and the 'dummy' respectively,
    // then we calculate angle between them, and increment x and y by velocity*cos(angle) and velocity*sin(angle) respectively
    // the angle constantly changes as Faiza and the dummy move, hence anxiety constantly follows Faiza
    difference_x = target_x - posX;
    difference_y = target_y - posY;
    
    // to avoid zero division error in the angle
    if (difference_x == 0 && difference_y > 0) {
      angle = radians(90);
    }
    if (difference_x == 0 && difference_y < 0) {
      angle = radians(270);
    }
    else {
      angle = atan(difference_y/difference_x);
    }
    
    
    // incrementing x and y positions using the fact that cos(-x) = cos(x) and sin(-x) = -sin(x):
    if (difference_x == 0 && difference_y > 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x == 0 && difference_y < 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y == 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y == 0) {
      posX -= velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y > 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y < 0) {
      posX -= velocity * cos(angle);
      posY -= velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y > 0) {
      posX -= velocity * cos(angle);
      posY -= velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y < 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    
    // Since Anxiety is following the 'dummy', we have to take into account the collision between the dummy and Anxiety
    // and set both the dummy's and Faiza's alive attributes to False.
    if (game.level >= 6 && game.level <= 10) {
      if (distance() <= radius + target_r) {
        alive = false;
        game.faiza.breakdown_counter += 1;
        game.faiza.alive = false;
      }
    }
  }
    
    // defining the distance method for calculating the distance between Anxiety and the dummy  
    double distance() {
    float a = (posX - target_x);
    float b = (posY - target_y);
    double c = Math.pow(a, 2);
    double d = Math.pow(b, 2);
    return Math.pow(c + d, 0.5);
  }
    
    // We slightly modify the display function for Anxiety since we don't want the text beneath Anxiety's image to be inverted when anxiety moves leftwards
    void display() {
      update();
      
      if (directionX == "right" || directionX == "left") {
        image(sprite_image, float(int(posX - imgwidth/2)), float(int(posY - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
      }
    }
  }
        
        
// Creating the obstacle Assignment, which is instantiated randomly at one of the 4 boundaries of the game's screen.
// First, it captures the position of Faiza, then locks those target coordinates (denoted by target_x and target_y) and is then fired towards them.
// Appears in levels 8-10
class Assignment extends Creature {
  float target_x, target_y, velocity;
  float difference_x, difference_y, angle;
  
  Assignment(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames, float tx, float ty) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
    // target_x and target_y represent the coordinates of Faiza
    // we make use of angles and difference in x and y to fire assignments towards faiza with a velocity
    target_x = tx;
    target_y = ty;
    difference_x = target_x - posX;
    difference_y = target_y - posY;
    velocity = 8;
    
    if (difference_x == 0 && difference_y > 0) {
      angle = radians(90);
    }
    if (difference_x == 0 && difference_y < 0) {
      angle = radians(270);
    }
    else {
      angle = atan(difference_y/difference_x);
    }
  }
  
  void update() {
    if (frameCount % 20 == 0) {
      frame = (frame + 1) % num_frames;
    }
    
    // We use the fact that cos(-x) = cos(x) and sin(-x) = -sin(x) and divide the possible directions of movement into cases:
    if (difference_x == 0 && difference_y > 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x == 0 && difference_y < 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y == 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y == 0) {
      posX -= velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y > 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y < 0) {
      posX -= velocity * cos(angle);
      posY -= velocity * sin(angle);
    }
    if (difference_x < 0 && difference_y > 0) {
      posX -= velocity * cos(angle);
      posY -= velocity * sin(angle);
    }
    if (difference_x > 0 && difference_y < 0) {
      posX += velocity * cos(angle);
      posY += velocity * sin(angle);
    }
  }
}
    
// Creating the distractions class which represents different distractions which appear in level 11
class Distractions extends Creature {

  Distractions(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
    // all distractions are instantiated with random speeds within a certain limit
    velocityX = random(2, 5);
    velocityY = -1 * random(2, 5);
  }

  void update() {
    if (frameCount % 12 == 0) {
      frame = (frame + 1) % num_frames;
    }


    // setting conditions for rebounding the distractions when they hit the corners of the screen
    if (posX + radius >= 1024) {
      velocityX *= -1;
    }
    if (posX - radius <= 0) {
      velocityX *= - 1;
    }
    if (posY - radius <= 10) {
      velocityY *= -1;
    }
    if (posY + radius >= 780) {
      velocityY *= -1;
    }

    posX += velocityX;
    posY += velocityY;
  }
}

// Creating the Brain class which appears in levels 1-10 which represents the mental health
class Brain extends Creature {
  Brain(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
  }
  
  void update() {
    if (frameCount % 20 == 0) {
      frame = (frame + 1) % num_frames;
    }
  }
}

// Creating the GPA class which appears in level 11
class GPA extends Creature {

  GPA(float x, float y, float r, String image_name, float img_w, float img_h, int number_frames) {
    super(x, y, r, image_name, img_w, img_h, number_frames);
  }
}

class Game {
  int game_width, game_height;
  Faiza faiza;
  GPA gpa;
  Brain brain, brain2;
  Clock clock, clock2, clock3;
  Anxiety anxiety, anxiety2;
  int level;
  PImage intro_bg, final_bg, over_bg, game_background;
  int x, x_shift, width_right, width_left;
  Discussion discussion, discussion2;
  int rand_int, rand_int2, rand_int3;
  
  Game(int game_wth, int game_hght) {
    level = -1;
    x = 0;
    // x_shift will be used to move the background image when faiza is moving with some x-velocity
    x_shift = 0;
    width_right = 0;
    width_left = 0;
    // rand_int, rand_int2 and rand_int3 are used for random integers which decide the boundary from which assignments are generated
    rand_int = 0;
    rand_int2 = 0;
    rand_int3 = 0;
    game_width = game_wth;
    game_height = game_hght;
    intro_bg = loadImage("start_background.png");
    game_background = loadImage("background1.png");
    final_bg = loadImage("background.png");
    over_bg = loadImage("gameover_background.png");
    
    faiza = new Faiza(34, 585, 27, "faiza.png", 66, 66, 9);
    gpa = new GPA(990, 35, 25, "gpa.png", 70, 56, 1);
    brain = new Brain(980, 570, 30, "brain_waving.png", 85, 85, 2);
    brain2 = new Brain(980, 50, 30, "brain_waving.png", 85, 85, 2);
    clock = new Clock(310, 330, 32, "clock.png", 66, 66, 4);
    clock2 = new Clock(695, 570, 32, "clock.png", 66, 66, 4);
    clock3 = new Clock(500, 440, 32, "clock.png", 66, 66, 4);
    anxiety = new Anxiety(500, 500, 25, "anxiety.png", 66, 66, 3, 34, 585, faiza.radius);
    anxiety2 = new Anxiety(1000, 700, 25, "anxiety.png", 66, 66, 3, 34, 585, faiza.radius);
    
    // instantiating discussions to be added to the array of discussions
    discussion = new Discussion(int(random(300,711)), int(random(300,591)), 25, "Discussions.png", 66, 66, 3);
    discussion2 = new Discussion(int(random(120,995)), int(random(300,591)), 25, "Discussions.png", 66, 66, 3);
    
    discussion_list = new Discussion[1];
    discussion_list2 = new Discussion[1];
    
    discussion_list[0] = discussion;
    discussion_list2[0] = discussion2;
    
    // adding distractions to the array of distractions
    distractions = new Distractions[6];
    distractions[0] =  new Distractions(100, 300, 58, "jake.png", 120, 120, 6);
    distractions[1] =  new Distractions(444, 333, 48, "insta.png", 100, 100, 1);
    distractions[2] =  new Distractions(900, 120, 48, "facebook.png", 100, 100, 1);
    distractions[3] =  new Distractions(887, 635, 48, "netflix.png", 100, 100, 1);
    distractions[4] =  new Distractions(134, 587, 48, "youtube.png", 100, 100, 1);
    distractions[5] =  new Distractions(55, 100, 48, "ps.png", 120, 120, 1);
    
    // having a position_list array which holds possible coordinates of where assignments can be launched
    position_list = new int[4][2];
    position_list[0][0] = int(random(30, 995));
    position_list[0][1] = 30;
    position_list[1][0] = 994;
    position_list[1][1] = int(random(150, 731));
    position_list[2][0] = int(random(30, 995));
    position_list[2][1] = 730;
    position_list[3][0] = 30;
    position_list[3][1] = int(random(150, 401));
    
    assignments = new Assignment[1];
    assignments[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
    assignments2 = new Assignment[2];
    assignments2[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
    assignments2[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
    assignments3 = new Assignment[3];
    assignments3[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
    assignments3[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
    assignments3[2] = new Assignment(position_list[rand_int3][0], position_list[rand_int3][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
  }

  void update() {
    // Sending Faiza back to her original position when faiza.alive == False and then setting faiza.alive to True again
    if (faiza.alive == false) {
      faiza.posX = 34;
      faiza.posY = 585;
      faiza.alive = true;
    }
    
    position_list[0][0] = int(random(30, 995));
    position_list[0][1] = 30;
    position_list[1][0] = 994;
    position_list[1][1] = int(random(150, 731));
    position_list[2][0] = int(random(30, 995));
    position_list[2][1] = 730;
    position_list[3][0] = 30;
    position_list[3][1] = int(random(150, 401));
    
    // changing the assignments in each position of the assignments array after certain intervals
    if (level == 8) {
      rand_int = int(random(0,4));
      if (frameCount % 200 == 0) {
        assignments[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
    }
    
    else if (level == 9) {
      rand_int = int(random(0,4));
      rand_int2 = int(random(0,4));
      if (frameCount % 200 == 0) {
        assignments2[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
      if (frameCount % 201 == 0) {
        assignments2[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
    }
    
    else if (level == 10) {
      rand_int = int(random(0,4));
      rand_int2 = int(random(0,4));
      rand_int3 = int(random(0,4));
      if (frameCount % 200 == 0) {
        assignments3[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
      if (frameCount % 201 == 0) {
        assignments3[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
      if (frameCount % 202 == 0) {
        assignments3[2] = new Assignment(position_list[rand_int3][0], position_list[rand_int3][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
    }
    
    // Resetting the position of the Anxieties when anxiety.alive or anxiety2.alive are False
    if (anxiety.alive == false || anxiety2.alive == false) {
      anxiety.posX = 500;
      anxiety2.posX = 1000;
      anxiety.target_x = 34;
      anxiety2.target_x = 34;
      anxiety.posY = 500;
      anxiety2.posY = 700;
      anxiety.target_y = 585;
      anxiety2.target_y = 585;
      anxiety.alive = true;
      anxiety2.alive = true;
    }
    
    // adding new discussions to the discussion_lists which are instantiated at newer random positions
    // in later levels, discussions are instantiated more frequently.
    if (frameCount % 300 == 0) {
      discussion = new Discussion(random(300,711), random(300,591), 25, "Discussions.png", 66, 66, 3);
      discussion_list[0] = discussion;
    }
    
    if (frameCount % 150 == 0) {
      discussion2 = new Discussion(random(120, 995), random(130, 739), 25, "Discussions.png", 66, 66, 3);
      discussion_list2[0] = discussion2;
    }
    
    // the following blocks of code check the collisions of assignments with faiza
    if (game.level == 8) {
      if (faiza.distance(assignments[0]) <= faiza.radius + assignments[0].radius) {
        faiza.breakdown_counter += 1;
        faiza.alive = false;
        anxiety.alive = false;
        anxiety2.alive = false;
        rand_int = int(random(0,4));
        assignments[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
      }
    }
    
    if (game.level == 9) {
      for (int i = 0; i < 2; i++) {
        if (faiza.distance(assignments2[i]) <= faiza.radius + assignments2[i].radius) {
          faiza.breakdown_counter += 1;
          faiza.alive = false;
          game.anxiety.alive = false;
          game.anxiety2.alive = false;
          rand_int = int(random(0,4));
          rand_int2 = int(random(0,4));
          assignments2[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
          assignments2[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
        }
      }
    }
    
    if (game.level == 10) {
      for (int i = 0; i < 3; i++) {
        if (faiza.distance(assignments3[i]) <= faiza.radius + assignments3[i].radius) {
          faiza.breakdown_counter += 1;
          faiza.alive = false;
          anxiety.alive = false;
          anxiety2.alive = false;
          rand_int = int(random(0,4));
          rand_int2 = int(random(0,4));
          rand_int3 = int(random(0,4));
          assignments3[0] = new Assignment(position_list[rand_int][0], position_list[rand_int][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
          assignments3[1] = new Assignment(position_list[rand_int2][0], position_list[rand_int2][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
          assignments3[2] = new Assignment(position_list[rand_int3][0], position_list[rand_int3][1], 30, "assignment.png", 66, 66, 4, faiza.posX, faiza.posY);
        }
      }
    }
    
  }

  void display() {
    update();

     // displaying the introduction screen
    if (level == -1) {
      image(intro_bg, 0, 0);
      textSize(80);
      text("UNI SUFFERERS", 230, 80);
      textSize(40);
      fill(255, 213, 43);
      text("Press the space bar to proceed", 200, 650);
    }
    
    // displaying the instructions screen
    if (level == 0) {
      image(game_background, 0, 0);
      textSize(50);
      fill(75, 0, 70);
      text("INSTRUCTIONS", 290, 80);
      textSize(30);
      text("1) The player plays the game as Faiza the Falcon", 20, 140);
      text("2) Use the arrow keys to control the movement of Faiza", 20, 180);
      text("3) Help Faiza avoid obstacles and save her mental health", 20, 220);
      text("4) Keep a check on the breakdown counter in the first 10 levels", 20, 260);
      text("5) The obstacles in the first 10 levels are of the following types:", 20, 300);
      text("a) Clocks representing 5am classes move sideways on the screen", 20, 340);
      text("b) Class discussions randomly pop up anywhere on the screen", 20, 380);
      text("c) Anxiety constantly follows the movement of Faiza", 20, 420);
      text("d) Assignments lock Faiza's coordinates and are shot with a velocity", 20, 460);
      text("6) Avoid distractions in the last level and achieve a 4.0 GPA", 20, 500);
      text("7) Once the game is over, click on the screen to play again", 20, 540);
      textSize(40);
      text("Click on the screen to begin playing", 180, 650);
    }
    
    
    // moving the background when faiza is moving in the x direction to give parallax effect
    if (level >= 1 && level <= 10) {
      x = 0;
      x = x_shift;
      
      width_right = x % game_width;
      width_left = game_width - width_right;
      
      image(game_background, 0, 0, width_left, game_height, width_right, 0, game_width, game_height);
      image(game_background, width_left, 0, width_right, game_height, 0, 0, width_right, game_height);
    }

    if (level == 11) {
      image(final_bg, 0, 0);
      //textMode(CENTER);
      textSize(40);
      fill(255, 213, 43);
      text("GET THAT 4.0!", 310, 65);
      textSize(20);
      text(faiza.distraction_counter + " distraction(s)", 860, 740);
    }

    if (level == 12) {
      image(over_bg, 0, 0);
      textSize(150);
      fill(255, 213, 43);
      text("GAME", 270, 220); 
      text("OVER", 290, 350);
      textSize(30);
      text(faiza.breakdown_counter + " breakdowns and " + faiza.distraction_counter + " distraction(s) later,", 240, 550);
      text("you finally got that 4.0 GPA!", 300, 590);
      text("Think you can do better? Click on the", 240, 630);
      text("screen to play again!", 340, 670);
    }
    
    textSize(40);
    fill(75, 0, 70);
    if (level == 1) {
      text("GO SAVE YOUR MENTAL HEALTH!", 180, 70);
    }
    else if (level == 2) {
      text("5 AM CLASSES ARE WAITING!", 210, 70);
    }
    else if (level == 3) {
      text("TOO EASY? LET'S POP THINGS UP!", 170, 70);
    }
    else if (level == 4) {
      text("HAVE MORE OF IT!", 290, 70);
    }
    else if (level == 5) {
      text("AND MORE!", 360, 70);
    }
    else if (level == 6) {
      textSize(35);
      text("SOME THINGS JUST WON'T STOP FOLLOWING YOU", 65, 60);
    }
    else if (level == 7) {
      text("THIS AIN'T GETTING ANY BETTER", 150, 65);
    }
    else if (level == 8) {
      text("WAIT, WHAT? ASSIGNMENT?", 210, 65);
    }
    else if (level == 9) {
      text("WHAT? THERE WERE TWO?", 230, 65);
    }
    else if (level == 10) {
      text("YOU'RE KIDDING ME...", 270, 65);
    }
    
    if (level >= 1 && level <= 10) {
      textSize(20);
      text(faiza.breakdown_counter + " breakdown(s)", 860, 740);
    }
      
    // creating the grid for the first few levels
    if (level >= 1 && level <= 5) {
        stroke(0, 0, 0);
        strokeWeight(7);
        line(0, 100, 1024, 100);
        line(0, 115, 1024, 115);
        strokeWeight(9);
        line(0, 280, 120, 280);
        line(120, 280, 120, 390);
        line(120, 390, 270, 390);
        line(270, 280, 270, 390);
        line(120, 490, 270, 490);
        line(0, 620, 120, 620);
        line(120, 490, 120, 620);
        line(270, 490, 270, 620);
        line(270, 280, 650, 280);
        line(650, 280, 650, 160);
        line(270, 620, 750, 620);
        line(750, 620, 750, 250);
        line(750, 250, 820, 250);
        line(820, 250, 820, 620);
        line(650, 160, 920, 160);
        line(920, 160, 920, 520);
        line(920, 520, 1024, 520);
        line(820, 620, 1024, 620);
    }

    // calling the display function of all objects in the relevant levels
    
    if (level >= 1 && level <= 11) {
      faiza.display();
    }
    
    if (level >= 2 && level <= 5) {
      clock.display();
    }
    
    if (level >= 4 && level <= 5) {
      clock2.display();
    }
    
    if (level == 5) {
      clock3.display();
    }

    if (level >= 3 && level <= 5) {
      discussion_list[0].display();
    }
    
    if (level >= 6 && level <= 10) {
      discussion_list2[0].display();
      brain2.display();
      anxiety.display();
    }
    
    if (level >= 7 && level <= 10) {
      anxiety2.display();
    }
    
    if (level >= 1 && level <= 5) {
      brain.display();
    }
    
    if (level == 8) {
      assignments[0].display();
    }
    
    if (level == 9) {
      assignments2[0].display();
      assignments2[1].display();
    }
    
    if (level == 10) {
      assignments3[0].display();
      assignments3[1].display();
      assignments3[2].display();
    }

    if (level == 11) {
      gpa.display();
      for (int i = 0; i < 6; i++) {
        distractions[i].display();
      }
    }
  }
}


void setup() {
  size(1024, 768);
  game = new Game(1024, 768);
  // setting up the introductory song and the background song
  path = sketchPath(audioName);
  intro_song = new SoundFile(this, path);
  intro_song.loop();
  
  path2 = sketchPath(audioName2);
  background_song = new SoundFile(this, path2);
}

void draw() {
  background(255, 255, 255);
  game.display();
}

// Defining keyPressed and keyReleased for Faiza and the 'dummies' in Anxiety and Anxiety2:
void keyPressed() {
  // displaying the isntructions screen when the space bar is pressed at the intro screen
  if (keyCode == 32 && game.level == -1) {
    game.level = 0;
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      game.faiza.move_right = true;
      game.anxiety.move_right = true;
      game.anxiety2.move_right = true;
    }
    if (keyCode == LEFT) {
      game.faiza.move_left = true;
      game.anxiety.move_left = true;
      game.anxiety2.move_left = true;
    }
    if (keyCode == UP) {
      game.faiza.move_up = true;
      game.anxiety.move_up = true;
      game.anxiety2.move_up = true;
    }
    if (keyCode == DOWN) {
      game.faiza.move_down = true;
      game.anxiety.move_down = true;
      game.anxiety2.move_down = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      game.faiza.move_right = false;
      game.anxiety.move_right = false;
      game.anxiety2.move_right = false;
    }
    if (keyCode == LEFT) {
      game.faiza.move_left = false;
      game.anxiety.move_left = false;
      game.anxiety2.move_left = false;
      
    }
    if (keyCode == UP) {
      game.faiza.move_up = false;
      game.anxiety.move_up = false;
      game.anxiety2.move_up = false;
    }
    if (keyCode == DOWN) {
      game.faiza.move_down = false;
      game.anxiety.move_down = false;
      game.anxiety2.move_down = false;
    }
  }
}

void mouseClicked(){
  // starting the game when the mouse is clicked at the instructions screen
  if (game.level == 0) {
    intro_song.stop();
    background_song.loop();
    game.level = 1;
  }
  // restarting the game when the mouse is clicked at the game over screen
  if (game.level == 12){
    background_song.stop();
    game = new Game(1024, 768);
    intro_song.loop();
  }
}
