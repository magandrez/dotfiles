CONFIGS := bin config fonts git gpg screen x desktop

all: $(CONFIGS)
$(CONFIGS):
	stow $@

%:
    @: stow $@


.PHONY: % all $(CONFIGS)
