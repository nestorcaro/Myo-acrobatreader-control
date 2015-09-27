scriptId = 'com.nescio.pdfreader'
scriptTitl = 'pdfreader'
scriptDetailsUrl = '' 
myo.setLockingPolicy("none")
myo.controlMouse(true)
printCount=0

function onForegroundWindowChange(app, title) -- Only will work while defined app is on (true)
	if (app == "AcroRd32.exe") then
		myo.debug('Currently reading: '..title)
		return true
	else  
		return false
	end
end

function onPoseEdge(pose, edge) -- return pose on while posing, off while not
    myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
    globaledge=edge
	globalpose=pose
	if (pose == "fist") then
			onFist()		
    elseif (pose == "fingersSpread") then
		if (edge == "on") then
			onFingersSpread()
			end
	end
end

function onPeriodic()
	printCount=printCount+1
	if printCount==7 then
		if (globalpose == "waveOut") then
			onWaveOut()			
		elseif (globalpose == "waveIn") then
			onWaveIn()
		end
		
		printCount=0
	end
end

function onWaveIn()  
	myo.debug("Down")
	myo.keyboard("down_arrow", "press")	
end
	
function onWaveOut()  
    myo.debug("Up")   
    myo.keyboard("up_arrow","press")
end

function onFist()  

	if (globaledge == "on") then
		myo.debug("Holding click")  
		myo.mouse("left","down")
	elseif (globaledge == "off") then
		myo.debug("Releasing click")  
		myo.mouse("left","up")
	end

end

function onFingersSpread()  
    myo.debug("Page up")  
    myo.keyboard("z","press","control")
end 


