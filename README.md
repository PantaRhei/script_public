# rename all file
Usage:
```bash
./rename_files.sh /chemin/vers/repertoire "abc " "_"
```
Arg1: path of folder
Arg2: list of caractere to change
Arg3: all caractere in arg2 will be change in arg3

# rename all file
## Add domain 
Usage:
```bash
./block_domain.sh -a domain
```
Add to hosts file a local rediction on domain.

## Remove domain 
Usage:
```bash
./block_domain.sh -s domain
```
Remove to hosts file a local rediction on domain.
Note: if you have
```
127.0.0.1 www.google.com
127.0.0.1 google.com
```
and you use 
```bash
./block_domain.sh -s google.com
```
A script remove 2 lines (bug TODO: check sed flags)

## recovery hosts file 
Usage:
```bash
./block_domain.sh -r
```
Recovery hosts file