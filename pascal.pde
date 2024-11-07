// パスカルの三角形を256行までProcessingで描画し、エントリが奇数の場合はセルに色を付け、エントリが偶数の場合は色をつけないProcessingのコード
import processing.pdf.*;  //ライブラリ
// パスカルの三角形の各行の数を計算する関数
int[][] pascal(int n) {
  // n: 行数
  // 返り値: パスカルの三角形の各行の数の二次元配列
  int[][] triangle = new int[n][]; // パスカルの三角形の各行の数を格納する二次元配列
  for (int i = 0; i < n; i++) {
    // 各行の数を計算する
    triangle[i] = new int[i + 1]; // i行目の配列の長さをi + 1にする
    triangle[i][0] = 1; // i行目の最初の数を1にする
    triangle[i][i] = 1; // i行目の最後の数を1にする
    for (int j = 1; j < i; j++) {
      // i行目の2番目から最後から2番目までの数を計算する
      triangle[i][j] = triangle[i - 1][j - 1] + triangle[i - 1][j]; // 上の段の隣り合う数の和を代入する
    }
  }
  return triangle; // 二次元配列を返す
}

// パスカルの三角形の各セルの色を決める関数
color cellColor(int i, int n) {
  // i: 行数
  // n: 数
  // 返り値: セルの色
  if (n % 2 == 0) {
    // 数が偶数なら
    return color(255); // 白を返す
  } else {
    // 数が奇数なら
    // 色の指定をHSVにする
    int j = 0;
    colorMode(HSB, 360, 100, 100); // カラーモードをHSVに変更し、各要素の最大値を指定する
    // hueの値をセルの中心のy座標にする
    float[] position = cellPosition(i, j); // セルの位置と大きさを決める関数を呼び出す
    float y = position[1]; // セルの中心のy座標
    float hue = map(y, 0, height, 0, 360)-50; // y座標を0から360の範囲にマッピングする
    return color(hue*2/1.5, 100, 100); // hueの値を色相として返す
  }
}

// パスカルの三角形の各セルの位置と大きさを決める関数
float[] cellPosition(int i, int j) {
  // i: 行数
  // j: 列数
  // 返り値: セルの中心の座標と半径の配列
  float[] position = new float[3]; // セルの中心の座標と半径を格納する配列
  float r = 5; // セルの半径
  float x = width / 2 + (j - i / 2.0) * r * 2; // セルの中心のx座標
  float y = i * r * sqrt(3); // セルの中心のy座標
  position[0] = x; // 配列にx座標を代入する
  position[1] = y+500; // 配列にy座標を代入する
  position[2] = r; // 配列に半径を代入する
  return position; // 配列を返す
}

// パスカルの三角形の各セルを描画する関数
void drawCell(int i, int j, int n) {
  // i: 行数
  // j: 列数
  // n: 数
  float[] position = cellPosition(i, j); // セルの位置と大きさを決める関数を呼び出す
  float x = position[0]; // セルの中心のx座標
  float y = position[1]; // セルの中心のy座標
  float r = position[2]; // セルの半径
  color c = cellColor(i, n); // セルの色を決める関数を呼び出す
  fill(c); // 塗りつぶしの色をセットする
  ellipse(x, y, r * 2, r * 2); // 円を描画する
}

// パスカルの三角形を描画するメインの関数
void drawPascal(int n) {
  // n: 行数
  int[][] triangle = pascal(n); // パスカルの三角形の各行の数を計算する関数を呼び出す
  for (int i = 0; i < n; i++) {
    // 各行に対して
    for (int j = 0; j < i + 1; j++) {
      // 各列に対して
      drawCell(i, j, triangle[i][j]); // パスカルの三角形の各セルを描画する関数を呼び出す
    }
  }
}


void setup() {
  // 画面のサイズや背景色などを設定する
  size(2480, 3507); // 画面のサイズを800x800にする
  background(0); // 背景色を黒にする
  noLoop(); // draw()関数を繰り返さないようにする
}

void draw() {
  // パスカルの三角形を描画する
  beginRecord(PDF, "x22004.pdf");
  drawPascal(256); // パスカルの三角形を描画するメインの関数を呼び出す
  save("output.png"); //実行結果をpng画像として保存
  endRecord();
}
