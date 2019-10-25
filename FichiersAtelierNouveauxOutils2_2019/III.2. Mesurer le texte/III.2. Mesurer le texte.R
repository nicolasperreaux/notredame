######################################################################################################
# Script écrit pour l'atelier "Du parchemin à la fouille de données. Nouveaux outils pour la création, 
#      la formalisation et l'analyse des corpus médiévaux", Paris, 28-30 octobre 2019
# Paul Bertrand, Étienne Cuvelier, Sébastien de Valeriola, Nicolas Perreaux, Nicolas Ruffini-Ronzani
#
######################################################################################################
# III.2. Mesurer le texte
######################################################################################################

rm(list=ls())
setwd("D:\\DigitalHumanities\\Evenements\\2019.10.28_Atelier Nouveaux Outils 2\\Livrables\\III.2. Mesurer le texte")

library(tm)

load("../II.3. Outils disponibles et formats dentrée/fichiersRData/corpusMiniND.RData")


# 01. Matrice termes-documents ----

# Creation
matriceTDminiND = TermDocumentMatrix(corpusMiniND)
inspect(matriceTDminiND)

matriceTDminiND = TermDocumentMatrix(corpusMiniND,control = list(removePunctuation = TRUE))
inspect(matriceTDminiND)

matriceTDminiND_nettoyee = removeSparseTerms(matriceTDminiND, 0.80)
inspect(matriceTDminiND_nettoyee)

findFreqTerms(matriceTDminiND_nettoyee, 15)

findAssocs(matriceTDminiND_nettoyee, "episcopus",0.9)


# 02. Indice tf-idf ----

matriceTDminiNDtfidf = TermDocumentMatrix(corpusMiniND,control = list(removePunctuation = TRUE,
                                                                 weighting = weightTfIdf))
inspect(matriceTDminiNDtfidf)
findFreqTerms(matriceTDminiNDtfidf, 0.10)


# 03. Distance de Damerau-Levenshtein ----
library(stringdist)

stringdist("abbatia","episcopus")
stringdist("episcopus","dictus")
stringdist("dictus","abbatia")

vecteurMots = c("abbatia","episcopus","dictus")
stringdistmatrix(vecteurMots)

