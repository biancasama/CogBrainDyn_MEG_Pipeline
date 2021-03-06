PYTHON = python

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  fetch         to fetch the data"
	@echo "  preproces      to run all scripts after anatomy. LFREQ must be set for highpass cutoff"
	@echo "  check         check if the dependencies are available"
	@echo "  profile       to profile memory consumption"
	@echo "  all           to build fetch data, run anatomy scripts and all the processing scripts with no highpass"
	@echo "  clean		remove intermediate scripts generated by processing"

check:
	$(PYTHON) check_system.py

clean:
	$(PYTHON) clean.py

fetch:
	$(PYTHON) 00-fetch_data.py

preproces:
	$(PYTHON) 01-import_and_filter.py
	$(PYTHON) 02-apply_maxwell_filter.py
	$(PYTHON) 03-extract_events.py
	$(PYTHON) 04a-run_ica.py
	$(PYTHON) 04b-compute_and_apply_ssp.py
	$(PYTHON) 06-make_epochs.py
	$(PYTHON) 07-make_evoked.py
	# $(PYTHON) 99-make_reports.py

all:
	$(MAKE) fetch
	$(MAKE) preproces
