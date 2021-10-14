local present1, gl = pcall(require, 'galaxyline')
if not present1 then
    print("galaxyline not found")
    return
end

local colors = {
    bg       = '#4C566A',
    line_bg  = '#2E3440',
    fg       = '#81A1C1',
    fg_light = '#D8DEE9',

    yellow   = '#EBCB8B',
    cyan     = '#8FBCBB',
    darkblue = '#5E81AC',
    green    = '#A3BE8C',
    orange   = '#D08770',
    violet   = '#B48EAD',
    magenta  = '#B48EAD',
    blue     = '#81A1C1',
    red      = '#BF616A',
}

insert_left{
  Sep = {
    provider = function() return ' ' end,
    highlight = {colors.line_bg, },
  }
}
insert_left{
  Sep = {
    provider = function() return ' ' end,
    highlight = {colors.bg },
  }
}
