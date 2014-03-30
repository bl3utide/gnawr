module gnawr.mixer;

import derelict.sdl.sdl;
import derelict.sdl.mixer;
import gnawr.util.sound;

// bgm

// se
enum {
  SE_CURSOR_OK, SE_CURSOR_CANCEL, SE_CURSOR_MOVE
}

// Music(ogg) file names
const string[] MUSIC_FILE_NAME = [
];

// SE(wav) file names
const string[] SE_FILE_NAME = [
  "cursor_ok.wav", "cursor_cancel.wav", "cursor_move.wav"
];
const int[] SE_CHANNEL = [
  0, 0, 1
];

private const int MUSIC_NUM = 0;
private const int SE_NUM    = 3;

private Sound bgm[MUSIC_NUM];
private Sound se[SE_NUM];

void initMixer() {
  Sound.init();

//  for(int i = 0; i < MUSIC_NUM; i++) {
//    bgm[i] = new Sound();
//    bgm[i].loadMusic(MUSIC_FILE_NAME[i]);
//  }
  for(int i = 0; i < SE_NUM; i++) {
    se[i] = new Sound();
    se[i].loadChunk(SE_FILE_NAME[i], SE_CHANNEL[i]);
  }
}

void closeMixer() {
//  for(int i = 0; i < MUSIC_NUM; i++)
//    bgm[i].free();
  for(int i = 0; i < SE_NUM; i++)
    se[i].free();
  
  Sound.close();
}

//void playBGM(int n) {
//  bgm[n].playMusic();
//}

void mixerPlaySE(int n) {
  se[n].playChunk();
}

void mixerStopBGM() {
  Sound.stopMusic();
}

void mixerFadeBGM() {
  Sound.fadeMusic();
}

void mixerStopSE(int n) {
  se[n].haltChunk();
}
