module gnawr.util.sound;

import gnawr.gnawr;
import derelict.sdl.sdl;
import derelict.sdl.mixer;

class Sound {
public:
  static int fadeoutSpeed = 1280;
  
  static void init() {
    if(SDL_InitSubSystem(SDL_INIT_AUDIO) < 0)
      throw new Exception("error: SDL_mixer Init");

    int audioFreq = 44100;
    Uint16 audioFormat = MIX_DEFAULT_FORMAT;
    int audioChannels = 2;
    int audioChunkSize = 2048;
    
    if(Mix_OpenAudio(audioFreq, audioFormat, audioChannels, audioChunkSize) < 0)
      throw new Exception("error: MixOpenAudio");
      
    Mix_QuerySpec(&audioFreq, &audioFormat, &audioChannels);
  }
  
  static void close() {
    if(Mix_PlayingMusic())
      Mix_HaltMusic();
    
    Mix_CloseAudio();
  }
  
  void loadMusic(string name) {
    string fileName = soundDir ~ name;
    music = Mix_LoadMUS(cast(const(char*))fileName);
    if(!music)
      throw new Exception("error: " ~ name ~ " not found");
  }
  
  void loadChunk(string name, int channel) {
    string fileName = soundDir ~ name;
    //chunk = Mix_LoadWAV(cast(const(char*))fileName);
    chunk = Mix_LoadWAV(fileName);
    if(!chunk)
      throw new Exception("error: " ~ name ~ " not found");
    
    chunkChannel = channel;
  }
  
  void free() {
    if(music) {
      stopMusic();
      Mix_FreeMusic(music);
    }
    if(chunk) {
      haltChunk();
      Mix_FreeChunk(chunk);
    }
  }
  
  void playMusic() {
    Mix_PlayMusic(music, -1);
  }
  
  static void fadeMusic() {
    Mix_FadeOutMusic(fadeoutSpeed);
  }
  
  static void stopMusic() {
    if(Mix_PlayingMusic())
      Mix_HaltMusic();
  }
  
  void playChunk() {
    Mix_PlayChannel(chunkChannel, chunk, 0);
  }
  
  void haltChunk() {
    Mix_HaltChannel(chunkChannel);
  }

protected:
  Mix_Music* music;
  Mix_Chunk* chunk;
  int chunkChannel;
}
