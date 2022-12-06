function main()
    path = "E:\FACULTATE\Anul 4\Sem1\MPS\Project\arhive\archive\wine\winequalityN.csv";
    [input, output] = ReadData(path);
    output_column_name = output.Properties.VariableNames;
    input_column_names = input.Properties.VariableNames;
    
    % check for string values
    stringFeatures = StringFeatureIndex(input)
    
    % create matrix with input in double format
    matrix = [];
    for feature=1:width(stringFeatures)
        [columnWithoutString, types_dict] = ReplaceStringWithInt(input(:, feature));
        matrix = [matrix columnWithoutString];
    end
    
    for i=1:width(input)
        if ismember(i, stringFeatures) == false
            matrix = [matrix input{:, i}];
        end
    end
    
    input = matrix;
    
    input = RemoveRowsWithNan(input);

    minime = Minim(input);
    disp(minime);
    
    maxime = Maxime(input);
    disp(maxime);

    [coeff, score, explained] = pca(input);
    explained
    
    % table column -> array i guess
    %out = output{:, ["quality"]};
    %Histograma(out, 'quality');
end

function stringFeatureIndex = StringFeatureIndex(input)
    stringFeatureIndex = [];
    for col=1:width(input)
        if class(input{1,col}) == "cell"
            stringFeatureIndex = [stringFeatureIndex col];
        end
    end
end

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

function cleanInput = RemoveRowsWithNan(input)
    cleanInput = [];
    for row=1:height(input)
        in = input(row,:);
        noOfNan = isnan(in);
        if sum(noOfNan) == 0
            in = input(row,:);
            cleanInput = [cleanInput; in];
       end
    end
end

function minime = Minim(input)
    minime = []
    for i=2:1:width(input)
        in = input(:,[i]);
        minime = [minime min(in)];
    end
end

function maxime = Maxime(input)
    maxime = []
    for i=2:1:width(input)
        in = input(:,[i]);
        maxime = [maxime max(in)];
    end
end

function Histograma(input, featureName)
    f = figure("Name", featureName);
    histogram(input);
end

