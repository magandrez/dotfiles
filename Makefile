CONFIGS := bin config git gpg screen x desktop

all: $(CONFIGS)
$(CONFIGS):
	stow $@

%:
    @: stow $@


.PHONY: % all $(CONFIGS)
