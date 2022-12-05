path = "E:\FACULTATE\Anul 4\Sem1\MPS\Project\arhive\archive\wine\winequalityN.csv";
[input, output] = ReadData(path);
output_column_name = output.Properties.VariableNames;
input_column_names = input.Properties.VariableNames;

for i=2:1:width(input)
    in = input{:,[input_column_names(i)]};
    is_nan = isnan(in);
    disp(sum(is_nan))
end


% table column -> array i guess
out = output{:, ["quality"]};
histogram(out);
wine_types = unique(input(:,"type"));

