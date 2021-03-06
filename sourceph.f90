module source_ph_mod
  implicit none
  save
contains

  subroutine  sourceph(xp,yp,zp,nxp,nyp,nzp,sint,cost,sinp,cosp,phi,&
          fi,fq,fu,fv,xmax,ymax,zmax,twopi,xcell,ycell,zcell,iseed,L,&
          C,DELTA,WL,diff,d_flag)

    use mc_sample_mod
    use grid_mod
    implicit none

    include 'photon.txt'

    integer xcell,ycell,zcell,iseed
    real*8 xmax,ymax,zmax,twopi, DELTA ,WL
    real*8, intent(in):: L(nwl),C(nwl)

    integer d_flag
    real*8 ran, theta

    real*8 diff

    if (nwl.gt.1) then
    call mc_sample(C,L,WL)
    endif

    ! SET LAUNCH POSITION (**UNIFORM IRRADIANCE**)
    call random_number(ran)
    XP = (2.*ran -1.)*xmax

    call random_number(ran)
    YP = (2.*ran-1.)*ymax

    ZP = ZMAX-DELTA

    !***** Set photon direction cosines for direction of travel *********

    ! set photon directions
    ! SET LAUNCH DIRECTION(SPHERICAL POLARS)
    ! (NEED TO KEEP COST ETC. FOR STOKES SUB?)

    call random_number(ran)
    theta=acos(-ran)
    call random_number(ran)
    phi=twopi*ran

    call random_number(ran)
    if (ran.lt.diff) then
       d_flag=1 !d_flag =1 if the photon is diffuse
       !stop

       COST = cos(theta)
       SINT = sin(theta)

       cosp=cos(phi)
       sinp=sin(phi)

       NXP=sint*cosp
       NYP=sint*sinp
       NZP=cost

    else
       d_flag=0 !d_flag =0 if photon is direct
       cost=-1
       sint=0.
       NXP=0.
       NYP=0.
       NZP=cost

       theta=twopi/2.
    end if
    !***** Set Stokes fluxes ********************************************
    fi=1.
    fq=0.
    fu=0.
    fv=0.

    !*************** Linear Grid *************************
    xcell=int(nxg*(xp+xmax)/(2.*xmax))+1
    ycell=int(nyg*(yp+ymax)/(2.*ymax))+1
    zcell=int(nzg*(zp+zmax)/(2.*zmax))+1
    !*****************************************************

    return
  end subroutine sourceph
end module
  !KENNY CODE ISO ORIGIN
!!$!$$$c***** emit photon isotropically from origin
!!$c$$$      xp=0.
!!$c$$$      yp=0.
!!$c$$$      zp=0.
!!$c$$$
!!$c$$$      cost=2.*ran2(iseed)-1.
!!$c$$$      sint=(1.-cost*cost)
!!$c$$$      if(sint.le.0.)then
!!$c$$$        sint=0.
!!$c$$$      else
!!$c$$$        sint=sqrt(sint)
!!$c$$$      endif
!!$c$$$
!!$c$$$      xp=0.
!!$c$$$      yp=0.
!!$c$$$      zp=0.
!!$c$$$
!!$c$$$      phi=twopi*ran2(iseed)
!!$c$$$      cosp=cos(phi)
!!$c$$$      sinp=sin(phi)
!!$c$$$
!!$c$$$
!!$c$$$c***** Set photon direction cosines for direction of travel *********
!!$c$$$      nxp=sint*cosp
!!$c$$$      nyp=sint*sinp
!!$c$$$      nzp=cost
