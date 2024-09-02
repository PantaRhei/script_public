#!/bin/bash
#exemple: ./rename_files.sh /chemin/vers/repertoire "abc "

#Check arg 
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <path> <characters_to_remove> <replacement_character>"
    exit 1
fi

path=$1
chars_to_remove=$2
replacement_char=$3

#check if path id valid
if [ ! -d "$path" ]; then
    echo "Path invalid"
    exit 1
fi

# Suppression des caractères spécifiés dans les noms de fichiers
for file in "$path"/*; do
    if [ -f "$file" ]; then
        # Récupération du nom de fichier sans le chemin
        filename=$(basename "$file")
        tmp=$filename
        # Remplacement des caractères spécifiés par le caractère de remplacement
        new_filename=$(echo "$filename" | sed "s/[$chars_to_remove]/$replacement_char/g")
        
        # Renommage du fichier
        mv "$file" "$path/$new_filename" &> /dev/null
        if [ $? -eq 0 ]; then
            echo "File: $tmp name was changed"
        fi
    fi
done

echo "Finish"