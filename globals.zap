

	.FUNCT	INIT-STATUS-LINE
	LESS?	WIDTH,38 \?CND1
	PRINTI	"[Screen too narrow.]"
	CRLF	
	QUIT	
	RTRUE	
?CND1:	SET	'OHERE,FALSE-VALUE
	SET	'OLD-LEN,0
	CLEAR	-1
	SPLIT	1
	SCREEN	S-WINDOW
	HLIGHT	H-INVERSE
	CURSET	1,1
	ICALL2	PRINT-SPACES,WIDTH
	SUB	WIDTH,16
	CURSET	1,STACK
	PRINTI	"Time: "
	HLIGHT	H-NORMAL
	SCREEN	S-TEXT
	RTRUE	


	.FUNCT	UPDATE-STATUS-LINE
	SCREEN	S-WINDOW
	HLIGHT	H-NORMAL
	HLIGHT	H-INVERSE
	EQUAL?	HERE,OHERE /?CND1
	SET	'OHERE,HERE
	DIROUT	D-TABLE-ON,SL-TABLE
	ICALL1	SAY-HERE
	DIROUT	D-TABLE-OFF
	CURSET	1,2
	ICALL2	PRINT-SPACES,OLD-LEN
	GET	SL-TABLE,0 >OLD-LEN
	CURSET	1,2
	ICALL1	SAY-HERE
?CND1:	SUB	WIDTH,10
	CURSET	1,STACK
	ICALL1	TELL-TIME
	PRINTC	32
	HLIGHT	H-NORMAL
	SCREEN	S-TEXT
	RTRUE	


	.FUNCT	PRINT-SPACES,N,AMT
?PRG1:	GRTR?	N,BLANKS-LEN \?CCL5
	SET	'AMT,BLANKS-LEN
	JUMP	?CND3
?CCL5:	SET	'AMT,N
?CND3:	PRINTT	BLANKS,AMT
	SUB	N,AMT >N
	GRTR?	N,0 /?PRG1
	RTRUE	


	.FUNCT	SAY-HERE
	ZERO?	LIT? \?PRG6
	PRINTI	"Darkness"
	RTRUE	
