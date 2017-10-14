!==============================================================================!
  subroutine Demo_Cholesky_Solver
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Interfaces]---------------------------------!
  include "Backward_Substitution.int"
  include "Forward_Substitution.int"
  include "Print_Matrix.int"               
  include "Print_Vector.int"               
  include "Cholesky_Factorization.int"
  include "Matrix_Vector_Multiply.int"
!-----------------------------------[Locals]-----------------------------------!
  integer :: row, col, choice, i
!==============================================================================!

  ! Matrix 2 for Cholesky factorization
  integer, parameter    :: n = 7
  real, dimension(n, n) :: a_matrix, f_matrix
  real, dimension(n)    :: b, x, y
  data (a_matrix(1,col), col=1,n) / 44., -4., -3.,  0., -1.,  0.,  0. /
  data (a_matrix(2,col), col=1,n) / -4., 44., -4., -3.,  0., -1.,  0. /
  data (a_matrix(3,col), col=1,n) / -3., -4., 44., -4., -3.,  0., -1. /
  data (a_matrix(4,col), col=1,n) /  0., -3., -4., 44., -4., -3.,  0. /
  data (a_matrix(5,col), col=1,n) / -1.,  0., -3., -4., 44., -4., -3. /
  data (a_matrix(6,col), col=1,n) /  0., -1.,  0., -3., -4., 44., -4. /
  data (a_matrix(7,col), col=1,n) /  0.,  0., -1.,  0., -3., -4., 44. /
  data (b(row), row=1,n)          /  1.,  2.,  3.,  4.,  3.,  2.,  1. /

  ! Just print original matrix
  call Print_Matrix("a_matrix:", a_matrix)

  ! Perform Cholesky factorization on the matrix to fin the lower one
  call Cholesky_Factorization(f_matrix, a_matrix)
  call Print_Matrix("f_matrix after Cholesky factorization", f_matrix)

  ! Compute y by forward substitution
  call Forward_Substitution(y, f_matrix, b)
  call Print_Vector("Vector y after forward substitution:", y) 

  ! Compute x by backward substitution
  call Backward_Substitution(x, f_matrix, y)
  call Print_Vector("Vector x after backward substitution:", x) 

  ! Multiply original matrix with solution vector to check result
  call Matrix_Vector_Multiply(y, a_matrix, x)
  call Print_Vector("Vector y should recover the source term:", y)

  end subroutine Demo_Cholesky_Solver
