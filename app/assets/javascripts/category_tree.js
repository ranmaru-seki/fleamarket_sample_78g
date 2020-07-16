//$(function(){
$(document).on('turbolinks:load', ()=> {
// 子カテゴリーを追加するための処理です。
  function buildChildHTML(child){
    var html =`<a class="child_category show_hover" id="${child.id}"
                href="/categories/${child.id}">${child.name}</a>`;
    return html;
  }

  //親カテゴリ表示
  $(document).on("mouseover", ".parent_show_hover", function () {
    $(".displayNone").css('display', 'block');
    $(".category-overlay").css('display', 'block');
  });

  //Overlayを使い、カテゴリ枠外をクリックすると消える
  $(".category-overlay").on('click', function() {
    $('.category-overlay').css('display', 'none');
    $('.show_hover').css('display', 'none');
  });

  //親カテゴリにマウスが乗ったらイベント発火
  $(".parent_category").on("mouseover", function() {
    var id = this.id　//どのリンクにマウスが乗ってるのか取得します
    $(".child_category").remove();　
    $(".grand_child_category").remove();　
    $.ajax({
      type: 'GET',
      url: '/products/get_toppage_children',
      data: {parent_id: id},　
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) {
        var html = buildChildHTML(child);
        $(".children_list").append(html);
      })
    });
  });

  // 孫カテゴリを追加する処理、基本的に子要素と同じ
  function buildGrandChildHTML(child){
    var html =`<a class="grand_child_category show_hover" id="${child.id}"
               href="/categories/${child.id}">${child.name}</a>`;
    return html;
  }

  //子カテゴリーのリストは動的に追加されたHTMLのため
  $(".children_list").on("mouseover", ".child_category", function () {
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
