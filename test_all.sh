while read in
do (export EXERCISE=$in && make test) || break
done < exercises.txt
