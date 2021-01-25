

	.FUNCT	TOMBS-BLOCK
	ICALL2	THIS-IS-IT,MONUMENTS
	ICALL2	SAY-THE,MONUMENTS
	PRINTI	"s block your path."
	CRLF	
	RFALSE	


	.FUNCT	CREEPY-CORNER-F,CONTEXT
	EQUAL?	CONTEXT,M-LOOK \FALSE
	PRINTI	"You're in a creepy "
	PRINTD	CORNER
	PRINTI	" of the"
	ICALL2	WHICH-TOWN,STR?169
	PRINTI	", surrounded by silent "
	PRINTD	MONUMENTS
	PRINTI	"s. A"
	FSET?	SOUTH-GATE,OPENBIT \?PRG13
	PRINTI	"n iron gate opens"
	JUMP	?PRG15
?PRG13:	PRINTI	" closed iron gate stands"
?PRG15:	PRINTC	32
	CALL1	TO-E
	PRINT	STACK
	PRINTR	", and a narrow lane wanders north."


	.FUNCT	EXIT-TO-OUTSIDE
	FSET?	SOUTH-GATE,OPENBIT \?CCL3
	ZERO?	SKEWED? /?CCL6
	ICALL1	SLAM-THE-GATE
	RFALSE	
?CCL6:	ICALL1	SURE-IS-SPOOKY
	RETURN	OUTSIDE-CEMETERY
?CCL3:	ICALL2	ITS-CLOSED,SOUTH-GATE
	RFALSE	


	.FUNCT	SURE-IS-SPOOKY
	PRINTI	"Whew! That "
	PRINTD	CEMETERY
	PRINTI	" sure is spooky."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	SPOOKY-COPSE-F,CONTEXT
	EQUAL?	CONTEXT,M-LOOK \FALSE
	PRINTI	"A copse of "
	PRINTD	WILLOWS
	PRINTI	"s makes this part of the "
	PRINTD	CEMETERY
	PRINTI	" look really spooky. Narrow lanes wander south and west.

There's an "
	PRINTD	OPEN-GRAVE
	PRINTI	" nearby, freshly dug, with a "
	PRINTD	MONUMENTS
	PRINTI	" erected next to it."
	IN?	GRAVEDIGGER,SPOOKY-COPSE \?CND6
	CRLF	
	CRLF	
	PRINTI	"An old "
	PRINTD	GRAVEDIGGER
	PRINTI	" is resting under a "
	PRINTD	WILLOWS
	PRINTR	"."
?CND6:	CRLF	
	RTRUE	


	.FUNCT	EXIT-TO-LAKE
	FSET?	NORTH-GATE,OPENBIT \?CCL3
	ZERO?	SKEWED? /?CCL6
	ICALL1	ESCAPE-VAPORS
	RETURN	EDGE-OF-LAKE
?CCL6:	ICALL1	SURE-IS-SPOOKY
	RETURN	EDGE-OF-LAKE
?CCL3:	ICALL2	ITS-CLOSED,NORTH-GATE
	RFALSE	


	.FUNCT	RETURN-TO-COPSE
	IN?	GRAVEDIGGER,EDGE-OF-LAKE /?CCL2
	RETURN	SPOOKY-COPSE
?CCL2:	REMOVE	GRAVEDIGGER
	RETURN	SPOOKY-COPSE


	.FUNCT	TWILIGHT-GLEN-F,CONTEXT
	EQUAL?	CONTEXT,M-LOOK \FALSE
	PRINTI	"The trees here are so thick, it's almost too dark to see! You can make out a"
	ICALL	OPEN-CLOSED,NORTH-GATE,TRUE-VALUE
	PRINTD	NORTH-GATE
	PRINTC	32
	CALL1	TO-N
	PRINT	STACK
	PRINTI	", and a narrow lane between the "
	PRINTD	MONUMENTS
	PRINTI	"s winds off "
	CALL1	TO-E
	PRINT	STACK
	PRINTR	"."


	.FUNCT	NORTH-GATE-F
	ICALL2	THIS-IS-IT,NORTH-GATE
	EQUAL?	PRSA,V?WALK-TO,V?THROUGH,V?ENTER /?CTR2
	EQUAL?	PRSA,V?USE \?CCL3
