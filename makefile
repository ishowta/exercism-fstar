# This makefile is based on https://github.com/FStarLang/FStar/blob/master/examples/sample_project/Makefile

ifndef EXERCISE
   $(error "Please define the `EXERCISE` variable (ex. `EXERCISE=hello-world`).")
endif

EXERCISE_RAW_FILENAME=$(subst -,_,$(EXERCISE))

EXERCISE_MODULE_NAME=$(shell echo $(EXERCISE_RAW_FILENAME) | perl -pe 's/([a-z])([a-z_]*)/\U$$1\L$$2/g')

EXERCISE_LIB_DIR=$(EXERCISE)/lib

FSTAR_FILES=$(wildcard *.fst) $(wildcard $(EXERCISE)/*.fst)

FSTAR_LIBS=ppx_deriving ppx_deriving_yojson.runtime fstarlib

ML_FILES=$(addprefix $(EXERCISE_LIB_DIR)/,$(addsuffix .ml,$(subst .,_, $(subst .fst,,$(FSTAR_FILES)))))

FSTAR=fstar.exe --cache_checked_modules --odir $(EXERCISE) --use_hints $(OTHERFLAGS) --z3rlimit_factor 2 --detail_errors

$(EXERCISE)/.depend: $(FSTAR_FILES)
	test -d $(EXERCISE) && $(FSTAR) --dep full $(FSTAR_FILES) --extract '* -FStar -Prims -Bridge' > $(EXERCISE)/.depend

%.checked: %
	$(FSTAR) $*
	touch $@

$(EXERCISE)/%.ml:
	$(FSTAR) $(subst .checked,,$<) --codegen OCaml --odir $(EXERCISE_LIB_DIR)

-include $(EXERCISE)/.depend

init:
	exercism download --exercise=$(EXERCISE) --track=ocaml
	test -f $(EXERCISE)/$(EXERCISE_MODULE_NAME).fst || echo "module $(EXERCISE_MODULE_NAME)" > $(EXERCISE)/$(EXERCISE_MODULE_NAME).fst
	sed -r -i "" "s/\(libraries (.*)\)\)/\(libraries \1 $(FSTAR_LIBS)\)\)/" $(EXERCISE)/dune
	sed -r -i "" "s/-warn-error/-w/" $(EXERCISE)/dune
	echo "\n\n(include_subdirs unqualified)" >> $(EXERCISE)/dune
	mv $(EXERCISE)/$(EXERCISE_RAW_FILENAME).ml $(EXERCISE)/Sample_$(EXERCISE_MODULE_NAME).ml
	mv $(EXERCISE)/$(EXERCISE_RAW_FILENAME).mli $(EXERCISE)/Sample_$(EXERCISE_MODULE_NAME).mli
	mkdir -p $(EXERCISE_LIB_DIR)
	ln -f *.ml $(EXERCISE_LIB_DIR)

check: $(EXERCISE)/.depend $(addsuffix .checked, $(ALL_FST_FILES))

test: $(ALL_ML_FILES)
	test ! -f $(EXERCISE_LIB_DIR)/$(EXERCISE_MODULE_NAME).ml || mv $(EXERCISE_LIB_DIR)/$(EXERCISE_MODULE_NAME).ml $(EXERCISE)
	cd $(EXERCISE); OCAMLRUNPARAM='b' dune runtest

submit:
	exercism submit $(EXERCISE_LIB_DIR)/$(EXERCISE_MODULE_NAME).ml

clean:
	rm -rf $(EXERCISE)/_build $(ML_FILES) $(EXERCISE)/*~ $(EXERCISE)/*.checked $(EXERCISE)/.depend
