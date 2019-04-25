/*function Animal(name, energy) {
  let animal = {}
  animal.name = name
  animal.energy = energy

  animal.eat = function (amount) {
    console.log(`${this.name} is eating.`)
    this.energy += amount
  }

  animal.sleep = function (length) {
    console.log(`${this.name} is sleeping.`)
    this.energy += length
  }

  animal.play = function (length) {
    console.log(`${this.name} is playing.`)
    this.energy -= length
  }

  return animal
}*/

// 函数实例化与共享方法
const animalMethods = {
  eat(amount) {
    console.log(`${this.name} is eating.`)
    this.energy += amount
  },
  sleep(length) {
    console.log(`${this.name} is sleeping.`)
    this.energy += length
  },
  play(length) {
    console.log(`${this.name} is playing.`)
    this.energy -= length
  }
}
// 通过将共享方法移动到它们自己的对象并在 Animal 函数中引用该对象，我们现在已经解决了内存浪费和新对象体积过大的问题。
function Animal(name, energy) {
  let animal = {}
  animal.name = name
  animal.energy = energy

  animal.eat = animalMethods.eat

  animal.sleep = animalMethods.sleep

  animal.play = animalMethods.play

  return animal
}

//Object.create



const leo = Animal('liuliu', 7)
console.log(leo.name)
console.log(leo.energy)
leo.sleep(12)
console.log(leo.name)
console.log(leo.energy)
leo.play(4)
console.log(leo.energy)