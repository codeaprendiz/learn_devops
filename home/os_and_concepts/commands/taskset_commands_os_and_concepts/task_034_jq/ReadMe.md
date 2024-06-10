# jq

jq - Command-line JSON processor

- [jq](#jq)
  - [Docs](#docs)
  - [EXAMPLES](#examples)
    - [getting started](#getting-started)
    - [. -- pretty print](#----pretty-print)
    - [-c -- compact output](#-c----compact-output)
    - [.key -- get value of key](#key----get-value-of-key)
    - [sort\_by(.\[num\]) -- sort by key](#sort_bynum----sort-by-key)
    - [split()](#split)
      - [with keys](#with-keys)
      - [with specific array element](#with-specific-array-element)
      - [with map on all array elements](#with-map-on-all-array-elements)
    - [split() | tonumber | first](#split--tonumber--first)
      - [Explaining jq Operations](#explaining-jq-operations)
    - [contains() | and |-- Check if a string contains a substring](#contains--and----check-if-a-string-contains-a-substring)
    - [fromjson | When value of a key is a JSON string](#fromjson--when-value-of-a-key-is-a-json-string)
    - [max\_by() | Get the maximum value of a key in an array of objects and array of arrays](#max_by--get-the-maximum-value-of-a-key-in-an-array-of-objects-and-array-of-arrays)

## Docs

- [jq](http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html)
- [learn-jq](https://lzone.de/cheat-sheet/jq)

## EXAMPLES

### getting started

```bash
cat example1.json | jq
```

Output

```bash
{
  "commit_id": "b8f2b8b",
  "environment": "test",
  "tags_at_commit": "sometags",
  "project": "someproject",
  "current_date": "09/10/2014",
  "version": "someversion"
}
```

### . -- pretty print

```bash

$ echo $json | jq '.'         
{
  "commit_id": "b8f2b8b",
  "environment": "test",
  "tags_at_commit": "sometags",
  "project": "someproject",
  "current_date": "09/10/2014",
  "version": "someversion"
}
```

### -c -- compact output

```bash
cat example1.json | jq -c
```

Output

```bash
{"commit_id":"b8f2b8b","environment":"test","tags_at_commit":"sometags","project":"someproject","current_date":"09/10/2014","version":"someversion"}
```

### .key -- get value of key

```bash
cat example1.json | jq '.commit_id'
```

Output

```bash
"b8f2b8b"
```

### sort_by(.[num]) -- sort by key

```bash
$ cat example2.json| jq -c                
[["data4","info4",9],["data2","info2",4],["data1","info1",10],["data3","info3",5]]
```

```bash
cat example2.json| jq -c 'sort_by(.[2])'
```

Output

```bash
[["data2","info2",4],["data3","info3",5],["data4","info4",9],["data1","info1",10]]
```

### split()

#### with keys

```bash
$ echo '{"data": "one-two-three-four-five"}' | jq -c '.data | split("-")'
["one","two","three","four","five"]
```

#### with specific array element

```bash
$ echo '{"dataArray": ["one-two-three", "four-five-six", "seven-eight-nine"]}' | jq -c '.dataArray[0] | split("-")' 
["one","two","three"]
```

#### with map on all array elements

```bash
$ echo '{"dataArray": ["one-two-three", "four-five-six", "seven-eight-nine"]}' | jq -c '.dataArray | map(split("-"))'
[["one","two","three"],["four","five","six"],["seven","eight","nine"]]
```

### split() | tonumber | first

```bash
$ cat example4.json| jq -c                                                      
[["item1","partA-123-100"],["item4","partD-456-400"],["item3","partC-345-300"],["item2","partB-234-200"]]
```

```bash
$ cat example4.json | jq -c 'sort_by(.[1])'                                      
[["item1","partA-123-100"],["item2","partB-234-200"],["item3","partC-345-300"],["item4","partD-456-400"]]
```

```bash
cat example4.json| jq -c 'sort_by(.[1] | split("-") | .[2] | tonumber) | last' 
```

Output

```bash
["item4","partD-456-400"]
```

#### Explaining jq Operations

1. **Sorting by the First Element in Each Sub-Array (`sort_by(.[1])`)**:
   - `.[1]` accesses the second element of each sub-array (since jq indexing is zero-based). For example, for `["item1", "partA-123-100"]`, it selects `"partA-123-100"`.
   - `sort_by(.[1])` sorts the entire outer array based on these second elements as strings.

2. **Using `split("-")` in a Chain with `sort_by`**:
   - `split("-")` is used to break the string `"partA-123-100"` into parts, resulting in an array like `["partA", "123", "100"]`.
   - `.[2]` after the split selects the third part of the split array, for instance `"100"` from `["partA", "123", "100"]`.
   - `tonumber` then converts this string `"100"` into a number, making it suitable for numeric sorting.
   - `sort_by(.[1] | split("-") | .[2] | tonumber)` sorts the outer array by these numeric values.

3. **Selecting the Last Element (`| last`)**:
   - `| last` simply selects the last element from the sorted array, which is the one with the highest value from the sorted criterion.

- The expression `. [1]` inside `sort_by` is not returning the "first element of the array" but rather the second element of each sub-array, which is then processed further.
- `split("-")` does not appear at the level of sorting the whole array by itself; it's applied to the string that `. [1]` retrieves from each sub-array, helping in extracting a specific part for numeric comparison.

### contains() | and |-- Check if a string contains a substring

```bash
echo '{
  "message": "This is a sample message containing keyword1 and keyword2.",
  "description": "This is another field that contains keyword1 and keyword2.",
  "details": "Here we have keyword1 but not the other keyword."
}' | jq -r '(.message | contains("keyword1") and contains("keyword2")) and (.description | contains("keyword1") and contains("keyword2"))' 
```

Output

```bash
true
```

### fromjson | When value of a key is a JSON string

```bash
echo '{
  "test": "{\"key\":\"value\",\"anotherKey\":\"anotherValue\"}"
}' | jq -e '.test | fromjson | .key'
```

### max_by() | Get the maximum value of a key in an array of objects and array of arrays

Array of objects

```bash
echo '[{"name":"Alice","age":25},{"name":"Bob","age":30},{"name":"Charlie","age":20}] '| jq -c 'max_by(.age)'
```

Output

```bash
{"name":"Bob","age":30}
```

Array of arrays

```bash
echo '[[1,2,3],[4,5,6],[7,8,9]]' | jq -c 'max_by(.[2])'
```

Output

```bash
[7,8,9]
```
