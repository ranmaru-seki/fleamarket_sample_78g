$(function() {
// 子カテゴリーを追加するための処理です。
  function buildChildHTML(child){
    var html =`<a class="child_category show_hover" id="${child.id}"
                href="/category/${child.id}">${child.name}</a>`;
    return html;
  }

  //親カテゴリ表示
  $(document).on("mouseover", ".parent_show_hover", function () {
    $(".displayNone").css('display', 'block');
    $(".category-overlay").css('display', 'block');
  });


  $(document).on("mouseover", ".show_hover", function () {
    $(".displayNone").css('display', 'block');
    $(".category-overlay").css('display', 'block');
  });

  //カテゴリ外をクリックすると消える
  $(".category-overlay").on('click', function() {
    $('.category-overlay').css('display', 'none');
    $('.show_hover').css('display', 'none');
  });

  $(".parent_category").on("mouseover", function() {
    var id = this.id//どのリンクにマウスが乗ってるのか取得します
    $(".child_category").remove();//一旦出ている子カテゴリ消します！
    $(".grand_child_category").remove();//孫、てめえもだ！
    $.ajax({
      type: 'GET',
      url: '/products/get_toppage_children',
      data: {parent_id: id},//どの親の要素かを送ります　params[:parent_id]で送られる
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) {//帰ってきた子カテゴリー（配列）
        var html = buildChildHTML(child);//HTMLにして
        $(".children_list").append(html);//リストに追加します
      })
    });
  });

  // 孫カテゴリを追加する処理です　基本的に子要素と同じです！
  function buildGrandChildHTML(child){
    var html =`<a class="grand_child_category show_hover" id="${child.id}"
               href="/category/${child.id}">${child.name}</a>`;
    return html;
  }

  $(document).on("mouseover", ".child_category", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
    var id = this.id
    $.ajax({
      type: 'GET',
      url: '/products/get_toppage_grandchildren',
      data: {parent_id: id},
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) {
        var html = buildGrandChildHTML(child);
        $(".grand_children_list").append(html);
      })
      $(document).on("mouseover", ".child_category", function () {
        $(".grand_child_category").remove();
      });
    });
  });
});
