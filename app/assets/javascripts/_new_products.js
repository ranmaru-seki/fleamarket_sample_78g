$(function () {
  // 範囲内をクリックで画像を選択
  $('.DropArea').on('click', function (event) {
    $("#hidden-field").click();
  });

  // 範囲内にファイルがドラッグされた場合のアクション
  $('.DropArea').on('dragenter dragover', function (event) {
    event.stopPropagation();
    event.preventDefault();
    $('.ImagePlace').css('border', '1px solid #333');  // ドラッグされると枠を実線にする
  });
  $('.DropArea').on('dragleave', function (event) {
    event.stopPropagation();
    event.preventDefault();
    $('.ImagePlace').css('border', '1px dotted #aaa');  // ドラッグが離れると枠を点線に戻す
  });

  //ファイルがドロップされた時にイベント発火
  $(document).on('drop',".DropArea", function (e) {
    e.preventDefault();
    console.log("Hey")
    $("#hidden-field")[0].files = e.originalEvent.dataTransfer.files;
    $("#hidden-field").change();
  });


  //画像プレビューの表示
  $('#hidden-field').change(function(event){
    event.preventDefault();
    $('.ImagePlace').css('border', '1px solid #333');
    var file = event.target.files[0]; // FileListの指定する。0で一番のファイルを指定している。
    var reader = new FileReader();  //Fileをブラウザに読み込ませる
    reader.onload = function () { // 読み込みが完了したら
      img_src = reader.result;  // 下のreadAsDataURLの読み込み結果がresult
      var html = `<div class="image--box">
      <img src=${img_src}></img>
      <p class='delete--btn'> 画像を削除 </p></div>`;
      $('.Preview').append(html) //Previewクラスに挿入
      $('.letter').hide();
      $('.letter2').hide();
    }
    reader.readAsDataURL(file); // ブラウザ上にファイル読み込み、resultプロパティにURLを格納
  });

  // 画像プレビューを削除するボタン
  $(document).on("click",".delete--btn",function () {
    var target_image = $(this).parent()  //プレビューの削除する要素を取得
    target_image.remove();    //上で指定した要素を削除
    $('#hidden-field').val('');  // input要素の中身を削除
    $('.ImagePlace').css('border', '1px dotted #aaa');  // 枠を点線に戻す
  });

});
