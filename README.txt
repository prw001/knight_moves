Created in response to an assignment from The Odin Project (project #2 at webpage):
https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms?ref=lnav

——————————————————————————————————————————————————————————
The problem:  

Write a program that, given a position of a knight on a chessboard in coordinate format, finds the shortest number of moves it takes to move to another given position on the board.


Files:

knight_moves.rb - generates two random coordinates of a chessboard (does not allow for an identical pair), the game board, the move tree, and the visual rendering w/output info in regards to the solution.

game_board.rb - describes the game_board object, square object, and path object and their functions

GameTools.rb - module with methods for:
- the building of the move tree (DAG, root is the knight’s initial position)
- finding valid moves from a given position (specific to a knight’s coordinate shifts)
- adding two coordinates together
- inspecting outbound paths for a given destination square from a given starting square
- and finding the shortest path from coordinates A to B based on the move tree (uses BFS)