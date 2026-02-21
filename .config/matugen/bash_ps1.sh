PRIMARY_HEX="{{colors.primary.default.hex}}"
R=$((16#${PRIMARY_HEX:1:2}))
G=$((16#${PRIMARY_HEX:3:2}))
B=$((16#${PRIMARY_HEX:5:2}))

export PS1="\[\e[38;2;${R};${G};${B}m\][\h][\w]\$ \[\e[0m\]"
