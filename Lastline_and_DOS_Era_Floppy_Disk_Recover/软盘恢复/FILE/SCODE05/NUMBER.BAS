�   �� Q��$ ��Z� d i (��    � '> �� �   �aV �  mg    I  [ �2�� � t � � n � z   WR [ s   CLYYS� a b� 
 �  C � ( � 2 < � F � P 8Z � d � @number, �  � �     �     �  	 � i nO nn   na ei   es nb  naax nxit   nbb j       gy.{    k�N    k1U xxI yy   kx: ky   xo   yo   LP INE  '   	gosub9999� RETURN3   t� kjh� sav   .23456#   jiange   nuber  �&   goto8765="   nhg� jkl  m   savv  O ��   to14�   jkll   ji  k   l A nui   nuii   col   scr                                                                                                                                                                                                                                                                    	  ��������        number 0v!  v < �  	 g   m   O   U   �   �    �   I   P     s P�     �  �   �db]   [ .   � �    � � w �    � d) �vpk   ? &d) �v �   [ 4  
 - � 107 n = INT(nhg * 10 ^ sav + .5) / 10 ^ sav   
  108 FOR i = 10 TO 1 STEP -1   
  2nui = n / 10 ^ (i - 1)  
  :  
  Rnb(i) = FIX(nui)  
  vn = n - nb(i) * 10 ^ (i - 1)  
  �NEXT i  
  �  
  �FOR i = 10 TO 1 STEP -1   
  �IF nb(i) <> 0 THEN GOTO 78  
 	 �jkl = i   
  �NEXT i  
 	 �GOTO 79   
  78 jkl = i  
  &79 kx = xx / 10   
  :ky = yy / 10  
  Hk = 0   
  nIF number >= 0 THEN GOTO 8765   
 H �LINE (k * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo), col  
  �k = jiange  
  �  
  �  
  8765 FOR j = jkl TO 1 STEP -1   
  GOSUB 9999  
  ,k = k + jiange  
  :NEXT j  
  XIF sav <= 0 GOTO 9876   
  `  
 X �PSET ((4 + k) * kx + xo, 9 * ky + yo), col: PSET ((5 + k) * kx + xo, 9 * ky + yo), col  
 Z PSET ((4 + k) * kx + xo, 10 * ky + yo), col: PSET ((5 + k) * kx + xo, 10 * ky + yo), col  
  &  
   LFOR i = 20 TO 21 - sav STEP -1  
  nnuii = nn / 10 ^ (i - 21)   
  �nb(i) = FIX(nuii)   
 ! �nn = nn - nb(i) * 10 ^ (i - 21)   
  �NEXT i  
  �  
 ! � FOR j = 20 TO 21 - sav STEP -1   
  k = k + jiange  
  GOSUB 9999  
  $NEXT j  
 
 49876 END  
  <  
  D  
  L  
 ! t9999 'writing number subroutine   
  |  
  �  
  �  
  �  
  �  
  �  
 0 �ON nb(j) + 1 GOTO 0, 1, 2, 3, 4, 5, 6, 7, 8, 9  
  �'1  
 h R1 LINE (CINT((5 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((5 + k) * kx) + xo, CINT(10 * ky) + yo), col  
 	 b RETURN   
  l'2  
 g �2 LINE (CINT((0 + k) * kx) + xo, CINT(2 * ky) + yo)-(CINT((3 + k) * kx) + xo, CINT(0 * ky) + yo), col   
 e FLINE (CINT((3 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((7 + k) * kx) + xo, CINT(0 * ky) + yo), col   
 f �LINE (CINT((7 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((10 + k) * kx) + xo, CINT(2 * ky) + yo), col  
 g  LINE (CINT((10 + k) * kx) + xo, CINT(2 * ky) + yo)-(CINT((10 + k) * kx) + xo, CINT(4 * ky) + yo), col   
 f �LINE (CINT((10 + k) * kx) + xo, CINT(4 * ky) + yo)-(CINT((0 + k) * kx) + xo, CINT(8 * ky) + yo), col  
 ` �LINE (CINT((0 + k) * kx) + xo, CINT(8 * ky) + yo)-(CINT((0 + k) * kx) + xo, 10 * ky + yo), col  
 O H	LINE ((0 + k) * kx + xo, 10 * ky + yo)-((9 + k) * kx + xo, 10 * ky + yo), col   
 	 X	 RETURN   
  b	'3  
 O �	3 LINE ((0 + k) * kx + xo, 2 * ky + yo)-((3 + k) * kx + xo, 0 * ky + yo), col   
 M 
LINE ((3 + k) * kx + xo, 0 * ky + yo)-((7 + k) * kx + xo, 0 * ky + yo), col   
 N `
LINE ((7 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo), col  
 O �
LINE ((10 + k) * kx + xo, 2 * ky + yo)-((10 + k) * kx + xo, 4 * ky + yo), col   
 N 
LINE ((10 + k) * kx + xo, 4 * ky + yo)-((4 + k) * kx + xo, 5 * ky + yo), col  
 N ^LINE ((5 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 6 * ky + yo), col  
 O �LINE ((10 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col   
 O 
LINE ((10 + k) * kx + xo, 8 * ky + yo)-((7 + k) * kx + xo, 10 * ky + yo), col   
 O `LINE ((7 + k) * kx + xo, 10 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo), col   
 N �LINE ((2 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo), col  
 	 � RETURN   
  �'4  
 N "4 LINE ((10 + k) * kx + xo, 7 * ky + yo)-(0 + k * kx + xo, 7 * ky + yo), col  
 M vLINE ((0 + k) * kx + xo, 7 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), col   
 N �LINE ((8 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col  
 	 � RETURN   
  �  
  �'5  
 P B5 LINE ((0 + k) * kx + xo, 9 * ky + yo)-((3 + k) * kx + xo, 10 * ky + yo), col  
 � �LINE ((3 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col: LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col  
 � �LINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo), col: LINE ((10 + k) * kx + xo, 5 * ky + yo)-((8 + k) * kx + xo, 4 * ky + yo), col   
 � *LINE ((8 + k) * kx + xo, 4 * ky + yo)-((3 + k) * kx + xo, 4 * ky + yo), col: LINE ((3 + k) * kx + xo, 4 * ky + yo)-((0 + k) * kx + xo, 4 * ky + yo), col  
 � �LINE ((0 + k) * kx + xo, 4 * ky + yo)-((0 + k) * kx + xo, 0 * ky + yo), col: LINE ((0 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 0 * ky + yo), col   
 	 � RETURN   
  �'6  
 O <6 LINE ((0 + k) * kx + xo, 5 * ky + yo)-((3 + k) * kx + xo, 4 * ky + yo), col   
 M �LINE ((3 + k) * kx + xo, 4 * ky + yo)-((8 + k) * kx + xo, 4 * ky + yo), col   
 � 4LINE ((8 + k) * kx + xo, 4 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo), col: LINE ((10 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col   
 � �LINE ((10 + k) * kx + xo, 8 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col: LINE ((8 + k) * kx + xo, 10 * ky + yo)-((3 + k) * kx + xo, 10 * ky + yo), col  
 � zLINE ((3 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo), col: LINE ((0 + k) * kx + xo, 8 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo), col   
 � LINE ((0 + k) * kx + xo, 2 * ky + yo)-((3 + k) * kx + xo, 0 * ky + yo), col: LINE ((3 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), col  
 N n'LINE ((8 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo),col  
 	 ~ RETURN   
  �'7  
 � ,7 LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 0 * ky + yo), col: LINE ((0 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 0 * ky + yo), col   
 � �LINE ((10 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo), col: LINE ((3 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo), col  
 	 � RETURN   
  �'8  
 O @8 LINE ((2 + k) * kx + xo, 5 * ky + yo)-((8 + k) * kx + xo, 5 * ky + yo), col   
 N �LINE ((8 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 6 * ky + yo), col  
 � 8LINE ((10 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col: LINE ((10 + k) * kx + xo, 8 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col  
 � �LINE ((8 + k) * kx + xo, 10 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo), col: LINE ((2 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo), col   
 � |LINE ((0 + k) * kx + xo, 8 * ky + yo)-((0 + k) * kx + xo, 6 * ky + yo), col: LINE ((0 + k) * kx + xo, 6 * ky + yo)-((2 + k) * kx + xo, 5 * ky + yo), col  
 � LINE ((2 + k) * kx + xo, 5 * ky + yo)-((0 + k) * kx + xo, 3 * ky + yo), col: LINE ((0 + k) * kx + xo, 3 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo), col  
 M pLINE ((0 + k) * kx + xo, 2 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo), col   
 �     LINE ((2 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), col: LINE ((8 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo), col   
 � �LINE ((10 + k) * kx + xo, 2 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo), col: LINE ((8 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo), col   
  �RETURN  
  �'9  
 K $' LINE ((0 + k) * kx + xo, 8 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo)   
 Q |9 LINE ((2 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col   
 �  LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col: LINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo), col  
 � �LINE ((10 + k) * kx + xo, 2 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), col: LINE ((8 + k) * kx + xo, 0 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo), col   
 � bLINE ((2 + k) * kx + xo, 0 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo), col: LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 4 * ky + yo), col  
 � LINE ((0 + k) * kx + xo, 4 * ky + yo)-((2 + k) * kx + xo, 6 * ky + yo), col: LINE ((2 + k) * kx + xo, 6 * ky + yo)-((8 + k) * kx + xo, 6 * ky + yo), col  
 N VLINE ((8 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 4 * ky + yo), col  
 	 f RETURN   
  p'0  
 P �0 LINE ((2 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col  
 O LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), col   
 O rLINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo), col   
 �  LINE ((10 + k) * kx + xo, 2 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), col: LINE ((8 + k) * kx + xo, 0 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo), col   
 � � LINE ((2 + k) * kx + xo, 0 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo), col: LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo), col  
 � X!LINE ((0 + k) * kx + xo, 8 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo), col: LINE ((2 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), col   
  f!RETURN  
  ��        Q 	  ������� �      