?CTR2:	EQUAL?	HERE,TWILIGHT-GLEN \?CCL8
	ICALL2	DO-WALK,P?NORTH
	RTRUE	
?CCL8:	ICALL2	DO-WALK,P?SOUTH
	RTRUE	
?CCL3:	CALL2	GENERIC-GATE?,NORTH-GATE
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	WALL-OF-DIRT
	PRINTI	"You just walked into a wall of dirt."
	CRLF	
	RFALSE	


	.FUNCT	ENTER-HOLE?
	ZERO?	SKEWED? \?CCL3
	ICALL1	CANT-GO
	RFALSE	
?CCL3:	CALL2	CANT-FIT-INTO?,STR?204
	ZERO?	STACK \FALSE
	ICALL	MOVE-ALL,INSIDE-GRAVE,OPEN-GRAVE
	MOVE	GRAVE,INSIDE-GRAVE
	RETURN	TUNNEL-FORK


	.FUNCT	ENTER-GRAVE
	CALL2	CANT-FIT-INTO?,STR?285
	ZERO?	STACK \FALSE
	ZERO?	SKEWED? /?CCL5
	ICALL1	ESCAPE-VAPORS
?CND1:	ICALL	MOVE-ALL,OPEN-GRAVE,INSIDE-GRAVE
	RETURN	INSIDE-GRAVE
?CCL5:	IN?	GRAVEDIGGER,SPOOKY-COPSE \?CND1
	ICALL2	SAY-THE,GRAVEDIGGER
	PRINTI	" reaches into the "
	PRINTD	OPEN-GRAVE
	PRINTI	" and pulls you out. ""Don't go in there!"" he cries. ""You might get buried alive!"""
	CRLF	
	RFALSE	


	.FUNCT	ESCAPE-VAPORS
	CALL2	INT,I-VAPORS
	PUT	STACK,0,0
	FCLEAR	VAPORS,RMUNGBIT
	EQUAL?	DIGGER-SCRIPT,1,0 \?CCL3
	EQUAL?	HERE,SPOOKY-COPSE /?CCL3
	CALL1	SURE-IS-SPOOKY
	RSTACK	
?CCL3:	ICALL2	SAY-THE,VAPORS
	PRINTI	"s "
	CALL2	PICK-ONE,VAPOR-YELLS
	PRINT	STACK
	PRINTI	" as you escape their misty clutches."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	GRAVE-TO-COPSE
	IN?	BRANCH,PROTAGONIST \?CCL3
	ICALL2	NEVER-GET-OUT-WITH,STR?33
	RFALSE	
?CCL3:	IN?	UMBRELLA,PROTAGONIST \?CCL5
	FSET?	UMBRELLA,OPENBIT \?CCL5
	ICALL2	NEVER-GET-OUT-WITH,STR?34
	RFALSE	
?CCL5:	CALL2	WEIGHT,PROTAGONIST
	GRTR?	STACK,18 \?PRG10
	ICALL2	NEVER-GET-OUT-WITH,STR?289
	RFALSE	
?PRG10:	PRINTI	"With great difficulty, you manage to climb out of the "
	PRINTD	OPEN-GRAVE
	PRINTC	46
	CRLF	
	CRLF	
	ZERO?	SKEWED? /?CND12
	SET	'DIGGER-SCRIPT,0
	CALL	QUEUE,I-VAPORS,-1
	PUT	STACK,0,1
?CND12:	ICALL	MOVE-ALL,INSIDE-GRAVE,OPEN-GRAVE
	MOVE	GRAVE,INSIDE-GRAVE
	RETURN	SPOOKY-COPSE


	.FUNCT	NEVER-GET-OUT-WITH,STR
	PRINTI	"You'll never climb out of the "
	PRINTD	OPEN-GRAVE
	PRINTI	" holding "
	PRINT	STR
	PRINTR	"!"


	.FUNCT	ARE-YOU-SURE?
	EQUAL?	HERE,OUTSIDE-CEMETERY \?CCL3
	FSET?	SOUTH-GATE,OPENBIT \?CCL6
	CALL1	BE-SURE
	ZERO?	STACK /FALSE
	ZERO?	SKEWED? \?CTR11
	RETURN	CREEPY-CORNER
