# Sudoku Solver

This was the week 4 project at Makers Academy, and possibly the hardest in terms of pure logic. It can solve easy, hard and 'impossible' sudoku puzzles (the tests are commented out for speed reasons, but when turned on they do pass). Here's roughly how it all works.

## Roughly how it all works

So most of the work is done by the Grid, but each Grid is made up of Cells, so I figured it might be clearer to start there

### Cells

A Cell is initialised with a value and an array of known neighbours (which starts empty and is updated by its Grid, which knows where everything is). It knows it's solved when the value isn't 0. It knows what values are condidates for its solution (ie all the numbers that aren't in its neighoburing cells). It knows whether or not its solvable. It can solve itself, either with a certain solution (when there's only one candidate value), or with a guess.

It also claims to know if it's valid (ie if its value isn't in any of the neighbouring boxes) and, indeed, passes a couple of relevant tests, but I think the last thing I noticed before we had to move on was that the grid adds a solved cell to its own list of neighbours (which doesn't affect any other checks), leaving every solved cell technically 'invalid'. The method was a late addition meant to be a sanity check, that ended up failing at its one role. There isn't really a need for it, as if everything works as it should it would be impossible to return an invlaid solution (and, you konw, everything's tested). But it does give me something to fix (either just the addition of neighbours, or maybe even rejigging the whoel architecture) if I ever have the time to get back to this.

Anyway, all of the important functionality is functional. Which is good.

### Grid

A Grid is initialised with a puzzle (in the form of a string representing the intial state of the problem (000905060300210...)). The Grid creates and stores cells with the corresponding values, and updates the neighbours of each cell (as discussed and disclaimed above).

A Grid is also initialised with arrays of all the indexes in certain squares, set as constants. This isn't easy to explain, but giving a smaller example should help. Say you have a 4x4 sudoku like so

<table>
  <tr>
    <td>0</td>
    <td>1</td>
    <td>2</td>
    <td>3</td>
  </tr>
  <tr>
    <td>4</td>
    <td>5</td>
    <td>6</td>
    <td>7</td>
  </tr>
  <tr>
    <td>8</td>
    <td>9</td>
    <td>10</td>
    <td>11</td>
  </tr>
  <tr>
    <td>12</td>
    <td>13</td>
    <td>14</td>
    <td>15</td>
  </tr>
</table>

Then the indexes of the elements of the first row will be [0,1,2,3], those of the first column will be [0,4,8,12] and those of the first 'box' will be [0,1,4,5]. Once you've set up arrays of all related collections, it's very easy to find out what elements are in a given row, column or box. Not the most elegant solution, maybe, but it means the main body of code is a lot nicer than what I was working towards before.

So now the Grid can easily find the values in a row, column, or box of a given cell, given it can work out the index of that cell and which box/column/row that cell is in. This is how it updates the neighbours of a cell (and why it counts a completed cell as its own neighbour).

Given it knows all that stuff, we can now try to solve Sudokus. A grid is solved (or at least will claim to be when you ask it) when all the cells in that grid are solved. For simple puzzles, you simply loop through the grid, cell by cell, trying to solve each individual cell (using the method described above) until everything's been solved. The loop breaks if the grid is solved, or a passthrough of all the cells yields no new solved cells.

Once that happens, as is guaranteed with harder puzzles, we have to try something more complex. First the grid sorts all remaining cells. There are three lines here, two of which are commented, representing three different ways of sorting, which turn out to be faster for different puzzles. If I'd had more time to spend on this, it would have been nice to work out exactly which case was which and adjust the alogorithm on the fly, but that may have been beyond me at the end of that particular week. The first just gets the first unsolved cell. The second sorts all the cells by number of unsolved cells, and then finds the first unsolved one. The third gets all unsolved cells, then sorts only those cells by number of possible values, and grabs the first. Currently the second is active. Once we have our cell and have updated its neighbours, we loop through all its candidate values, creating a parallel grid (like a possible world for a sudoku puzzle) and trying to solve that grid supposing that the current candidate value of our chosen cell is the actual value of our chosen cell. So our parallel grid goes through the last two paragraphs until it either throws an error or is solved. If it throws an error, we try the next candidate value. If it's solved, we copy the solution to the real grid and claim that solution as our own.

Also, if you want, you can print out the grid as either a string, or as an array.

## How To Use

If you want to give it a go yourself, type this nonsense into your local ruby REPL.

```ruby
require './lib/cell'
require './lib/grid'

# First we set the puzzle to be solved (ideally you'd want more than one empty value)
really_easy_puzzle = '615493872348127956279568431496832517521746389783915264952681743864379125137254690'
# Then we set up the grid itself
really_easy_grid = Grid.new(really_easy_puzzle)

# Check it isn't solved
really_easy_grid.solved?
=> false
# Solve it!
really_easy_grid.solve
really_easy_grid.solved?
=> true

# If you really want to check the values yourself
really_easy_grid.to_s     # returns a string of all the numbers (as initialised with)
really_easy_grid.inspect  # returns an array of all the numbers
```
