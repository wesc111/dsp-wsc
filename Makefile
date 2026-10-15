# Makefile for converting Jupyter notebooks to Python scripts and running them
# Werner Schoegler, 15-Oct-2026

VENV     ?= .venv
PYTHON   ?= $(VENV)/bin/python
JUPYTEXT ?= $(PYTHON) -m jupytext

JUPY_FILE ?= fft_dtmf.ipynb
DEST_FILE  = $(JUPY_FILE:.ipynb=.py)

.PHONY: help jupy2py run_py clean

help:
	@echo "Usage:"
	@echo "  make jupy2py    Convert $(JUPY_FILE) to $(DEST_FILE)"
	@echo "  make run_py     Run $(DEST_FILE)"
	@echo "  make clean      Remove $(DEST_FILE)"
	@echo "  make help       Show this help message"
	@echo ""
	@echo "Other notebook:  make run_py JUPY_FILE=fft_example1.ipynb"
	@echo ""
	@echo "for using virtual python environment, use:"
	@echo "  source .venv/bin/activate"

jupy2py: $(DEST_FILE)

# pattern rule: works for any notebook
%.py: %.ipynb
	$(JUPYTEXT) --to py:percent -o $@ $<

run_py: $(DEST_FILE)
	$(PYTHON) $<

clean:
	@rm -f $(DEST_FILE)