?CTR11:	ICALL1	SLAM-THE-GATE
	RFALSE	
?CCL6:	ICALL2	ITS-CLOSED,SOUTH-GATE
	RFALSE	
?CCL3:	EQUAL?	HERE,EDGE-OF-LAKE \FALSE
	FSET?	NORTH-GATE,OPENBIT \?CCL17
	CALL1	BE-SURE
	ZERO?	STACK /FALSE
	RETURN	TWILIGHT-GLEN
?CCL17:	ICALL2	ITS-CLOSED,NORTH-GATE
	RFALSE	


	.FUNCT	BE-SURE
	ICALL2	SAY-THE,CEMETERY
	PRINTI	" is a "
	CALL2	PICK-ONE,FRIGHTS
	PRINT	STACK
	PRINTI	" place"
	ZERO?	SKEWED? /?PRG7
	PRINTI	", especially at night"
?PRG7:	PRINTI	". "
	ICALL1	SAY-SURE
	PRINTI	"go in there?"
	CALL1	YES?
	ZERO?	STACK /?CCL13
	ZERO?	SKEWED? /?PRG16
	SET	'DIGGER-SCRIPT,0
	CALL	QUEUE,I-VAPORS,-1
	PUT	STACK,0,1
?PRG16:	CRLF	
	PRINTI	"You have been warned."
	CRLF	
	CRLF	
	RTRUE	
?CCL13:	ICALL1	THAT-WAS-CLOSE
	RFALSE	


	.FUNCT	SLAM-THE-GATE
	FCLEAR	SOUTH-GATE,OPENBIT
	FSET	SOUTH-GATE,LOCKEDBIT
	PRINTI	"Clang! "
	ICALL1	SUDDEN-GUST
	PRINTI	"blows the "
	PRINTD	SOUTH-GATE
	PRINTI	" shut in your face."
	CRLF	
	CRLF	
	PRINT	YOU-HEAR
	PRINTI	"misty voices giggling "
	EQUAL?	HERE,OUTSIDE-CEMETERY \?PRG10
	PRINTI	"on the other side"
	JUMP	?PRG12
?PRG10:	PRINTI	"all around you"
?PRG12:	PRINTR	", and a loud ""click"" as the gate locks."


	.FUNCT	CEMETERY-F
	EQUAL?	PRSA,V?FIND,V?LOOK-INSIDE,V?EXAMINE \?CCL3
	CALL1	IN-CEMETERY?
	ZERO?	STACK \TRUE
	EQUAL?	HERE,OUTSIDE-CEMETERY \?CCL8
	ICALL2	SEE-IT,STR?293
	RTRUE	
?CCL8:	EQUAL?	HERE,EDGE-OF-LAKE \?CCL10
	ICALL2	SEE-IT,STR?294
	RTRUE	
?CCL10:	ICALL1	REFER-TO-MAP
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?ENTER,V?THROUGH,V?WALK-TO \FALSE
	CALL1	IN-CEMETERY?
	ZERO?	STACK \TRUE
	EQUAL?	HERE,OUTSIDE-CEMETERY \?CCL17
	ICALL2	DO-WALK,P?WEST
	RTRUE	
?CCL17:	EQUAL?	HERE,EDGE-OF-LAKE \?CCL19
	ICALL2	DO-WALK,P?SOUTH
	RTRUE	
?CCL19:	ICALL1	REFER-TO-MAP
	RTRUE	


	.FUNCT	IN-CEMETERY?
	EQUAL?	HERE,CREEPY-CORNER,SPOOKY-COPSE,TWILIGHT-GLEN \FALSE
	PRINTR	"It's all around you!"


	.FUNCT	SEE-IT,STR
	PRINT	YOU-SEE
	PRINTI	"it to the "
	PRINT	STR
	PRINTR	"."


	.FUNCT	MONUMENTS-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?CCL3
	EQUAL?	HERE,SPOOKY-COPSE \?PRG14
	ICALL2	SAY-THE,MONUMENTS
	PRINTI	" next to the "
	PRINTD	OPEN-GRAVE
	ZERO?	SKEWED? /?PRG12
	ICALL1	HAS-YOUR-NAME
	RTRUE	
