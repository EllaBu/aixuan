// this指向问题
// 一、ES5中funciton的this指向：
// 1、函数通过new 构造函数创建出来的实例对象this指向的是该实例对象。
/*function Person() {
  console.log(this, '1') //Person
  this.say = function (){
    console.log( this, '2'); //Person
  }
}
// 在构造函数中，this指向的是new出来的实例，所以两处this都指向Person
let per = new Person()
per.say()*/

//因为构造函数本身是无法访问其自身的值，实例化对象可以。 这里为了比较，做了以下的写法:
/*function Person() {
  console.log(this, '1') //Window
  this.say = function (){
    console.log( this, '2'); //Window
    this.eat = function () {
      console.log(this, '3'); //Window
    }
    this.eat()
  }
  this.say()
}
Person()*/
//解析：用函数名()调用时，无论嵌套多少层，this默认指向的也是window。

//eg1：
/*var a = 2
var obj = {
  a: 1,
  b: function() {
    console.log(this,this.a) //obj  1  这里是obj调用的，所以this指向obj
  }
}
obj.b()

//eg2：
var a = 2
var obj = {
  a: 1,
  b: function() {
    setTimeout(function() {
      console.log(this, this.a) //window  2
    })
    console.log(this, this.a) //obj  1
  }
}
obj.b()*/
//解析：setTimeout的执行环境是Window，所以会把this指向改变到Window上。


// 那假如在对象中嵌套多层呢？情况会是怎么样的呢？
/*const obj = {
  a: function() { console.log(this) },
  b: {
    c: function() {console.log(this)}
  }
}
obj.a()          // obj, obj调用的a()方法
obj.b.c()        //obj.b, obj.b调用的a()方法*/


// 还有一个情况就是闭包中的this指向，这里也讲解一下。 （面试的时候可能会出这种变形题。）
//eg1:
/*var name = '张'
function Person() {
  this.name = '柳';
  let say = function (){
    console.log( this, this.name + ' do Something');//张 do Something  this指向window
  }
  say()
}
var per = new Person()*/


//eg2:
/*var name = '张'
function Person() {
  this.name = '柳';
  return function (){  //本质都是匿名函数的自执行
    console.log( this.name + ' do Something');//张 do Something
  }
}
var per = new Person()
per()*/

// 解析：看到这就明白了，其实这是一道闭包题。闭包函数具有匿名函数自执行的特性，默认this指向是挂在Window下的。


// 二、 ES6箭头函数中的this
// 《深入浅出ES6》（65页）中关于箭头函数this的解释：
//     箭头函数中没有this绑定，必须通过查找作用域链来决定其值。
//     如果箭头函数被非箭头函数包围，那么this绑定的是最近一层非箭头函数的this；
//     否则，this的值会被设置为undefined。

//eg1：
/*var x=11;
var obj={
  x:22,
  say:function(){
    console.log(this.x)
  }
}
obj.say();
//console.log输出的是22

//eg2:
var x=11;
var obj={
  x:22,
  say:()=>{
    console.log(this.x);
  }
}
obj.say();*/
//输出的值为11

/*解析：
这样就非常奇怪了如果按照之前function定义应该输出的是22,而此时输出了11，那么如何解释ES6中箭头函数中的this是定义时的绑定呢？
所谓的定义时候绑定，this绑定的是最近一层非箭头函数的this；因为箭头函数是在obj中运行的，obj的执行环境就是window，
因此这里的this.x实际上表示的是window.x，因此输出的是11。*/

//eg3:
/*var a = 2
const obj = {
  a: 1,
  b: () => {
    console.log(this.a)//2
  }
}
obj.b()  //1.默认绑定外层this
obj.b.call(obj.a)  //2.不能用call方法修改里面的this*/

/*const obj = {
  a: function() {
    console.log(this)
    window.setTimeout(() => {
      console.log(this)
    }, 100)
  }
}
obj.a()  //第一个this是obj对象，第二个this还是obj对象*/

/*const obj = {
  a: function() {
    console.log(this)
  },
  b: {
    c: () => {console.log(this)}
  }
}
obj.a()   //没有使用箭头函数打出的是obj
obj.b.c()  //打出的是window对象！！*/


// 三、改变this指向的办法
// call()、apply()、bind()改变this指向
//eg1:
const obj = {
  log: function() {
    console.log(this)
  }
}

//1.不用变量接收：this默认指向为obj
obj.log() //obj
obj.log.call(window)  //window  call和apply都会返回一个新函数
obj.log.apply(window)  //window
obj.log.bind(window)() //window bind则是返回改变了上下文后的一个函数，要想执行的话，还需要加个括号调用。

//2.用变量接收：用变量接收的话，this的默认指向就变成全局了
var objName = obj.log
objName()  //王
// call、apply、bind的用法还和上面的一样，这里就不重复了。

// 1、call和apply改变了函数的this上下文后便执行该函数,而bind则是返回改变了上下文后的一个函数。
// 2、call、apply的区别: 他们俩之间的差别在于参数的区别，
//     call和aplly的第一个参数都是要改变上下文的对象，而call从第二个参数开始以参数列表的形式展现，
//     apply则是把除了改变上下文对象的参数放在一个数组里面作为它的第二个参数



// 除了call、apply、bind这三种改变this指向的办法， 还有常规的用一个变量保存当前this指向，然后在去调用。
// eg2:
var _this = this
const obj = {
  log: function() {
    console.log(_this)
  }
}
obj.log()//此时this的当前指向不再是obj，而是window了。