?PRG6:	PRINTD	HERE
	RTRUE	


	.FUNCT	BE-SPECIFIC
	PRINTI	"[Be specific: what do you want to "
	RTRUE	


	.FUNCT	TO-DO-THING-USE,STR1,STR2
	PRINTI	"[To "
	PRINT	STR1
	PRINTI	" something, use the command: "
	PRINT	STR2
	PRINTR	" THING.]"


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	PRINTI	"[This story can't understand the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	ICALL	WORD-PRINT,?TMP1,STACK
	PRINTR	""" when you use it that way.]"


	.FUNCT	DONT-UNDERSTAND
	PRINTR	"[That sentence didn't make sense. Please reword it or try something else.]"


	.FUNCT	NOT-IN-SENTENCE,STR
	PRINTI	"[There aren't "
	PRINT	STR
	PRINTR	" in that sentence.]"


	.FUNCT	GROUND-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-ON,V?EXAMINE \?CCL3
	EQUAL?	HERE,INSIDE-THEATER \?PRG9
	FSET?	GLASSES,RMUNGBIT \?PRG9
	ICALL	PERFORM,V?LOOK-UNDER,SEAT
	RTRUE	
?PRG9:	PRINT	YOU-SEE
	PRINTI	"nothing "
	CALL2	PICK-ONE,YAWNS
	PRINT	STACK
	PRINTI	" about the "
	ICALL1	GROUND-OR-FLOOR
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?LIE-DOWN,V?SIT \?CCL14
	ICALL1	V-LIE-DOWN
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?THROUGH,V?WALK-TO,V?CROSS /?CTR15
	EQUAL?	PRSA,V?ENTER \?CCL16
?CTR15:	ICALL1	V-WALK-AROUND
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?PUT-UNDER,V?LOOK-UNDER \?CCL20
	ICALL1	HOW?
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?CCL22
	EQUAL?	PRSI,GROUND,AISLE \?CCL22
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?TAKE \?CCL26
	EQUAL?	PRSI,GROUND,AISLE \?CCL26
	ICALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?CCL26:	EQUAL?	AISLE,PRSO,PRSI /FALSE
	ICALL2	YOU-DONT-NEED,GROUND
	RETURN	2


	.FUNCT	GROUND-OR-FLOOR
	FSET?	HERE,INDOORSBIT \?CCL3
	PRINTI	"floor"
	RTRUE	
?CCL3:	PRINTD	GROUND
	RTRUE	


	.FUNCT	HERE-F
	EQUAL?	PRSA,V?LOOK-DOWN,V?LOOK-INSIDE,V?EXAMINE \?CCL3
	ICALL1	V-LOOK
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?FIND \?CCL5
	PRINTR	"It's right here!"
?CCL5:	EQUAL?	PRSA,V?WALK,V?WALK-TO,V?FOLLOW /?CTR8
	EQUAL?	PRSA,V?CLIMB-ON,V?CROSS,V?LEAVE /?CTR8
	EQUAL?	PRSA,V?ENTER,V?CLIMB-DOWN,V?CLIMB-UP /?CTR8
	EQUAL?	PRSA,V?THROUGH \?CCL9
?CTR8:	ICALL1	V-WALK-AROUND
	RETURN	2
?CCL9:	EQUAL?	PRSA,V?DIG,V?LIE-DOWN,V?SIT \?CCL17
	ICALL1	WASTE-OF-TIME
	RTRUE	
?CCL17:	EQUAL?	PRSA,V?THROW,V?PUT-ON,V?PUT \?CCL19
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL19
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL19:	CALL2	TALKING-TO?,ROAD
	ZERO?	STACK \?CTR22
	EQUAL?	PRSA,V?YELL \?CCL23
?CTR22:	ICALL1	NOTHING-EXCITING
	RETURN	2
?CCL23:	ICALL	YOU-DONT-NEED,STR?32,TRUE-VALUE
	RTRUE	


	.FUNCT	WALLS-F
	FSET?	HERE,INDOORSBIT /?CCL3
	EQUAL?	HERE,INSIDE-GRAVE /?CCL3
	ICALL2	CANT-SEE-ANY,WALLS
	RETURN	2
?CCL3:	CALL1	GETTING-INTO?
	ZERO?	STACK \?PRG12
	EQUAL?	PRSA,V?LOOK-BEHIND \?CCL9
?PRG12:	CALL2	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?LOOK-UNDER \?CCL15
	PRINTR	"There's a floor there."
?CCL15:	CALL2	HURT?,WALLS
	ZERO?	STACK \?CTR18
	CALL2	MOVING?,WALLS
	ZERO?	STACK /?CCL19
?CTR18:	ICALL2	SAY-THE,WALLS
	PRINTR	" is not affected."
?CCL19:	CALL2	TALKING-TO?,WALLS
	ZERO?	STACK \?PRG28
	EQUAL?	PRSA,V?YELL \?CCL25
?PRG28:	PRINTI	"Talking to walls"
	ICALL1	SIGN-OF-COLLAPSE
	RETURN	2
?CCL25:	ICALL2	YOU-DONT-NEED,WALLS
	RETURN	2


	.FUNCT	CEILING-F
	FSET?	HERE,INDOORSBIT /?CCL3
	ICALL2	CANT-SEE-ANY,CEILING
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?LOOK-UNDER \?CCL7
	ICALL1	V-LOOK
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \FALSE
	EQUAL?	HERE,UNDER-CELL \?CCL12
	ICALL	PERFORM,V?EXAMINE,HIDDEN-HATCH
	RTRUE	
?CCL12:	EQUAL?	HERE,ON-BRIDGE \FALSE
	PRINTR	"The bridge is covered by a roof."


	.FUNCT	ME-F,CONTEXT,OLIT
	EQUAL?	PRSA,V?ALARM \?CCL3
	PRINTR	"You're already wide awake."
?CCL3:	CALL2	TALKING-TO?,ME
	ZERO?	STACK \?CTR6
	EQUAL?	PRSA,V?YELL \?CCL7
?CTR6:	ICALL1	TALK-TO-SELF
	RETURN	2
?CCL7:	EQUAL?	PRSA,V?LISTEN \?CCL13
	PRINT	CANT
	PRINTR	" help doing that."
?CCL13:	EQUAL?	PRSA,V?GIVE \?CCL17
	EQUAL?	PRSI,ME \?CCL17
	CALL2	ULTIMATELY-IN?,PRSO
	ZERO?	STACK /?CCL22
	PRINTR	"You already have it."
?CCL22:	ICALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?CCL17:	EQUAL?	PRSA,V?KILL \?CCL26
	PRINTR	"Desperate? Call the Samaritans."
?CCL26:	EQUAL?	PRSA,V?FIND \?CCL30
	PRINTR	"You're right here!"
?CCL30:	CALL2	HURT?,ME
	ZERO?	STACK /FALSE
	PRINTR	"Punishing yourself that way won't help matters."


	.FUNCT	TALK-TO-SELF
	PRINTI	"Talking to yourself"
	ICALL1	SIGN-OF-COLLAPSE
	CALL1	PCLEAR
	RSTACK	


	.FUNCT	SIGN-OF-COLLAPSE
	PRINTR	" is said to be a sign of impending mental collapse."


	.FUNCT	GLOBAL-ROOM-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?LOOK \?CCL3
	ICALL1	V-LOOK
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?DROP,V?THROUGH,V?ENTER /?CTR4
	EQUAL?	PRSA,V?EXIT \?CCL5
?CTR4:	ICALL1	V-WALK-AROUND
	RETURN	2
?CCL5:	EQUAL?	PRSA,V?WALK-AROUND \FALSE
	PRINTR	"Walking around the area reveals nothing new.

[If you want to go somewhere, just type a direction.]"


	.FUNCT	ALREADY-IN,PLACE,NOT?
	PRINTI	"But you're "
	ZERO?	NOT? /?PRG8
	PRINTI	"not"
	JUMP	?PRG10
?PRG8:	PRINTI	"already"
?PRG10:	PRINTI	" in "
	ICALL	ARTICLE,PLACE,TRUE-VALUE
	PRINTD	PLACE
	PRINTR	"!"


	.FUNCT	UPDATE-SCORE,POINTS
	ADD	SCORE,POINTS >SCORE
	EQUAL?	NOTIFYING?,2 /FALSE
	PRINTI	"[Your score just went "
	GRTR?	POINTS,-1 \?PRG10
	PRINTI	"up"
	JUMP	?PRG12
?PRG10:	PRINTI	"DOWN"
?PRG12:	PRINTI	" by "
	LESS?	POINTS,0 \?CCL16
	SUB	0,POINTS
	JUMP	?CND14
?CCL16:	PUSH	POINTS
?CND14:	PRINTN	STACK
	PRINTI	" point"
	EQUAL?	POINTS,1,-1 /?PRG21
	PRINTC	115
?PRG21:	PRINTI	"! Your total score is "
	PRINTN	SCORE
	PRINTI	" out of 100.]"
	CRLF	
	ZERO?	SOUND-ENABLED? /?CND23
	GRTR?	POINTS,-1 \?CCL27
	SOUND	S-BEEP
	JUMP	?CND23
?CCL27:	SOUND	S-BOOP
?CND23:	ZERO?	NOTIFYING? \TRUE
	SET	'NOTIFYING?,1
	CRLF	
	PRINTR	"[NOTE: You can turn score notification on or off at any time with the NOTIFY command.]"


	.FUNCT	GO-INSIDE
	PRINTR	"Why not go inside and look around?"


	.FUNCT	CANT-MAKE-OUT-ANYTHING
	PRINT	CANT
	PRINTR	" make out anything inside."


	.FUNCT	OBJECT-IS-LOCKED
	PRINT	CANT
	PRINTR	" do that. It's locked."


	.FUNCT	CANT-SEE-ANY,THING,STRING?
	ICALL1	YOU-CANT-SEE
	ZERO?	STRING? /?CCL3
	PRINT	THING
	JUMP	?PRG16
?CCL3:	ZERO?	THING /?PRG14
	FSET?	THING,NARTICLEBIT /?PRG12
	PRINTI	"any "
?PRG12:	PRINTD	THING
	JUMP	?PRG16
?PRG14:	PRINTI	"that"
?PRG16:	PRINTR	" here!"


	.FUNCT	YOU-CANT-SEE
	SET	'CLOCK-WAIT,TRUE-VALUE
	ICALL1	PCLEAR
	PRINT	CANT
	PRINTI	" see "
	RTRUE	


	.FUNCT	HOW-WOULD-YOU-LIKE-IT,OBJ
	PRINTI	"How would you like it if somebody did that to YOUR "
	PRINTD	OBJ
	PRINTR	"?"


	.FUNCT	SIGN-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?CCL3
	EQUAL?	HERE,HILLTOP \?CCL6
	PRINTI	"There are two arrows on the signpost. The arrow pointing west says ""To Cemetery."" The east arrow is marked ""To"
	ICALL1	WHICH-TOWN
	PRINTR	"."""
