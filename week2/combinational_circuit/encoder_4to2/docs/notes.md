Basic encoder:
  Valid only for one-hot input
  Multiple bits active → invalid (valid=0)
  Uses: case statement

Priority encoder:
  Valid for any non-zero input
  Multiple bits active → highest bit wins
  Uses: casez with don't-care (?)
  
Interview question:
  "What happens in your encoder if two inputs are
   high simultaneously?"
  Basic encoder answer    → invalid, valid=0
  Priority encoder answer → highest priority wins, valid=1