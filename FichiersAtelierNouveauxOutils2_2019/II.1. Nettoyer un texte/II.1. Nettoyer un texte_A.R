######################################################################################################
# Script écrit pour l'atelier "Du parchemin à la fouille de données. Nouveaux outils pour la création, 
#      la formalisation et l'analyse des corpus médiévaux", Paris, 28-30 octobre 2019
# Paul Bertrand, Étienne Cuvelier, Sébastien de Valeriola, Nicolas Perreaux, Nicolas Ruffini-Ronzani
#
######################################################################################################
# II.1. Nettoyer un texte A
######################################################################################################

rm(list=ls())
setwd("D:\\DigitalHumanities\\Evenements\\2019.10.28_Atelier Nouveaux Outils 2\\Livrables\\II.1. Nettoyer un texte")

library(stringr)
  

# 0. Chargement des donnees ----
volume1 = readLines("data/ND_volume1_etat1.txt",encoding = "UTF-8")

# verification que le chargement s'est bien deroule 
volume1[1]
length(volume1)



# 1. Fonctions R à utiliser ----

# exercice :  
str_subset(string = volume1, pattern = 'mense Januario')



# 2. Sequences d'echappement ----

# exemples : 
text = c('x	y','xxy','xysfdres','xy$')
str_subset(string = text, pattern = '\t')
str_subset(string = text, pattern = '$')
str_subset(string = text, pattern = '\\$')
  
# exercice :  
str_subset(string = volume1, pattern = "l'")
str_subset(string = volume1, pattern = 'l\'')



# 3. Operateurs ----

# exemples : 
text = c('xy','xwy','xzeedy','xy21','xy001','mnop')
str_subset(string = text, pattern = 'x.')
str_subset(string = text, pattern = 'x[^y]')
str_subset(string = text, pattern = 'x[w-y]')
str_subset(string = text, pattern = 'xy[2-9]')
str_subset(string = text, pattern = 'xy|mn')

lignesMotif = str_subset(string = volume1, pattern = '100[0-9]')
str_extract(string = lignesMotif, pattern = '100[0-9]')

# exercice : 
lignesMotif = str_subset(string = volume1, pattern = '[eua]rn[ \\.,;]')
str_extract(string = lignesMotif, pattern = '[eua]rn[ \\.,;]')



# 4. Quantificateurs ----

# exemples : 
text = c('xy','x-y','x--y','x---y','x----y')
str_subset(string = text, pattern = 'x-y')
str_subset(string = text, pattern = 'x-*y')
str_subset(string = text, pattern = 'x-+y')
str_subset(string = text, pattern = 'x-?y')
str_subset(string = text, pattern = 'x-{2}y')
str_subset(string = text, pattern = 'x-{2,}y')
str_subset(string = text, pattern = 'x-{2,3}y')

as.numeric(as.roman("MCCLIV"))

# exercice :  
lignesMotif = str_subset(string = volume1, pattern = 'MC{1,5}L?[XVI]*')
str_extract(string = lignesMotif, pattern = 'MC{1,5}L?[XVI]*')

millArabes = as.numeric(as.roman(str_extract(string = lignesMotif, pattern = 'MC{1,5}L?[XVI]*')))
hist(millArabes)
hist(millArabes,breaks=25)



# 5. Comportement des quantificateurs ----

# exemple :  
text = c('xyxyy___xyy')
str_extract(string = text, pattern = '.*y')
str_extract(string = text, pattern = '.*?y')

text = c('<tag>Some text</tag>')
str_replace_all(string = text, pattern = '<.+>',replacement = "")
str_replace_all(string = text, pattern = '<.+?>',replacement = "")

# exercice : 
lignesMotif1 = str_subset(string = volume1, pattern = '\\(.+\\)')
str_extract_all(string = lignesMotif1, pattern = '\\(.+\\)',simplify = TRUE)

lignesMotif2 = str_subset(string = volume1, pattern = '\\(.+?\\)')
str_extract_all(string = lignesMotif2, pattern = '\\(.+?\\)',simplify = TRUE)



# 6. Classes de caracteres ----

# exemple : 
text = c('xy','xwy','xzeedy','xy21','xy001','mnop')
str_subset(string = text, pattern = '[[:digit:]]')

# exercice : 
lignesMotif = str_subset(string = volume1, pattern = '[:upper:]?[:lower:]+[:digit:]')
str_extract_all(string = lignesMotif, pattern = '[:upper:]?[:lower:]+[:digit:]',simplify = TRUE)


# 7. Position au sein de la chaine ----

# exemple : 
text = c('xy','xwy','xzeedx','yxxx210','xy001','mnopx','eds xdes')
str_subset(string = text, pattern = '^x')
str_subset(string = text, pattern = 'x$')
str_subset(string = text, pattern = '\\bx')
str_subset(string = text, pattern = '\\<x')

# exercice : 
str_subset(string = volume1, pattern = '-$')
str_subset(string = volume1, pattern = '^[CLXVI]+\\.$')


# 8. Retro-references ----

# exemple : 
text = c('The numbers are aa01214 and bb007')
str_replace(string = text, pattern = '.*[a-z]{2}([0-9]{3,}).*\\s[a-z]{2}([0-9]{3,})',replacement = "\\1 & \\2")
str_replace(string = text, pattern = '.*[a-z]{2}(?:[0-9]{3,}).*\\s[a-z]{2}([0-9]{3,})',replacement = "\\1")

# exercice : 
lignesMotif = str_subset(string = volume1, pattern = 'mense ([A-Z]?[a-z]+)')
motif = str_extract(string = lignesMotif, pattern = 'mense ([A-Z]?[a-z]+)')
str_replace(string = motif, pattern = 'mense ([A-Z]?[a-z]+)',replacement = "\\1")






