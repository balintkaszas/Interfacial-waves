!=======================
! Exercise 7: Lee waves
!=======================
! Author: J. Kaempf, August 2009 

PROGRAM slice

USE param
USE sub

! local parameters
INTEGER :: ntot, nout

!**********
CALL INIT  ! initialisation
!**********

! runtime parameters
ntot = INT(6.*6./dt)
time = 0.0

! output frequency
nout = INT(0.3/dt)

! open files for output
!OPEN(10,file ='q.dat',form='formatted')
!OPEN(20,file ='u.dat',form='formatted')
!OPEN(30,file ='w.dat',form='formatted')
!OPEN(40,file ='eta.dat',form='formatted')
OPEN(50,file ='rho.dat',form='formatted')
OPEN(60, file = 'rho_timeseries_13.dat', form ='formatted')
OPEN(70, file = 'rho_timeseries_14.dat', form ='formatted')

!---------------------------
! simulation loop
!---------------------------
DO n = 1,ntot

time = time + dt
write(*,*)"time (hours)", time/(3600.)

! prognostic equations
CALL dyn
WRITE(60, *)(time, rho(13,k)-RHOREF, k = 1, nx)
WRITE(70, *)(time, rho(14,k)-RHOREF, k = 1, nx)

! data output
IF(MOD(n,nout)==0)THEN
  DO i = 1,nz
!    WRITE(10,'(501F12.6)')(q(i,k)/(RHOREF*G),k=1,nx)
!    WRITE(20,'(501F12.6)')(u(i,k),k=1,nx)
!    WRITE(30,'(501F12.6)')(w(i,k),k=1,nx)
    WRITE(50,'(501F12.6)')(rho(i,k)-RHOREF,k=1,nx)
  END DO
!  WRITE(40,'(501F12.6)')(q(0,k)/(RHOREF*G),k=1,nx)
  WRITE(6,*)"Data output at time = ",time/(24.*3600.)
ENDIF
END DO ! end of iteration loop
CLOSE(60)

END PROGRAM slice
