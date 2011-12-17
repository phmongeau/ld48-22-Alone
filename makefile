MXMLC = fcshctl mxmlc
FLIXEL = /Users/philippemongeau/Documents/Flex/Library/flixelDev
SRC = *.as
MAIN = Alone.as
SWF = Game.swf

run : $(SWF)
	open $(SWF)

$(SWF) : $(SRC)
	$(MXMLC) $(MAIN)  -o $(SWF) -static-link-runtime-shared-libraries=true --source-path=$(FLIXEL)

