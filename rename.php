<?php

// find . -name "batch-*" | tr "/" " " | awk '{print "\"### " $3 "\"" " => " "\"### " $3 " -- [Title](URL)\","}' | sort -n
$batch_links = array(
    "### batch-1--001-018" => "### batch-1--001-018 -- [LinkedIn - Learning Nodejs](https://www.linkedin.com/learning/learning-node-js-2017)",
    "### batch-2--019-044" => "### batch-2--019-044 -- [LinkedIn - Node.js Essential Training](https://www.linkedin.com/learning/node-js-essential-training-14888164/learning-the-node-js-basics)",
    "### batch-3--045-049" => "### batch-3--045-049 -- [LinkedIn - Learning npm, a package manager](https://www.linkedin.com/learning/learning-npm-a-package-manager)",
    "### batch-4--050-076" => "### batch-4--050-076 -- [LinkedIn - Express Essential Training](https://www.linkedin.com/learning/express-essential-training-14539342)",
    "### batch-5--077-093" => "### batch-5--077-093 -- [Not Revised Yet](URL)",
    "### batch-6--094-104" => "### batch-6--094-104 -- [Not Revised Yet](URL)",
    "### batch-7--105-110" => "### batch-7--105-110 -- [Not Revised Yet](URL)",
);

// find . -name "batch-*" | tr "/" " " | awk '{print "\"### " $3 "\"" ","}' | sort -n
$batch_folders = array(
    "### batch-1--001-018",
    "### batch-2--019-044",
    "### batch-3--045-049",
    "### batch-4--050-076",
    "### batch-5--077-093",
    "### batch-6--094-104",
);


// Tested and works
/**
 * Generates a tree structure of directories and subdirectories.The createTree function takes two arguments: $directoryPath and $directoryRegex. 
 * @param string $directoryPath represents the path of the directory for which the tree structure is generated. 
 * @param string $directoryRegex is an optional argument that defines the regular expression pattern used to include directories in the tree structure (default value is /^task-/)
 * @return string The tree structure as a string.
 */
function createTree_v1($directoryPath = './', $directoryRegex = '/^task-/')
{
    $tree = [];  // Initialize an empty array to store the tree structure

    $directoriesArray = array_filter( // Get all subdirectories within the given directory, If you give ./home as the directory path, then the glob function will return an array of all subdirectories within the home directory i.e [0] => ./home/cloud-certifications, [1] => ./home/cloud-providers etc. 
                                    glob($directoryPath . '/*'), // The glob() function scans the directory specified by $directoryPath and returns an array of matching file and directory paths.
                                    'is_dir' //  The returned array contains the paths of all subdirectories within the given directory because the is_dir parameter is used as the second argument of array_filter(). 
                                    ); // This means that only the directory paths from the result of glob() will be included in the final filtered array.


    sort($directoriesArray);   // Sort the directories in ascending order

    foreach ($directoriesArray as $directory) { // directory: ./home/cloud-certifications/aws/taskset/task-001-aws-certified-solutions-architect-professional
        $dirName = trim(basename($directory)); // Get the directory name, if $d is ./home/cloud-certifications, then the basename() function inside trim() will return cloud-certifications        
        if (preg_match($directoryRegex, $dirName)) {
            $realPath = realpath($directory);
            print("\ndirectory: "); print_r($directory);
            print("\ndir name: "); print_r($dirName);
            print("\nReal path: "); print_r($realPath);
            // trim everything until learn-devops from begining of relativePath
            $relativePath = substr($realPath, strpos($realPath, 'home'));
            print("\nRelative path: "); print_r($relativePath);
            $pathParts = explode(DIRECTORY_SEPARATOR, $relativePath);
            print("\nPath parts: "); print_r($pathParts);
            $parentDir = $pathParts[count($pathParts) - 2];
            print("\nParent dir: "); print_r($parentDir);
            print("\nTree: "); print_r($tree);
            if (!isset($tree[$parentDir])) { 
                // If the parent directory is not set in the tree array, then initialize it as an empty array
                $tree[$parentDir] = [];
                print("Tree for parentDir was not set");
                // State of the tree
            }

            $tree[$parentDir][] = "- [$dirName]($relativePath)";
        }

        if (!empty(glob("$directory/*"))) {
            $tree = array_merge($tree, createTree_v1($directory));
        }
    }

    return $tree;
}




// Usage
$tree = createTree_v1('.', '/^task-/'); // if first call is for ".", second call is for "./home" and so on as the function is recursive

print_r($tree);


?>
