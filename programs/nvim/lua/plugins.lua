require 'nvim-web-devicons'.setup { default = true; }
require 'colorizer'.setup { user_default_options = { css = true, }, }
require 'Comment'.setup()
local ft = require('Comment.ft')
ft.agda = { '--%s', '{-%s-}' }
ft.tf = { '#%s', '{/*%s*/}' }
require 'todo-comments'.setup {}
require 'fidget'.setup {}
require 'crates'.setup()
