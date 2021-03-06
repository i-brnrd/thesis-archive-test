module grid_mod
  use packet_mod, only:nwl,nlayer
  implicit none
  save
  !contains
  integer, parameter :: nxg=50,nyg=50,nzg=400

  real*8 :: xface(-3:nxg+4),yface(-3:nyg+4),zface(-3:nzg+4)
  real*8 :: MASK(nxg,nyg,nzg,nlayer)
  real*8 :: rhokap(nxg,nyg,nzg)

  REAL*8 :: PL_SUM(nwl,NXG,NYG,NZG)
  REAL*8 :: E_SUM(nwl,NXG,NYG,NZG)

end module grid_mod
