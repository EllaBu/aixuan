$(function () {
  initials()

  $('.collect-input input').bind('input propertychange', function () {
    let searchWord = $(this).val()
    if (searchWord) {
      $(this).siblings('i').show()
    }
  })
  $('.collect-input i').on('click', function () {
    console.log(111)
    console.log($(this).siblings('input').val())
    $(this).siblings('input').val('')
  })

  var indexHeight = $('.search-index').height()
  console.log(indexHeight)
  $('.search-index').css('margin-top', -indexHeight/2)
  $('.sort-letter').prev('div').find('p').css('border', 'none')

  var fontSize = $('html').css('font-size')
  var inputHeight = 1.28 * parseInt(fontSize)

  $('.search-index li').click(function () {
    var _this = $(this)
    var _index = _this.index()
    if (_index === 0) {
      $('html,body').animate({scrollTop: '0px'}, 300);//点击第一个滚到顶部
    } else if( _this.text() == '#'){
      // } else if(_index===$('.search-index li').length -1){
      var DefaultTop=$('#default').position().top;
      $('html,body').animate({scrollTop: DefaultTop+'px'}, 300);//点击最后一个滚到#号
    } else {
      var letter = _this.text();
      console.log(letter)
      if ($('#' + letter).length > 0) {
        var LetterTop = $('#' + letter).position().top;
        console.log(LetterTop)
        $('html,body').animate({scrollTop: LetterTop - inputHeight + 'px'}, 300);
      }
    }
  })
})

function initials() {//公众号排序
  var SortList=$(".company-search-list>div");
  var SortBox=$(".company-search-list");
  SortList.sort(asc_sort).appendTo('.company-search-list');//按首字母排序
  function asc_sort(a, b) {
    return makePy($(b).find('p').text().charAt(0))[0].toUpperCase() < makePy($(a).find('p').text().charAt(0))[0].toUpperCase() ? 1 : -1;
  }

  var initials = []
  var searchLetter = ''
  var num=0;
  SortList.each(function(i) {
    var initial = makePy($(this).find('p').text().charAt(0))[0].toUpperCase();
    if(initial>='A'&&initial<='Z'){
      if (initials.indexOf(initial) === -1)
        initials.push(initial);
    }else{
      num++;
    }

  });

  console.log(initials)

  $.each(initials, function(index, value) {//添加首字母标签
    SortBox.append('<div class="sort-letter" id="'+ value +'">' + value + '</div>');
    searchLetter += '<li>'+ value +'</li>'
    console.log(index)
    console.log(value)
  });
  $('.search-index').append(searchLetter)
  if(num != 0){
    SortBox.append('<div class="sort-letter" id="default">#</div>');
    $('.search-index').append('<li>#</li>')
  }

  for (var i =0;i<SortList.length;i++) {//插入到对应的首字母后面
    var letter=makePy(SortList.eq(i).find('p').text().charAt(0))[0].toUpperCase();
    switch(letter){
      case "A":
        $('#A').after(SortList.eq(i));
        break;
      case "B":
        $('#B').after(SortList.eq(i));
        break;
      case "C":
        $('#C').after(SortList.eq(i));
        break;
      case "D":
        $('#D').after(SortList.eq(i));
        break;
      case "E":
        $('#E').after(SortList.eq(i));
        break;
      case "F":
        $('#F').after(SortList.eq(i));
        break;
      case "G":
        $('#G').after(SortList.eq(i));
        break;
      case "H":
        $('#H').after(SortList.eq(i));
        break;
      case "I":
        $('#I').after(SortList.eq(i));
        break;
      case "J":
        $('#J').after(SortList.eq(i));
        break;
      case "K":
        $('#K').after(SortList.eq(i));
        break;
      case "L":
        $('#L').after(SortList.eq(i));
        break;
      case "M":
        $('#M').after(SortList.eq(i));
        break;
      case "O":
        $('#O').after(SortList.eq(i));
        break;
      case "P":
        $('#P').after(SortList.eq(i));
        break;
      case "Q":
        $('#Q').after(SortList.eq(i));
        break;
      case "R":
        $('#R').after(SortList.eq(i));
        break;
      case "S":
        $('#S').after(SortList.eq(i));
        break;
      case "T":
        $('#T').after(SortList.eq(i));
        break;
      case "U":
        $('#U').after(SortList.eq(i));
        break;
      case "V":
        $('#V').after(SortList.eq(i));
        break;
      case "W":
        $('#W').after(SortList.eq(i));
        break;
      case "X":
        $('#X').after(SortList.eq(i));
        break;
      case "Y":
        $('#Y').after(SortList.eq(i));
        break;
      case "Z":
        $('#Z').after(SortList.eq(i));
        break;
      default:
        $('#default').after(SortList.eq(i));
        break;
    }
  };
}
