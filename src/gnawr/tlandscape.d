module gnawr.tlandscape;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.gnawr;
import gnawr.util.task;

/**
 *
 * Landscape
 *
 */
class Landscape : Mover {
private:
  ulong counter;
  double rvel;

public:
  new(size_t t) {
    return operator_new(t, lstLandscape);
  }

  this(float rotateVelocity) {
    super(lstLandscape, 0, 0);
    counter = 0;
    rvel = rotateVelocity;
  }
  
  override bool move() {
    return !isBlackOut;
  }
}






class BlueScape : Landscape {
public:
  this() {
    super(0.4);
  }
  
  override bool move() {
    counter++;
    return super.move();
  }
  
  override void draw() {
    glPushMatrix();
      glTranslatef(0.0f, 0.0f, 0.0f);
      glColor4ub(20, 30, 50, 55);
      glBegin(GL_QUADS);
       glVertex3f(-30.0f, -30.0f, 0.0f);
        glVertex3f(-30.0f, 30.0f, 0.0f);
        glVertex3f(30.0f, 30.0f, 0.0f);
        glVertex3f(30.0f, -30.0f, 0.0f);
      glEnd();
    glPopMatrix();
  
    glPushMatrix();
      glTranslatef(scrAxisX, 0.0f, -15.0f);
      glRotatef(counter * rvel % 360, 1.0f, 0.0f, 0.0f);
      glScalef(6.0f, 6.0f, 6.0f);
      for(int i = 0; i < 360; i+= 45) {
        glRotatef(i, 1.0f, 0.0f, 0.0f);
        glColor4ub(0, 40, 120, 80);

        glPushMatrix();
//          glBegin(GL_LINE_LOOP);
          i % 2 == 0 ? glBegin(GL_QUADS) : glBegin(GL_LINE_LOOP);
            glVertex3f(-2.0f, -1.8f, -0.6f);
            glVertex3f(-2.0f, -1.8f,  0.6f);
            glVertex3f( 2.0f, -1.8f,  0.6f);
            glVertex3f( 2.0f, -1.8f, -0.6f);
          glEnd();
        glPopMatrix();

        glPushMatrix();
          i % 2 == 1 ? glBegin(GL_QUADS) : glBegin(GL_LINE_LOOP);
//          glBegin(GL_LINE_LOOP);
            glVertex3f(-2.0f, -1.4f, -0.5f);
            glVertex3f(-2.0f, -1.4f,  0.5f);
            glVertex3f( 2.0f, -1.4f,  0.5f);
            glVertex3f( 2.0f, -1.4f, -0.5f);
          glEnd();
        glPopMatrix();

        glPushMatrix();
          glBegin(GL_LINE_LOOP);
            glVertex3f( 2.0f, -1.0f, -0.4f);
            glVertex3f( 2.0f, -1.0f,  0.4f);
            glVertex3f(-2.0f, -1.0f,  0.4f);
            glVertex3f(-2.0f, -1.0f, -0.4f);
          glEnd();
        glPopMatrix();
      }
    glPopMatrix();
  }
}