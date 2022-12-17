% ReplaceStringWithInt.m
%
% Aceasta functie inlocuieste valorile de tip String(cell) cu valori numerice. 
%
% Sintaxa: [newColumn, types] = ReplaceStringWithInt(table(:, feature))
%
% Parametri de intrare:
%   feature = coloana cu index-ul feature dintr-un tabel
%
% Parametri de iesire:
%   newColumn = un vector cu noile valori numerice 
%   types = un dictionar in care cheia este un string, iar valoarea este de tip numeric


function [newColumn, types] = ReplaceStringWithInt(feature)
    % se extrag string-urile unice de pe coloana data ca parametru de intrare
    types = unique(feature);
    index = 0;
    % numericTypes este de tip dictionar si va stoca asocierile dintre string si valoare
    numericTypes = dictionary;
    types = types{:, :};
    for i=1:width(types)+1
        numericTypes(types(i, 1)) = index;
        index = index +1;
    end
    
    % se construieste vectorul cu noile valori numerice
    newColumn = [];
    for i=1:height(feature)
        newColumn = [newColumn; numericTypes(feature{i,1})];
    end   
end
