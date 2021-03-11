# This makefile is based on https://github.com/FStarLang/FStar/blob/master/examples/sample_project/Makefile

ifndef EXERCISE
   $(error "Please define the `EXERCISE` variable (ex. `EXERCISE=hello-world`).")
endif

EXERCISE_FILENAME=$(subst -,_,$(EXERCISE))

EXERCISE_MODULE_NAME=$(shell echo $(EXERCISE_FILENAME) | perl -pe 's/^([a-z])(.*)$$/\U$$1\L$$2/g')

FSTAR_FILES=$(wildcard *.fst) $(wildcard $(EXERCISE)/*.fst)

FSTAR_LIBS=ppx_deriving ppx_deriving_yojson.runtime fstarlib

ML_FILES=$(addprefix $(EXERCISE)/,$(addsuffix .ml,$(subst .,_, $(subst .fst,,$(FSTAR_FILES)))))

FSTAR=fstar.exe --cache_checked_modules --odir $(EXERCISE) --use_hints $(OTHERFLAGS) --z3rlimit_factor 2 --detail_errors

$(EXERCISE)/.depend: $(FSTAR_FILES)
	$(FSTAR) --dep full $(FSTAR_FILES) --extract '* -FStar -Prims -Bridge' > $(EXERCISE)/.depend

%.checked: %
	$(FSTAR) $*
	touch $@

$(EXERCISE)/%.ml:
	$(FSTAR) $(subst .checked,,$<) --codegen OCaml

-include $(EXERCISE)/.depend

init:
	exercism download --exercise=$(EXERCISE) --track=ocaml
	test -f $(EXERCISE)/$(EXERCISE_FILENAME).fst || echo "module $(EXERCISE_MODULE_NAME)" > $(EXERCISE)/$(EXERCISE_FILENAME).fst
	sed -r -i "" "s/\(libraries (.*)\)\)/\(libraries \1 $(FSTAR_LIBS)\)\)/" $(EXERCISE)/dune
	sed -r -i "" "s/\(-warn-error\)/\(-w\)/" $(EXERCISE)/dune
	mv $(EXERCISE)/$(EXERCISE_FILENAME).ml $(EXERCISE)/sample_$(EXERCISE_FILENAME).ml
	mv $(EXERCISE)/$(EXERCISE_FILENAME).mli $(EXERCISE)/sample_$(EXERCISE_FILENAME).mli
	ln *.ml $(EXERCISE)

check: $(EXERCISE)/.depend $(addsuffix .checked, $(ALL_FST_FILES))

build: $(ALL_ML_FILES)

test: $(ALL_ML_FILES)
	cd $(EXERCISE); OCAMLRUNPARAM='b' dune runtest

submit:
	exercism submit $(EXERCISE)/$(EXERCISE_MODULE_NAME).ml

clean:
	rm -rf $(EXERCISE)/_build $(ML_FILES) $(EXERCISE)/*~ $(EXERCISE)/*.checked $(EXERCISE)/.depend
