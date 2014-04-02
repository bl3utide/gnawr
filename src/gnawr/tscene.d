module gnawr.tscene;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import gnawr.gnawr;
import gnawr.bitfont;
import gnawr.mixer;
import gnawr.render;
import gnawr.tship;
import gnawr.tlandscape;
import gnawr.tface;
import gnawr.util.task;

class Scene : Mover {
  new(size_t t) {
    return operator_new(t, lstScene);
  }
  this() {
    super(lstScene, 0, 0);
  }
}




/**
 *************************
 Game Frame
 ************************* 
 */
class GameFrame : Scene {
private:
public:
  this() {}
  
  // 継承先ではテキストの直前に呼び出す
  // ということは、真っ先にこれを呼び出すということか
  override void draw() {
    glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO);
    glPushMatrix();
      glPushMatrix();
        glTranslatef(0.0f, 0.0f, 0.0f);
        glColor4ub(44, 44, 44, 200);
        glBegin(GL_QUADS);
          glVertex3f(-9.4f, -7.2f, 0.0f);
          glVertex3f(-9.4f,  7.2f, 0.0f);
          glVertex3f(-5.3f,  7.2f, 0.0f);
          glVertex3f(-5.3f, -7.2f, 0.0f);
          glVertex3f( 9.4f, -7.2f, 0.0f);
          glVertex3f( 9.4f,  7.2f, 0.0f);
          glVertex3f( 5.3f,  7.2f, 0.0f);
          glVertex3f( 5.3f, -7.2f, 0.0f);
        glEnd();
      glPopMatrix();
    glPopMatrix();
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  }
}





/**
 ************************
  ボスを出すクラス
 ************************
 */
class DomineerUnit : GameFrame {
private:
  int targetBoss;

public:
  this(int _targetBoss) {
    this.targetBoss = _targetBoss;
    new BlindWipeIn();
    new BlueScape();
    gameShip = new RedShip(0.0f, -4.0f);
  }
  
  override bool move() {
    return true;
  }
  
  override void draw() {
    super.draw();
    
  }
}




enum TitleSelect { game, select, exit }

/**
 ************************
  タイトル画面クラス
 ************************
 */
class Title : Scene {
private:
  TitleSelect pCurPos;
  int cCurPosX, cCurPosY; // 面セレメニューのカーソルの位置
  int cCurPosTgtX;        // 面セレメニューの上下移動によるcCurPosXのずれを補修する
  bool isParentSelected;  // 親メニューが選ばれてるかどうか
  ubyte cntPrnt;          // 子メニュー選択時のカウンタ
  ubyte pal;              // 子メニュー選択時の点滅に使用する数値
  ubyte cntChld;          // 面セレカーソルの点滅に使用するカウンタ
  ubyte cal;              // 面セレカーソルの点滅に使用する数値
  ubyte csz;              // 面セレカーソルのサイズに使用する数値
  
  int targetBoss;         // 選択したボスのシグネチャ(グループ数*10 + 添字番号)
                          // 下一桁が9の場合、そのグループを頭から全て連続で遊ぶモード

public:
  this() {
    pCurPos = TitleSelect.game;
    cCurPosX = 0;
    cCurPosY = 0;
    cCurPosTgtX = 0;
    isParentSelected = false;
    cntPrnt = 0;
    pal = 0;
    cntChld = 0;
    cal = 0;
    csz = 0;
    
    targetBoss = 0;
    new BlueScape();
  }

