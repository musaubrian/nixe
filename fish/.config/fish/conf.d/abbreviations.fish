abbr --command jj ss --set-cursor show % --simple
abbr --command jj move --set-cursor bookmark move % --to @-
abbr --command jj create --set-cursor bookmark create %
abbr --command jj delete --set-cursor bookmark delete %
abbr --command jj fetch git fetch

abbr --a -- jjp  jj git push
abbr --a -- jjpb jj git push --bookmark
abbr --a -- jjs  jj status
abbr --a -- first ./first.bin
abbr --a -- cl clear
abbr --a -- nv nvim
abbr --a -- jr jan rm -v
abbr --a -- denor deno run