?CCL6:	EQUAL?	HERE,ROTARY-WEST \?CCL12
	ICALL2	SAY-THE,SIGN
	PRINTI	" over the "
	PRINTD	ENTRANCE
	PRINTI	" says, """
	ZERO?	SKEWED? /?PRG20
	PRINTI	"Witchville"
	JUMP	?PRG22
?PRG20:	PRINTI	"Festeron"
?PRG22:	PRINTR	" Police Headquarters."""
?CCL12:	EQUAL?	HERE,NORTH-OF-BRIDGE \?CCL25
	ZERO?	SKEWED? /?CCL28
	PRINTR	"The childlike scrawl is hard to decipher. With a little imagination, you can make out the phrase ""Toll Bridge, One Gold Coin."""
?CCL28:	ICALL2	CANT-SEE-ANY,SIGN
	RTRUE	
?CCL25:	EQUAL?	HERE,CLIFF-EDGE \?CCL32
	ICALL1	DESCRIBE-SIGN
	RTRUE	
?CCL32:	EQUAL?	HERE,PLEASURE-WHARF \?CCL34
	PRINTR	"The neon sign says, ""VIDEO GAMES."""
?CCL34:	EQUAL?	HERE,EDGE-OF-LAKE \?CCL38
	ICALL	PERFORM,V?READ,SAND
	RTRUE	
