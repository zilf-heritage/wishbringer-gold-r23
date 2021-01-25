

	.FUNCT	I-FOG-RISING
	ZERO?	ECLIPSE? \?CCL2
	EQUAL?	HERE,CLIFF-EDGE /?CND1
?CCL2:	CALL2	INT,I-FOG-RISING
	PUT	STACK,0,0
	RTRUE	
?CND1:	INC	'WOMAN-SCRIPT
	ZERO?	WOMAN-SCRIPT /TRUE
	CRLF	
	EQUAL?	WOMAN-SCRIPT,1 \?CCL9
	PRINTR	"The fog in the valley is rising towards you!"
?CCL9:	EQUAL?	WOMAN-SCRIPT,2 \?CCL13
	PRINTR	"Fog is spilling over the edge of the cliff."
?CCL13:	EQUAL?	WOMAN-SCRIPT,3 \?CCL17
	PRINTR	"Fingers of fog are swirling around your feet."
?CCL17:	CALL2	INT,I-FOG-RISING
	PUT	STACK,0,0
	MOVE	PROTAGONIST,FOG
	SET	'HERE,FOG
	SET	'OHERE,FALSE-VALUE
	SET	'TLOC,7
	ICALL2	START-BUZZ,1
	PRINTI	"The rising mist envelops the cliff in a thick layer of..."
	CRLF	
	CRLF	
	ICALL1	V-LOOK
	RTRUE	


	.FUNCT	ENTER-FOG?
	ZERO?	ENDING? /?CND1
	SET	'WOMAN-SCRIPT,5
	PRINTI	"A sudden noise from the "
	PRINTD	MAGICK-SHOPPE
	PRINTI	" changes your mind."
	CRLF	
	RFALSE	
?CND1:	SET	'TLOC,6
	ICALL2	START-BUZZ,1
	ZERO?	SKEWED? \?PRG8
	RETURN	STEEP-TRAIL
?PRG8:	PRINTI	"As you descend the "
	PRINTD	TRAIL
	PRINTI	" you are immediately engulfed in..."
	CRLF	
	CRLF	
	RETURN	FOG


	.FUNCT	FOG-PSEUDO
	EQUAL?	PRSA,V?LOOK-INSIDE,V?LOOK-THRU,V?EXAMINE \?CCL3
	PRINTR	"It's so thick you can barely see your own feet!"
?CCL3:	EQUAL?	PRSA,V?ENTER,V?WALK-TO,V?TAKE /?PRG10
	EQUAL?	PRSA,V?THROUGH \?CCL7
?PRG10:	PRINTR	"There's more than enough right here."
?CCL7:	ICALL	YOU-DONT-NEED,STR?254,TRUE-VALUE
	RETURN	2


	.FUNCT	STEEP-TRAIL-F,CONTEXT
	EQUAL?	CONTEXT,M-LOOK \FALSE
	PRINTI	"A steep, rocky "
	PRINTD	TRAIL
	PRINTI	" winds "
	GET	TRAILS,TLOC
	PRINT	STACK
	PRINTR	"."


	.FUNCT	N-TRAIL
	EQUAL?	TLOC,1,3,7 \?CCL3
	ICALL1	BUMP-CLIFF
	RFALSE	
?CCL3:	EQUAL?	TLOC,4,5 \?CCL5
	ICALL1	PROB-TUMBLE
	RFALSE	
?CCL5:	EQUAL?	TLOC,2 \?CCL7
	ICALL2	NEW-TRAIL,3
	JUMP	?CND1
?CCL7:	ICALL2	NEW-TRAIL,5
?CND1:	CALL1	NEXT-CELL
	RSTACK	


	.FUNCT	E-TRAIL
	EQUAL?	TLOC,5,6,7 \?CCL3
	ICALL1	PROB-TUMBLE
	RFALSE	
?CCL3:	EQUAL?	TLOC,1,3 \?CCL5
	ICALL1	BUMP-CLIFF
	RFALSE	
?CCL5:	EQUAL?	TLOC,2 \?CCL7
	ICALL2	NEW-TRAIL,1
	JUMP	?CND1
?CCL7:	ICALL2	NEW-TRAIL,5
?CND1:	CALL1	NEXT-CELL
	RSTACK	


	.FUNCT	S-TRAIL
	EQUAL?	TLOC,1,2,7 \?CCL3
	ICALL1	PROB-TUMBLE
	RFALSE	
?CCL3:	EQUAL?	TLOC,4,6 \?CCL5
	ICALL1	BUMP-CLIFF
	RFALSE	
?CCL5:	EQUAL?	TLOC,3 \?CCL7
	ICALL2	NEW-TRAIL,2
	JUMP	?CND1
