#!/usr/bin/ruby

puts "start dead code analysis"

result = `periphery scan --report-exclude \"yourProjectName/Service/GraphQL/**\"`

result_stripped_of_absolute_path_prefix = result.gsub(Dir.pwd, '')
filtered_out_result = result_stripped_of_absolute_path_prefix.split("\n").filter { |line| /:\d+:\d+:/.match?(line) }
sorted_result = filtered_out_result.sort
result_with_removed_code_line_number = sorted_result.map {|l| l.sub(/:\d+:\d+:/, '') }
output = result_with_removed_code_line_number.join("\n") + "\n"

File.write('periphery_output', output)

puts "done with dead code analysis"