?CCL38:	EQUAL?	HERE,GRUE-NEST \?CCL40
	ICALL	PERFORM,V?EXAMINE,REFRIGERATOR
	RTRUE	
?CCL40:	EQUAL?	HERE,VIDEO-ARCADE \?CCL42
	ICALL1	ARCADE-SIGN
	RTRUE	
?CCL42:	EQUAL?	HERE,CIRCULATION-DESK \?CCL44
	ICALL2	SAY-THE,SIGN
	PRINTI	" over the hall says, ""To "
	PRINTD	MUSEUM
	PRINTR	"."""
?CCL44:	EQUAL?	HERE,MUSEUM \FALSE
	ICALL1	SAY-DCASE-SIGN
	RTRUE	
?CCL3:	CALL2	HURT?,SIGN
	ZERO?	STACK \?CTR49
	EQUAL?	PRSA,V?PUT,V?RUB,V?TAKE /?CTR49
	EQUAL?	PRSA,V?MOVE,V?PUSH \?CCL50
?CTR49:	ICALL1	WASTE-OF-TIME
	RTRUE	
?CCL50:	ICALL2	YOU-DONT-NEED,SIGN
	RETURN	2


	.FUNCT	CANT-FIT-INTO?,PLACE
	IN?	BRANCH,PROTAGONIST \?CCL3
	ICALL	NEVER-GET-IN,PLACE,STR?33
	RTRUE	
?CCL3:	IN?	UMBRELLA,PROTAGONIST \?CCL5
	FSET?	UMBRELLA,OPENBIT \?CCL5
	ICALL	NEVER-GET-IN,PLACE,STR?34
	RTRUE	
