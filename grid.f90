module grid_mod
  implicit none
  save
  !contains
  integer, parameter :: nxg=50,nyg=50,nzg=400
  integer, parameter :: nwl=121
  integer, parameter :: nlayer=5

  real*8 :: xface(-3:nxg+4),yface(-3:nyg+4),zface(-3:nzg+4)
  real*8 :: MASK(nxg,nyg,nzg,nlayer)
  real*8 :: rhokap(nxg,nyg,nzg)

  REAL*8 :: PL_SUM(nwl,NXG,NYG,NZG)
  REAL*8 :: E_SUM(nwl,NXG,NYG,NZG)

  integer :: n_phot_wl(nwl)
  integer :: lcount(nlayer)

end module grid_mod