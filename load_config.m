%==========================================================================
%
% load_config  Loads a simple configuration file into a dictionary.
%
%   config = load_config(file_path)
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
%   file_path   - (char array or 1×1 string) relative or absolute file path
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
    
    % sets options for reading in config file as a table
    opts = delimitedTextImportOptions('CommentStyle','#','delimiter',...
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
    
    % populates config dictionary
    for i = 1:length(fields)
        
        % extracts key and value
        key = keys.(fields{i});
        value = values.(fields{i});
        
        % converts any string values to char arrays
        value = convertStringsToChars(value);
        
        % empty config
        if isempty(value)
            if key(end) == ':'
                key = key(1:end-1);
            end
            value = [];
            
        % logical (boolean) true config
        elseif strcmpi(value,'false')
            value = false;
            
        % logical (boolean) false config
        elseif strcmpi(value,'true')
            value = true;
            
        % array config
        elseif strcmpi(value(1),'[')
            
            % removes any extra whitespace after commas
            value = strrep(value,', ',',');
            
            % removes brackets and ensures the array is a string array
            value = string(split(value(2:end-1),',')).';
            
            % converts to double or logical array if value elements are 
            % numeric or logical
            if ~isempty(str2num(value(1)))
                value = str2num(convertStringsToChars(strjoin(value)));
            end
            
        end
        
        % stores value in dictionary
        config{key} = value;
        
    end
    
end