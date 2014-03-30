module gnawr.tship;

import std.math;
import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.gnawr;
import gnawr.event;
import gnawr.render;
import gnawr.tweapon;
import gnawr.util.task;


class RedShip : Ship {
private:
  static const float normal_speed = 0.14f;
  static const float slant_speed = 0.1f;

protected:
  override void shot() {
    new RedShot(x - 0.4f, y, 0.25f, 0.4f);
    new RedShot(x - 0.2f, y, 0.25f, 0.45f);
    new RedShot(x + 0.2f, y, 0.25f, 0.45f);
    new RedShot(x + 0.4f, y, 0.25f, 0.4f);
    new RedShot(x - 0.2f, y, 0.255f, 0.35f);
    new RedShot(x - 0.4f, y, 0.255f, 0.3f);
    new RedShot(x + 0.2f, y, 0.245f, 0.35f);
    new RedShot(x + 0.4f, y, 0.245f, 0.3f);
  }

public:
  this(float x, float y) {
    super(x, y, normal_speed, slant_speed);
  }

  override void draw() {

    glPushMatrix();
      glTranslatef(x, y, 0.0f);

      glColor4ub(255, 200, 80, 105);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f,  0.1f, 0.0f);
        glVertex3f(-0.1f,  0.1f, 0.0f);
      glEnd();
      
      glColor4ub(255, 40, 10, 120);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f,  0.1f, 0.0f);
        glVertex3f(-0.1f,  0.1f, 0.0f);
      glEnd();
      
      glRotatef(phase, 0.2f, 0.4f, 0.8f);

      glColor4ub(255, 100, 100, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glColor4ub(255, 100, 100, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
      
      glColor4ub(200, 120, 100, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();

      glColor4ub(200, 120, 100, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glRotatef(90.0f, 0.0f, 1.0f, 0.0f);
      
      glColor4ub(180, 100, 100, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();

      glColor4ub(180, 100, 100, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
    glPopMatrix();
  }
}

class BlueShip : Ship {
private:
  static const float normal_speed = 0.1f;
  static const float slant_speed = 0.08f;

protected:
  override void shot() {
    new BlueShot(x - 0.45f, y, 0.29f, 0.45f);
    new BlueShot(x - 0.15f, y, 0.29f, 0.45f);
    new BlueShot(x + 0.15f, y, 0.21f, 0.45f);
    new BlueShot(x + 0.45f, y, 0.21f, 0.45f);

    new BlueShot(x - 0.75f, y, 0.3f, 0.4f);
    new BlueShot(x - 1.05f, y, 0.3f, 0.4f);
    new BlueShot(x + 0.75f, y, 0.2f, 0.4f);
    new BlueShot(x + 1.05f, y, 0.2f, 0.4f);
  }

public:
  this(float x, float y) {
    super(x, y, normal_speed, slant_speed);
  }
  
//  override bool move() {
//    if(gameEvent.isButton2Pushed()) {
//      gameShip = new RedShip(x, y);
//      return false;
//    }
//    return super.move();
//  }

  override void draw() {
  
    glPushMatrix();
      glTranslatef(x, y, 0.0f);

      glColor4ub(255, 10, 40, 105);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f,  0.1f, 0.0f);
        glVertex3f(-0.1f,  0.1f, 0.0f);
      glEnd();
      
      glColor4ub(255, 10, 40, 120);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f, -0.1f, 0.0f);
        glVertex3f( 0.1f,  0.1f, 0.0f);
        glVertex3f(-0.1f,  0.1f, 0.0f);
      glEnd();
      
      glRotatef(phase, 0.2f, 0.4f, 0.8f);

      glColor4ub(100, 100, 255, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glColor4ub(100, 100, 255, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
      
      glColor4ub(100, 120, 200, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();

      glColor4ub(100, 120, 200, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
      
      glRotatef(90.0f, 0.0f, 1.0f, 0.0f);
      
      glColor4ub(100, 180, 180, 40);
      glBegin(GL_TRIANGLE_FAN);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();

      glColor4ub(100, 180, 180, 180);
      glBegin(GL_LINE_LOOP);
        glVertex3f(-0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f, -0.3f, 0.0f);
        glVertex3f( 0.3f,  0.3f, 0.0f);
        glVertex3f(-0.3f,  0.3f, 0.0f);
      glEnd();
    glPopMatrix();
  }
}


class Ship : Mover {
private:
  float phase;
  int cntRapid;
  float speed;
  float lspeed;
  float slantSpeed;
  float slantLSpeed;
  static const float coeSlant = 0.7f;
  float toScr;
  float toScrSlant;
  
protected:
  
  void shot() {}

public:
  new(size_t t) {
    return operator_new(t, lstShip);
  }

  this(float x, float y, float speed, float lspeed) {
    super(lstShip, x, y);
    this.phase = 0.0f;
    this.cntRapid = 0;
    this.speed = speed;
    this.lspeed = lspeed;
    this.slantSpeed = speed * coeSlant;
    this.slantLSpeed = lspeed * coeSlant;
    this.toScr = speed * scrSpeed;
    this.toScrSlant = slantSpeed * scrSpeed;
  }
  
  override bool move() {
    // デバッグ用
    if(gameEvent.isButton2Pushed()) {
      return false;
    }

    // セミオート連射
    if(cntRapid == 0 && gameEvent.isButton1Pushed()) {
      cntRapid = 16;
    }
    else {
      if(cntRapid > 0)
        cntRapid--;
    }
    if(cntRapid > 5 && cntRapid % 3 == 0)
      shot();

    // 移動
    if(gameEvent.isUpPressed() && gameEvent.isLeftPressed()) {
      if(x > -sedgeX) {
        x -= slantSpeed;
        scrX = -toScrSlant;
      }
      if(y < sedgeY)
        y += slantSpeed;
    }
    else if(gameEvent.isUpPressed() && gameEvent.isRightPressed()) {
      if(x < sedgeX) {
        x += slantSpeed;
        scrX = toScrSlant;
      }
      if(y < sedgeY)
        y += slantSpeed;
    }
    else if(gameEvent.isDownPressed() && gameEvent.isLeftPressed()) {
      if(x > -sedgeX) {
        x -= slantSpeed;
        scrX = -toScrSlant;
      }
      if(y > -sedgeY)
        y -= slantSpeed;
    }
    else if(gameEvent.isDownPressed() && gameEvent.isRightPressed()) {
      if(x < sedgeX) {
        x += slantSpeed;
        scrX = toScrSlant;
      }
      if(y > -sedgeY)
        y -= slantSpeed;
    }
    else if(gameEvent.isUpPressed() && !gameEvent.isDownPressed()) {
      y += speed;
      if(y > sedgeY)
        y = sedgeY;
    }
    else if(gameEvent.isDownPressed() && !gameEvent.isUpPressed()) {
      y -= speed;
      if(y < -sedgeY)
        y = -sedgeY;
    }
    else if(gameEvent.isLeftPressed() && !gameEvent.isRightPressed()) {
      if(x > -sedgeX) {
        x -= speed;
        scrX = -toScr;
      }
    }
    else if(gameEvent.isRightPressed() && !gameEvent.isLeftPressed()) {
      if(x < sedgeX) {
        x += speed;
        scrX = toScr;
      }
    }

    phase += 2.0f;
    if(phase >= 360.0f)
      phase = 0.0f;

    return true;
  }
}