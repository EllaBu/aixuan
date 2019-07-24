// String Skill
// 时间对比：时间个位数形式需补0
const time1 = "2019-03-31 21:00:00";
const time2 = "2019-05-01 09:00:00";
const overtime = time1 > time2;
console.log(overtime)

// 格式化金钱
const thousandNum = num => num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
const money = thousandNum(19941112);
// money => "19,941,112"
console.log(money)
/*
\b 匹配一个单词边界，即字与空格间的位置。
\B 非单词边界匹配。
() 标记一个子表达式的开始和结束位置。子表达式可以获取供以后使用。要匹配这些字符，请使用 \( 和 \)。
?  匹配前面的子表达式零次或一次，或指明一个非贪婪限定符。要匹配 ? 字符，请使用 \?。
*/

// 生成随机ID
const randomId = len => Math.random().toString(36).substr(3, len);
// 数字类型的toString()方法可以接收表示转换基数（可选，2-36中的任何数字），如果不指定此参数，转换规则将是基于十进制。
console.log(Math.random().toString())
console.log(Math.random().toString(36))
const id = randomId(10);
console.log(id + '---')
console.log(id.length)

// 生成随机HEX色值
const randomColor = () => "#" + Math.floor(Math.random() * 0xffffff).toString(16).padEnd(6, "0");
// ES2017 引入了字符串补全长度的功能。如果某个字符串不够指定长度，会在头部或尾部补全。padStart()用于头部补全，padEnd()用于尾部补全。
const color = randomColor();
console.log(color)

// 生成星级评分
const startScore = rate => "★★★★★☆☆☆☆☆".slice(5 - rate, 10 - rate);
// slice(开始截取的下标，结束的下标)
const start = startScore(3);
// start => "★★★"
console.log(start)

// 操作URL查询参数
// location.search = "?name=yajun&sex=female"
const params = new URLSearchParams(location.search.replace(/\?/ig, ""));
console.log(params.toString())
console.log(params.has("yajun")); // true
console.log(params.get("sex")); // "female"