?PRG12:	PRINTR	" is blank."
?PRG14:	PRINTI	"The lettering"
	ICALL1	TOO-FADED
	RTRUE	
?CCL3:	CALL2	MOVING?,MONUMENTS
	ZERO?	STACK /FALSE
	ICALL2	TOO-LARGE,MONUMENTS
	RTRUE	


	.FUNCT	TOO-FADED
	PRINTR	" is too faded to read clearly."


	.FUNCT	IN-OPEN-GRAVE,CONTEXT
	EQUAL?	CONTEXT,M-CONT \FALSE
	CALL2	TOUCHING?,PRSO
	ZERO?	STACK /FALSE
	PRINT	CANT
	PRINTI	" reach "
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTD	PRSO
	PRINTI	" from here. The "
	PRINTD	OPEN-GRAVE
	PRINTI	" is too deep."
	CRLF	
	RETURN	2


	.FUNCT	OPEN-GRAVE-F
	EQUAL?	PRSA,V?THROUGH,V?ENTER,V?WALK-TO /?CTR2
	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-DOWN \?CCL3
?CTR2:	ICALL2	DO-WALK,P?DOWN
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLIMB-UP,V?EXIT \?CCL7
	ICALL	ALREADY-IN,OPEN-GRAVE,TRUE-VALUE
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?LOOK-DOWN,V?SEARCH,V?EXAMINE /?PRG12
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL9
?PRG12:	PRINTI	"It's six feet deep and freshly dug."
	FIRST?	OPEN-GRAVE \?CND14
	PRINTC	32
	PRINT	YOU-SEE
	ICALL2	PRINT-CONTENTS,OPEN-GRAVE
	PRINTR	" inside."
?CND14:	CRLF	
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?THROW,V?PUT \?CCL21
	EQUAL?	PRSI,OPEN-GRAVE \?CCL21
	EQUAL?	PRSO,HANDS \?CCL26
	ICALL1	NOTHING-EXCITING
	RTRUE	
?CCL26:	EQUAL?	PRSO,UMBRELLA \FALSE
	FSET?	UMBRELLA,OPENBIT \FALSE
	ICALL	YOUD-HAVE-TO,STR?68,UMBRELLA
	RTRUE	
?CCL21:	CALL1	GENERIC-GRAVE?
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	GENERIC-GRAVE?
	EQUAL?	PRSA,V?DIG \?CCL3
	PRINTR	"It's deep enough already."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	ICALL1	HOW?
	RTRUE	


	.FUNCT	GRAVE-F
	EQUAL?	PRSA,V?THROUGH,V?WALK-TO,V?ENTER /?CTR2
	EQUAL?	PRSA,V?CLIMB-DOWN \?CCL3
?CTR2:	ZERO?	SKEWED? /?CCL8
	ICALL2	DO-WALK,P?NORTH
	RTRUE	
?CCL8:	ICALL2	ALREADY-AT,GRAVE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-UP,V?EXIT \?CCL10
	ICALL2	DO-WALK,P?OUT
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?SEARCH,V?EXAMINE,V?LOOK-DOWN /?CTR11
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL12
?CTR11:	ICALL1	V-LOOK
	RTRUE	
?CCL12:	EQUAL?	PRSA,V?TAKE \?CCL16
	EQUAL?	PRSI,GRAVE \?CCL16
	ICALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?THROW,V?PUT \?CCL20
	EQUAL?	PRSI,GRAVE \?CCL20
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL20:	CALL1	GENERIC-GRAVE?
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	ENTER-SPOOKY-COPSE
	ZERO?	SKEWED? \?CND1
	ZERO?	DIGGER-SCRIPT /?CCL2
	RETURN	SPOOKY-COPSE
?CCL2:	CALL	QUEUE,I-DIGGER-TALK,-1
	PUT	STACK,0,1
