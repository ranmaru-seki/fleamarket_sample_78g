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


  $(document).on('turbolinks:load', ()=> {
    // 画像用のinputを生成する関数
    const buildFileField = (index)=> {
      const html = `<div data-index="${index}" class="js-file_group">
                      <input class="js-file" type="file"
                      name="product[images_attributes][${index}][src]"
                      id="product_images_attributes_${index}_src"><br>
                      <div class="js-remove">削除</div>
                    </div>`;
      return html;
    }
  
    // file_fieldのnameに動的なindexをつける為の配列
    let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  
    $("#hidden-field").on('change', '.js-file', function(e) {
      // fileIndexの先頭の数字を使ってinputを作る
      $('.PreviewBox').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    });
  
    $('.PreviewBox').on('click', '.js-remove', function() {
      $(this).parent().remove();
      // 画像入力欄が0個にならないようにしておく
      if ($('.js-file').length == 0) $('.PreviewBox').append(buildFileField(fileIndex[0]));
    });
  });

});