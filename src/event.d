module gnawr.event;

import derelict.sdl.sdl;
import gnawr.render;

class GameEvent {
private:
  SDL_Event ev;
  Uint8* keys;
  bool[7] on;
  /*
    0: quit
    1: up
    2: down
    3: left
    4: right
    5: button1
    6: button2
  */
  
public:
  this() {
    foreach(i; on)
      i = false;
  }
  
  void beginEvent() {
    keys = SDL_GetKeyState(null);

    while(SDL_PollEvent(&ev)) {
      if(ev.type == SDL_QUIT)
        on[0] = true;
      if(ev.type == SDL_VIDEORESIZE) {
        SDL_ResizeEvent re = ev.resize;
        resizeScreen(re.w, re.h);
      }
      if(ev.type == SDL_KEYDOWN) {
        switch(ev.key.keysym.sym) {
          case SDLK_ESCAPE:
            on[0] = true;
            break;
          case SDLK_UP:
          case SDLK_w:
            on[1] = true;
            break;
          case SDLK_DOWN:
          case SDLK_s:
            on[2] = true;
            break;
          case SDLK_LEFT:
          case SDLK_a:
            on[3] = true;
            break;
          case SDLK_RIGHT:
          case SDLK_d:
            on[4] = true;
            break;
          case SDLK_l:
          case SDLK_z:
            on[5] = true;
            break;
          case SDLK_SEMICOLON:
          case SDLK_x:
            on[6] = true;
            break;
          default:
            break;
        }
      }
    }
  }
  
  void cleanup() {
    for(int i = 0; i < 7; i++ )
      on[i] = false;
  }
  
  bool isQuit() { return on[0]; }

  bool isUpPushed() { return on[1]; }

  bool isDownPushed() { return on[2]; }

  bool isLeftPushed() { return on[3]; }

  bool isRightPushed() { return on[4]; }

  bool isButton1Pushed() { return on[5]; }

  bool isButton2Pushed() { return on[6]; }

  bool isUpPressed() {
    return
      keys[SDLK_UP] == SDL_PRESSED ||
      keys[SDLK_w] == SDL_PRESSED
    ;
  }

  bool isDownPressed() {
    return
      keys[SDLK_DOWN] == SDL_PRESSED ||
      keys[SDLK_s] == SDL_PRESSED
    ;
  }

  bool isLeftPressed() {
    return
      keys[SDLK_LEFT] == SDL_PRESSED ||
      keys[SDLK_a] == SDL_PRESSED
    ;
  }

  bool isRightPressed() {
    return
      keys[SDLK_RIGHT] == SDL_PRESSED ||
      keys[SDLK_d] == SDL_PRESSED
    ;
  }

  bool isButton1Pressed() {
    return
      keys[SDLK_l] == SDL_PRESSED ||
      keys[SDLK_z] == SDL_PRESSED
    ;
  }

  bool isButton2Pressed() {
    return
      keys[SDLK_SEMICOLON] == SDL_PRESSED ||
      keys[SDLK_x] == SDL_PRESSED
    ;
  }
}