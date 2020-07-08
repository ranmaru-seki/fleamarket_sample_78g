class Status < ActiveHash::Base
  self.data = [
      {id: 1, name: '新品、未使用品'}, {id: 2, name: '未使用品に近い'}, {id: 3, name: '目立った傷や汚れなし'},
      {id: 4, name: 'やや傷や汚れあり'}, {id: 5, name: '傷や汚れあり'}
  ]
end