?CCL5:	CALL2	WEIGHT,PROTAGONIST
	GRTR?	STACK,18 \FALSE
	ICALL	NEVER-GET-IN,PLACE,STR?35
	RTRUE	


	.FUNCT	NEVER-GET-IN,PLACE,THING
	PRINTI	"You'll never get into the "
	PRINT	PLACE
	PRINTI	" holding "
	PRINT	THING
	PRINTR	"!"


	.FUNCT	GET-INTO,PLACE
	PRINTI	"With great effort, you manage to squeeze yourself into the "
	PRINT	PLACE
	PRINTC	46
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	NOT-LIQUID
	CALL2	ITS-NOT-A,STR?36
	RSTACK	


	.FUNCT	NOT-SOLID
	CALL2	ITS-NOT-A,STR?37
	RSTACK	


	.FUNCT	ITS-NOT-A,STR
	PRINTI	"It's not a "
	PRINT	STR
	PRINTR	"."


	.FUNCT	COME-TO-SENSES
	ICALL1	CARRIAGE-RETURNS
	SET	'BROOM-SIT?,FALSE-VALUE
	PRINTI	"You come to your senses empty-handed and aching all over."
	CRLF	
	CRLF	
	ICALL1	V-LOOK
	ICALL1	I-LUCK
	CALL1	I-GLOW
	RSTACK	


	.FUNCT	PROBABLY-DROWN-IN-RIVER
	ICALL2	PROBABLY-DROWN,TRUE-VALUE
	RFALSE	


	.FUNCT	PROBABLY-DROWN,RIVER?
	PRINTI	"You'd probably drown in the "
	ZERO?	RIVER? /?CCL5
	PRINTD	RIVER
	JUMP	?CND3
?CCL5:	EQUAL?	HERE,WHARF,TIDAL-POOL,FESTERON-POINT \?CCL7
	PRINTD	BAY
	JUMP	?CND3
?CCL7:	EQUAL?	HERE,EDGE-OF-LAKE,RIVER-OUTLET,ISLAND \?CCL9
	PRINTD	LAKE
	JUMP	?CND3
?CCL9:	EQUAL?	HERE,PARK \?CCL11
	PRINTD	FOUNTAIN
	JUMP	?CND3
?CCL11:	EQUAL?	HERE,HILLTOP \?CCL13
	ZERO?	SKEWED? /?CCL13
	PRINTD	MOAT
	JUMP	?CND3
?CCL13:	PRINTD	RIVER
?CND3:	ICALL1	WENT-THAT-WAY
	RFALSE	


	.FUNCT	WENT-THAT-WAY
	PRINTR	" if you went that way."


	.FUNCT	WATER-DIRTY
	PRINTR	"Better not. The water might be dirty."


	.FUNCT	HANDLE-WATER?
	CALL1	GETTING-INTO?
	ZERO?	STACK /?CCL3
	ICALL1	PROBABLY-DROWN
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TASTE,V?DRINK \?CCL5
	ICALL1	WATER-DIRTY
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?BITE,V?EAT \?CCL7
	ICALL1	NOT-SOLID
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?PUT-UNDER,V?PUT-ON,V?PUT /?PRD11
	EQUAL?	PRSA,V?THROW \?CCL9
?PRD11:	EQUAL?	PRSI,BAY,RIVER,LAKE /?CTR8
	EQUAL?	PRSI,MOAT \?CCL9
?CTR8:	REMOVE	PRSO
	PRINTI	"Splash!"
	CRLF	
	CRLF	
	EQUAL?	PRSO,HORSE,DHORSE \?CCL20
	CALL2	ENABLED?,I-HORSE-DEATH
	ZERO?	STACK /?CND21
	CALL2	INT,I-HORSE-DEATH
	PUT	STACK,0,0
?CND21:	ICALL2	SAY-THE,PRSO
	PRINTI	" floats without moving for a few anxious moments. Then it "
	EQUAL?	PRSO,DHORSE \?CCL27
	PRINTI	"sinks slowly into the dark water"
	JUMP	?PRG32
