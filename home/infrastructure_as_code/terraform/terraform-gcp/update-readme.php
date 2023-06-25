<?php

$header_row = "| Tasks | Skills | High Level Objective |\n|-------|--------|----------------------|";
$rows = array();

foreach (glob("taskset/task-*") as $task_folder) {
    $file_contents = file_get_contents("$task_folder/ReadMe.md");

    $pattern_for_objectives = '/\*\*High Level Objectives\*\*(.*?)\*\*Skills\*\*/s';
    if (preg_match($pattern_for_objectives, $file_contents, $matches_for_objectives)) {
        $matched_lines_between_pattern_for_objectives = explode("\n", $matches_for_objectives[1]);
        $objectives = '';
        foreach ($matched_lines_between_pattern_for_objectives as $line) {
            $line = trim($line);
            $line = str_replace('- ', '<li>', $line);
            if (!empty($line)) {
//                 $line = '`'.$line.'`';
//                 $objectives .= ($objectives ? ', ' : '') . $line;
                $objectives .= ($objectives ? '<br> ' : '') . $line;
            }
        }
    } else {
        echo "\nNo matches found.";
    }

    $patter_for_skills = '/\*\*Skills\*\*(.*?)\*\*Version Stack\*\*/s';
    if (preg_match($patter_for_skills, $file_contents, $matches_for_keywords)) {
        $matched_lines_between_pattern_for_keywords = explode("\n", $matches_for_keywords[1]);
        $skills = '';
        foreach ($matched_lines_between_pattern_for_keywords as $line) {
            $line = trim($line);
            $line = str_replace('-', '', $line);
            if (!empty($line)) {
                $line = '`'.$line.'`';
                $skills .= ($skills ? ', ' : '') . $line;
//                 $skills .= ($skills ? '<br> ' : '') . $line;
            }
        }
    } else {
        echo "No matches found.";
    }

    $task_name = basename($task_folder);
    $task_name = substr($task_name, 5, 3);

    $row = "| [$task_name]($task_folder) | $skills | $objectives |";
    array_push($rows, $row);
}

$table = $header_row . "\n" . implode("\n", $rows);

echo $table;
file_put_contents("ReadMe.md", $table);

# https://github.com/nvuillam/markdown-table-formatter
# npm install markdown-table-formatter -g
exec('markdown-table-formatter');

?>
