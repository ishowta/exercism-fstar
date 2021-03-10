# This makefile is based on https://github.com/FStarLang/FStar/blob/master/examples/sample_project/Makefile

ifndef EXERCISE
   $(error "Please define the `EXERCISE` variable (ex. `EXERCISE=hello-world`).")
endif

EXERCISE_FN=$(subst -,_,$(EXERCISE))

EXERCISE_MODULE_NAME=$(shell echo $(EXERCISE_FN) | perl -pe 's/^([a-z])(.*)$$/\U$$1\L$$2/g')

FSTAR_FILES=$(wildcard $(EXERCISE)/*.fst)

FSTAR_LIBS=ppx_deriving ppx_deriving_yojson.runtime fstarlib

ML_FILES=$(addprefix $(EXERCISE)/,$(addsuffix .ml,$(subst .,_, $(subst .fst,,$(FSTAR_FILES)))))

FSTAR=fstar.exe --cache_checked_modules --odir $(EXERCISE) --use_hints $(OTHERFLAGS) --z3rlimit_factor 2

$(EXERCISE)/.depend:
	$(FSTAR) --dep full $(FSTAR_FILES) --extract '* -FStar -Prims' > $(EXERCISE)/.depend

$(EXERCISE)/%.checked: $(EXERCISE)/%
	$(FSTAR) $(EXERCISE)/$*

$(EXERCISE)/%.ml:
	$(FSTAR) $(subst .checked,,$<) --codegen OCaml --extract_module $(subst $(EXERCISE)/,,$(subst .fst.checked,,$<))

-include $(EXERCISE)/.depend

init:
	exercism download --exercise=$(EXERCISE) --track=ocaml
	test -f $(EXERCISE)/$(EXERCISE_FN).fst || echo "module $(EXERCISE_MODULE_NAME)" > $(EXERCISE)/$(EXERCISE_FN).fst
	sed -r -i "" "s/\(libraries (.*)\)\)/\(libraries \1 $(FSTAR_LIBS)\)\)/" $(EXERCISE)/dune
	mv $(EXERCISE)/$(EXERCISE_FN).ml $(EXERCISE)/sample_$(EXERCISE_FN).ml
	mv $(EXERCISE)/$(EXERCISE_FN).mli $(EXERCISE)/sample_$(EXERCISE_FN).mli

check: $(EXERCISE)/.depend $(addsuffix .checked, $(ALL_FST_FILES))

build: $(ALL_ML_FILES)

test: $(ALL_ML_FILES)
	cd $(EXERCISE); dune runtest

submit:
	exercism submit $(EXERCISE)/$(EXERCISE_MODULE_NAME).ml

clean:
	rm -rf $(EXERCISE)/_build $(ML_FILES) $(EXERCISE)/*~ $(EXERCISE)/*.checked $(EXERCISE)/.depend
