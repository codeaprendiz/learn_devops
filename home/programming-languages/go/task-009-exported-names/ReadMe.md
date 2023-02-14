# Exported names

[https://go.dev/tour/basics/3](https://go.dev/tour/basics/3)


```bash
go run exported-names.go                           
# command-line-arguments
./exported-names.go:10:19: undefined: math.pi

# after commenting
go run exported-names.go
3.141592653589793
```