?CCL27:	SET	'HORSE-SAVED?,TRUE-VALUE
	PRINTI	"springs suddenly to life, circling and splashing joyfully in the waves. Before it swims away it looks up at you with an unmistakable expression of gratitude"
?PRG32:	PRINTR	"."
?CCL20:	EQUAL?	PRSO,CANDLE \?PRG42
	FSET?	CANDLE,ONBIT \?PRG42
	PRINTI	"Weird! "
	ICALL2	SAY-THE,CANDLE
	PRINTI	" remains lit even as it"
	ICALL1	SINKS-INTO-WATER
	RTRUE	
?PRG42:	PRINTI	"Silently, "
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTD	PRSO
	ICALL1	SINKS-INTO-WATER
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?PUSH-TO \?CCL47
	EQUAL?	PRSI,BAY,RIVER,LAKE /?CTR46
	EQUAL?	PRSI,MOAT \?CCL47
?CTR46:	CALL2	ULTIMATELY-IN?,PRSO
	ZERO?	STACK /?CCL54
	ICALL	PRESUMABLY-YOU-WANT-TO,STR?38,PRSI
	ICALL	PERFORM,V?PUT,PRSO,PRSI
	RTRUE	
?CCL54:	IN?	PRSO,HERE \?CCL56
	FSET?	PRSO,TAKEBIT \?CCL56
	MOVE	PRSO,PROTAGONIST
	PRINTI	"[with your foot]"
	CRLF	
	ICALL	PERFORM,V?PUT,PRSO,PRSI
	RTRUE	
?CCL56:	ICALL1	V-PUSH-TO
	RTRUE	
?CCL47:	CALL1	SEE-VERB?
	ZERO?	STACK /?CCL62
	PRINTR	"The water is too deep to see much of anything."
?CCL62:	ICALL	YOU-DONT-NEED,STR?39,TRUE-VALUE
	RETURN	2


	.FUNCT	SINKS-INTO-WATER
	PRINTI	" disappears beneath the surface of "
	ICALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTD	PRSI
	PRINTR	"."


	.FUNCT	YOU-ARE-HOLDING,THING,AGAIN
	ICALL2	THIS-IS-IT,THING
	CRLF	
	CRLF	
	PRINTI	"[You are "
	ZERO?	AGAIN /?PRG8
	PRINTI	"again"
	JUMP	?PRG10
?PRG8:	PRINTI	"now"
?PRG10:	PRINTI	" holding "
	ICALL	ARTICLE,THING,AGAIN
	PRINTD	THING
	PRINTI	".]"
	RTRUE	


	.FUNCT	NOTHING-EXCITING
	PRINTR	"Nothing exciting happens."


	.FUNCT	THAT-WAS-CLOSE
	PRINTR	"Whew! That was close."


	.FUNCT	GOOD-PLACE-TO-SAVE
	CRLF	
	PRINTR	"[This might be a good time to SAVE your story position.]"


	.FUNCT	HOW?
	PRINTR	"How do you intend to do that?"


	.FUNCT	CORNER-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?LOOK-ON,V?EXAMINE \?CCL3
	ICALL1	V-LOOK
	RTRUE	
?CCL3:	CALL1	GETTING-INTO?
	ZERO?	STACK /?CCL5
	PRINTI	"You're close enough to the "
	PRINTD	CORNER
	PRINTR	" already."
?CCL5:	ICALL2	YOU-DONT-NEED,CORNER
	RETURN	2


	.FUNCT	TOO-FAR-AWAY,OBJ
	ICALL1	UNFORTUNATELY
	ICALL	ARTICLE,OBJ,TRUE-VALUE
	PRINTD	OBJ
	PRINTR	" is too far away for you to do that."


	.FUNCT	UNFORTUNATELY
	PRINTI	"Unfortunately, "
	RTRUE	


	.FUNCT	EXCELLENT-VIEW,OBJ
	ICALL2	SAY-THE,OBJ
	PRINTR	" affords an excellent view of the surrounding area."


	.FUNCT	ALREADY-AT,OBJ,TOP?
	PRINTI	"You're already at the "
	ZERO?	TOP? /?PRG8
	PRINTI	"top"
	JUMP	?PRG10