  override bool move() {
    if(!isEnterable) {      /// ブラックアウト中
      if(isBlackOut) {  // ブラックアウトが終わったら
        // 操作可能に戻す
        isEnterable = true;

        // ボスステージ生成
        new DomineerUnit(targetBoss);
        return false;
      }
      return true;
    }

    if(!isParentSelected) {   //// parent menu ////
      if(pCurPos == TitleSelect.game) {     // parent-progress
        if(gameEvent.isButton1Pushed()) {
          // PLAY SE: Cursor OK
          mixerPlaySE(SE_CURSOR_OK);

          // 通しプレイへ
          isParentSelected = true;
        }
        else if(gameEvent.isButton2Pushed()) {
          // PLAY SE: Cursor Cancel
          mixerPlaySE(SE_CURSOR_CANCEL);

          pCurPos = TitleSelect.exit;
        }
        else if(gameEvent.isRightPushed()) {
          // PLAY SE: Cursor Move
          mixerPlaySE(SE_CURSOR_MOVE);

          pCurPos++;
        }
      }
      else if(pCurPos == TitleSelect.select) {  // parent-domineer
        if(gameEvent.isButton1Pushed()) {
          // PLAY SE: Cursor OK
          mixerPlaySE(SE_CURSOR_OK);

          // 面セレへ
          isParentSelected = true;
          cntPrnt = 0;
          cntChld = 0;
        }
        else if(gameEvent.isButton2Pushed()) {
          // PLAY SE: Cursor Cancel
          mixerPlaySE(SE_CURSOR_CANCEL);

          pCurPos = TitleSelect.exit;
        }
        else if(gameEvent.isLeftPushed()) {
          // PLAY SE: Cursor Move
          mixerPlaySE(SE_CURSOR_MOVE);

          pCurPos--;
        }
        else if(gameEvent.isRightPushed()) {
          // PLAY SE: Cursor Move
          mixerPlaySE(SE_CURSOR_MOVE);

          pCurPos++;
        }
      }
      else {
        if(gameEvent.isButton1Pushed()) {
          // PLAY SE: Cursor OK
          mixerPlaySE(SE_CURSOR_OK);

          endRunning();
          return false;
        }
        else if(gameEvent.isButton2Pushed()) {
          // PLAY SE: Cursor Cancel
          mixerPlaySE(SE_CURSOR_CANCEL);
        }
        else if(gameEvent.isLeftPushed()) {
          // PLAY SE: Cursor Move
          mixerPlaySE(SE_CURSOR_MOVE);

          pCurPos--;
        }
      }
    }
    else {    //// child menu ////
      if(pCurPos == TitleSelect.game) {
        if(gameEvent.isButton2Pushed()) {
          // PLAY SE: Cursor Cancel
          mixerPlaySE(SE_CURSOR_CANCEL);

          isParentSelected = false;
          cntPrnt = 0;
          cntChld = 0;
        }
      }
      if(pCurPos == TitleSelect.select) {
        if(gameEvent.isUpPushed()) {
          if(cCurPosY > 0) {
            // PLAY SE: Cursor Move
            mixerPlaySE(SE_CURSOR_MOVE);
            
            if(cCurPosX > gameLevelChilds[cCurPosY - 1] - 1) {
              cCurPosX = gameLevelChilds[cCurPosY - 1] - 1;
            }
            else {
              if(cCurPosTgtX <= gameLevelChilds[cCurPosY - 1] - 1)
                cCurPosX = cCurPosTgtX;
              else
                cCurPosX = gameLevelChilds[cCurPosY - 1] - 1;
            }
            cCurPosY--;
            cntChld = 0;
          }
        }
        else if(gameEvent.isDownPushed()) {
          if(cCurPosY < gameLevelGroups - 1) {
            // PLAY SE: Cursor Move
            mixerPlaySE(SE_CURSOR_MOVE);
            
            if(cCurPosX > gameLevelChilds[cCurPosY + 1] - 1)
              cCurPosX = gameLevelChilds[cCurPosY + 1] - 1;
            else {
              if(cCurPosTgtX <= gameLevelChilds[cCurPosY + 1] - 1)
                cCurPosX = cCurPosTgtX;
              else
                cCurPosX = gameLevelChilds[cCurPosY + 1] - 1;
            }
            cCurPosY++;
            cntChld = 0;
          }
        }
        else if(gameEvent.isLeftPushed()) {
          if(cCurPosX > 0) {
            // PLAY SE: Cursor Move
            mixerPlaySE(SE_CURSOR_MOVE);
            
            cCurPosX--;
            cCurPosTgtX = cCurPosX;
            cntChld = 0;
          }
        }
        else if(gameEvent.isRightPushed()) {
          if(cCurPosX < gameLevelChilds[cCurPosY] - 1) {
            // PLAY SE: Cursor Move
            mixerPlaySE(SE_CURSOR_MOVE);
            
            cCurPosX++;
            cCurPosTgtX = cCurPosX;
            cntChld = 0;
          }
        }
        else if(gameEvent.isButton1Pushed()) {
          // PLAY SE: Cursor OK
          mixerPlaySE(SE_CURSOR_OK);
        
          // 入力不可にする
          isEnterable = false;
          
          // 選択したボスのシグネチャを設定
          targetBoss = cCurPosY * 10 + cCurPosX;
          
          new BlindWipeOut();
        }
        else if(gameEvent.isButton2Pushed()) {
          // PLAY SE: Cursor Cancel
          mixerPlaySE(SE_CURSOR_CANCEL);

          isParentSelected = false;
          cntPrnt = 0;
          cntChld = 0;
        }
      }
      cntPrnt++;
      cntChld++;
    }
    return true;
  }

