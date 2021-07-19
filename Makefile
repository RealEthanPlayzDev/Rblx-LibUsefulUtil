ifeq ($(OS),Windows_NT) 
    runos = "Windows"
else
    runos = "Linux"
endif

outputfile = "LibUsefulUtility.rbxmx"
outputplace = "LibUsefulUtility.rbxlx"
rojoexecutable = "rojo"
rojoproject = "default.project.json"
rojoplaceproject = "place.project.json"

all :
	$(rojoexecutable) build $(rojoproject) --output $(outputfile)

file :
	$(rojoexecutable) build $(rojoproject) --output $(outputfile)

place :
	$(rojoexecutable) build $(rojoplaceproject) --output $(outputplace)

clean :
	ifeq (runos, Windows)
		if exist $(outputfile) then ( rd /S /Q $(outputfile) )
		if exist $(outputplace) then ( rd /S /Q $(outputplace) )
	else
		$(RM) $(outputfile)
		$(RM) $(outputplace)
	endif