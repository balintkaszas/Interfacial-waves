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
INTEGER :: iter
iter  = 10
CALL INIT(iter)  ! initialisation
!**********

! runtime parameters
ntot = INT(6.*6./dt)
time = 0.0
! output frequency
nout = INT(0.3/dt)
! open files for output
!OPEN(10,file ='q.dat',form='formatted')
OPEN(20,file ='perhaps/'//trim(str(iter))//'/u.dat',form='formatted')
OPEN(30,file ='perhaps/'//trim(str(iter))//'/w.dat',form='formatted')
!OPEN(40,file ='eta.dat',form='formatted')
OPEN(50,file ='perhaps/'//trim(str(iter))//'/rho.dat',form='formatted')
OPEN(60, file = 'perhaps/'//trim(str(iter))//'/rho_timeseries_13.dat', form ='formatted')
OPEN(70, file = 'perhaps/'//trim(str(iter))//'/rho_timeseries_14.dat', form ='formatted')
OPEN(80, file = 'perhaps/'//trim(str(iter))//'/u_timeseries_1.dat', form ='formatted')
!OPEN(95,file ='force.dat',form='formatted')

!---------------------------
! simulation loop
!---------------------------
DO n = 1,ntot
L = nx*dx

time = time + dt
write(*,*)"time (hours)", time/(3600.), "distance: ", iter

! prognostic equations
CALL dyn
WRITE(60, '(501F12.6)')(rho(13,k)-RHOREF, k = 1, nx)
WRITE(70, '(501F12.6)')(rho(14,k)-RHOREF, k = 1, nx)
WRITE(80, '(501F12.6)')(u(5,k), k = 1, nx)
!WRITE(95,'(501F12.6)') (G*0.003*2*PI/(L)*SIN(2*PI*k/(2*nx))*COS(2.*PI*time/6.6), k = 1, nx)
! data output
IF(MOD(n,nout)==0)THEN
  DO i = 1,nz
!    WRITE(10,'(501F12.6)')(q(i,k)/(RHOREF*G),k=1,nx)
    WRITE(20,'(501F12.6)')(u(i,k),k=1,nx)
    WRITE(30,'(501F12.6)')(w(i,k),k=1,nx)
    WRITE(50,'(501F12.6)')(rho(i,k)-RHOREF,k=1,nx)
  END DO
!  WRITE(40,'(501F12.6)')(q(0,k)/(RHOREF*G),k=1,nx)
  WRITE(6,*)"Data output at time = ",time/(24.*3600.)
ENDIF
END DO ! end of iteration loop
CLOSE(60)
CLOSE(70)
CLOSE(80)
CLOSE(20)
CLOSE(30)
CLOSE(50)

END PROGRAM slice
