# coreEphysAcq
core ephys acquisition code for the Wilson Lab

ephysSettingsExample
  Make a copy of this code in another repository of yours and save it as ephysSettings.mat
  That copy should be the only code you need to change regularly.  

runExpt
  Main script that you run the experiment from.  To start an experiment enter a command like this runExpt('test',1,18).  This runs an experiment with a prefix code ‘test’ and experiment number 1 which means the data is saved in a folder called ~\Data\ephysData\test\expNum001.  The third input argument specifies the stim set number which in this case is 18. 
  runExpt relies on the following functions: 

getFlyNum
  Works out which fly number you are on. 

getFlyDetails
  Asks you for the line, date of eclosion etc. 

getDataFileName
  Works out where to save data.   I save trials in a folder structure like this: 
  ~\DataFolder\ephysData\prefixCode\expNum\flyNum\cellNum\cellExpNum
  For example:
  Data\ephysData\18C11\expNum001\flyNum012\cellNum001\cellExpNum003
  The cell has a cellExpNum so that I can run different kinds of stimulus sets with the same cell.  Note that I save each trial’s data individually so that data isn’t lost if MATLAB crashes part-way through an experiment. You can merge trials at the end of an experiment using the mergeTrials function. 

preExptRoutine
  Runs a set of trials for acquiring data for, calculating and saving pipette resistance etc.  It uses the following functions: 
      measurePipetteResistance
      measureMembraneResistance
      measureAccessResistance

exampleStimSet
  runExpt calls a stimSet to run the experiment in the section of code called “Run experiment with stimulus”.  This example code shows you what a stimSet looks like.  The stimSets are the main code that you will edit.  

acquireTrial
  Each stimSet calls acquireTrial to acquire a particular trial. 
  ephysSettings
  Stores the information about the wiring of you DAC etc.  You will need to edit this doc. 
  
decodeTelegraphedOutput
  Decodes the telegraphed output channel from the Axopatch 200B.  
  plotData
  A rough plotting function for plotting data at the end of a trial. 

mergeTrials
  Merges individual trials into one matrix. 