?CCL7:	ICALL2	NEW-TRAIL,6
?CND1:	CALL1	NEXT-CELL
	RSTACK	


	.FUNCT	W-TRAIL
	EQUAL?	TLOC,2,3,4 \?CCL3
	ICALL1	PROB-TUMBLE
	RFALSE	
?CCL3:	EQUAL?	TLOC,6 \?CCL5
	ICALL1	BUMP-CLIFF
	RFALSE	
?CCL5:	EQUAL?	TLOC,1 \?CCL7
	ICALL2	NEW-TRAIL,2
	JUMP	?CND1
?CCL7:	EQUAL?	TLOC,5 \?PRG10
	ICALL2	NEW-TRAIL,4
?CND1:	CALL1	NEXT-CELL
	RSTACK	
?PRG10:	PRINTI	"Crash! "
	ICALL1	BELL-TINKLES
	RFALSE	


	.FUNCT	U-TRAIL
	EQUAL?	TLOC,1,2,4 /?CTR2
	EQUAL?	TLOC,5,7 \?CCL3
?CTR2:	ICALL	CANT-SEE-ANY,STR?261,TRUE-VALUE
	RFALSE	
?CCL3:	EQUAL?	TLOC,3 \?CCL7
	ICALL2	NEW-TRAIL,4
	JUMP	?CND1
?CCL7:	ZERO?	SKEWED? /?CCL10
	SET	'TLOC,7
?CND1:	CALL1	NEXT-CELL
	RSTACK	
?CCL10:	SET	'TLOC,FALSE-VALUE
	FSET?	CLIFF-EDGE,RMUNGBIT /?CCL12
	RETURN	CLIFF-EDGE
?CCL12:	FCLEAR	CLIFF-EDGE,RMUNGBIT
	ICALL2	UPDATE-SCORE,1
	CRLF	
	RETURN	CLIFF-EDGE


	.FUNCT	D-TRAIL
	EQUAL?	TLOC,2,3,5 /?CTR2
	EQUAL?	TLOC,6 \?CCL3
?CTR2:	ICALL	CANT-SEE-ANY,STR?262,TRUE-VALUE
	RFALSE	
?CCL3:	EQUAL?	TLOC,1 \?CCL7
	ZERO?	SKEWED? /?CND8
	ICALL1	WALK-OUT-OF-FOG
?CND8:	SET	'TLOC,FALSE-VALUE
	RETURN	CLIFF-BOTTOM
?CCL7:	EQUAL?	TLOC,4 \?CCL11
	ICALL2	NEW-TRAIL,3
	JUMP	?CND1
?CCL11:	ICALL2	NEW-TRAIL,6
?CND1:	CALL1	NEXT-CELL
	RSTACK	


	.FUNCT	NEXT-CELL
	ZERO?	SKEWED? \?CTR2
	RETURN	STEEP-TRAIL
?CTR2:	FCLEAR	FOG,TOUCHBIT
	RETURN	FOG


	.FUNCT	WALK-OUT-OF-FOG
	ICALL2	START-BUZZ,2
	ICALL1	SUDDEN-GUST
	PRINTI	"dissolves the fog and clears your vision."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	SUDDEN-GUST
	PRINTI	"A sudden gust of wind "
	RTRUE	


	.FUNCT	NEW-TRAIL,NEW-LOC
	FCLEAR	FOG,TOUCHBIT
	FCLEAR	STEEP-TRAIL,TOUCHBIT
	SET	'TLOC,NEW-LOC
	RETURN	TLOC


	.FUNCT	BUMP-CLIFF
	CALL2	PICK-ONE,BUMPS
	PRINT	STACK
	PRINTC	46
	CRLF	
	RFALSE	


	.FUNCT	PROB-TUMBLE
	ADD	T-PROB,10 >T-PROB
	EQUAL?	T-PROB,100 /?PRG6
	RANDOM	100
	LESS?	T-PROB,STACK /?CCL3
?PRG6:	PRINTI	"Oh, no! You lost your footing and tumbled off the cliff!"
	CALL1	BAD-ENDING
	RSTACK	
?CCL3:	CALL1	TUMBLE
	RSTACK	


	.FUNCT	TUMBLE
	PRINTI	"You'd "
	CALL2	PICK-ONE,FALLS
	PRINT	STACK
	EQUAL?	HERE,HILLTOP,LOOKOUT-HILL \?PRG8
	PRINTI	" down the hill"
	JUMP	?CND3
?PRG8:	PRINTI	" off the "
	PRINTD	CLIFF
?CND3:	ICALL1	WENT-THAT-WAY
	RFALSE	

	.ENDI