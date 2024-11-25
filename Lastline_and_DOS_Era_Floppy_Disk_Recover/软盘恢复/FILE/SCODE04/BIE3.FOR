	 program main
	 parameter (nr=5,nl=5)
	 logical solut 
	 dimension a(nr,nl),x(nr),b(nr)
 	 A(1,1)=2.89D+6
	 a(1,2)=4556.
	 a(1,3)=2.68
	 a(1,4)=1700.
	 a(1,5)=-1.
	 a(2,1)=5.29e+6
	 a(2,2)=1.6008e+4
	 a(2,3)=6.96
	 a(2,4)=2300.
	 a(2,5)=-1.
	 a(3,1)=9.0e+6
	 a(3,2)=2.73e+4
	 a(3,3)=9.1
	 a(3,4)=3000.
	 a(3,5)=-1.
	 a(4,1)=1.444e+7
	 a(4,2)=3.8874e+4
	 a(4,3)=10.23
	 a(4,4)=3800.
	 a(4,5)=-1.
	 a(5,1)=2.5e+7
	 a(5,2)=55050
	 a(5,3)=11.01
	 a(5,4)=5000.
	 a(5,5)=-1.
	 b(1)=-7.1824
	 b(2)=-48.4416
	 b(3)=-82.81
	 b(4)=-104.6529
	 b(5)=-121.2201
	 goto 67
	 a(1,1)=1.
	 a(1,2)=1.
   	 a(1,3)=1.
	 a(1,4)=1.
 	 a(1,5)=1.
	 a(2,1)=1.
	 a(2,2)=-1.
	 a(2,3)=1.
	 a(2,4)=1.
	 a(2,5)=1.
	 a(3,1)=1.
	 a(3,2)=-1.
	 a(3,3)=-1.
	 a(3,4)=1.
	 a(3,5)=1.
	 a(4,1)=1.
	 a(4,2)=-1.
	 a(4,3)=-1.
	 a(4,4)=-1.
	 a(4,5)=1.
	 a(5,1)=1
	 a(5,2)=-1.
	 a(5,3)=-1.
	 a(5,4)=-1.
	 a(5,5)=-1.
	 b(1)=5.
	 b(2)=3.
	 b(3)=1.
	 b(4)=-1.
	 b(5)=-3.
c	 read (*,100) ((a(i,j),j=1,nl),B(I),i=1,nr)
c100	 format(5f14.3,f10.5)
67	 write (*,101 )((a(i,j),j=1,nl),B(I),I=1,NR)
101	 format(10x,'coefi cients of equations:'/(4x,5f14.3,5x,f10.5))
	 call gauss(a,nr,nl,b,x,solut)
	 if (solut) then 
	   write(*,102) (i,x(i),i=1,nr)
102    format(1x,i2,f20.10)
	 else
C print *,'no unique solution or no soloution.'
	 end if
	 end


	 subroutine gauss(a,m,n,b,x,solut)
	 logical solut
	 dimension a(m,n),b(m),x(m)
	 do 30 k=1,n
	  ik=k
	  call spiv(A,M,N,B,IK,SOLUT)
	  IF(SOLUT) THEN 
	  DO 20 I=K,M
	    C=A(I,K)
	 IF(ABS(C).NE.0.0) THEN
	 DO 10 J=K,N
	 A(I,J)=A(I,J)/C
	 IF(I.GT.K) THEN
	 A(I,J)=A(I,J)-A(K,J)
	 END IF
10	 CONTINUE
	 B(i)=B(I)/C
	 IF(I.GT.K) THEN
	 B(I)=B(i)-B(K)
	 END IF
	 END IF
20 	 CONTINUE
	 ELSE
	 RETURN
	 END IF
30 	 CONTINUE



	 X(M)=B(M)
	 DO 60 I=M-1,1,-1
	 SUM=B(I)
	 DO 50 J=I+1,m
	 SUM=SUM- A(I,J)*X(J)
50	 CONTINUE
	 X(I)= SUM
60	 CONTINUE
	 RETURN
	 end


	 SUBROUTINE SPIV(A,M,N,B,K,SOLUT)
	 DIMENSION A(M,N),B(M)
	 LOGICAL SOLUT
	 SOLUT=.FALSE.
	 DO 10 I=K,M
	   IF(A(I,K).NE.0.0) THEN
	   SOLUT=.TRUE.
	  END IF
10 	 CONTINUE
	 IF(SOLUT) THEN
	 L=K
	 DO 20 J=K,M
	 IF(ABS(A(J,K)).GT. ABS(A(L,K))) THEN
	 L=J
	 END IF
20	 CONTINUE
	 IF(L.NE.K) THEN
	 TM=B(K)
	 B(K)=B(L)
	 B(L)=TM
	 DO 30 J=K,M
	 TM=A(K,J)
	 A(K,J)=A(L,J)
	 A(L,J)=TM
30	 CONTINUE
	 END IF
	 END IF
	 return
	  END
	 
