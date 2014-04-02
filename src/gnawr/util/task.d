module gnawr.util.task;

import std.stdio;
import std.exception;
import core.memory : GC;
import gnawr.tship;
import gnawr.tweapon;
import gnawr.tscene;
import gnawr.tlandscape;
import gnawr.tface;

TaskList lstShip;
TaskList lstWeapon;
TaskList lstScene;
TaskList lstLandscape;
TaskList lstFace;

/*---------------------------
  Mover derives to
  -Landscape  - content
  -Ship       - content
  -Enemy      - content
  -Weapon     - content
  -Bullet     - content
  -Effect     - content
  -Scene      - not content
  -Face       - not content
  
  content classes are able to be shaken.
  Scene系とFace系以外は、isBlackOut==trueでタスクを消すようにする
---------------------------*/

/**
 * Task Class
 */
class Task {
public:
  this(TaskList _list) {
    list = _list;
    
    // アクティブタスクに入れる
    prev = _list.activeTask.prev;
    next = _list.activeTask;
    prev.next = this;
    next.prev = this;
  }

  ~this() {
    // アクティブタスクから外す
//    prev.next = next;
//    next.prev = prev;
  }

  void del() {
    operator_delete(cast(void*)this, this.list);
  }
  
protected:
  static void* operator_new(size_t _t, TaskList _list) {
    // 確保を試みるタスクのサイズが、リスト内タスク1個分の最大サイズを超えるとエラー
    enforce(_t <= cast(size_t)_list.taskSize, "error: task size over");
    
    // フリータスクが空のときnullを返す
    enforce(_list.freeTaskLength > 0, "error: taken from zero-freetask");
//    if(_list.freeTaskLength <= 0) {
//      return null;
//    }
    
    // フリータスクから1個取り出す
    Task task = _list.freeTask.next;
    _list.freeTask.next = task.next;
    _list.freeTaskLength--;
    
    // コンストラクタへ渡す
    return cast(void*)task;
  }
  
  static void operator_delete(void* _p, TaskList _list) {
    Task task = cast(Task)_p;
  
    // アクティブタスクから外す
    task.prev.next = task.next;
    task.next.prev = task.prev;
    
    // フリータスクへ入れる
    task.next = _list.freeTask.next;
    _list.freeTask.next = task;
    _list.freeTaskLength++;
    
    // フリータスクの数がリスト内のタスクの最大数を超えるとエラー
    enforce(_list.freeTaskLength <= _list.maxTaskNum, "over adding to freetask");
  }
  
private:
  TaskList list;
  Task prev, next;
}

/**
 * Mover Class
 */
class Mover : Task {
public:
  float x, y;             // 座標
  float cl, ct, cr, cb;   // 当たり判定の相対座標
  
  this(TaskList _list, float _x, float _y) {
    super(_list);
    x = _x;
    y = _y;
    cl = 0.0f;
    ct = 0.0f;
    cr = 0.0f;
    cb = 0.0f;
  }
  
  this(TaskList _list, float _x, float _y, float _cl, float _ct, float _cr, float _cb) {
    super(_list);
    x = _x;
    y = _y;
    cl = _cl;
    ct = _ct;
    cr = _cr;
    cb = _cb;
  }
  
  bool move() { return true; }
  void draw() {}

  bool hit(Mover _m) {
    return
      x + cl < _m.x + _m.cr && _m.x + _m.cl < x + cr &&
      y + ct < _m.y + _m.cb && _m.y + _m.ct < y + cb;
  }

  bool hit(Mover _m, float _cl, float _ct, float _cr, float _cb) {
    return
      x + _cl < _m.x + _m.cr && _m.x + _m.cl < x + _cr &&
      y + _ct < _m.y + _m.cb && _m.y + _m.ct < y + _cb;
  }
  
protected:
  bool isOut(float size) {
//    import std.conv, std.exception;
//    enforce(!(8.0f + size < y), to!(string)(y));
    return
      y <  -8.0f - size ||  8.0f + size < y ||
      x < -11.0f - size || 11.0f + size < x;
  }
}

/**
 * Task List Class
 */
class TaskList {
public:
  this(int _maxSize, int _maxLength) {
    taskSize = _maxSize;
    maxTaskNum = _maxLength;
    freeTaskLength = maxTaskNum;
    
    // アクティブタスクとフリータスクの各ダミータスクのメモリを確保
    activeTask = cast(Task)GC.malloc(taskSize);
    freeTask = cast(Task)GC.malloc(taskSize);
    
    // アクティブタスクの初期状態は空にする
    activeTask.prev = activeTask;
    activeTask.next = activeTask;
    
    // フリータスクの初期化
    Task task = freeTask;
    for(int i = 0; i < maxTaskNum; i++) {
      Task buf = cast(Task)GC.malloc(taskSize);
      task.next = buf;
      task = task.next;
    }
    task.next = freeTask;
  }
  
  ~this() {
    // アクティブタスクリストのメモリを解放
    for(Task task = activeTask; task.next !is activeTask; ) {
      Task buf = task.next;
      task.next = buf.next;
      GC.free(cast(void*)buf);
    }

    // フリータスクリストのメモリを解放
    for(Task task = freeTask; task.next !is freeTask; ) {
      Task buf = task.next;
      task.next = buf.next;
      GC.free(cast(void*)buf);
    }

    // ダミータスクを解放
    GC.free(cast(void*)activeTask);
    GC.free(cast(void*)freeTask);
    GC.collect();
  }
  
  // アクティブタスクの個数を返す
  int getNumActiveTask() { return maxTaskNum - freeTaskLength; }
  
  // フリータスクの個数を返す
  int getNumFreeTask() { return freeTaskLength; }
  
  void deleteTask() {
    for(TaskIter i = TaskIter(this); i.hasNext(); i.next(), i.remove()) {}
  }

private:
  Task activeTask, freeTask;
  int taskSize;       // タスク1つの最大サイズ
  int maxTaskNum;     // タスクの最大数
  int freeTaskLength; // フリータスクの残数
}

/**
 * Task Iterator
 */
struct TaskIter {
  TaskList list;
  Task task;
  
  this(TaskList _list) {
    list = _list;
    task = list.activeTask;
  }
  
  bool hasNext() { return task.next !is list.activeTask; }
  Task next() { return task = task.next; }
  void remove()  {
    task = task.prev;
    task.next.del();
  }
}

// クラスのサイズを返す
size_t getClassSize(T)() if(is(T : Object)) {
  return T.classinfo.init.length;
}

void initTaskList() {
  lstShip         = new TaskList(getClassSize!(Ship)(), 8);
  lstWeapon       = new TaskList(getClassSize!(RedShot)(), 256);
  lstScene        = new TaskList(getClassSize!(Title)(), 20);
  lstLandscape    = new TaskList(getClassSize!(BlueScape)(), 4);
  lstFace         = new TaskList(getClassSize!(BlindWipeOut)(), 4);
}

void closeTaskList() {
  clear(lstShip);
  clear(lstWeapon);
  clear(lstScene);
  clear(lstLandscape);
  clear(lstFace);
}

void moveTask(TaskList _list) {
  for(TaskIter i = TaskIter(_list); i.hasNext(); ) {
    Mover mover = cast(Mover)i.next();
    if(!mover.move()) {
      i.remove();
    }
  }
}

void drawTask(TaskList _list) {
  for(TaskIter i = TaskIter(_list); i.hasNext(); ) {
    Mover mover = cast(Mover)i.next();
    mover.draw();
  } 
}