// 画像プレビュー機能
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#img_prev").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#image-select-btn").change(function () {
    readURL(this);
  });
});

// 人数指定 

window.addEventListener('load', function () {
  var hoge = document.getElementById("minimum_range");
  // 選択した際のイベント取得
  hoge.addEventListener('change', (e) => {
    document.getElementsByClassName('minimum_number')[0].textContent = hoge.value;
  });
});

window.addEventListener('load', function () {
  
  var hoge = document.getElementById("maximum_range");
  // 選択した際のイベント取得
  hoge.addEventListener('change', (e) => {
    document.getElementsByClassName('maximum_number')[0].textContent = hoge.value;
  });

});

