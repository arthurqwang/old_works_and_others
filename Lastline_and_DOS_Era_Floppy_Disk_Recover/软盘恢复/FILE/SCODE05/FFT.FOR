C		************************************
C		*          XI' AN FFT              *
C		*   PERFORM FFT(+,-) IN COMPLEX    *
C		*   LX:NUMBER OF COMPLEX DATA(2^N) *
C		*   CX:NAME OF COMPLEX ARR         *
C		*   IG:TRANSFORM SIGN              *
C		*   -1:T----F  +1:F----T           *
C		************************************
		SUBROUTINE FFT(LX,CX,IG)
		COMPLEX CX(LX),CARG,CW,CTEMP
		L=LX/2
		IF (IG.EQ.-1) THEN
		SC=1.
		ELSE 
		SC=1./LX
		END IF
		A=3.1415926535*IG
		J=1
		DO 30 i=1,LX
		IF(i.LE.J) THEN
		  CTEMP=CX(J)*SC
		  CX(J)=CX(i)*SC
		  CX(i)=CTEMP
		ENDIF
		M=L
20		IF(J.GT.M) THEN
		J=J-M
		M=M/2
		IF(M.GE.1) GO TO 20
		ENDIF
		J=J+M
30		CONTINUE
		L=1
40		ISTEP=2*L
		AB=A/L
		SA=0.0
		CA=1.0
		SB=SIN(AB)
		CB=COS(AB)
		CW=CMPLX(CA,SA)
		DO 50 M=1,L
		DO 45 i=M,LX,ISTEP
		  CTEMP=CW*CX(i+L)
		cx(i+L)=CX(i)-ctemp
45  		  CX(i)=CX(i)+CTEMP
		CALL SWING(CA,SA,CB,SB)
		CW=CMPLX(CA,SA)
50		CONTINUE
		L=ISTEP
		IF(L.LT.LX) GO TO 40
		RETURN
		END
C		****************************
		SUBROUTINE SWING(CA,SA,CB,SB)
		D=CB-1.0
		Z1=CA+D*CA-SA*SB
		Z2=SA+D*SA+CA*SB
		T=1.5-0.5*(Z1*Z1+Z2*Z2)
		CA=T*Z1
		SA=T*Z2
		RETURN
		END
