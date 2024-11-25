DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
        SCREEN 7
        LOCATE 5, 6
        CALL hanzi("гКвт╬У╪Л╡БхМел╙║", 7, 2, 4, 9)
        LOCATE 5, 6
        CALL hanzi("гКвт╬У╪Л╡БхМел╙║", 10, 2, 4, 9)
        LOCATE 5, 6
        CALL hanzi("гКвт╬У╪Л╡БхМел╙║", 8, 2, 4, 9)
        LOCATE 5, 6
        CALL hanzi("гКвт╬У╪Л╡БхМел╙║", 9, 2, 4, 9)

1       IF INKEY$ = "" THEN 1
        END


