# This makefile is based on https://github.com/FStarLang/FStar/blob/master/examples/sample_project/Makefile and https://github.com/FStarLang/FStar/blob/master/ulib/ml/Makefile.include

ifndef EXERCISE
   $(error "Please define the `EXERCISE` variable (ex. `EXERCISE=hello-world`).")
endif

EXERCISE_RAW_FILENAME=$(subst -,_,$(EXERCISE))

EXERCISE_MODULE_NAME=$(shell echo $(EXERCISE_RAW_FILENAME) | perl -pe 's/([a-z])([a-z_]*)/\U$$1\L$$2/g')

EXERCISE_LIB_DIR=$(EXERCISE)/lib

FSTAR_FILES=$(wildcard *.fst) $(wildcard $(EXERCISE)/*.fst)

FSTAR_LIBS=ppx_deriving ppx_deriving_yojson.runtime fstarlib

ML_FILES=$(addprefix $(EXERCISE_LIB_DIR)/,$(addsuffix .ml,$(subst .,_, $(subst .fst,,$(FSTAR_FILES)))))

FSTAR=fstar.exe --cache_checked_modules --odir $(EXERCISE_LIB_DIR) --record_hints --use_hints $(OTHERFLAGS) --z3rlimit_factor 2 --detail_errors --include $(EXERCISE) # Add `--query_stats` for more details.

FSTAR_REALIZED_MODULES=All BaseTypes Buffer Bytes Char CommonST Constructive Dyn Float Ghost Heap Monotonic.Heap \
	HyperStack.All HyperStack.ST HyperStack.IO Int16 Int32 Int64 Int8 IO \
	List.Tot.Base Mul Option Pervasives.Native Set ST Exn String \
	UInt16 UInt32 UInt64 UInt8 \
	Pointer.Derived1 Pointer.Derived2 \
	Pointer.Derived3 \
	BufferNG \
	TaggedUnion \
	Bytes Util \
	Pervasives Order Range \
	Vector.Base Vector.Properties Vector TSet
	# prims is realized by default hence not included in this list

NOEXTRACT_MODULES=$(addprefix -FStar., $(FSTAR_REALIZED_MODULES) Printf) \
  -LowStar.Printf +FStar.List.Tot.Properties +FStar.Int.Cast.Full -Steel

$(EXERCISE)/.depend: $(FSTAR_FILES)
	test -d $(EXERCISE) && $(FSTAR) --dep full $(FSTAR_FILES) --extract '* -FStar -Prims -Bridge' > $(EXERCISE)/.depend

%.checked: %
	$(FSTAR) $*
	touch $@

$(EXERCISE)/%.ml:
	$(FSTAR) $(subst .checked,,$<) --codegen OCaml --odir $(EXERCISE_LIB_DIR) --extract '* $(NOEXTRACT_MODULES)'

-include $(EXERCISE)/.depend

init:
	exercism download --exercise=$(EXERCISE) --track=ocaml
	sed -r -i "" "s/\(libraries (.*)\)\)/\(libraries \1 $(FSTAR_LIBS)\)\)/" $(EXERCISE)/dune
	sed -r -i "" "s/-warn-error/-w/" $(EXERCISE)/dune
	echo "\n\n(include_subdirs unqualified)" >> $(EXERCISE)/dune
	test -f $(EXERCISE)/$(EXERCISE_MODULE_NAME).fst || (echo "module $(EXERCISE_MODULE_NAME)\nopen Bridge\n" > $(EXERCISE)/$(EXERCISE_MODULE_NAME).fst && cat $(EXERCISE)/$(EXERCISE_RAW_FILENAME).mli | sed -r "s/ int / native_int /g" | sed -r "s/ int$$/ native_int/g" | sed -r "s/ list / native_list /g" >> $(EXERCISE)/$(EXERCISE_MODULE_NAME).fst)
	mkdir -p $(EXERCISE)/samples
	mv $(EXERCISE)/$(EXERCISE_RAW_FILENAME).ml $(EXERCISE)/samples/Sample_$(EXERCISE_MODULE_NAME).ml
	mv $(EXERCISE)/$(EXERCISE_RAW_FILENAME).mli $(EXERCISE)/samples/Sample_$(EXERCISE_MODULE_NAME).mli
	mkdir -p $(EXERCISE_LIB_DIR)
	ln -f *.ml $(EXERCISE_LIB_DIR)

check: $(EXERCISE)/.depend $(addsuffix .checked, $(ALL_FST_FILES))

test: $(ALL_ML_FILES)
	cd $(EXERCISE); OCAMLRUNPARAM='b' dune runtest

submit:
	exercism submit $(EXERCISE_LIB_DIR)/$(EXERCISE_MODULE_NAME).ml

clean:
	rm -rf $(EXERCISE)/_build $(ML_FILES) $(EXERCISE)/*~ $(EXERCISE)/*.checked $(EXERCISE)/.depend