  override void draw() {
    // board(Title)
    glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO);
    glPushMatrix();
      glTranslatef(0.0f, 0.0f, 0.0f);
      glColor4ub(132, 132, 132, 200);
      glBegin(GL_QUADS);
        glVertex3f(-9.4f, -7.2f, 0.0f);
        glVertex3f(-9.4f,  7.2f, 0.0f);
        glVertex3f( 9.4f,  7.2f, 0.0f);
        glVertex3f( 9.4f, -7.2f, 0.0f);
      glEnd();
      glColor4ub(32, 32, 32, 200);
      glBegin(GL_QUADS);
        glVertex3f(-5.3f, -7.2f, 0.0f);
        glVertex3f(-5.3f,  7.2f, 0.0f);
        glVertex3f( 5.3f,  7.2f, 0.0f);
        glVertex3f( 5.3f, -7.2f, 0.0f);
      glEnd();
    glPopMatrix();
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);

    // title logo
    renderBitFont(FontType.abs, "gnawr", -1.0f, 4.3f, 3, 255, 255, 255, 255);

    if(!isParentSelected) {     // parent menu
      if(pCurPos == TitleSelect.game) {
        renderBitFont(FontType.squ, "PROGRESS", -4.6f, 3.2f, 1, 255, 255, 255, 255);
        renderBitFont(FontType.squ, "DOMINEER", -1.4f, 3.2f, 1, 255, 255, 255, 55);
        renderBitFont(FontType.squ, "EXIT", 3.2f, 3.2f, 1, 255, 255, 255, 55);
        drawLine(-4.6f, 3.1f, -1.8f, 3.1f, 2.0f, 255, 255, 255, 255);
      }
      else if(pCurPos == TitleSelect.select) {
        renderBitFont(FontType.squ, "PROGRESS", -4.6f, 3.2f, 1, 255, 255, 255, 55);
        renderBitFont(FontType.squ, "DOMINEER", -1.4f, 3.2f, 1, 255, 255, 255, 255);
        renderBitFont(FontType.squ, "EXIT", 3.2f, 3.2f, 1, 255, 255, 255, 55);
        drawLine(-1.4f, 3.1f, 1.4f, 3.1f, 2.0f, 255, 255, 255, 255);
      }
      else {
        renderBitFont(FontType.squ, "PROGRESS", -4.6f, 3.2f, 1, 255, 255, 255, 55);
        renderBitFont(FontType.squ, "DOMINEER", -1.4f, 3.2f, 1, 255, 255, 255, 55);
        renderBitFont(FontType.squ, "EXIT", 3.2f, 3.2f, 1, 255, 255, 255, 255);
        drawLine(3.2f, 3.1f, 4.6f, 3.1f, 2.0f, 255, 255, 255, 255);
      }
    }
    else {    // child menu
      pal = (cntPrnt % 2) * 100 + 40;
      if(pCurPos == TitleSelect.game) {
        renderBitFont(FontType.squ, "PROGRESS", -4.6f, 3.2f, 1, 255, 255, 255, pal);
        renderBitFont(FontType.squ, "DOMINEER", -1.4f, 3.2f, 1, 255, 255, 255, 10);
        renderBitFont(FontType.squ, "EXIT", 3.2f, 3.2f, 1, 255, 255, 255, 10);
      }
      else if(pCurPos == TitleSelect.select) {
        renderBitFont(FontType.squ, "PROGRESS", -4.6f, 3.2f, 1, 255, 255, 255, 10);
        renderBitFont(FontType.squ, "DOMINEER", -1.4f, 3.2f, 1, 255, 255, 255, pal);
        renderBitFont(FontType.squ, "EXIT", 3.2f, 3.2f, 1, 255, 255, 255, 10);
        
        // 面セレの表示
        for(int j_grp = 0; j_grp < gameLevelGroups; j_grp++) {
          for(int i_chd = 0; i_chd < gameLevelChilds[j_grp]; i_chd++) {
            if(cCurPosX == i_chd && cCurPosY == j_grp) {
              cal = 32 - (cntChld % 32);
              csz = (cntChld % 32);
              drawBox(-3.0f + i_chd * 1.0f, 2.0f - j_grp * 0.9f, 0.4f + csz * 0.03f, 0.4f + csz * 0.03f, 255, 120, 100, cal);
              drawBox(-3.0f + i_chd * 1.0f, 2.0f - j_grp * 0.9f, 0.4f, 0.4f, 255, 120, 100, 100);
            }
            else {
              drawBox(-3.0f + i_chd * 1.0f, 2.0f - j_grp * 0.9f, 0.4f, 0.4f, 255, 255, 255, 100);
            }
          }
        }
      }
    }
    
    // button response view
    gameEvent.isUpPressed()
      ? renderBitFont(FontType.squ, "U", -4.6f, -6.0f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "U", -4.6f, -6.0f, 1, 255, 255, 255, 55);
    gameEvent.isDownPressed()
      ? renderBitFont(FontType.squ, "D", -4.6f, -6.8f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "D", -4.6f, -6.8f, 1, 255, 255, 255, 55);
    gameEvent.isLeftPressed()
      ? renderBitFont(FontType.squ, "L", -4.95f, -6.4f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "L", -4.95f, -6.4f, 1, 255, 255, 255, 55);
    gameEvent.isRightPressed()
      ? renderBitFont(FontType.squ, "R", -4.2f, -6.4f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "R", -4.2f, -6.4f, 1, 255, 255, 255, 55);
    gameEvent.isButton1Pressed()
      ? renderBitFont(FontType.squ, "A", -3.8f, -6.0f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "A", -3.8f, -6.0f, 1, 255, 255, 255, 55);
    gameEvent.isButton2Pressed()
      ? renderBitFont(FontType.squ, "B", -3.8f, -6.8f, 1, 255, 255, 255, 255)
      : renderBitFont(FontType.squ, "B", -3.8f, -6.8f, 1, 255, 255, 255, 55);
  }
}
