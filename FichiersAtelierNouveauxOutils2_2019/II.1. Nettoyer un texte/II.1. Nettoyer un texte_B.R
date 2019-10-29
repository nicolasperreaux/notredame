######################################################################################################
# Script écrit pour l'atelier "Du parchemin à la fouille de données. Nouveaux outils pour la création, 
#      la formalisation et l'analyse des corpus médiévaux", Paris, 28-30 octobre 2019
# Paul Bertrand, Étienne Cuvelier, Sébastien de Valeriola, Nicolas Perreaux, Nicolas Ruffini-Ronzani
#
######################################################################################################
# II.1. Nettoyer un texte B
######################################################################################################

rm(list=ls())
setwd("D:\\DigitalHumanities\\Evenements\\2019.10.28_Atelier Nouveaux Outils 2\\Livrables\\II.1. Nettoyer un texte")

library(stringr)


# 0. Chargement des donnees ----
volume1a = readLines("data/ND_volume1-etat2.txt",encoding = "UTF-8")


# 1. Suppression des lignes en trop : ----
#        on ne garde que celles qui ne commencent pas pas % et qui ont au moins un caractere
volume1b = str_subset(volume1a,"^[^%]")

writeLines(text = volume1b,con = "data/essai.txt")


# 2. On enleve les caracteres genants ----
volume1c = str_replace_all(volume1b,"[\\[\\]\\(\\)\\*«»\\']","")

writeLines(text = volume1c,con = "data/essai.txt")


# 3. On retire les appels de note ----
volume1d = str_replace_all(volume1c,"([a-z])[0-9]([\\s[:punct:]])","\\1\\2")

writeLines(text = volume1d,con = "data/essai.txt")


# 4. On ajoute des caracteres-clefs au debut des lignes a ne pas coller ----  
volume1e = volume1d
indNum = which(str_detect(volume1e,"^[CLXVIclxvi1]+[\\.,L]$"))
volume1e[indNum] = str_c("@",volume1e[indNum])
volume1e[indNum+1] = str_c("§",volume1e[indNum+1])
volume1e[indNum+2] = str_c("#",volume1e[indNum+2])

writeLines(text = volume1e,con = "data/essai.txt")


# 5. On recolle les autres lignes aux precedentes ----
# on recolle toutes les lignes en placant un caractere "fin de ligne" aux jonctions
volume1f = paste(volume1e,collapse = "\n")
# on supprime les caractères "fin de ligne" pour les lignes à coller
volume1f = str_replace_all(volume1f,"\n([^@§#])","\\1")
# on recoupe le tout en lignes
volume1g = str_split(volume1f,"\n",simplify = TRUE)

writeLines(text = volume1g,con = "data/essai.txt")


# 6. On recolle les mots avec saut ligne ----
volume1h = str_replace_all(volume1g,"- ","")


# 7. On ecrit le resultat dans un fichier ----
writeLines(text = volume1h,con = "data/ND_volume1-etat3.txt")





