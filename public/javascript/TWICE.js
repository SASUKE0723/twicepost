//video要素の取得
  var video = document.getElementById('video');
  //videoボタンの取得
  var video_btn = document.getElementById('video-btn');
  //状態保存
  var btn_status = 0;

  //画面クリックで再生・ポーズ
  video_btn.addEventListener('click', function () {
    if(btn_status === 0) {
      video.play();
      btn_status = 1;
    }else {
      video.pause();
      btn_status = 0;
    }
  });
  
  //■page topボタン

$(function(){
var topBtn=$('#pageTop');
topBtn.hide();

 

//◇ボタンの表示設定
$(window).scroll(function(){
  if($(this).scrollTop()>80){

    //---- 画面を80pxスクロールしたら、ボタンを表示する
    topBtn.fadeIn();

  }else{

    //---- 画面が80pxより上なら、ボタンを表示しない
    topBtn.fadeOut();

  } 
});

 

// ◇ボタンをクリックしたら、スクロールして上に戻る
topBtn.click(function(){
  $('body,html').animate({
  scrollTop: 0},500);
  return false;

});


});


$(window).load(function() {
	var img = $("#slideshow").children("img"), // 画像を取得
		num = img.length, // 画像の数を数える
		count = 0, // 現在何枚目を表示しているかのカウンター
		interval = 5000; // 次の画像に切り替わるまでの時間(1/1000秒)
	
	img.eq(0).addClass("show"); // 最初の画像にshowクラス付与
	
	setTimeout(slide, interval); // slide関数をタイマーセット
	
	function slide() {
		img.eq(count).removeClass("show"); // 現在表示している画像からshowクラスを取り除く
		count++; // カウンターを一個進める
		if(count >= num) {
			count = 0; // カウンターが画像の数より大きければリセット
		}
		img.eq(count).addClass("show"); // 次の画像にshowクラス付与
		setTimeout(slide, interval); // 再びタイマーセット
	}
});