?CND1:	RETURN	SPOOKY-COPSE


	.FUNCT	COPSE-TO-GLEN
	IN?	GRAVEDIGGER,TWILIGHT-GLEN \?CCL3
	CALL	QUEUE,I-BYE-DIGGER,-1
	PUT	STACK,0,1
	RETURN	TWILIGHT-GLEN
?CCL3:	IN?	GRAVEDIGGER,SPOOKY-COPSE /?CCL4
	RETURN	TWILIGHT-GLEN
?CCL4:	CALL2	INT,I-DIGGER-TALK
	PUT	STACK,0,0
	CALL	QUEUE,I-DIGGER-FOLLOWS,-1
	PUT	STACK,0,1
	RETURN	TWILIGHT-GLEN


	.FUNCT	I-BYE-DIGGER
	CALL2	INT,I-BYE-DIGGER
	PUT	STACK,0,0
	CRLF	
	ICALL2	SAY-THE,GRAVEDIGGER
	PRINTI	" is locking the "
	PRINTD	NORTH-GATE
	PRINTI	" from the outside as you approach."
	CALL1	OUT-OF-TROUBLE
	RSTACK	


	.FUNCT	OUT-OF-TROUBLE
	ICALL2	THIS-IS-IT,GRAVEDIGGER
	ICALL2	THIS-IS-IT,NORTH-GATE
	MOVE	GRAVEDIGGER,EDGE-OF-LAKE
	FCLEAR	NORTH-GATE,OPENBIT
	FSET	NORTH-GATE,LOCKEDBIT
	PRINTI	" ""Keep out of the "
	PRINTD	CEMETERY
	PRINTI	" after Dark,"" he tells you with a sly wink."
	CRLF	
	CRLF	
	PRINT	YOU-HEAR
	PRINTI	"him chuckling as he disappears "
	CALL1	TO-N
	PRINT	STACK
	PRINTR	"."


	.FUNCT	I-DIGGER-FOLLOWS
	CALL2	INT,I-DIGGER-FOLLOWS
	PUT	STACK,0,0
	CRLF	
	ICALL2	SAY-THE,GRAVEDIGGER
	PRINTI	" follows behind you. "
	IN?	ENVELOPE,GRAVEDIGGER /?CTR4
	IN?	ENVELOPE,SPOOKY-COPSE \?PRG10
?CTR4:	MOVE	ENVELOPE,PROTAGONIST
	ICALL1	FORGOT
	PRINTI	" he says, handing it back to you."
	ICALL	YOU-ARE-HOLDING,ENVELOPE,TRUE-VALUE
	JUMP	?PRG12
