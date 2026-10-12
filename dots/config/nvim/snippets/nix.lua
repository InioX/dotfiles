local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'zmod',
    fmt(
      [[
{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.<path>.<name>;
in {
  options.zenyte.<path2>.<name2> = {
    enable = mkBoolOpt false "<desc>";
  };

  config = mkIf cfg.enable {
    <body>
  };
}
]],
      {
        path = i(1, 'apps'),
        name = i(2, 'nvim'),
        path2 = rep(1),
        name2 = rep(2),
        desc = d(3, function(args) return sn(nil, i(1, 'Whether to enable ' .. args[1][1] .. '.')) end, { 2 }),
        body = i(0),
      },
      { delimiters = '<>' }
    )
  ),
}