?PRG8:	PRINTI	"bottom"
?PRG10:	PRINTI	" of the "
	PRINTD	OBJ
	PRINTR	"!"


	.FUNCT	LOITERING-ON,OBJ
	PRINTI	"There's no reason to loiter around the "
	PRINTD	OBJ
	PRINTR	"."


	.FUNCT	PRESUMABLY-YOU-WANT-TO,STR,THING
	PRINT	I-ASSUME
	PRINTC	32
	PRINT	STR
	PRINTC	32
	ZERO?	THING /?PRG8
	ICALL	ARTICLE,THING,TRUE-VALUE
	PRINTD	THING
	JUMP	?PRG10
?PRG8:	PRINTI	"it"
?PRG10:	PRINTR	".]"


	.FUNCT	MAKE-IT-SNAPPY
	PRINTI	" If you want to make a wish, you'd better make it snappy!)"
	RTRUE	


	.FUNCT	HOLD-YOUR-PEACE
	PRINTI	" Wish now, or forever hold your peace!)"
	RTRUE	


	.FUNCT	IT-IGNORES-YOU,WHO
	ICALL2	SAY-THE,WHO
	PRINTC	32
	CALL2	PICK-ONE,IGNORANCE
	PRINT	STACK
	PRINTR	"."


	.FUNCT	SOUND-F
	EQUAL?	PRSA,V?LISTEN \?CCL3
	EQUAL?	HERE,INSIDE-THEATER \?CCL6
	EQUAL?	MOVIE-SCRIPT,6 /?CTR8
	ZERO?	ECLIPSE? /?PRG12
?CTR8:	ICALL1	BLANK-SCREEN
	RTRUE	
?PRG12:	PRINTR	"The soundtrack is an artless mix of Witchville slogans and John Philip Sousa marches, played at earsplitting volume."
?CCL6:	EQUAL?	HERE,LOBBY \?CCL15
	LESS?	MOVIE-SCRIPT,6 \?CCL15
	ZERO?	ECLIPSE? \?CCL15
	PRINT	YOU-HEAR
	PRINTI	"a blare of noise coming from inside the "
	PRINTD	MOVIE-THEATER
	JUMP	?PRG50
?CCL15:	EQUAL?	HERE,HILLTOP \?CCL22
	FSET?	ENVELOPE,RMUNGBIT /?CCL22
	PRINTI	"Uh-oh! The calling voice belongs to"
	ICALL1	BOSS
	PRINTR	"!"
?CCL22:	EQUAL?	HERE,MUSEUM \?CCL30
	CALL2	ENABLED?,I-PLEA
	ZERO?	STACK /?CCL30
	PRINTI	"The voice sounds just like the "
	PRINTD	OLD-WOMAN
	PRINTI	" you met at the "
	PRINTD	MAGICK-SHOPPE
	JUMP	?PRG50
?CCL30:	EQUAL?	HERE,INSIDE-SHOPPE \?CCL36
	FSET?	CLOCK,RMUNGBIT \?CCL36
	ICALL	PERFORM,V?LISTEN,CLOCK
	RTRUE	
?CCL36:	EQUAL?	HERE,JAIL-CELL \?PRG48
	LESS?	JAIL-SCRIPT,9 \?CCL43
	PRINTI	"The "
	ICALL1	EVIL-VOICES
	PRINTR	" don't sound very friendly."
?CCL43:	ICALL1	HEAR-WAILS
	RTRUE	
?PRG48:	PRINTI	"At the moment, you hear nothing "
	CALL2	PICK-ONE,YAWNS
	PRINT	STACK
?PRG50:	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?WALK-TO,V?FOLLOW \?CCL53
	ICALL1	V-WALK-AROUND
	RTRUE	
?CCL53:	EQUAL?	PRSA,V?WAIT-FOR \?CCL55
	ICALL1	V-WAIT
	RTRUE	
