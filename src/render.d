module gnawr.render;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import derelict.opengl.glu;
import gnawr.gnawr;

private uint brightness;

void initRenderer() {
  initGL();
  
  // load textures
  loadTexture("brightness_b.bmp", &brightness);
}

void closeRenderer() {
  deleteTexture(&brightness);
  closeGL();
}

private void initGL() {
  glViewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
  
  glLineWidth(1.0f);
  glEnable(GL_LINE_SMOOTH);
  
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  glEnable(GL_BLEND);
  
  glDisable(GL_LIGHTING);
  glDisable(GL_CULL_FACE);
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_TEXTURE_2D);
  glDisable(GL_COLOR_MATERIAL);
  
  resizeScreen(SCREEN_WIDTH, SCREEN_HEIGHT);
  glLoadIdentity();
  
  glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
}

private void closeGL() {
}

private void loadTexture(string filename, uint* texture) {
  string fileDir = "image/";
  string filePath = fileDir ~ filename;
  SDL_Surface* surface;
  
  surface = SDL_LoadBMP(cast(const(char*))filePath);
  if(!surface) {
    throw new Exception("error: texture bmp not found");
  }
  
  glGenTextures(1, texture);
  glBindTexture(GL_TEXTURE_2D, *texture);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, surface.w, surface.h, 0, GL_RGB, GL_UNSIGNED_BYTE, surface.pixels);
//  gluBuild2DMipmaps(GL_TEXTURE_2D, 3, surface.w, surface.h, GL_RGBA, GL_UNSIGNED_BYTE, surface.pixels);
}

private void deleteTexture(uint* texture) {
  glDeleteTextures(1, texture);
}

void drawGLBegin() {
  glClear(GL_COLOR_BUFFER_BIT);
  
  double zoom = 17;
  glPushMatrix();
  
  gluLookAt(0, 0, zoom, 0, 0, 0, 0, 1.0, 0.0);
}

void drawGLEnd() {
  glPopMatrix();
}

void resizeScreen(int _width, int _height) {
  glViewport(0, 0, _width, _height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(45.0, cast(double)SCREEN_WIDTH / cast(double)SCREEN_HEIGHT, 0.1, 1000);
  glMatrixMode(GL_MODELVIEW);
}

void setEyePos() {
  float rx = 0.0f;
  float ry = 0.0f;
  
  glTranslatef(rx, ry, 0.0f);
}

void drawContentBegin() {
  glPushMatrix();
  setEyePos();
}

void drawContentEnd() {
  glPopMatrix();
}

void drawBoardBegin() {
  glPushMatrix();
}

void drawBoardEnd() {
  glPopMatrix();
}

void drawLine(float x1, float y1, float x2, float y2, float width, ubyte r, ubyte g, ubyte b, ubyte a) {
  glPushMatrix();
    glTranslatef(0.0f, 0.0f, 0.0f);
    glColor4ub(r, g, b, a);
    glLineWidth(width);
    glBegin(GL_LINES);
      glVertex3f(x1, y1, 0.0f);
      glVertex3f(x2, y2, 0.0f);
    glEnd();
    glLineWidth(1.0f);
  glPopMatrix();
}

void drawBox(float x, float y, float w, float h, ubyte r, ubyte g, ubyte b, ubyte a) {
  glPushMatrix();
    glTranslatef(0.0f, 0.0f, 0.0f);
    glColor4ub(r, g, b, a);
    glBegin(GL_QUADS);
      glVertex3f(x - w / 2, y - h / 2, 0.0f);
      glVertex3f(x + w / 2, y - h / 2, 0.0f);
      glVertex3f(x + w / 2, y + h / 2, 0.0f);
      glVertex3f(x - w / 2, y + h / 2, 0.0f);
    glEnd();
  glPopMatrix();
}

void drawFilledBox(float x, float y, float w, float h, ubyte r, ubyte g, ubyte b, ubyte a) {
  glPushMatrix();
    glTranslatef(0.0f, 0.0f, 0.0f);
    glColor4ub(r, g, b, a);
    glBegin(GL_QUADS);
      glVertex3f(x - w / 2, y - h / 2, 0.0f);
      glVertex3f(x + w / 2, y - h / 2, 0.0f);
      glVertex3f(x + w / 2, y + h / 2, 0.0f);
      glVertex3f(x - w / 2, y + h / 2, 0.0f);
    glEnd();
  glPopMatrix();
}

void drawBrightness(float x, float y, float w, float h, ubyte r, ubyte g, ubyte b, ubyte a) {
  float ww = w / 2;
  float hh = h / 2;
  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, brightness);
  glPushMatrix();
    glTranslatef(x, y, 0.0f);
    glColor4ub(r, g, b, a);
    glBegin(GL_QUADS);
      glTexCoord2d(0, 1); glVertex2f(-ww, -hh);
      glTexCoord2d(1, 1); glVertex2f( ww, -hh);
      glTexCoord2d(1, 0); glVertex2f( ww,  hh);
      glTexCoord2d(0, 0); glVertex2f(-ww,  hh);
    glEnd();
  glPopMatrix();
  glDisable(GL_TEXTURE_2D);
}

void drawBrightness(float x, float y, float w, float h, float d, ubyte r, ubyte g, ubyte b, ubyte a) {
  float ww = w / 2;
  float hh = h / 2;
  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, brightness);
  glPushMatrix();
    glTranslatef(x, y, 0.0f);
    glRotatef(360.0f * d, 0.0f, 0.0f, 1.0f);
    glColor4ub(r, g, b, a);
    glBegin(GL_QUADS);
      glTexCoord2d(0, 1); glVertex2f(-ww, -hh);
      glTexCoord2d(1, 1); glVertex2f( ww, -hh);
      glTexCoord2d(1, 0); glVertex2f( ww,  hh);
      glTexCoord2d(0, 0); glVertex2f(-ww,  hh);
    glEnd();
  glPopMatrix();
  glDisable(GL_TEXTURE_2D);
}