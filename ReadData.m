function [input, output] = ReadData(filePath)
    %read data from file
    data = readtable(filePath);
    no_columns = width(data);
    no_features = no_columns - 1;
    input = data(:, 1:no_features);
    output = data(:, no_features+1);
end