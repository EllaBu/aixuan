// table的id 需要合并的列（从0开始算）
function mergeCell(tableId, cols) {
  var table = document.getElementById(tableId);
  var table_rows = table.rows;
  // 需要合并的列的数组
  cols.forEach((v, k) => {
    // 循环table每一行
    for (let i = 0; i < table_rows.length - 1; i++) {
      // row
      let now_row = table_rows[i];
      let next_row = table_rows[i + 1];
      // col
      let now_col = now_row.cells[v];
      let next_col = next_row.cells[v];
      if (now_col.innerHTML == next_col.innerHTML) {
        // 标记为需要删除
        $(next_col).addClass('remove');
        // 递归判断当前对象时候已经被删除
        setParentSpan(table, i, v);
      }
    }
  })
  $(".remove").remove();
} // (递归方法，用于多行统计) pram => table表格 当前行 对应的列
function setParentSpan(table, row, col) {
  var col_item = table.rows[row].cells[col];
  if ($(col_item).hasClass('remove')) {
    setParentSpan(table, --row, col)
  } else {
    col_item.rowSpan += 1;
  }
}

