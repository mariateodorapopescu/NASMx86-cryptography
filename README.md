# Cryptography in ASM

## task-1:
- I put a letter from the source, then add the step to that letter. if it exceeds uppercase letters,
subtract 26, so that the capital letter remains. then I return to the for loop. if not, continue.
- I check if the letter contained in al has the value in ASCII code greater than Z
and check and decrease each time, as necessary, until the letter is smaller than Z
- if the respective letter is still part of the alphabet, I do not subtract or add, but move on
- at the end, I put one character at a time in the encrypted text, and if I have finished iterating through the string, I close the program

## task-2
**Part 1**
- initially it would have been: ``sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))``
- but, when it is parallel to ox => the difference of y's is 0, so the result is x2 - x1
- when it is parallel to oy => the difference of x's is 0, so the result is y2 -y1
- check if ONLY two points have the same x
- I take small registers, like cl, dl because I work with small numbers, that's what I noticed from the tests
- if I had used larger registers, there would have been other values in them, being completed with f's
- it should be mentioned that in cl and in dl they are maintained,
- as the case may be, the x's (or y's) of the first, respectively the second point.
- first take the x's of the two points. if the x's are not equal, I make the difference between them
- if they are, go ahead and make the difference of y's.
therefore move in cl on y of the first point
- I check their order to make the absolute difference. if the second one is bigger,
I make a difference directly; if it's the other way around, then I subtract from the second to the first
- at the end, I move the difference to the destination and close the program

**Part 2**
- it's similar to 1, only I take 2 by 2 this time not randomly, but from a vector
- I take the x of the point from the edx index, which is initially 0, as it starts from the beginning
then the x of the point following the one we took
- I compare them, and if they are not equal, I make a difference between the x's
- otherwise, I take the y's and make the difference between them
- I check which one is bigger to take the absolute difference
- if the second is greater than the first, subtract from the second to the first
- if the first one is bigger, then it makes the difference normally
- if both x's and y's are equal, put 0 in the register where the result is requested
- then I add the destination register, then move to the next point in the vector
- I compare the address/index I am at to know if I still have elements in the vector
- if I still have it, then I'll start again. if there are no more elements to check in the vector, then close the program

**Part 3**
- in C it would come like this:
  ``for (i = nr_elem_vector - 1; i >= 0; i--)
  for (j = 1; j <= elem_curr_vector; j++)
  if (j * j == elem_current_in_vector)
  *then put 1 in the vector in which the result is requested*``
  but it's asm, so:
- take the current element from the vector
- first I assume that it is not a perfect square, that's why I put 0 im vectoruld destination
- I enter a loop with a suggestive name as I explained above with a kind of j
- I square the j and compare it with the current element in the vector
- if it is his root, then I go to the label where he puts 1
- if not, I move on
- and if it has gone further, it goes to the next factor, so that I can find the root, if it is a perfect square
- compare with the number so that I know when I leave the suggestive forum with j
- and if I have finished verifying the existence of the root (whether I found it or not), then I go further in the vector and see if I still have elements from the vector to check or not
- if yes, repeat the for with suggestive i; if not, then I leave the program

## task-3:
- in edi I change the size of the text to clear
- iterate through the string in clear
- I put a character from the key here to complete, to repeat the key how many characters does the clear have
- I try to take some kind of ``for (j = strlen(key)-1; j >= 0; j--)`` being a good way to help me get through the key
- I iterate through the key until I reach the end, to put it in a string in which to repeat it
- I take the address of the key, I take the address of the text clearly, I make the difference between the addresses, so that I know how much to complete
- the main idea is to complete the key with it enough to reach the length of the plain text to pass through both at the same time
- I move the remaining new dimension so that I know how much I repeat, how much I extend
- I go to the beginning of the extended key to prepare to go through the key and the clear text simultaneously
- I take a character from the extended key, compare it with a character from the plain text, make the difference between key and clear, according to the formula discovered with the help of one from the wiki
- the formula sounds something like this: ``carac_cheie - carac_clear + letter_A (ie 65 in ascii);`` if it is smaller, I add 26 to return to the uppercase alphabet. if it exceeds, decrease
- I move to the destination what I changed. I go further in the extended key, but also with the text in clear.

## task-4:
- I divide the matrix into a kind of concentric squares/one inside the other, which I go through as follows:
- first the upper side, then the right side, then the bottom side and finally the left side
- to make it more interactive: I divide the matrix into k squares, depending on the parity of N
- I will discuss the parity of N further on
- take line k, then column N-k, then line N-K then column k.
- take the length of a line from the matrix, but also of a column from the matrix (they are the same),
especially since it is a quadratic matrix
- I take the address of the first element in the matrix and put the size of an int in a separate register
- that size I took earlier, I make it 16 because I have 4 for the line, 4 for the column.
- practically, this helps me move from one line to another.
- I take a kind of ``for (k = N; k >= 0; k--)`` but it is with the label fork (for k)
- each square has size k and their size increases successively
- I check if I have reached element 0
- I do the case-by-case verification of k and N. here I check to see if N is odd or not
- I reset the counter as it comes
- I take line k, put the character (in ascii) from the key, i.e. from the matrix and add it to
the character in the text in clear, according to the formula
- I add 1 to move to the next element in the clear text
- I add 4 to move to the next element in the line
- continue iterating through the line. if I have no more elements per line, I move back to the size counter,
for when I will take the n-k column
- this logic will be repeated, only that when going through the columns, 16 is added (because I am moving from a
line by line). 4 and 16 respectively are added when going from right to left on the top line, on the right column, then go from the end to the beginning (so 4 and 16 are subtracted respectively) on the bottom line and on the left column of the square.
- here it happens similarly as when going through the line k (lk), only that I don't add four but 16, that I go on a lower line
- after making a square, I go further, add the address I arrived at and 1 more to pass in the inner square
- subtract from the size of a square 1 as the squares get progressively smaller
- after exiting the fork (for k) that takes the squares, I move back what was at the beginning in the registers to help me put the processed characters in the encrypted string
- I take the text in plain text, which has been modified, and put it in the destination.
- I move to the next character from the modified clear, as well as in what I have changed, this only if I still have elements in the modified clear
