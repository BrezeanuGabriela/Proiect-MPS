function main()
    format short g;

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
    
    medii = [];
    for i=1:width(input)
        medie = Medie(input(:,i));
        medii = [medii medie];
    end
    disp("Media pentru fiecare features");
    disp(medii);

    mediane = [];
    for i=1:width(input)
        median = Median(input(:,i));
        mediane = [mediane median];
    end
    disp("Mediane");
    disp(mediane);

    [coeff, score, explained] = pca(input);
    %disp(explained);
    
    % table column -> array i guess
    out = output{:, ["quality"]};
    %Histograma(out, 'quality');

    dispersii = [];
    for i=1:width(input)
        [deviatiaStandard, domDispersie, variatia, coeficientVariatie] = Dispersie(input(:, i));
        dispersii = [dispersii; [deviatiaStandard, domDispersie, variatia, coeficientVariatie]];
    end
    disp(dispersii);

end

function [input, output] = ReadData(filePath)
    %read data from file
    data = readtable(filePath);
    noColumns = width(data);
    noFeatures = noColumns - 1;
    input = data(:, 1:noFeatures);
    output = data(:, noFeatures+1);
end

function [deviatiaStandard, domDispersie, variatia, coeficientVariatie] = Dispersie(input)
    domDispersie = range(input);
    deviatiaStandard = std(input);
    variatia = var(input);
    coeficientVariatie = deviatiaStandard/Medie(input);
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
    minime = [];
    for i=1:1:width(input)
        in = input(:,[i]);
        minime = [minime min(in)];
    end
end

function maxime = Maxime(input)
    maxime = [];
    for i=1:1:width(input)
        in = input(:,[i]);
        maxime = [maxime max(in)];
    end
end

function medie = Medie(input)
    medie = sum(input);
    medie = medie/height(input);
end

function med = Median(input)
    med = median(input);
end

function deviatie = StandardDeviation(input)
    deviatie = std(input);
end

function variatie = Variance(input)
    variatie = var(input)
end

function domDispersie = DomeniuDispersie(input)
    domDispersie = range(input);
end

function Histograma(input, featureName)
    f = figure("Name", featureName);
    histogram(input);
end

