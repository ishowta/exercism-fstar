# Refer to https://github.com/exercism/cli/issues/718#issuecomment-751472866

curl -LS https://exercism.io/tracks/ocaml/exercises | grep "/tracks/ocaml/exercises/" | awk '{print $3}' | cut -d/ -f5 | cut -d\" -f1 > exercises.txt
while read in
do export EXERCISE=$in && make init
done < exercises.txt
