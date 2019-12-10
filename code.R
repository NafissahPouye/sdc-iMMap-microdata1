#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
#https://data.humdata.org/dataset/caracterizacion-migrantes-en-transito-peatonal
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-iMMap-microdata1")
data <-read_excel("data.xlsx", sheet = "Datos_IMMAP")
#Select key variables                   
selectedKeyVars <- c('genero',	'edad',	'menor_acompañado',
                     'gestante',	'lactante',	'estado_civil',
                     'etnia',	'etnia_otra',	'nacionalidad',
                     'medios_comunicacion', 'acompaniantes',
                     'num_hijOs_14_acomp', 'nivel_educativo',
                     'inasistencia_clases_hijos',
                     'documentos_vigentes', 'edo_procedencia_venezuela',
                     'dpto_antes_colombia')

#select weights
#weightVars <- c('weights')

#Convert variables to factors
cols =  c('genero',	'edad',	'menor_acompañado',
          'gestante',	'lactante',	'estado_civil',
          'etnia',	'etnia_otra',	'nacionalidad',
          'medios_comunicacion', 'acompaniantes',
          'num_hijOs_14_acomp', 'nivel_educativo',
          'inasistencia_clases_hijos',
          'documentos_vigentes', 'edo_procedencia_venezuela',
          'dpto_antes_colombia')

data[,cols] <- lapply(data[,cols], factor)

#Convert sub file to a dataframe
subVars <- c(selectedKeyVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars
                       )

#print the risk
print(objSDC, "risk")

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 

