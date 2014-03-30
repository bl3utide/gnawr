module gnawr.bitfont;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.table.bitmap;

void initBitFont() {
  font[FontType.abs] = BitFont("abstract_12pt.bmp", tBitmapAbsRect, 36, SDL_Color(0, 0, 0, 255));
  font[FontType.squ] = BitFont("square_48pt.bmp", tBitmapSquRect, 40, SDL_Color(0, 0, 0, 255));
}

void closeBitFont() {
  font[FontType.abs].closeFont();
  font[FontType.squ].closeFont();
}

void renderBitFont(FontType _kind, string _text, float _x, float _y, uint _s, ubyte _r, ubyte _g, ubyte _b, ubyte _a) {
  //---------------------------------------------------------------------------------
  // サーフェイス作成
  Uint32 cm_r = 255 << 24;
  Uint32 cm_g = 255 << 16;
  Uint32 cm_b = 255 << 8;
  
  // テキストの内容を決定する
  if(_text != "")
    str = std.string.sformat(buffer, "%s", _text);
  else
    str = std.string.sformat(buffer, "%s", " ");
  
  // サーフェイスの大きさ決定してサーフェイス作成
  sw = 0; sh = 0;
  sh = font[_kind].height;
  foreach(ch; str) {
    short chi = cast(short)ch - 32;
    sw += font[_kind].ps[chi].w;
  }
  surface = SDL_CreateRGBSurface(SDL_SWSURFACE, sw, sh, 32, cm_r, cm_g, cm_b, 255);
  
  // 画像から位置文字ずつサーフェイスをコピーする
  sw = 0;
  foreach(ch; str) {
    short chi = cast(short)ch - 32;
    SDL_Rect src = { font[_kind].ps[chi].x, font[_kind].ps[chi].y,
                     font[_kind].ps[chi].w, font[_kind].ps[chi].h };
    SDL_Rect dst = { cast(short)sw, 0, 0, 0 };
    SDL_BlitSurface(font[_kind].fileSurface, &src, surface, &dst);
    sw += font[_kind].ps[chi].w;
  }
  SDL_SetColorKey(surface, SDL_SRCCOLORKEY,
                  SDL_MapRGB(surface.format, font[_kind].colorKey.r, font[_kind].colorKey.g, font[_kind].colorKey.b));
  
  //-----------------------------------------------------------------------
  // OpenGLのテスクチャへ
  uint texture = 0;

  glGenTextures(1, &texture);
  glBindTexture(GL_TEXTURE_2D, texture);
  
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, surface.w, surface.h, 0, GL_RGBA, GL_UNSIGNED_BYTE, surface.pixels);
  
  glPushMatrix();
    glTranslatef(_x, _y, 0.0f);
    glColor4ub(_r, _g, _b, _a);
    glScalef(_s * 0.01f, _s * 0.01f, 1.0f);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
      glTexCoord2d(0, 0); glVertex2f(0.0f     , surface.h);
      glTexCoord2d(1, 0); glVertex2f(surface.w, surface.h);
      glTexCoord2d(1, 1); glVertex2f(surface.w, 0.0f     );
      glTexCoord2d(0, 1); glVertex2f(0.0f     , 0.0f     );
    glEnd();
    glBindTexture(GL_TEXTURE_2D, 0);
    glDisable(GL_TEXTURE_2D);
  glPopMatrix();
  
  glDeleteTextures(1, &texture);
  SDL_FreeSurface(surface);
}

struct BitFont {
  SDL_Surface* fileSurface;
  SDL_Rect[96] ps;
  ushort height;
  SDL_Color colorKey;
  this(const(char)* locBitmap, SDL_Rect[96] ps, ushort height, SDL_Color colorKey) {
    this.fileSurface = SDL_LoadBMP(locBitmap);
    this.ps = ps;
    this.height = height;
    this.colorKey = colorKey;
    
    if(!this.fileSurface)
      throw new Exception("error: bmp not found");
  }
  void closeFont() {
    SDL_FreeSurface(this.fileSurface);
  }
}

enum FontType { abs, squ, all };

private SDL_Surface *surface;
private int sw, sh;
private char[256] buffer;
private char[] str;

BitFont font[FontType.all];