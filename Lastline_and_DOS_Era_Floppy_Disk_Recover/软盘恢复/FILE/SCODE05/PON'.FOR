
		INTEGER*2  S(2000)
		DIMENSION SS(2000)
		CHARACTER*21  FILE1,FILE2
		WRITE(*,'(a\)')'  file1='
		READ(*,'(A)') FILE1
	        write(*,'(a\)')'  file2='
		READ(*,'(A)')  file2
 		OPEN(2,FILE=FILE2,ACCESS='DIRECT',RECL=2240,STATUS='NEW')
		open(1,file=file1,status='OLD')
		DO 40 I=1,120
		S(I)=0
40		CONTINUE
 		S(58)=1000
		S(59)=2000
		DO 1 I=121,1120
		READ(1,*) SS(I)
		S(I)=INT(SS(I)*1000)
1		CONTINUE
		close(1)
		do 45 i=1,30
		WRITE(2,REC=I)(S(iI),iI=1,1120)
45		CONTINUE
		CLOSE(2)
1000		FORMAT(A21)
		END
				
		
