#tree ./lib -I "$1" -o ./tree.txt
tree ./ -a -I ".dart_tool|.idea|android|ios|test|web|windows|build" -o ./tree.txt