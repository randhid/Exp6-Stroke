files = dir('*s1*.txt');
for i=1:length(files)
  [pathname,filename,extension] = fileparts(files(i).name);
  % the new name, e.g.
  newFilename = strrep(filename, 's1', 's01');
  % rename the file
  movefile([filename extension], [newFilename extension]);
end

%%