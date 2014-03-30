module gnawr.gnawr;

import std.stdio;
import std.c.windows.windows;
import core.runtime;
import core.sys.windows.windows;
import derelict.sdl.sdl;
import derelict.sdl.mixer;
import derelict.opengl.gl;
import derelict.opengl.glu;
import gnawr.bitfont;
import gnawr.event;
import gnawr.mixer;
import gnawr.render;
import gnawr.tship;
import gnawr.tscene;
import gnawr.tface;
import gnawr.util.task;

// ウィンドウに関わる変数
const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;
const char* SCREEN_CAPTION = "gnawr";

// ゲームに関わる変数
SDL_Surface *screen = null;
GameEvent gameEvent;
uint pTick = 0;
uint nTick = 0;
int fps = 60;
bool isEnterable;
bool isBlackOut;
private bool isRunning;
private bool isGameEnd;

// ステージに関わる変数
const int[] gameLevelChilds = [    // レベルごとのステージの数
  4, 4, 3, 5, 2, 6
];
const int gameLevelGroups = gameLevelChilds.length; // 大まかなレベルの種類
const string[][] gameLevelNames = [
];

// 自機に関わる変数
Ship gameShip = null;
const float sedgeX = 5.1f;
const float sedgeY = 6.9f;
const float scrSpeed = 0.3f;  // 自機の左右の移動量に対する他のオブジェクトの移動量を出す係数
float scrX = 0.0f;            // 自機が左右に動いたフレームで、他のオブジェクトを動かす値
                              // scrX = shipSpeedX * scrSpeed;
float scrAxisX = 0.0f;        // 自機の左右の位置から相対的な画面のずれ
//float backObjX;   //




// プログラムを終了する
void endRunning() {
  isRunning = false;
}

// ゲームからタイトルへ戻る
void endGame() {
  isGameEnd = true;
}

void toGame(int tsig) {
  // tsigに対応したステージを生成
  // tsig=0ならProgressモード
  // tsig>0ならDomineerモード
}

int myWinMain() {
  initAll();
  
  while(isRunning) {
    gameEvent.beginEvent();
    isRunning = !gameEvent.isQuit();

    auto f = frameSync();
    for(int i = 0; i < f; i++) {
      moveAllTasks();
    }
    drawAllTasks();
    SDL_GL_SwapBuffers();
    
    gameEvent.cleanup();
  }
  closeAll();

  return 1;
}

int main(string[] args) {
  DerelictSDL.load();
  DerelictSDLMixer.load();
  DerelictGL.load();
  DerelictGLU.load();

  int result;

  try {
    result = myWinMain();
  } catch(Exception e) {
    MessageBoxA(null, cast(char *)e.msg, "Error", MB_OK | MB_ICONEXCLAMATION);
    result = 0;
  }

  DerelictGLU.unload();
  DerelictGL.unload();
  DerelictSDL.unload();
  DerelictSDL.unload();

  return result;
}

private void initAll() {
  // SDLの初期化
  if(SDL_Init(SDL_INIT_VIDEO) < 0)
    throw new Exception("error: SDL Init");

  //SDL_putenv("SDL_VIDEO_CENTERED=center");
  screen = SDL_SetVideoMode(SCREEN_WIDTH, SCREEN_HEIGHT, 0, SDL_OPENGL | SDL_RESIZABLE);
  if(!screen)
    throw new Exception("error: SDL_SetVideoMode");

  SDL_WM_SetCaption(SCREEN_CAPTION, null);
  
  // OpenGL等の初期化
  initRenderer();
  
  // ミキサーの初期化
  initMixer();
  
  // ビットマップフォントの初期化
  initBitFont();
  
  // event
  gameEvent = new GameEvent();
  
  // タスクリストの初期化
  initTaskList();

  isRunning = true;
  isGameEnd = false;

  isEnterable = true;
  isBlackOut = false;
  new Title();
}

private void closeAll() {
  closeTaskList();
  
  closeBitFont();
  
  closeMixer();

  closeRenderer();

  SDL_Quit();

}

private int frameSync() {
  int interval = 1000 / fps;
  nTick = SDL_GetTicks();
  auto frame = cast(int)((nTick - pTick) / interval);
  if(frame <= 0) {
    frame = 1;
    SDL_Delay(pTick + interval - nTick);
    pTick = SDL_GetTicks();
  } else if(frame > 5) {
    frame = 5;
    pTick = nTick;
  } else {
    pTick += frame * interval;
  }
  return frame;
}

private void updateScreenAxis() {
  scrAxisX -= scrX;
  scrX = 0.0f;
}

private void moveAllTasks() {
  moveTask(lstFace);

  moveTask(lstShip);
  moveTask(lstWeapon);
  moveTask(lstLandscape);
  moveTask(lstScene);
  
  updateScreenAxis();
  
  // もしゲームの途中でタイトルに戻るなら
  // すべてのタスクを削除してタイトルを生成する
  if(isGameEnd) {
    deleteAllTasks();
    new Title();
    isGameEnd = false;
  }
  
  if(!isRunning) {
    deleteAllTasks();
  }
}

private void drawAllTasks() {
  drawGLBegin();

  // content
  drawContentBegin();
    drawTask(lstLandscape);
    drawTask(lstShip);
    drawTask(lstWeapon);
  drawContentEnd();
  
  // board
  drawBoardBegin();
    drawTask(lstScene);
    drawTask(lstFace);
  drawBoardEnd();

  drawGLEnd();
}

private void deleteAllTasks() {
  lstShip.deleteTask();
  lstWeapon.deleteTask();
  lstLandscape.deleteTask();
  lstScene.deleteTask();
  lstFace.deleteTask();
}