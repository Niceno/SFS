!==============================================================================!
  subroutine Split_String(string, delimiter, substrings, substring_count)
!------------------------------------------------------------------------------!
!   Helper function
!   Splits the supplied string along a delimiter
!------------------------------------------------------------------------------!
!   Input:
!   string:    Variable-length character string that is to be split
!   delimiter: Character along which to split
!
!   Output:
!   substrings:      Array of substrings generated by split operation
!   substring_count: Number of substrings generated
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  character(*), intent(in)  :: string
  character,    intent(in)  :: delimiter
  character(*), intent(out) :: substrings(*)
  integer,      intent(out) :: substring_count
!-----------------------------------[Locals]-----------------------------------!
  integer :: start_position, end_position
!==============================================================================!

  start_position  = 1
  substring_count = 0

  do
    end_position = index(string(start_position:), delimiter)

    substring_count = substring_count + 1

    if (end_position == 0) then
      substrings(substring_count) = string(start_position:)
      EXIT
    else
      substrings(substring_count) = string(start_position : start_position + end_position - 2)
      start_position = start_position + end_position
    end if
  end do

  end subroutine