?PRG10:	PRINTI	"""What's your hurry?"" he complains."
?PRG12:	CRLF	
	CRLF	
	PRINTI	"Throwing a shovel over his shoulder, the "
	PRINTD	GRAVEDIGGER
	PRINTI	" ambles through the "
	PRINTD	NORTH-GATE
	PRINTI	" and locks it."
	CALL1	OUT-OF-TROUBLE
	RSTACK	


	.FUNCT	FORGOT
	PRINTI	"""Hey! You forgot your envelope!"""
	RTRUE	


	.FUNCT	COPSE-TO-CORNER
	IN?	GRAVEDIGGER,SPOOKY-COPSE /?PRD4
	RETURN	CREEPY-CORNER
?PRD4:	IN?	ENVELOPE,GRAVEDIGGER /?CCL2
	IN?	ENVELOPE,SPOOKY-COPSE /?CCL2
	RETURN	CREEPY-CORNER
?CCL2:	ICALL2	SAY-THE,GRAVEDIGGER
	PRINTI	" yells, "
	ICALL1	FORGOT
	CRLF	
	CRLF	
	RETURN	CREEPY-CORNER


	.FUNCT	WILLOWS-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The droopy boughs sway eerily in the breeze."
?CCL3:	CALL1	GETTING-INTO?
	ZERO?	STACK /FALSE
	ICALL1	NO-FOOTHOLDS
	RTRUE	


	.FUNCT	NO-FOOTHOLDS
	PRINT	CANT
	PRINTR	". There aren't any good footholds."


	.FUNCT	VAPORS-F,CONTEXT
	ZERO?	SKEWED? \?CCL3
	ICALL2	CANT-SEE-ANY,VAPORS
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	ICALL2	SAY-THE,VAPORS
	PRINTR	"s stare back at you with translucent curiosity."
?CCL7:	CALL2	TOUCHING?,VAPORS
	ZERO?	STACK /?CCL11
	PRINT	CANT
	PRINTI	" touch an "
	PRINTD	VAPORS
	PRINTR	"!"
?CCL11:	CALL2	TALKING-TO?,VAPORS
	ZERO?	STACK /?CCL15
	ICALL2	SAY-THE,VAPORS
	PRINTR	"s pay no heed."
?CCL15:	EQUAL?	PRSA,V?LISTEN \?CCL19
	ICALL2	SAY-THE,VAPORS
	PRINTR	"s' voices are hard to hear, but sinister."
?CCL19:	EQUAL?	PRSA,V?THROW,V?FEED,V?GIVE \FALSE
	EQUAL?	PRSI,VAPORS \FALSE
	REMOVE	PRSO
	PRINTI	"Silently, "
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTD	PRSO
	PRINTI	" disappears into the ghostly mist."
	CRLF	
	EQUAL?	PRSO,WISHBRINGER,SHOE \TRUE
	ICALL1	I-LUCK
	RTRUE	


	.FUNCT	I-VAPORS,OBJ,NXT,DO-LUCK?
	ZERO?	FUZZY? \TRUE
	ZERO?	ECLIPSE? \TRUE
	EQUAL?	HERE,TWILIGHT-GLEN,SPOOKY-COPSE,CREEPY-CORNER \FALSE
	INC	'DIGGER-SCRIPT
	CRLF	
	EQUAL?	DIGGER-SCRIPT,1 \?CCL10
	PRINTI	"As you glance around you notice luminous ribbons of mist darting among the "
	PRINTD	MONUMENTS
	PRINTR	"s. The air is filled with sinister voices."
?CCL10:	EQUAL?	DIGGER-SCRIPT,2 \?CCL14
	FSET?	VAPORS,RMUNGBIT \?CCL17
	FIRST?	PROTAGONIST >OBJ /?BOGUS18
?BOGUS18:	ICALL2	SAY-THE,VAPORS
	ZERO?	OBJ /?PRG33
	PRINTI	"s are eyeing "
	ICALL	ARTICLE,OBJ,TRUE-VALUE
	PRINTD	OBJ
	FSET?	OBJ,WORNBIT \?PRG31
	PRINTI	" you're wearing"
	JUMP	?PRG35
?PRG31:	PRINTI	" in "
	PRINTD	HANDS
	PRINTC	115
	JUMP	?PRG35
?PRG33:	PRINTI	"s are hovering around you"
?PRG35:	PRINTI	" fiendishly"
	JUMP	?PRG41
?CCL17:	ZERO?	LUCKY? /?PRG39
	FSET	VAPORS,RMUNGBIT
	SET	'DIGGER-SCRIPT,1
?PRG39:	PRINTI	"The luminous mists suddenly condense into a cloud of "
	PRINTD	VAPORS
	PRINTI	"s! Circling like "
	PRINTD	SHARKS
	PRINTI	", they stroke your face with ghostly fingers and whisper dreadful secrets into your ears"
?PRG41:	PRINTR	"."
?CCL14:	FIRST?	PROTAGONIST >OBJ /?PRG44
?PRG44:	PRINTI	"Giggling with mischievous Glee, the "
	PRINTD	VAPORS
	PRINTI	"s "
	ZERO?	LUCKY? /?CTR47
	ZERO?	OBJ \?CCL48
?CTR47:	FCLEAR	VAPORS,RMUNGBIT
	CALL2	INT,I-VAPORS
	PUT	STACK,0,0
	PRINTI	"clutch your legs and cover your eyes with their luminous hands. "
	ICALL2	SAY-THE,GROUND
	ICALL1	BENEATH-FEET
	PRINTI	" as the foggy fiends lift you high above the treetops"
	ZERO?	OBJ /?PRG59
	PRINTI	", scatter your possessions"
?PRG59:	PRINTI	" and carry you screaming"
	ICALL1	INTO-NIGHT
	CALL2	PICK-ONE,DROP-OFFS >HERE
	MOVE	PROTAGONIST,HERE
	SET	'OHERE,FALSE-VALUE
?PRG61:	ZERO?	OBJ /?REP62
	NEXT?	OBJ >NXT /?BOGUS66
?BOGUS66:	FCLEAR	OBJ,WORNBIT
	CALL2	PICK-ONE,DROP-OFFS
	MOVE	OBJ,STACK
	EQUAL?	OBJ,WISHBRINGER,SHOE \?CND67
	SET	'DO-LUCK?,TRUE-VALUE
?CND67:	SET	'OBJ,NXT
	JUMP	?PRG61
?REP62:	ICALL1	COME-TO-SENSES
	ZERO?	DO-LUCK? /FALSE
	ICALL1	I-LUCK
	CALL1	I-GLOW
	RSTACK	
?CCL48:	SET	'DIGGER-SCRIPT,1
	FCLEAR	OBJ,WORNBIT
	CALL2	PICK-ONE,DROP-OFFS
	MOVE	OBJ,STACK
	FSET	VAPORS,RMUNGBIT
	PRINTI	"snatch "
	ICALL	ARTICLE,OBJ,TRUE-VALUE
	PRINTD	OBJ
	PRINTI	" out of "
	PRINTD	HANDS
	PRINTI	"s and carry it away"
	ICALL1	INTO-NIGHT
	CRLF	
	EQUAL?	OBJ,BROOM \?CCL78
	SET	'BROOM-SIT?,FALSE-VALUE
	RETURN	BROOM-SIT?
?CCL78:	EQUAL?	OBJ,WISHBRINGER,SHOE \FALSE
	ICALL1	I-LUCK
	CALL1	I-GLOW
	RSTACK	


	.FUNCT	INSIDE-GRAVE-F,CONTEXT
	EQUAL?	CONTEXT,M-LOOK \FALSE
	PRINTI	"You're at the bottom of an "
	PRINTD	OPEN-GRAVE
	PRINTI	", surrounded by six-foot walls of dirt."
	ZERO?	SKEWED? /?CND6
	ZERO?	DIGGER-SCRIPT \?PRG13
	PRINTI	" A"
	JUMP	?PRG15
?PRG13:	PRINTI	" Luminous ribbons of mist are swarming overhead, and a"
?PRG15:	PRINTR	" dark hole is visible in the north wall."
?CND6:	CRLF	
	RTRUE	


	.FUNCT	HOLE-F
	ZERO?	SKEWED? /?CTR2
	EQUAL?	HERE,LOOKOUT-HILL,UNDER-HILL \?CCL3
	FSET?	STUMP,OPENBIT /?CCL3
?CTR2:	ICALL2	CANT-SEE-ANY,HOLE
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?THROUGH,V?ENTER,V?WALK-TO \?CCL11
	EQUAL?	HERE,INSIDE-GRAVE,LOOKOUT-HILL \?CCL14
	ICALL2	DO-WALK,P?IN
	RTRUE	
?CCL14:	EQUAL?	HERE,TUNNEL-FORK \?CCL16
	ICALL2	DO-WALK,P?SOUTH
	RTRUE	
?CCL16:	ICALL2	DO-WALK,P?OUT
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?CCL18
	ICALL1	CANT-MAKE-OUT-ANYTHING
	RTRUE	
?CCL18:	ICALL2	YOU-DONT-NEED,HOLE
	RETURN	2


	.FUNCT	UMBRELLA-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The handle of the"
	ICALL2	OPEN-CLOSED,UMBRELLA
	PRINTD	UMBRELLA
	PRINTR	" is carved like a parrot's head."
?CCL3:	EQUAL?	PRSA,V?LOOK-DOWN,V?LOOK-ON,V?LOOK-INSIDE \?CCL9
	FSET?	UMBRELLA,OPENBIT \?CCL12
	ICALL2	NOTHING-INTERESTING,TRUE-VALUE
	RTRUE	
?CCL12:	ICALL2	ITS-CLOSED,UMBRELLA
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?RAISE,V?OPEN \?CCL14
	EQUAL?	PRSO,UMBRELLA \?CCL14
	FSET?	UMBRELLA,OPENBIT \?CCL19
	ICALL1	ALREADY-OPEN
	RTRUE	
?CCL19:	IN?	UMBRELLA,PROTAGONIST /?CCL21
	ICALL	YOUD-HAVE-TO,STR?234,UMBRELLA
	RTRUE	
?CCL21:	EQUAL?	HERE,INSIDE-GRAVE \?CND17
	PRINTR	"There's no room here!"
?CND17:	PUTP	UMBRELLA,P?SIZE,20
	FSET	UMBRELLA,SURFACEBIT
	ICALL	NOW-CLOSED-OR-OPEN,UMBRELLA,TRUE-VALUE
	FSET?	HERE,INDOORSBIT \TRUE
	ICALL2	BAD-LUCK,STR?296
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?LOWER,V?CLOSE \?CCL28
	FSET?	UMBRELLA,OPENBIT \?CCL28
	IN?	UMBRELLA,PROTAGONIST /?CND31
	ICALL	YOUD-HAVE-TO,STR?234,UMBRELLA
	RTRUE	
?CND31:	PUTP	UMBRELLA,P?SIZE,10
	FCLEAR	UMBRELLA,SURFACEBIT
	RFALSE	
?CCL28:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?CCL34
	EQUAL?	PRSI,UMBRELLA \?CCL34
	EQUAL?	PRSO,UMBRELLA \?CCL39
	CALL2	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL39:	IN?	UMBRELLA,PROTAGONIST /?CCL43
	ICALL	YOUD-HAVE-TO,STR?234,UMBRELLA
	RTRUE	
?CCL43:	EQUAL?	PRSO,HAT,COAT,SNAKE-CAN \?CCL45
	PRINTR	"That would look silly."
?CCL45:	EQUAL?	PRSA,V?PUT \?CCL49
	FSET?	UMBRELLA,OPENBIT /?CCL49
	ICALL2	ITS-CLOSED,UMBRELLA
	RTRUE	
?CCL49:	GETP	PRSO,P?SIZE
	GRTR?	STACK,5 \?PRG54
	ICALL2	TOO-LARGE,PRSO
	RTRUE	
?PRG54:	PRINTI	"It immediately slides "
	EQUAL?	PRSA,V?PUT-ON \?PRG61
	PRINTI	"off"
	JUMP	?CND56
?PRG61:	PRINTI	"out"
?CND56:	ICALL2	AND-DROPS-OUT,PRSO
	RTRUE	
?CCL34:	EQUAL?	PRSA,V?RAISE,V?STAND-UNDER \?CCL64
	CALL2	DONT-HAVE?,UMBRELLA
	ZERO?	STACK \TRUE
	FSET?	UMBRELLA,OPENBIT /?PRG70
	ICALL	YOUD-HAVE-TO,STR?80,UMBRELLA
	RTRUE	
?PRG70:	PRINT	OKAY
	PRINTR	"you look very cosmopolitan."
?CCL64:	EQUAL?	PRSA,V?LIE-DOWN,V?STAND-ON,V?SIT /?PRD75
	EQUAL?	PRSA,V?BURN,V?MUNG \FALSE
?PRD75:	EQUAL?	PRSO,UMBRELLA \FALSE
	ICALL2	RUIN,UMBRELLA
	RTRUE	


	.FUNCT	PUTTING-OPEN-UMBRELLA?
	EQUAL?	PRSO,UMBRELLA \FALSE
	FSET?	UMBRELLA,OPENBIT \FALSE
	ICALL	YOUD-HAVE-TO,STR?68,UMBRELLA
	RTRUE	


	.FUNCT	TREE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"This is no time for botanizing."
?CCL3:	CALL1	GETTING-INTO?
	ZERO?	STACK /FALSE
	ICALL1	NO-FOOTHOLDS
	RTRUE	

	.ENDI
