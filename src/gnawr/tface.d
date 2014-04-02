module gnawr.tface;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.gnawr;
import gnawr.util.task;

class Face : Mover {
private:
  static size_t ms;

public:
  new(size_t t) {
    return operator_new(t, lstFace);
  }

  this() {
    super(lstFace, 0, 0);
  }
}



/*
 *  ブラックアウト
 */
class BlindWipeOut : Face {
private:
  int cntBlind;

public:
  this() {
    this.cntBlind = 0;
  }
  
  override bool move() {
    if(cntBlind == 1000) {
      isBlackOut = true;
      return false;
    }
    else {
      cntBlind += 25;
      if(cntBlind > 1000)
        cntBlind = 1000;
    }
    return true;
  }
  
  override void draw() {
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glPushMatrix();
      glTranslatef(0.0f, 0.0f, 0.0f);
      glColor4ub(0, 0, 0, 230);
      glBegin(GL_QUADS);
        glVertex3f(-10.0f, -8.0f, 0.0f);
        glVertex3f(-10.0f + 0.02f * cntBlind, -8.0f, 0.0f);
        glVertex3f(-10.0f + 0.02f * cntBlind,  8.0f, 0.0f);
        glVertex3f(-10.0f,  8.0f, 0.0f);
        
        glVertex3f( 10.0f, -8.0f, 0.0f);
        glVertex3f( 10.0f - 0.02f * cntBlind, -8.0f, 0.0f);
        glVertex3f( 10.0f - 0.02f * cntBlind,  8.0f, 0.0f);
        glVertex3f( 10.0f,  8.0f, 0.0f);
      glEnd();
    glPopMatrix();
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);

  }
}





/*
 *  ブラックイン
 */
class BlindWipeIn : Face {
private:
  int cntBlind;

public:
  this() {
    this.cntBlind = 0;
    isBlackOut = false;
  }
  
  override bool move() {
    if(cntBlind == 1000) {
      return false;
    }
    else {
      cntBlind += 25;
      if(cntBlind > 1000)
        cntBlind = 1000;
    }
    return true;
  }
  
  override void draw() {
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glPushMatrix();
      glTranslatef(0.0f, 0.0f, 0.0f);
      glColor4ub(0, 0, 0, 230);
      glBegin(GL_QUADS);
        glVertex3f(-10.0f, -8.0f, 0.0f);
        glVertex3f( 10.0f - 0.02f * cntBlind, -8.0f, 0.0f);
        glVertex3f( 10.0f - 0.02f * cntBlind,  8.0f, 0.0f);
        glVertex3f(-10.0f,  8.0f, 0.0f);
        
        glVertex3f( 10.0f, -8.0f, 0.0f);
        glVertex3f(-10.0f + 0.02f * cntBlind, -8.0f, 0.0f);
        glVertex3f(-10.0f + 0.02f * cntBlind,  8.0f, 0.0f);
        glVertex3f( 10.0f,  8.0f, 0.0f);
      glEnd();
    glPopMatrix();
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);

  }
}