module gnawr.tweapon;

import std.math;
import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.gnawr;
import gnawr.render;
import gnawr.tship;
import gnawr.util.task;

/**
 *
 * Weapon
 *
 */
class Weapon : Mover {
public:
  int power;
  int durability;

  new(size_t t) {
    return operator_new(t, lstWeapon);
  }
  
  this(float x, float y) {
    super(lstWeapon, x, y);
  }
  
  override bool move() {
    return !isBlackOut;
  }
}





/**
 *
 * Shot
 *
 */
class NormalShot : Weapon {
private:
  float vx, vy;

protected:
  float dir;

public:
  this(float x, float y, float dir, float speed) {
    super(x, y);
    this.power = 1;
    this.durability = 1;
    this.dir = dir;
    this.vx = speed * cos(PI * 2 * dir);
    this.vy = speed * sin(PI * 2 * dir);
  }
  
  override bool move() {
    x += vx;
    y += vy;
    
    x -= scrX;
    return (!isOut(1.0f)) && super.move();
  }
}

class RedShot : NormalShot {
public:
  this(float x, float y, float dir, float speed) {
    super(x, y, dir, speed);
  }
  
  override void draw() {
    drawBrightness(x, y, 2.0f, 0.5f, dir, 255, 20, 40, 255);
    drawBrightness(x, y, 1.8f, 0.4f, dir, 255, 20, 40, 100);
    drawBrightness(x, y, 1.5f, 0.3f, dir, 255, 255, 255, 155);
  }
}

class BlueShot : NormalShot {
public:
  this(float x, float y, float dir, float speed) {
    super(x, y, dir, speed);
  }
  
  override void draw() {
    drawBrightness(x, y, 2.0f, 0.5f, dir, 0, 100, 255, 255);
    drawBrightness(x, y, 1.8f, 0.4f, dir, 0, 100, 255, 100);
    drawBrightness(x, y, 1.5f, 0.3f, dir, 255, 255, 255, 155);
  }
}








/**
 *
 * Laser
 *
 */
class Laser : Weapon {
private:
  float vy;
  Ship owner;

public:
  this() {
    super(owner.x, owner.y);
    this.power = 4;
    this.durability = 1;
    this.vy = 1.0f;
  }
  
  override bool move() {
    return true;
  }
}