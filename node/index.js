const express = require('express')
const app = express()
// CORS模块，处理web端跨域问题
const cors = require('cors')
app.use(cors())

//body-parser 解析表单
const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended:false}))
app.use(bodyParser.json())

//使用mysql中间件连接MySQL数据库
const mysql = require('mysql')
const connection = mysql.createConnection({
  host: 'localhost',           //数据库地址
  user: 'root',               //用户名
  password: '123456',           //密码
  port : '3306',              //端口
  database: 'test',           //库名
  multipleStatements: true     //允许执行多条语句
})


// 查询
app.get('/api/user',(req,res,next) => {
  const sql ='SELECT * FROM user'  //user为表名
  connection.query(sql,(err,results) =>{
    if(err){
      return res.json({
        code: 1,
        message: '用户不存在',
        affextedRows: 0
      })
    }
    res.json ({
      code : 200,
      message: results,
      affextedRows:results.affextedRows
    })
  })
})

// 条件查询
app.get('/api/query',(req,res) => {
  const id = req.query.searchWorld
  console.log(id)
  // const sql = 'SELECT * FROM ak01 where id=?'
  // const sql = 'SELECT * FROM ak01 WHERE norm_code = \'3.1.4.40.1.48\';'
  // const sql = 'SELECT * FROM ak01 WHERE norm_code = \'' + id + '\''
  const sql = 'SELECT * FROM ak01 WHERE diag_res like \'%' + id + '%\''
  console.log(sql)
  connection.query(sql,id,(err,results) => {
    if (err) {
      return res.json({
        code: 1,
        message: '无此结果',
        affextedRows: 0
      })
    }
    if (id === '') {
      return res.json({
        code: 2,
        message: '没有输入查询关键词',
        affextedRows: 0
      })
    }

    res.json ({
      code: 200,
      message: results,
      affextedRows:results.affextedRows
    })
  })
})

//增加
app.post('/api/adduser', (req,res) => {
  const user = req.body
  const addSql = 'INSERT INTO user (username, sex, age) VALUES (\''+user.username+'\', \''+user.sex+'\', \''+user.age+'\')'
  connection.query(addSql,user,(err,results) => {
    if (err) {
      return res.json({
        code: 1,
        message: '添加失败',
        affextedRows: 0
      })
    }
    res.json ({
      code: 200,
      message: '添加成功',
      affextedRows:results.affextedRows
    })
  })
})

//启动服务，端口3001
app.listen(3001,() => {
  console.log('服务启动成功:'+`http://localhost:3001/`)
})