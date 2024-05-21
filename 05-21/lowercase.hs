import Char
lowercase[]=[]
lowercase(c:cs) = toLower c : lowercase cs

uppercase[]=[]
uppercase(c:cs) = toUpper c : uppercase cs
