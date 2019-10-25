######################################################################################################
# Script écrit pour l'atelier "Du parchemin à la fouille de données. Nouveaux outils pour la création, 
#      la formalisation et l'analyse des corpus médiévaux", Paris, 28-30 octobre 2019
# Paul Bertrand, Étienne Cuvelier, Sébastien de Valeriola, Nicolas Perreaux, Nicolas Ruffini-Ronzani
#
######################################################################################################
# II.3. Outils disponibles et formats d'entrée
######################################################################################################

rm(list=ls())
setwd("D:\\DigitalHumanities\\Evenements\\2019.10.28_Atelier Nouveaux Outils 2\\Livrables\\II.3. Outils disponibles et formats dentrée")

library(tm)
library(stringr)


# 01. Construction d'un corpus avec tm ----

# On indique le repertoire de sources
repertoireMiniND = DirSource(directory = "miniCorpusND/")
repertoireMiniND = DirSource(directory = "miniCorpusND/",encoding = "UTF-8")
repertoireMiniND = DirSource(directory = "miniCorpusND/",encoding = "UTF-8",pattern = "\\.txt$")

# On cree le corpus
corpusMiniND = Corpus(x = repertoireMiniND)

# Manipulation du corpus
print(corpusMiniND)
inspect(corpusMiniND)
corpusMiniND[[1]]
names(corpusMiniND)


# 02. Metadata d'un corpus avec tm ----
meta(corpusMiniND[[1]])
meta(corpusMiniND, tag = "language", type = "corpus") = "lat"
meta(corpusMiniND[[1]])

# On sauve le corpus
save(corpusMiniND,file = "fichiersRData/corpusMiniND.RData")


# 03. Ecriture du corpus nettoye avec tm ----
volume1 = readLines("../II.1. Nettoyer un texte/data/ND_volume1-etat3.txt")
textesVol1 = str_subset(volume1,"#")
sourceVolume1 = VectorSource(textesVol1)
corpusVol1 = Corpus(x = sourceVolume1)
writeCorpus(x = corpusVol1,path = "actesVol1/")