?CCL55:	EQUAL?	PRSA,V?REPLY \?CCL57
	EQUAL?	HERE,HILLTOP \?CCL57
	FSET?	ENVELOPE,RMUNGBIT /?CCL57
	PRINTR	"You'll have to go inside to do that."
?CCL57:	CALL2	TALKING-TO?,SOUND
	ZERO?	STACK \?PRG67
	EQUAL?	PRSA,V?YELL \?PRG71
?PRG67:	PRINTI	"Try addressing the source of the sound."
	CRLF	
	RETURN	2
?PRG71:	PRINT	CANT
	ICALL1	DO-TO
	PRINTI	"a "
	PRINTD	SOUND
	PRINTR	"!"


	.FUNCT	TOO-LARGE,THING,SMALL?
	ICALL2	BUT-THE,THING
	PRINTI	"is much too "
	ZERO?	SMALL? /?PRG8
	PRINTI	"small"
	JUMP	?PRG10
?PRG8:	PRINTI	"large"
?PRG10:	PRINTR	"!"


	.FUNCT	FROBOZZ,STR
	PRINTI	"Frobozz Magic "
	PRINT	STR
	PRINTI	" Company"
	RTRUE	


	.FUNCT	NOT-LIKELY,THING,STR
	PRINTI	"It"
	CALL2	PICK-ONE,LIKELIES
	PRINT	STACK
	PRINTI	" that "
	ICALL	ARTICLE,THING,TRUE-VALUE
	PRINTD	THING
	PRINTC	32
	PRINT	STR
	PRINTR	"."


	.FUNCT	YOUD-HAVE-TO,STR,THING
	PRINTI	"You'd have to "
	PRINT	STR
	PRINTC	32
	ICALL	ARTICLE,THING,TRUE-VALUE
	PRINTD	THING
	PRINTR	" to do that."


	.FUNCT	CLOSED-AND-LOCKED
	PRINTR	" closed and locked."


	.FUNCT	STANDING
	PRINTI	"You're standing "
	RTRUE	


	.FUNCT	DO-TO
	PRINTI	" do that to "
	RTRUE	


	.FUNCT	INTRO
	PRINTI	"""Behind you!"" cries the Princess. ""It's a trap!""

Too late. The "
	PRINTD	DRAWBRIDGE
	PRINTI	" crashes shut against the "
	PRINTD	TOWER
	PRINTI	" wall. You turn to face your enemy, and find yourself staring into the open maw of"
	RTRUE	


	.FUNCT	FIRED,TIMEOUT?
	CRLF	
	PRINTI	"""There you are, "
	CALL2	PICK-ONE,INSULTS
	PRINT	STACK
	PRINTI	"!""

You wince as "
	PRINTD	CRISP
	PRINTI	" strides into view and grabs you by the front of your uniform.

""You good-for-nothing "
	CALL2	PICK-ONE,INSULTS
	PRINT	STACK
	PRINTI	"!"" he bellows in your face. ""I wanted you to "
	ZERO?	TIMEOUT? /?PRG8
	PRINTI	"deliver that envelope BEFORE five o'clock! Now the "
	PRINTD	MAGICK-SHOPPE
	PRINTI	" is closed... and y"
	JUMP	?PRG10
?PRG8:	PRINTI	"get back to the "
	PRINTD	POST-OFFICE
	PRINTI	" as soon as you were done with that envelope! Y"
?PRG10:	PRINTI	"ou're FIRED!"""
	CALL1	BAD-ENDING
	RSTACK	


	.FUNCT	SAY-HURRY
	CRLF	
	PRINTI	"(It's "
	ICALL1	TELL-TIME
	PRINTI	". Better hurry! "
	RTRUE	


	.FUNCT	BETTER-HURRY,HALF?
	ICALL1	SAY-HURRY
	ICALL2	SAY-THE,MAGICK-SHOPPE
	PRINTI	" closes in less than "
	ZERO?	HALF? /?PRG7
	PRINTI	"half "
?PRG7:	PRINTR	"an hour!)"

	.ENDI
