function [newColumn, types] = ReplaceStringWithInt(feature)
    types = unique(feature);
    index = 0;
    numericTypes = dictionary;
    types = types{:, :};
    for i=1:width(types)+1
        numericTypes(types(i, 1)) = index;
        index = index +1;
    end

    newColumn = [];
    for i=1:height(feature)
        newColumn = [newColumn; numericTypes(feature{i,1})];
    end   
end