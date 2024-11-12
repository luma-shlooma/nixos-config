{ ... } :

{
  services.kanata = {
    enable = true;
    keyboards."default".config = ''
(deflocalkeys-linux
  hash 43
  \ 86
)
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc 
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret
  caps a    s    d    f    g    h    j    k    l    ;    '    hash
  lsft \    z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc                 ralt rmet rctl 
)
(deflayer custom
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc 
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret
  esc  a    s    d    f    g    h    j    k    l    ;    '    hash
  lsft \    z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc                 ralt rmet rctl 
)
    '';
  };
}
