%==========================================================================
%
% load_config  Loads a simple configuration file.
%
%   config = load_simple_config(file_path)
%
% Copyright © 2023 Tamas Kis
% Last Update: 2023-05-20
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   file_path   - (char arary or 1×1 string) relative or absolute file path
%                 (with or without extension)
%
% -------
% OUTPUT:
% -------
%   config      - (1×1 dictionary (string --> cell)) dictionary storing 
%                 config data
%
%==========================================================================
function config = load_config(file_path)
    
    opts = delimitedTextImportOptions('CommentStyle','# ','delimiter',...
        ': ','VariableNamingRule','preserve');

    % reads in config as a table, rotates its orientation, converts it
    % to a struct, and removes extra row storing original variable names
    config_struct = rmfield(table2struct(rows2vars(readtable(file_path,...
        opts))),'OriginalVariableNames');
    
    % cell array storing field names
    fields = fieldnames(config_struct);
    
    % structs storing key/value pairs
    keys = config_struct(1);
    values = config_struct(2);
    
    % initializes config dictionary to return
    config = dictionary;
    
    % simplifies struct produces by table2struct, also converting all
    % fields from chars to strings
    for i = 1:length(fields)
        
        % extracts values
        value = values.(fields{i});
        
        % converts any string values to char arrays
        value = convertStringsToChars(value);
        
        % handles array inputs
        if strcmpi(value(1),'[')
            
            % removes any extra whitespace after commas
            value = strrep(convertStringsToChars(value),', ',',');
            
            % converts to double array if value elements are numeric
            if ~isempty(str2num(value(2)))
                value = str2num(strrep(value(2:end-1),',',' '));
                
            % otherwise converts to a string array
            else
                value = string(split(value(2:end-1),',')).';
                
            end
            
        end
        
        % stores value in dictionary
        config{keys.(fields{i})} = value;
        
    end
    
end